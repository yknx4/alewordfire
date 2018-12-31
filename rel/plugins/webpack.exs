defmodule PhoenixApp.PhoenixDigestTask do
  use Mix.Releases.Plugin

  def before_assembly(%Release{} = _release, _) do
    info("before assembly!")
    Mix.Task.run("phx.digest.clean")

    cd = "/edeliver/aleworld/builds/assets"

    case System.cmd("yarn", ["install"], cd: cd),
         System.cmd("yarn", ["webpack", "--mode", "--production"], cd: cd) do
      {output, 0} ->
        info(output)
        Mix.Task.run("phx.digest")
        nil

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
