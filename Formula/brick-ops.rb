class BrickOps < Formula
  include Language::Python::Virtualenv

  desc "Databricks operations CLI"
  homepage "https://github.com/DataRow1/db-ops"
  url "https://github.com/DataRow1/db-ops/archive/refs/tags/0.1.0.tar.gz"
  sha256 "e4755e0df6739717aa400a140892813d776dc02edf96c2214c791137118807e5"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end