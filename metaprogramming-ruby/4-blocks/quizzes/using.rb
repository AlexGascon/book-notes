module Kernel
  def using(resource)
    yield
  ensure
    resource.dispose
  end
end