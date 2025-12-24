class BrickOps < Formula
  include Language::Python::Virtualenv

  desc "Databricks operations CLI"
  homepage "https://github.com/DataRow1/db-ops"
  url "https://github.com/DataRow1/db-ops/archive/refs/tags/0.1.1.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "python@3.11"

  def install
    virtualenv_install_with_resources
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
