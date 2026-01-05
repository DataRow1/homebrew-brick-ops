class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/8d44637f77540961ec45446cd60b15ac1e4a669af1b9fd587e3d44e2004246a1"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/e7c8057946018a6c9c7e4259c37927b6eeaffde4f8f3a675665c1b568c32e83"
    end
  end

  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "e639cbf7a787bea2823f02e1bf4ac65ede63a540515dc4f9721d582af7f1b352"
  end

  def install
    bin.install "dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
