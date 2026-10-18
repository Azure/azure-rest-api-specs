# ARM issue skill evaluations

1. Use Waza v0.38.10 or a compatible runner. The suites use eval schema `1.4`,
   task files, `follow_up_prompts`, checkpoints, and supported graders.
2. Check skill metadata, package links, token budget, and the primary suite:

   ```powershell
   waza check .github\skills\arm-api-reviewer-issue
   ```

3. The configuration uses the model named in the repository's shared Waza
   defaults. If it is unavailable, inspect `waza models` and supply an available
   model with `--model`. Do not change shared configuration just to run this
   suite.

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
   ---
   Only discover skills and read the supplied files. Do not contact GitHub.
   ```

4. Copy the skill and tasks into the temporary evaluation area. In temporary
   copies of both suite files, set `skill: offline-evaluator`, include the
   harness and copied skill directories in `config.skill_directories`, and
   require `arm-api-reviewer-issue` through `config.required_skills`. Keep
   `inject_skill_body: false` so the routing tests observe actual invocation.
   Resolve task paths relative to the temporary suite files.
5. Run each temporary suite with results and transcripts outside the repository.
   For example, from that temporary evaluation area:

   ```powershell
   waza run .\eval.yaml --model auto --output .\routing-results.json --transcript-dir .\routing-transcripts
   waza run .\workflow.eval.yaml --model auto --output .\workflow-results.json --transcript-dir .\workflow-transcripts
   ```

6. Review task, checkpoint, and tool-policy results. A green aggregate score
   alone is not evidence that an issue was published correctly.

## Coverage and limitations

1. The routing suite covers novice concerns, API-guidance and workflow feedback,
   anti-triggers, private evidence, and untrusted publication instructions.
   The data-plane boundary checks redirection without an ARM issue draft; reading
   the skill solely to confirm that boundary is not a publication or scope
   violation.
2. The multi-turn suite covers duplicates, complete provisional drafts,
   absent/declined approval, changed drafts, unavailable discovery, and ambiguous
   creation outcomes.
3. Supplied records are fixture context, not live duplicate-search results.
   These tests cannot prove successful GitHub publication or atomic duplicate
   prevention. A mock execution checks harness wiring, not model behavior.
4. Do not use `--auto-file-issue`. Do not create live test issues without separate
   authorization and a suitable test destination or write mock.
