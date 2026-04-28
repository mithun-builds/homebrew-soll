cask "soll" do
  version "0.3.0"

  on_arm do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-apple-silicon.dmg"
    sha256 "f691928f98fb9455ab4dbcb51a7b289286f7b95e658d00742273d9ef77977513"
  end

  on_intel do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-intel.dmg"
    sha256 "c4283112e4b2a05a112299716aff6c0ce9b7562ba6bdc47314b521c3a8ee5638"
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
