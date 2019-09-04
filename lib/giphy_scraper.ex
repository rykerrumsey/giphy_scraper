defmodule GiphyScraper do
  @type image :: %{id: String.t, url: String.t, title: String.t, author: String.t | nil}
  @type response :: list(image)
  @type search :: {String.t, String.t, non_neg_integer}

  @spec search_for_gifs_from_specified_vendor(search) :: response
  def search_for_gifs_from_specified_vendor(search) do
    {vendor, query, limit} = search
    Vendor.get(vendor, {query, limit})
  end
end
