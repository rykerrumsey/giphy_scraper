defmodule Vendor do
  # do i need to re-declare these again?
  @type image :: %{id: String.t, url: String.t, title: String.t, author: String.t | nil}
  @type response :: list(image)
  
  @callback call_api_with_searchterm_and_count(tuple) :: response

  def get(vendor, search_data) do
    HTTPoison.start
    vendor.call_api_with_searchterm_and_count(search_data)
  end
end

# re-added back to this file
defmodule Giphy do
  @behaviour Vendor

  @impl Vendor
  def call_api_with_searchterm_and_count(search_data) do
    {query, limit} = search_data
    url = "https://api.giphy.com/v1/gifs/search?api_key=#{System.get_env("GIPHY_API_KEY")}&q=#{query}&limit=#{limit}"

    HTTPoison.get!(url)
    |> Map.get(:body)
    |> Jason.decode!
    |> parse_json
  end

  defp parse_json(data) do
    datalist = Map.get(data, "data")
    Enum.map(datalist, &(%{id: &1["id"], url: &1["url"], author: &1["username"], title: &1["title"]}))
  end
end

# re-added these back to this file
defmodule Tenor do
  @behaviour Vendor

  @impl Vendor
  def call_api_with_searchterm_and_count(search_data) do
    {query, limit} = search_data
    url = "https://api.tenor.com/v1/search?q=#{query}}&key=#{System.get_env("TENOR_API_KEY")}&limit=#{limit}"
    
    # looks like code duplication
    HTTPoison.get!(url)
    |> Map.get(:body)
    |> Jason.decode!
    |> parse_json
  end
  
  defp parse_json(data) do
    datalist = Map.get(data, "results")
    Enum.map(datalist, &(%{id: &1["id"], url: &1["url"], author: nil, title: &1["title"]}))
  end
end
