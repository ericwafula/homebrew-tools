class Dcke < Formula
  desc "Scaffold and initialize Android, KMP, iOS and Spring Boot projects"
  homepage "https://github.com/ericwafula/dcke"
  url "https://github.com/ericwafula/dcke/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "1096d42974bdcc2179f2a860b41ac692ee3b4ef6d6e2a0368539200d2811aa9a"

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
