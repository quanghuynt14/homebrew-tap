class BullmqDash < Formula
  desc "Terminal and browser dashboard for BullMQ queue monitoring"
  homepage "https://github.com/quanghuynt14/bullmq-dash"
  url "https://registry.npmjs.org/bullmq-dash/-/bullmq-dash-0.3.2.tgz"
  sha256 "61a160b4a7bef92e7afe66e6268f1a05748526eae101396cfdb12554f95ac4a3"
  license "MIT"

  depends_on "bun"

  def install
    libexec.install Dir["*"]
    (bin/"bullmq-dash").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("bun")}/bun" "#{libexec}/dist/index.js" "$@"
    SH
  end

  test do
    assert_match "bullmq-dash v#{version}", shell_output("#{bin}/bullmq-dash --version")
  end
end
