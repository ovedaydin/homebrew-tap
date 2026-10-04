cask "agent-mode" do
  version "1.3"
  sha256 "13c4ed1a05f7835ee07c77dae34b04be90a5c201a70f1f3d5eab99be55a9941e"

  url "https://github.com/ovedaydin/agent-mode/releases/download/v#{version}/Agent-Mode.zip"
  name "Agent Mode"
  desc "Menu bar app that prevents sleep while AI coding agents work"
  homepage "https://github.com/ovedaydin/agent-mode"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Agent Mode.app"
  # The app's own binary doubles as the command-line tool: `agentmode help`.
  binary "#{appdir}/Agent Mode.app/Contents/MacOS/AgentMode", target: "agentmode"

  # The app is self-signed, not notarized, so strip quarantine after install.
  # Remove this block if you switch to Developer ID + notarization.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Agent Mode.app"]
  end

  uninstall quit: "io.github.ovedaydin.agentmode"

  zap trash: [
    "~/.claude/settings.json.agentmode-backup",
    "~/Library/Preferences/io.github.ovedaydin.agentmode.plist",
  ]
end
