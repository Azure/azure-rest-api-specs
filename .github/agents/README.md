# agents

Custom Copilot Chat agents for this repo. Each `*.agent.md` at the top
level is auto-registered by Visual Studio Code.

## Agents

| File                                                                 | Purpose                                                                          | User-invocable? |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------- | --------------- |
| [`arm-api-reviewer.agent.md`](./arm-api-reviewer.agent.md)           | Reviews Azure REST API spec PRs; findings verified by the Critic before posting. | Yes             |
| [`arm-api-review-critic.agent.md`](./arm-api-review-critic.agent.md) | Internal subagent invoked by the Reviewer at Step 7 to re-verify findings.       | No              |
| [`hero-scenarios.agent.md`](./hero-scenarios.agent.md)               | Suggests hero scenarios from TypeSpec to seed SDK samples, docs, and tests.      | Yes             |

## Shared protocols

Multi-agent contracts live in [`protocols/`](./protocols/). The
subdirectory keeps reference files out of Visual Studio Code's agent scan path.

- [`protocols/arm-api-review-critic.protocol.md`](./protocols/arm-api-review-critic.protocol.md)
  is the Reviewer-Critic wire contract (inputs, verdicts, sentinels, marker schemas).
  Source of truth if either agent file disagrees.

## Conventions

- Filename: `<short-name>.agent.md`, lowercase-hyphenated.
- Internal subagents: set `user-invocable: false` in frontmatter.
- Extract shared schemas to `protocols/` to prevent drift.
- Prefer explicit tool allowlists over `github/*` for read-only agents.
- No emoji or non-ASCII chars except where required by agent output.
