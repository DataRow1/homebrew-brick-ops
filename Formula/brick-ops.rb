class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "29ccb89edab69b67f3df3283a589c1876581dd9556a88f16b49528fbd1b4f074"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "7066372ab0630054609abde338c8fce5fe1b870b6d21e6c0670e0ac789e4a022"
    end
  end

  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "__LINUX_AMD64_SHA256__"
  end

  def install
    bin.install "dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
