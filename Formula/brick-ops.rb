class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.4.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "bac95f61cfc0bf6cdadbea2d985d1d6a63a483cc4962bc131f515f99e3094dc4"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "1883583925b9a8cc6599acc61f51cf7e4e8e27ce78dba027af99d7017c07bbf8"
    end
  end






  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "0be18679cb5b9f6c7680fbc323f5594c0cb01040e702908eecbf112e38acdda4"
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
