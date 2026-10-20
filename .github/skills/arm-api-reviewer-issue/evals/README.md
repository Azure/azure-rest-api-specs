# ARM issue skill evaluations

1. Use Waza v0.38.10 or a compatible runner and Node.js for JavaScript graders.
   The suites use eval schema `1.4`, task files, `follow_up_prompts`, checkpoints,
   and supported graders.
2. Check skill metadata, package links, token budget, and the primary suite:

   ```powershell
   waza check .github\skills\arm-api-reviewer-issue
   ```

3. All three suites pin `gpt-5.6-sol`. Run `waza models` to confirm that the
   model is available, and use `--model` only for deliberate comparisons.
   Shared repository configuration is not changed.

## Windows PowerShell command smoke test

Run this command from the repository root on Windows with Node.js, GitHub CLI,
Windows PowerShell 5.1 (`powershell.exe`), and PowerShell 7 (`pwsh.exe`) on `PATH`:

```powershell
node --test .github\skills\arm-api-reviewer-issue\evals\powershell-command.test.ts
```

The test extracts the documented Copilot availability command and runs real
`gh.exe` in both shells. Only the API endpoint is replaced with a loopback HTTP
fixture, and credentials are replaced with dummy values. It checks the exact
GraphQL request, temporary paths containing spaces, API failure propagation,
and query-file cleanup after success and failure. It makes no external requests
or GitHub writes and requires no authentication. Non-Windows runs are skipped.
This test is separate from the model sessions and their read-only tool allowlist.

## Safe model execution

1. These are offline conversational tests, not live GitHub integration tests.
   Model execution needs Copilot authentication and may incur usage costs.
2. Every suite runs through the committed
   [offline evaluator](./harness/offline-evaluator.agent.md) custom agent. Its
   `tools` list is a runtime allowlist: skill discovery, file reading, and the
   local issue fixture. It grants no shell, network, file-writing, or GitHub
   tools. Each suite sets `skill: offline-evaluator`, loads the `harness` and
   skill directories, and requires `arm-api-reviewer-issue` through
   `config.required_skills`. `inject_skill_body: false` keeps skill invocation
   observable.
3. The mocked suite allows two exact MCP tool names because Waza v0.38.10
   permission events may already include the server name. Both identify the
   same local read-only fixture; neither grants live GitHub access. The
   `tool_constraint` graders also detect unexpected tool calls after execution.
4. Run each suite with results and transcripts outside the repository. For
   example, from this directory:

   ```powershell
   $out = Join-Path $env:TEMP arm-issue-evals
   waza run .\eval.yaml --output $out\routing.json --transcript-dir $out\routing
   waza run .\workflow.eval.yaml --output $out\workflow.json --transcript-dir $out\workflow
   waza run .\mocked.eval.yaml --output $out\mocked.json --transcript-dir $out\mocked
   ```

5. Review task, checkpoint, and tool-policy results. A green aggregate score
   alone is not evidence that an issue was published correctly.

## Coverage and limitations

1. The three suites contain 24 cases. The routing suite covers novice concerns,
   API-guidance and workflow feedback, anti-triggers, private evidence, and
   untrusted publication instructions. The data-plane boundary checks
   redirection without an ARM issue draft; reading the skill solely to confirm
   that boundary is not a publication or scope violation.
2. The multi-turn suite covers complete drafts in the assistant's main-chat
   output, ordinary conversational consent, absent/declined approval, revised
   drafts, duplicate races, unavailable discovery, ambiguous creation, pending
   verification, and mismatched read-back. It also covers metadata disclosure
   without push access, a Copilot assignment proposal for an
   implementation-ready draft, and labels or comments added by Issue Triage
   after creation. Every multi-turn task checks that the skill is invoked.
   Tasks whose expected behavior is defined only in the workflow reference also
   check that it is read. Prompts supply fixtures, not the expected behavior.
3. Success claims are rejected with patterns such as "I created the issue" or
   "Published and verified" unless verification is the expected outcome.
4. The mocked suite makes the model call a read-only MCP fixture for two labeled
   issue-list pages and find the duplicate on the second page. Tool-argument
   graders check repository, state, label, and pagination. It does not query
   live GitHub or expose any issue-writing tool.
5. Main-chat text is graded, but the host's actual approval-dialog ordering and
   activity indicator are not integration-tested. Supplied records are fixture
   context, not live results. These tests do not prove successful GitHub
   writes, label or assignee application, Copilot cloud agent startup, or
   atomic duplicate prevention. An `executor: mock` run checks harness wiring,
   not model behavior.
6. Do not use `--auto-file-issue`. Do not create live test issues without separate
   authorization and a suitable test destination or write mock.
