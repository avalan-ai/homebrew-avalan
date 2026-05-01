class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/1e/2a/a21ce9f3681222dbcabc14b09d5bb2dd25bc8c220d35e21fd7afb466248a/avalan-1.4.1-py3-none-any.whl"
  sha256 "d1b1b884cb03accba9eb5b5a7af51e26482440a958c75369c033cde423400c6b"
  license "MIT"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install_and_link "#{buildpath}[agent,server,tool,vendors,memory]"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/avalan --version")
    assert_match version.to_s, shell_output("#{bin}/avl --version")
    assert_match "usage:", shell_output("#{bin}/avalan --help")
  end
end
