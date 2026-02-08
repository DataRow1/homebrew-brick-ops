class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.4.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "f0ceda528c75c83b33a6afb917766b0b8ef85ec6fde0a5567a3b95948a3d15db"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "030ce496f2ee777f3e0e549c55eec0963bc4e683ea3153e7a36ed4c7bdcd9a7b"
    end
  end







  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "f4921654554b1a09ec00f2a4c6bccd06514af008dd124bebbb18f3bad4028972"
  end







  def install
    bundle = libexec/"dbops"
    bundle.install "dbops", "_internal"

    (bin/"dbops").write <<~EOS
      #!/bin/bash
      exec "#{bundle}/dbops" "$@"
    EOS

    chmod 0755, bin/"dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
