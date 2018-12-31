defmodule AlewordfireWeb.AboutView do
  use AlewordfireWeb, :view

  def render_section(section, opts) do
    render(
        AlewordfireWeb.AboutView,
        "section.html",
        [template: section] ++ opts
      )
  end
end
