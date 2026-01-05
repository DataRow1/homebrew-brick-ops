class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "fb108659809d6c6041acfe6f98891cf6aadca8c844cda21a749992911716f90c"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "b97ed113b7a1f31cfd6415f0f8dc21e3e913461ed351970e1d0a12efee9d799a"
    end
  end

  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "__LINUX_AMD64_SHA256__"
  end

  def install
    libexec.install "dbops"

    (bin/"dbops").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/dbops/dbops" "$@"
    EOS

    (bin/"dbops").chmod 0755
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
