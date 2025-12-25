class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/v0.1.3/dbops-darwin-arm64"
      sha256 "<SHA_ARM64>"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/v0.1.3/dbops-darwin-amd64"
      sha256 "<SHA_AMD64>"
    end
  end

  def install
    bin.install Dir["dbops-darwin-*"].first => "dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
