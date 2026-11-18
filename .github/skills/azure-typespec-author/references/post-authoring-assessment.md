# Post-Authoring Fast Assessment

## Completion offer

Offer a quick assessment by default after Step 5 actually changed TypeSpec,
Step 6 completed successfully, and Step 7 supplied the reference links. A recorded
skip because validation MCP is not exposed is allowed by the validation workflow;
failed checks, authentication failures, and unresolved validation blockers are not.
Do not offer assessment during intake, planning-only work, or an unchanged task.
Assessment never substitutes for authoring validation.

This is an opt-out completion workflow: always offer it for eligible work unless
the user already declined assessment of these changes. It is not permission to
run assessment without an answer.

Use the host's user-question tool to ask exactly:

**"Would you like to quickly assess your changes?"**

Use these exact choice labels, preserving capitalization and punctuation:

- **Run fast assessment (Recommended)**
- **Skip**

Wait for the answer. Skip completes authoring without assessment or another
prompt. Honor an earlier explicit opt-out or affirmative assessment request for
the same changes without reconfirming it. Opting out of SDK client configuration
is a separate decision and does not opt out of this offer.

## Accepted handoff

Invoke `azure-typespec-assessment` by name with fast mode
(`--assessment-mode fast`), the repository, and the authored TypeSpec project
scope. Do not duplicate its coordinator, judgment, or report workflow here.
If the user explicitly requested full mode instead, preserve that choice.

Carry forward an explicitly supplied or confirmed assessment baseline. Accepting
the offer does not choose a baseline: if none was supplied, the assessment skill
must first ask exactly **"Compare against origin/main, or a different branch or commit?"**
and wait. An authoring branch, an earlier Git merge, and a suggested default are
not baseline confirmation. For an explicitly requested PR assessment, use its
actual target baseline according to the assessment skill.

Let the assessment coordinator be the first operational assessment command after
baseline confirmation. Do not run a separate status, diff, fetch, worktree setup,
or project-discovery phase as part of this handoff. Reuse the known project
scope; if authoring changed multiple projects, pass all of them using the
assessment workflow's supported scope inputs.

Local assessment covers the complete comparison in that scope: merge-base
through `HEAD`, staged, unstaged, and relevant untracked changes. It is not
limited to edits made by the authoring agent. Do not commit, stash, switch
branches, stage files, or discard existing changes to prepare the assessment.
The assessment must preserve the authored source and the user's index and
working tree. When structured output describes the handoff scope, represent
agent-only scope as false (for example, `agentEditsOnly: false`); never narrow
the comparison to the agent's edits.

Fast mode retains Semantic intents and the existing full report layout.
Only Azure Guidelines search and judgment are skipped; the existing Guidelines
card and section show `0 findings` and `Skipped`, never passed. REST and
downstream SDK compatibility and deterministic Documentation Completeness
remain assessed. Do not fetch guideline documents for fast mode.

## Delivery and blockers

Follow the assessment skill through guarded finalization and its required
served **Assessment report** link and absolute `assessment.json` path.
An intermediate analysis file or a filesystem-only HTML link is not completion.

If the skill is unavailable or assessment is blocked, report the assessment gap
separately from the completed authoring and validation. Do not claim a clean
assessment or undo successful authoring. Stop after reporting findings and
potential limits; fixes need a new user request, not an automatic remediation
or assessment loop.
