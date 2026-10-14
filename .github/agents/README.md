# agents

Custom Copilot Chat agents for this repo. Each `*.agent.md` at the top level is
registered by supported interactive hosts. The ARM API Reviewer is available in
Visual Studio Code and local project sessions in the GitHub Copilot app.

## Agents

| File                                                                     | Purpose                                                                                                       | User-invocable? |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------- | --------------- |
| [`arm-api-reviewer.agent.md`](./arm-api-reviewer.agent.md)               | Reviews Azure REST API spec PRs and local specifications; findings are verified by the Critic.                | Yes             |
| [`arm-api-review-critic.agent.md`](./arm-api-review-critic.agent.md)     | Internal subagent invoked by the Reviewer at Step 7 to re-verify findings.                                    | No              |
| [`data-plane-api-reviewer.agent.md`](./data-plane-api-reviewer.agent.md) | Reviews data-plane TypeSpec for high-value semantic defects outside deterministic compiler and linter checks. | Yes             |
| [`hero-scenarios.agent.md`](./hero-scenarios.agent.md)                   | Suggests hero scenarios from TypeSpec to seed SDK samples, documentation, and tests.                          | Yes             |

## Shared protocols

Multi-agent contracts live in [`protocols/`](./protocols/). The
subdirectory keeps reference files out of the interactive agent scan path.

- [`protocols/arm-api-review-critic.protocol.md`](./protocols/arm-api-review-critic.protocol.md)
  is the Reviewer-Critic wire contract (inputs, verdicts, sentinels, marker schemas).
  Source of truth if either agent file disagrees.

## Conventions

- Filename: `<short-name>.agent.md`, lowercase-hyphenated.
- Internal subagents: set `user-invocable: false` in frontmatter.
- Extract shared schemas to `protocols/` to prevent drift.
- Prefer explicit tool allowlists over `github/*` for read-only agents.
- Agents that run unattended (from a `.github/workflows/*.md` gh-aw workflow)
  get **no** mutating GitHub tools at all; `safe-outputs` is their only write
  channel. Behavioral gating in prose is not a substitute for an allowlist.
- No emoji or non-ASCII chars except where required by agent output.
  Both reviewers use severity glyphs: ARM uses 🔴 / 🟠 / 🔵; data-plane uses
  🔴 / 🟡 / 💡.
