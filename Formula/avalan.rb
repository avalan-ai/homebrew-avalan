class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/92/72/b2184f7787ddfbc24eda3be9b4eef5aa8e536074e6c8e1d640bed6276be4/avalan-1.4.11.tar.gz"
  sha256 "f84b0b521d36a87784eec061f428f5a290142520efe22f6e88ba4c11065aac36"
  license "MIT"

  livecheck do
    url :stable
    strategy :pypi
  end

  depends_on "python@3.14"

  # Some installed wheels (e.g. tiktoken, pydantic-core, pillow) ship dylibs that
  # reference each other via @rpath; Homebrew's default install-name rewrite
  # would break that loader path.
  preserve_rpath

  # Keep this in parity with the default profile shipped by avalan-apt. Newer
  # opt-in extras such as `a2a`, `browser`, `code`, `litellm`, `memory`,
  # `translation`, `youtube`, and heavyweight hardware extras stay out of the
  # Homebrew formula so the CLI install remains practical. The upstream `vllm`
  # extra is currently reserved while its dependency chain has no patched
  # diskcache release.
  EXTRAS = %w[agent server tool vendors].freeze

  def install
    venv = virtualenv_create(libexec, "python3.14")

    # Install from the sdist that Homebrew already downloaded (verified via
    # `sha256` above) instead of re-fetching the package from PyPI. Bypass
    # `pip_install_and_link`, which would pass `--no-deps` and require a
    # `resource` block per transitive dependency. `virtualenv_create` builds
    # the venv with `--without-pip`, so drive pip from the parent interpreter
    # and target the venv via `--python=`.
    system Formula["python@3.14"].opt_bin/"python3.14",
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
