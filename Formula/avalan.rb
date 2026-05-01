class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/14/b2/075d312935a8cddf364db31f48e97f37bf141d9126a90cbf408fa492e51c/avalan-1.4.1.tar.gz"
  sha256 "d8c8756bb9dbaba9aa3b26620fb11de08bf9d71de2740914fea3d9bbe3856615"
  license "MIT"

  depends_on "python@3.12"

  resource "avalan" do
    url "https://files.pythonhosted.org/packages/1e/2a/a21ce9f3681222dbcabc14b09d5bb2dd25bc8c220d35e21fd7afb466248a/avalan-1.4.1-py3-none-any.whl"
    sha256 "d1b1b884cb03accba9eb5b5a7af51e26482440a958c75369c033cde423400c6b"
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install_and_link resource("avalan")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/avalan --version")
    assert_match version.to_s, shell_output("#{bin}/avl --version")
    assert_match "usage:", shell_output("#{bin}/avalan --help")
  end
end
