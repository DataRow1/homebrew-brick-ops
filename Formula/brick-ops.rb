class BrickOps < Formula
  include Language::Python::Virtualenv

  desc "Databricks operations CLI"
  homepage "https://github.com/DataRow1/db-ops"
  url "https://github.com/DataRow1/db-ops/archive/refs/tags/0.1.1.tar.gz"
  sha256 "ad668ba00a4dff945c37646bc88c42c25a356640681fb3032cc5fcdadb3351b6"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
