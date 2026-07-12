class BullmqDash < Formula
  desc "Terminal and browser dashboard for BullMQ queue monitoring"
  homepage "https://github.com/quanghuynt14/bullmq-dash"
  url "https://registry.npmjs.org/bullmq-dash/-/bullmq-dash-0.4.1.tgz"
  sha256 "52569e5e3e4f64b2c4eab0bbc3b7117063d670661aee5f9f9e58bce711c14922"
  license "MIT"

  depends_on "bun"

  def install
    libexec.install Dir["*"]
    # Vendor runtime dependencies next to dist/index.js so Bun resolves them
    # locally instead of auto-installing into the user cache on first run.
    system formula_opt_bin("bun")/"bun", "install", "--production", "--cwd", libexec
    (bin/"bullmq-dash").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("bun")}/bun" "#{libexec}/dist/index.js" "$@"
    SH
  end

  test do
    assert_match "bullmq-dash v#{version}", shell_output("#{bin}/bullmq-dash --version")
  end
end
