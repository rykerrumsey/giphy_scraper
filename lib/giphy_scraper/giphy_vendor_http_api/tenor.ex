defmodule Tenor do
  @behaviour GiphyVendorHttpApi 

  @impl GiphyVendorHttpApi 
  def vendor_search_url do 
    "https://api.tenor.com/v1/search?key=#{System.get_env("TENOR_API_KEY")}"
  end

  @impl GiphyVendorHttpApi
  def vendor_response_mapping(search_data) do
    data = search_data["results"]
    Enum.map(data, fn %{"id" => id, "url" => url, "title" => title} -> %GiphyImage{id: id, url: url, title: title} end)
  end
end
