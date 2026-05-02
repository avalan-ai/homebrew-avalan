class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/14/b2/075d312935a8cddf364db31f48e97f37bf141d9126a90cbf408fa492e51c/avalan-1.4.1.tar.gz"
  sha256 "d8c8756bb9dbaba9aa3b26620fb11de08bf9d71de2740914fea3d9bbe3856615"
  license "MIT"

  depends_on "python@3.12"
  depends_on "libpq"
  depends_on "rust" => :build


  def install
    virtualenv_create(libexec, "python3.12")

    python = Formula["python@3.12"].opt_bin/"python3.12"
    system python, "-m", "pip",
           "--python=#{libexec}/bin/python",
           "install",
           "--no-binary=cryptography,jiter",
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
