class Ctxline < Formula
  desc "Claude Code status line for context and usage limits"
  homepage "https://github.com/ericwafula/ctxline"
  url "https://github.com/ericwafula/ctxline/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "ad493797c9b1fc31e1654e1fb8b033b48100862d6e8cd7b1991a8e5950cbd089"
  license "MIT"

  uses_from_macos "python"

  def install
    libexec.install "src/ctxline"
    python = OS.mac? ? "/usr/bin/python3" : "python3"
    (bin/"ctxline").write <<~SH
      #!/bin/sh
      PYTHONPATH="#{opt_libexec}" exec "#{python}" -m ctxline "$@"
    SH
  end

  def caveats
    <<~EOS
      Make ctxline your Claude Code status line:
        ctxline install
    EOS
  end

  test do
    ENV["NO_COLOR"] = "1"
    ENV["CLAUDE_CONFIG_DIR"] = testpath
    payload = {
      model:          { display_name: "Opus" },
      context_window: { total_input_tokens: 42000, context_window_size: 200000 },
    }.to_json
    assert_equal "Opus · ctx 42k (21%)", pipe_output(bin/"ctxline", payload).strip
    assert_equal version.to_s, shell_output("#{bin}/ctxline --version").strip
  end
end
