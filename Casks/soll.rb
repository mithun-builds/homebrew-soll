cask "soll" do
  version "0.3.2"

  on_arm do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-apple-silicon.dmg"
    sha256 "3291c6ac3477fb0bd95d5ce08e653e2308cce8313023bfe2869e3e77cea74876"
  end

  on_intel do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-intel.dmg"
    sha256 "f88975d90b8a51f6c575ea4c9362c8ff1f296a54cdabeaa78bd741925025149b"
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
