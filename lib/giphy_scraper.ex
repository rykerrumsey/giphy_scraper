defmodule GiphyScraper do
  @spec search() :: list(GiphyImage)
  def search() do 
    GiphyVendorHttpApi.get_list_giphy_images(Giphy, {"cheese", 25})
  end

  @spec search(String.t, String.t, non_neg_integer) :: list(GiphyImage)
  def search(vendor, query, limit) do
    GiphyVendorHttpApi.get_list_giphy_images(vendor, {query, limit})
  end
end
