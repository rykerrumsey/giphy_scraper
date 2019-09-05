defmodule Giphy do
  @behaviour GiphyVendorHttpApi 

  @impl GiphyVendorHttpApi 
  def vendor_search_url do 
    "https://api.giphy.com/v1/gifs/search?api_key=#{System.get_env("GIPHY_API_KEY")}"
  end

  @impl GiphyVendorHttpApi
  def vendor_response_mapping(search_data) do
    data = search_data["data"]
    # how would i leave out the author if the username from the incoming data was ""?
    Enum.map(data, fn %{"id" => id, "url" => url, "username" => username, "title" => title} -> %GiphyImage{id: id, url: url, author: username, title: title} end)
  end
end
