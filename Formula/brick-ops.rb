class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/db-ops"
  license "MIT"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/db-ops/releases/download/0.1.4/dbops-darwin-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/DataRow1/db-ops/releases/download/0.1.4/dbops-darwin-amd64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  def install
    bin.install "dbops-darwin-#{Hardware::CPU.arm? ? 'arm64' : 'amd64'}" => "dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
