defmodule Backend.Search do

  import Tirexs.HTTP

  def index_product(id, data) do
    put("/capasse/products/#{id}", data)
  end

end
