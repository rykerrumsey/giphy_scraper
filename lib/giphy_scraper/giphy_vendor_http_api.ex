defmodule GiphyVendorHttpApi do
  @callback vendor_search_url :: String.t
  # if the data going into this function is completely different is any fine to use here?
  @callback vendor_response_mapping(any) :: list(GiphyImage) 

  def get_list_giphy_images(vendor, search_data) do
    HTTPoison.start

    vendor.vendor_search_url
    |> add_query_string(search_data)
    |> make_request_and_deserialize
    |> vendor.vendor_response_mapping
  end

  defp add_query_string(request_url, search_data) do
    {query, limit} = search_data
    "#{request_url}&q=#{query}&limit=#{limit}"  
  end
  
  defp make_request_and_deserialize(request_url) do 
    HTTPoison.get!(request_url)
    |> Map.get(:body)
    |> Jason.decode!
  end
end
