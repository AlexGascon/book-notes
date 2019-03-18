defmodule Pooly.WorkerSupervisor do
  use Supervisor

  ##############
  # Client API #
  ##############

  def start_link({_, _, _} = mfa) do
    Supervisor.start_link(__MODULE__, mfa)
  end

  ##############
  #  Callbacks #
  ##############

  # mfa = module, function, arguments
  def init({m, f, a}) do
    worker_options = [restart: :permanent, function: f]
    children = [worker(m, a, worker_options)]

    # See section 6.2.3 to learn more about the different supervision strategies
    supervisor_options = [
      strategy: :simple_one_for_one,
      max_restarts: 5,
      max_seconds: 5
    ]
    supervise(children, supervisor_options)
  end
end