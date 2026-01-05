class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.16"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "0e170afacfaf3426fe1db7017aedd979edc854a959a5c79499c4711e808cc611"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "31f536c805227c5d5efe430025dcb8c0cfd6702569c8226473a2e2eedf3cad42"
    end
  end

  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "f6e950fb009a0843091287725b463b5d2867c8794f6d6d6478b054142003f816"
  end

  def install
    # Install the full PyInstaller onedir bundle (directory `dbops/`)
    libexec.install Dir["dbops"]

    # Wrapper script to execute the binary from inside its bundle
    (bin/"dbops").write <<~EOS
      #!/bin/bash
      exec "#{libexec}/dbops/dbops" "$@"
    EOS

    chmod 0755, bin/"dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
