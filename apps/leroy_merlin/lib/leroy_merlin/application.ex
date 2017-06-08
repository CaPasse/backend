defmodule LeroyMerlin.Application do

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    true = Node.connect(Application.fetch_env!(:leroy_merlin, :node))

    Supervisor.start_link([
      worker(LeroyMerlin.Pages, []),
      worker(LeroyMerlin.Listings, []),
    ], strategy: :one_for_one, name: LeroyMerlin.Supervisor)
  end

end
