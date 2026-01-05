class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/60f43a045fef46463dff350a9d4d4fb007d1ddcba2dac29ee35f8a59b91d7f"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "d6e01d7539767900b0ad27066a923f76d07e8d76a1efc94f5d74b2e588449640"
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
