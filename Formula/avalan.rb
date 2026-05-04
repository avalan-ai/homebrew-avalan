class Avalan < Formula
  include Language::Python::Virtualenv

  desc "Multi-backend, multi-modal framework for AI agent development"
  homepage "https://github.com/avalan-ai/avalan"
  url "https://files.pythonhosted.org/packages/c0/5f/2bfa67862a09fc1a6b3faf6fe4fb34b3f575558a2683922413dff7cdfeda/avalan-1.4.3.tar.gz"
  sha256 "b9a90be021c3d72f326a24ff504c9de5c4c748deaaa72acd159fe8ae8eb3b54b"
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
