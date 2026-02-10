class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "3f010610492f58f0f95fc87cab0e31f6d0f9faf0074259f3fc63889b3732e183"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "8f3776cb2befa5d6f1a486d20365f60961b9859c1fe9df5906bf89a15ebafb8c"
    end
  end








  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "089bd474ad8eac98968ae61be36bdf095ee697ece32102336f7a44d7dd02ac3d"
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
