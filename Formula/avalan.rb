class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/3b/2a/80ca4687c7f0f9e2c004e1c6d8bc29c310ed62c872c21c898b9dc66b4093/avalan-1.4.6.tar.gz"
  sha256 "9c81dd093ee65813c60d92bd20ad52fdcfef1168c496be7e38d903912ebaa20d"
  license "MIT"

  depends_on "python@3.12"

  preserve_rpath

  def install
    virtualenv_create(libexec, "python3.12")

    python = Formula["python@3.12"].opt_bin/"python3.12"
    system python, "-m", "pip",
           "--python=#{libexec}/bin/python",
           "install",
           "avalan[agent,server,tool,vendors]==#{version}"

    bin.install_symlink libexec/"bin/avalan"
    bin.install_symlink libexec/"bin/avl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/avalan --version")
    assert_match version.to_s, shell_output("#{bin}/avl --version")
    assert_match "usage:", shell_output("#{bin}/avalan --help")
  end
end
