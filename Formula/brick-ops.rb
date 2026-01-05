class BrickOps < Formula
  desc "Databricks operations CLI for Jobs and Unity Catalog"
  homepage "https://github.com/DataRow1/brick-ops"
  license "MIT"
  version "0.1.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-arm64.tar.gz"
      sha256 "4e337e5303196882666775745c919093df16c0f0821cd57ca76aade0eaae00eb"
    else
      url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-darwin-amd64.tar.gz"
      sha256 "d3f660b34e0155fab5730b756a7dc3aa43858c5d38c4bfdb939f21477e19323b"
    end
  end


  on_linux do
    url "https://github.com/DataRow1/brick-ops/releases/download/#{version}/dbops-linux-amd64.tar.gz"
    sha256 "ba5bfc7e031927209cf6b3d6e4ac85062e080084e65849ee54ff21eb1526fb70"
  end


  def install
    libexec.install "dbops"
    bin.install_symlink libexec/"dbops/dbops" => "dbops"
  end

  test do
    system "#{bin}/dbops", "--help"
  end
end
