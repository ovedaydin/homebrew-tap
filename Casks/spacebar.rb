cask "spacebar" do
  version "0.4.0"
  sha256 "120c69e1e73596c3113f5cb21744b02b269bd025ff5888852a1ee8121ce929e3"

  url "https://github.com/ovedaydin/spacebar/releases/download/v#{version}/Spacebar-#{version}.zip"
  name "Spacebar"
  desc "Free, open-source disk space analyzer and cleaner"
  homepage "https://github.com/ovedaydin/spacebar"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: :ventura

  app "Spacebar.app"
  # The app's own binary doubles as the command-line tool: `spacebar help`.
  binary "#{appdir}/Spacebar.app/Contents/MacOS/Spacebar", target: "spacebar"

  # The app is self-signed, not notarized, so strip quarantine after install.
  # Remove this block if you switch to Developer ID + notarization.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Spacebar.app"]
  end

  uninstall quit: "io.github.ovedaydin.spacebar"

  zap trash: [
    "~/Library/Caches/io.github.ovedaydin.spacebar",
    "~/Library/Preferences/io.github.ovedaydin.spacebar.plist",
    "~/Library/Saved Application State/io.github.ovedaydin.spacebar.savedState",
  ]
end
