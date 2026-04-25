cask "soll" do
  version "0.2.2"

  on_arm do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-apple-silicon.dmg"
    sha256 "803937e044ba46caf520a6ca4386ad5b7d0e504a278f26ba3c0507449d79ed9d"
  end

  on_intel do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-intel.dmg"
    sha256 "47e96769fff9d92722da9905ae9fc15bec63cc3367c7bc10bb61206f849bb502"
  end

  name "Soll"
  desc "Voice to text for your Mac — local, private, free"
  homepage "https://mithun-builds.github.io/soll/"

  app "Soll.app"

  # Remove quarantine flag so macOS opens the app without Gatekeeper warnings
  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/Soll.app"],
      sudo: false
  end

  zap trash: [
    "~/Library/Application Support/com.soll.app",
    "~/Library/Preferences/com.soll.app.plist",
    "~/Library/Logs/com.soll.app",
  ]
end
