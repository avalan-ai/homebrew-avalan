class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/3a/38/310fe6476cf52c27c7f3459dbb62ef9b101911bdf2f9eb93c69bbbc498f6/avalan-1.4.7.tar.gz"
  sha256 "0f12d0786ace337c665e2ed8482ec3f6d30c79f583d135474f02b4670ff8fcd4"
  license "MIT"

  livecheck do
    url :stable
    strategy :pypi
  end

  depends_on "python@3.13"

  # Some installed wheels (e.g. tiktoken, pydantic-core, pillow) ship dylibs that
  # reference each other via @rpath; Homebrew's default install-name rewrite
  # would break that loader path.
  preserve_rpath

  # Avalan's CLI eagerly imports modules from these extras at startup (e.g. the
  # `tool` extra is needed for SQLAlchemy types used by tool.database). Keep the
  # set curated and lean — heavyweight/hardware-specific extras such as `local`,
  # `audio`, `vision`, `mlx`, `apple`, `nvidia`, `vllm`, `quantization` and `ds4`
  # are left for users to add via pip when they need them.
  EXTRAS = %w[agent server tool vendors].freeze

  def install
    venv = virtualenv_create(libexec, "python3.13")

    # Install from the sdist that Homebrew already downloaded (verified via
    # `sha256` above) instead of re-fetching the package from PyPI. Bypass
    # `pip_install_and_link`, which would pass `--no-deps` and require a
    # `resource` block per transitive dependency. `virtualenv_create` builds
    # the venv with `--without-pip`, so drive pip from the parent interpreter
    # and target the venv via `--python=`.
    system Formula["python@3.13"].opt_bin/"python3.13",
           "-m", "pip",
           "--python=#{venv.root}/bin/python",
           "install",
           "#{buildpath}[#{EXTRAS.join(",")}]"

    bin.install_symlink libexec/"bin/avalan"
    bin.install_symlink libexec/"bin/avl"
  end

  test do
    assert_match "avalan #{version}", shell_output("#{bin}/avalan --version")
    assert_match "avalan #{version}", shell_output("#{bin}/avl --version")
    assert_match "usage:", shell_output("#{bin}/avalan --help")
  end
end
