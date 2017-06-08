defmodule Backend.Application do
  @moduledoc """
  The Backend Application Service.

  The backend system business domain lives in this application.

  Exposes API to clients such as the `Backend.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Backend.Repo, []),
    ], strategy: :one_for_one, name: Backend.Supervisor)
  end
end
