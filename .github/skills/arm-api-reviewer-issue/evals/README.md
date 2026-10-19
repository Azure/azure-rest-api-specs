# ARM issue skill evaluations

1. Use Waza v0.38.10 or a compatible runner and Node.js for JavaScript graders.
   The suites use eval schema `1.4`, task files, `follow_up_prompts`, checkpoints,
   and supported graders.
2. Check skill metadata, package links, token budget, and the primary suite:

   ```powershell
   waza check .github\skills\arm-api-reviewer-issue
   ```

3. These suites default to Copilot's `auto` model selection. For a repeatable
   model choice, inspect `waza models` and supply an available model with
   `--model`. Automatic selection is not a reproducibility guarantee.
   Shared repository configuration is not changed.

## Safe model execution

1. These are offline conversational tests, not live GitHub integration tests.
   Do not grant shell, network, file-writing, or GitHub tools to test sessions.
   Model execution still needs Copilot authentication and may incur usage costs.
2. Prompt instructions and the `offline_read_only_tools` grader are not runtime
   enforcement. The grader detects unexpected tool calls after execution.
3. Use a temporary Waza custom-agent harness outside the repository to impose a
   runtime tool allowlist:

   ```yaml
   ---
   name: offline-evaluator
   description: Read-only harness for offline issue-skill evaluation.
   tools:
     - skill
     - view
     - glob
     - grep
     - rg
     - mcp:issue_fixture-list_issues
     - mcp:issue_fixture-issue_fixture-list_issues
   ---
   Only discover skills and read the supplied files. Do not contact GitHub.
   ```

   The two exact MCP entries cover Waza v0.38.10 permission events that may
   already include the server name. Both identify the same local read-only
   fixture; neither grants server-wide or live GitHub access.

4. Use a fresh temporary area with one harness definition. Copy the skill and
   tasks into it. In temporary
   copies of all three suite files, set `skill: offline-evaluator`, include the
   harness and copied skill directories in `config.skill_directories`, and
   require `arm-api-reviewer-issue` through `config.required_skills`. Keep
   `inject_skill_body: false` so the routing tests observe actual invocation.
   Resolve task paths relative to the temporary suite files. Preserve
   `mcp_mocks` in the mocked suite; its sole MCP capability is the local,
   read-only fixture tool named above, not a live GitHub server.
5. Run each temporary suite with results and transcripts outside the repository.
   For example, from that temporary evaluation area:

   ```powershell
   waza run .\eval.yaml --model auto --output .\routing-results.json --transcript-dir .\routing-transcripts
   waza run .\workflow.eval.yaml --model auto --output .\workflow-results.json --transcript-dir .\workflow-transcripts
   waza run .\mocked.eval.yaml --model auto --output .\mocked-results.json --transcript-dir .\mocked-transcripts
   ```

6. Review task, checkpoint, and tool-policy results. A green aggregate score
   alone is not evidence that an issue was published correctly.

## Coverage and limitations

1. The three suites contain 21 cases. The routing suite covers novice concerns,
   API-guidance and workflow feedback,
   anti-triggers, private evidence, and untrusted publication instructions.
   The data-plane boundary checks redirection without an ARM issue draft; reading
   the skill solely to confirm that boundary is not a publication or scope
   violation.
2. The multi-turn suite covers complete drafts in the assistant's main-chat
   output, ordinary conversational consent, absent/declined approval, revised
   drafts, duplicate races, unavailable discovery, ambiguous creation, pending
   verification, and mismatched read-back. It checks a clear awaiting-approval
   handoff when the approval prompt returns no response.
3. The mocked suite makes the model call a read-only MCP fixture for two labeled
   issue-list pages and find the duplicate on the second page. Tool-argument
   graders check repository, state, label, and pagination. It does not query
   live GitHub or expose any issue-writing tool.
4. Main-chat text is graded, but the host's actual approval-dialog ordering and
   activity indicator are not integration-tested. Supplied records are fixture
   context, not live results. These tests do not prove successful GitHub writes
   or atomic duplicate prevention. An `executor: mock` run checks harness wiring,
   not model behavior.
5. Do not use `--auto-file-issue`. Do not create live test issues without separate
   authorization and a suitable test destination or write mock.
