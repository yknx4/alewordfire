defmodule AlewordfireWeb.PageView do
  alias Alewordfire.Tools.Paginator
  use AlewordfireWeb, :view

  def create_paginator(entries) do
    Paginator.init(entries, per: 3)
  end

  def paginate(paginator, params) do
    Paginator.calculate(paginator, params)
  end

  def filter_posts(entries) do
    entries
    |> Enum.reject(fn entry ->
      comparable =
        entry.content
        |> String.split("_/stat", trim: true)
        |> List.first()

      from_title = "<p>#{entry.title}</p><img src=\"https://medium.com/"

      String.length(comparable) == String.length(from_title)
    end)
  end

  def paginate_posts(entries, %{current_page: current_page, per: per}) do
    offset = (current_page - 1) * per
    Enum.slice(entries, offset, per)
  end

  def post_date(date) do
    with {:ok, date} <- Timex.parse(date, "{RFC1123}"),
         {:ok, relative_str} <- Timex.format(date, "{relative}", :relative) do
      relative_str
    end
  end

  def post_ts(date) do
    with {:ok, date} <- Timex.parse(date, "{RFC1123}") do
      Timex.to_unix(date)
    end
  end

  def primary_image(nil), do: nil

  def primary_image(html) do
    "<html><body>#{html}</body></html>"
    |> Readability.article()
    |> Floki.find("img")
    |> Floki.attribute("src")
    |> Enum.reject(fn str -> String.starts_with?(str, "https://medium.com/_/stat") end)
    |> List.first()
  end

  def has_primary_image(content), do: not (content |> primary_image() |> is_nil())

  def boolean_link(text, enabled, opts) when is_boolean(enabled) do
    opts =
      if enabled do
        opts
      else
        opts ++ [disabled: ""]
      end

    link(text, opts)
  end

  def pagination_link_opts(conn, page, pagination) do
    is_current = page == pagination.current_page
    opts = [to: Routes.blog_page_path(conn, :index, page), "aria-label": "Goto page #{page}"]

    if is_current do
      opts ++ [class: "pagination-link is-current", "aria-current": "page"]
    else
      opts ++ [class: "pagination-link"]
    end
  end
end
