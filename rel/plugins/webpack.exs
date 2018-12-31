defmodule PhoenixApp.PhoenixDigestTask do
  use Mix.Releases.Plugin

  def before_assembly(%Release{} = _release, _) do
    info "before assembly!"
    case System.cmd("yarn", ["install", "--production"], cd: "/edeliver/aleworld/builds/assets") do
      {output, 0} ->
        info output
        Mix.Task.run("phx.digest.clean")
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
