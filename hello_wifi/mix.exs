defmodule HelloWifi.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi3"

  def project do
    [app: :hello_wifi,
     version: "0.0.1",
     elixir: "~> 1.3",
     archives: [nerves_bootstrap: "~> 0.2"],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     target: @target,
     deps_path: "deps/#{@target}",
     build_path: "_build/#{@target}",
     kernel_modules: kernel_modules(@target),
     aliases: aliases(),
     deps: deps() ++ system(@target)]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {HelloWifi, []},
     extra_applications: [:logger]]
  end

  defp deps do
    [{:nerves, "~> 0.4"},
     {:nerves_interim_wifi, "~> 0.1.1"}]
  end

  def system(target) do
    [{:"nerves_system_#{target}", "~> 0.6"}]
  end

  def kernel_modules("rpi3") do
    ["brcmfmac"]
  end
  def kernel_modules(_), do: []

  def aliases do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end

end
