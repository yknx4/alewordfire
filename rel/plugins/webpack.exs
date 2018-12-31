defmodule PhoenixApp.PhoenixDigestTask do
  use Mix.Releases.Plugin

  def before_assembly(%Release{} = _release, _) do
    info("before assembly!")
    Mix.Task.run("phx.digest.clean")

    cd = "/edeliver/aleworld/builds/assets"

    with {output1, 0} <- System.cmd("yarn", ["install"], cd: cd),
         {output2, 0} <- System.cmd("yarn", ["webpack", "--mode", "production"], cd: cd) do
      info(output1)
      info(output2)
      Mix.Task.run("phx.digest")
      nil
    else
      {output, error_code} ->
        {:error, output, error_code}
    end
  end

  def after_assembly(%Release{} = _release, _) do
    nil
  end

  def before_package(%Release{} = _release, _) do
    nil
  end

  def after_package(%Release{} = _release, _) do
    nil
  end

  def after_cleanup(%Release{} = _release) do
    nil
  end
end
