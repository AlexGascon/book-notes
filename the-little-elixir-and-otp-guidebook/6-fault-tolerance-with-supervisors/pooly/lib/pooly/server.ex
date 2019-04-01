defmodule Pooly.Server do
  use GenServer
  import Supervisor.Spec

  defmodule State do
    defstruct sup: nil, size: nil, mfa: nil
  end

  ##############
  # Client API #
  ##############

  def start_link(sup, pool_config) do
    GenServer.start_link(__MODULE__, [sup, pool_config], name: __MODULE__)
  end

  def status do
    GenServer.call(__MODULE__, :status)
  end

  ##############
  #  Callbacks #
  ##############

  def init([sup, pool_config]) when is_pid(sup) do
    monitors = :ets.new(:monitors, [:private])

    init(pool_config, %State{sup: sup, monitors: monitors})
  end

  # Parsing the options we care about
  def init([{:mfa, mfa} | rest], state) do
    init(rest, %{state | mfa: mfa})
  end

  def init([{:size, size} | rest], state) do
    init(rest, %{state | size: size})
  end

  def init([_ | rest], state) do
    init(rest, state)
  end

  def init([], state) do
    send(self, :start_worker_supervisor)
    {:ok, state}
  end

  def handle_info(:start_worker_supervisor, state = %{sup: sup, mfa: mfa, size: size}) do
    {:ok, worker_sup} = Supervisor.start_child(sup, supervisor_spec(mfa))
    workers = prepopulate(size, worker_sup)

    {:noreply, %{state | worker_sup: worker_sup, workers: workers}}
  end

  def handle_call(:checkout, {from_pid, _reference}, state = %{workers: workers, monitors: monitors}) do
    case workers do
      [] ->  # There are no more available workers
        {:reply, :noproc, state}

      [worker | rest] ->
        reference = Process.monitor(from_pid)
        true = :ets.insert(monitors, {worker, reference})

        {:reply, worker, %{state | workers: rest}}
    end
  end

  def handle_call({:checkin, worker}, state = %{workers: workers, monitors: monitors})
    case :ets.lookup(monitors, worker) do # Checking if the worker is currently in use
      {worker_pid, reference} ->
        true = Process.demonitor(reference)
        true = :ets.delete(monitors, worker_pid)
        
        {:noreply, %{state | workers: [worker_pid | workers]}}
      [] ->
        {:noreply, state}
    end
  end

  def handle_call(:status, _from, state) do
    # Info about the # of available workers + the # of busy workers
    {:reply, {length(workers), :ets.info(monitors, :size)}, state}
  end


  #######################
  #  Private functions  #
  #######################

  defp supervisor_spec(mfa) do
    # We disable the automatic worker restarting because we want to implement a
    # customised behavior that better fits our needs.
    options = [restart: :temporary]
    # Specifies that the process to be supervised is a Supervisor, not a worker
    supervisor(Pooly.WorkerSupervisor, [mfa], options)
  end

  defp prepopulate(size, supervisor, workers \\ [])

  defp prepopulate(size, _supervisor, workers) when size < 1 do
    workers
  end

  defp prepopulate(size, supervisor, workers) do
    prepopulate(size - 1, supervisor, [new_worker(supervisor) | workers])
  end

  defp new_worker(supervisor) do
    {:ok, worker} = Supervisor.start_child(supervisor, [[]])

    worker
  end
end
