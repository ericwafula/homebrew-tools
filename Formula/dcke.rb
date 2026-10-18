class Dcke < Formula
  desc "Scaffold and initialize Android, KMP, iOS and Spring Boot projects"
  homepage "https://github.com/ericwafula/dcke"
  url "https://github.com/ericwafula/dcke/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "3adc747991f5b6e63f1f8b4fc950de5eff3eef08aad40c82d402a2fec1fd798f"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "ci"
    system "npm", "run", "build"
    libexec.install "dist", "templates", "package.json"
    (bin/"dcke").write_env_script libexec/"dist/cli.js", PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  test do
    system bin/"dcke", "init", "--type", "android", "--name", "Todo", "--package", "com.acme.todo"
    assert_path_exists testpath/"Todo/gradlew"
    assert_path_exists testpath/"Todo/app/src/main/kotlin/com/acme/todo/MainActivity.kt"
  end
end
