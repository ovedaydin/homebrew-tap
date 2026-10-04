cask "agent-mode" do
  version "1.1"
  sha256 "c6b74f7357b07bb3db10ee973bf7ff253c527fee0f75da14d79d59ed2a65bf4d"

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
