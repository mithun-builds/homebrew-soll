cask "soll" do
  version "0.2.9"

  on_arm do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-apple-silicon.dmg"
    sha256 "fc7d4672297705aeaa6cb0c529ec0855c3a3b40890ce3453c38daf02eae35ec0"
  end

  on_intel do
    url "https://github.com/mithun-builds/soll/releases/download/v#{version}/Soll-v#{version}-intel.dmg"
    sha256 "25b2f3623baf773b4e6e0e9bcbaa8642882789336001353222800c7ed83f32f1"
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
