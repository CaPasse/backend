defmodule CP.Application do
  @moduledoc """
  The CP Application Service.

  The backend system business domain lives in this application.

  Exposes API to clients such as the `CP.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(CP.Repo, []),
    ], strategy: :one_for_one, name: CP.Supervisor)
  end
end
