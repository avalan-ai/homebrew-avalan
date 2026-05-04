class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/de/cd/02055cc273263f76b0b56e81fcb18aea0753b08ce11d65e37d75fcb28086/avalan-1.4.4.tar.gz"
  sha256 "5a1738e817d4e5226ff62762b9f7a07213013c7a4f77b446bc1aac99bf805b4c"
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
