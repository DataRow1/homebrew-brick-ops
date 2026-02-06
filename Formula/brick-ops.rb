class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "b487dc64945229d49eb51688edd0b632c2cf3b32fab49a0681d4049d07bc30d2"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "7b279fe54481fe83ac097044d73a53245ed5fada0ad9aa40ecadf262562d8d84"
    end
  end





  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "12f76a309a4ca14287e6c807cd6e48d9ba14a2ad70ec81618b58f11ed32ab41b"
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
