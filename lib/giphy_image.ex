defmodule GiphyImage do
  @enforce_keys
  defstruct [
    :id,
    :url,
    author: "anonymous",
    title: "N/A"
  ]
end

