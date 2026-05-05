#!/usr/bin/env node
/* eslint-disable no-console */

// =============================================================================
// design-claude-config — npx entrypoint
//
// Thin Node shim that execs setup.sh from the cloned repo. The real install
// logic lives in setup.sh — keep it there so `git clone + ./setup.sh` and
// `npx -y github:infinum/design-claude-config` always behave identically.
// =============================================================================

const { spawnSync } = require("child_process");
const path = require("path");
const fs = require("fs");
const os = require("os");

const repoRoot = path.resolve(__dirname, "..");
const setupSh = path.join(repoRoot, "setup.sh");

if (!fs.existsSync(setupSh)) {
	console.error(`✗ setup.sh not found at ${setupSh}`);
	console.error(`  This binary should ship alongside setup.sh in the repo.`);
	process.exit(1);
}

if (os.platform() === "win32") {
	console.error(`✗ Windows is not supported (setup.sh is bash).`);
	console.error(`  Use WSL, or run the slash commands manually inside Claude Code.`);
	process.exit(1);
}

const result = spawnSync("bash", [setupSh, ...process.argv.slice(2)], {
	cwd: repoRoot,
	stdio: "inherit",
});

if (result.error) {
	console.error(`✗ Failed to run setup.sh: ${result.error.message}`);
	process.exit(1);
}

process.exit(result.status ?? 0);
