cask "soll" do
  version "0.4.0"

  on_arm do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-apple-silicon.dmg"
    sha256 "a50326f485e929adcc23a142f7fe16f3ad9b0181890a4aefb6b7a7de95a7c1a7"
  end

  on_intel do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-intel.dmg"
    sha256 "1bfa59778d8414eccaa59c2afb4b3819541c21659b30489c4943fa4128acd4df"
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

  # Brew runs this on `uninstall --cask` AND on `upgrade --cask`
  # (upgrade is uninstall-then-install under the hood). Quitting the
  # running app first means the user can run `brew upgrade --cask soll`
  # while Soll is open and brew handles it cleanly.
  uninstall quit: "com.soll.app"

  zap trash: [
    "~/Library/Application Support/com.soll.app",
    "~/Library/Preferences/com.soll.app.plist",
    "~/Library/Logs/com.soll.app",
  ]
end
