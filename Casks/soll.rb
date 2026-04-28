cask "soll" do
  version "0.3.1"

  on_arm do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-apple-silicon.dmg"
    sha256 "9c15a6a8bea750ee30b688edabacebc8dd87330961046b8db1559f78c8763643"
  end

  on_intel do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-intel.dmg"
    sha256 "55014397cd4ba3b8e08293993b526123e0c0b2a7dce383dcd37baade6c3643e4"
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
