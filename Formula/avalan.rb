class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/c3/f4/26508259f37b38fddbcbd0bd24c0376b5716814c5e29fb30fa1aa3f6120a/avalan-1.4.5.tar.gz"
  sha256 "b8f85424240dca102cef2e047c567b4f6f263fb7546710d7dc9c7c8d54928cf1"
  license "MIT"

  depends_on "rust" => :build
  depends_on "python@3.12"

  def install
    virtualenv_create(libexec, "python3.12")

    python = Formula["python@3.12"].opt_bin/"python3.12"
    system python, "-m", "pip",
           "--python=#{libexec}/bin/python",
           "install",
           "--no-binary=cryptography,jiter,pydantic-core",
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
