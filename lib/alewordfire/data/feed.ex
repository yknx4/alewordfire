defmodule Alewordfire.Data.Feed do
  def data do
    url = "https://medium.com/feed/@aleworld"

    xml =
      with nil <- Cachex.get!(:network, url) do
        HTTPoison.start()

        with %HTTPoison.Response{status_code: 200, body: xml} <- HTTPoison.get!(url) do
          Cachex.put(:network, url, xml, ttl: 5 * 60 * 1000)
          xml
        end
      end

    xml
    |> ElixirFeedParser.parse()
  end
end
