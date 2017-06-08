defmodule LeroyMerlin.Pages do
  require Logger

  use Hound.Helpers

  def start_link do
    Task.start_link(fn -> loop() end)
  end

  defp loop do
    :timer.sleep(10000)
    loop()
  end

end
