defmodule Alewordfire.Data.Experience do
  @experience "priv/experience.json" |> File.read!() |> Jason.decode!()
  def data do
    @experience
  end
end
