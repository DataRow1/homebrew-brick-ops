class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "a25b635e8927570312714199ead638416669f86554e07112426d6382c21de1f7"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "10708dc2ef7f4026f74b3152ce123319303d87920ea74686a08ef3ffb79fd234"
    end
  end




  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "fd96a58fd412c53117f4838add67f50f4e98d9614b492f3cd180bee07dbd2188"
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
