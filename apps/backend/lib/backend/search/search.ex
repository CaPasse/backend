defmodule Backend.Search do

  import Tirexs.HTTP

  def index_product(id, data) do
    put("/index/products/#{id}", data)
  end

end
