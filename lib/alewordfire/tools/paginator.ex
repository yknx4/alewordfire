defmodule Alewordfire.Tools.Paginator do

  def init(data, opts \\ []) when is_list(opts) do
    per = Keyword.get(opts, :per, 5)

    %{
      total_pages: Float.ceil(length(data) / per) |> Kernel.trunc(),
      per: per
    }
  end

  def calculate(data, %{"page" => page}) when is_binary(page) do
    with {current_page, _} <- Integer.parse(page) do
      calculate(data, current_page: current_page)
    end
  end
  def calculate(data, %{}), do: calculate(data, [])
  def calculate(%{total_pages: total_pages} = data, opts) when total_pages > 0 do
    current_page = Keyword.get(opts, :current_page, 1)

    data
    |> Map.merge(%{
      current_page: current_page,
      next_page: current_page + 1,
      previous_page: current_page - 1,
      has_next: current_page < total_pages,
      has_previous: current_page > 1
    })
  end
end
