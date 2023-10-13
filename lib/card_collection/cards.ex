defmodule CardCollection.Cards do
  @moduledoc false

  def get_json do
    with {:ok, content} <- File.read("assets/ST-01.json"),
         {:ok, json} <- Poison.decode(content) do
      {:ok, json}
    end
  end
end
