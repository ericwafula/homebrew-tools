class Dcke < Formula
  desc "Scaffold and initialize Android, KMP, iOS and Spring Boot projects"
  homepage "https://github.com/ericwafula/dcke"
  url "https://github.com/ericwafula/dcke/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "98ff1c88a7ad1cfe15aa26e39dd3593d9e3ac4826cfed35490095d7c17bde899"
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
