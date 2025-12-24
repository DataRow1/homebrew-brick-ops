class BrickOps < Formula
  include Language::Python::Virtualenv

  desc "Databricks operations CLI"
  homepage "https://github.com/DataRow1/db-ops"
  url "https://github.com/DataRow1/db-ops/archive/refs/tags/0.1.2.tar.gz"
  sha256 "eb9c4c1f88a3e64e78edadd49aadd90ed97dbd128f89d0dc4563d127520e9cd8"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
