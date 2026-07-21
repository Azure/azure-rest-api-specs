<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-05-31
     Source of truth for the Reviewer-Posted Parity contract referenced by
     `arm-api-review.instructions.md`, `openapi-review.instructions.md`, and
     `typespec-review.instructions.md`. Prior to consolidation the same
     hard-rules list was duplicated across all three instruction files; the
     duplicates drifted (marker form, severity glyphs). Edit here only. -->

# Reviewer-Posted Parity

**REQUIRED -- no divergence.**

Parity is expressed against the **agreed finding set** -- the reconciled
set of findings the reviewer and critic have agreed on. Whatever is
posted to the GitHub PR **MUST** be **byte-for-byte identical** to the
corresponding entries in that agreed finding set. There **MUST** be no
discrepancy in content, count, ordering, severity, rule IDs, links, code
blocks, examples, fix snippets, or the trailing per-comment telemetry
marker (the comment body's last line containing
`posted-by: arm-api-reviewer-agent` plus the required fields defined in
the [protocol per-comment marker schema](../../../agents/protocols/arm-api-review-critic.protocol.md#per-comment-telemetry-marker-step-6-canonical-body-and-step-8-posting)).

## Review modes

The agreed finding set is acted on differently depending on **review
mode**. Mode is determined by execution context, not inferred ad hoc:

- **Interactive mode** -- the reviewer/critic agents run in a
  human-facing session (e.g., Copilot chat / VS Code). The agreed
  finding set is **presented** to the human reviewer, who decides which
  findings to post. Parity applies to the **human-approved subset**:
  agreed set -> human-approved subset -> posted set. Only findings the
  human selects are posted; each posted comment is still byte-for-byte
  identical to its agreed-set entry.
- **Autonomous mode** -- the agents run headless in GitHub Actions
  (under the gh-aw workflow; an Actions context is present). There is
  **no human gate** and the review **MUST NOT** wait for human
  confirmation. The agreed finding set is acted on directly:
  net-new findings are **posted**, previously agent-posted findings
  whose violation is now addressed are **resolved**, and duplicates are
  **skipped**. Parity applies across both the posted set (net-new
  findings) and the resolved set (addressed findings). The one-to-one,
  verbatim-reproduction, and post-post verification rules below apply to
  whatever is posted.

**Default when unsure:** if an Actions/gh-aw context is present, treat
the run as autonomous; otherwise treat it as interactive.

## Hard rules

1. **Single source of truth.** Build each comment body **once** as the
   canonical text for that finding. The text recorded in the agreed
   finding set (and rendered to the reviewer in chat, in interactive
   mode) and the text written into the GitHub review payload **MUST**
   come from that same string -- never a reconstructed, re-summarized,
   or shortened variant.
2. **Verbatim reproduction.** When assembling the review payload
   (`POST /repos/{owner}/{repo}/pulls/{pull_number}/reviews` with inline
   `comments[]`), each `comments[].body` **MUST** contain the canonical
   text unchanged. Do **not** drop, paraphrase, collapse, or shorten:
   - the rule ID hyperlinks,
   - the code / JSON / TypeSpec blocks under **Fix:**,
   - inline examples,
   - file path / line number / JSON path citations,
   - the trailing telemetry marker (including all required fields).
3. **No re-authoring during payload assembly.** Heredoc rebuilds,
   payload-time JSON-string escaping, multi-finding consolidation, or
   any step that involves "rewriting the body inline" is **forbidden**.
   Generate each comment body once, store it, and reference the stored
   value when building the payload.
4. **Exact one-to-one mapping.** Every finding that is posted **MUST**
   map to exactly one inline comment in the posted review. In
   interactive mode the human-approved subset **MUST** map one-to-one to
   the posted comments; in autonomous mode every net-new finding in the
   agreed set **MUST** map one-to-one to a posted comment. The consumer
   **MUST NOT** see N findings and the PR receive N-1 (something dropped)
   or N+1 (something added). Severity tags (`🔴 Blocking`,
   `🟠 Warning`, `🔵 Suggestion`) and `[NEW]` / `[EXISTING]`
   classifications **MUST** match.
5. **Post-post verification (REQUIRED).** Immediately after posting the
   review, the agent **MUST** fetch the live comment bodies
   (`GET /repos/{owner}/{repo}/pulls/comments/{id}` for each created
   comment) and verify, for every comment:
   - body length matches the canonical text length (within normalisation
     tolerance for line endings only),
   - the rule ID hyperlinks are present,
   - any code-fence (` ``` `) blocks present in the canonical text are
     present in the posted body,
   - the telemetry marker containing `posted-by: arm-api-reviewer-agent`
     and the required marker fields is present.

   On any mismatch the agent **MUST** PATCH the affected comment(s)
   (`PATCH /repos/{owner}/{repo}/pulls/comments/{id}`) to restore the
   canonical text and re-verify -- before reporting completion to the
   user.

6. **Failure handling.** If a finding cannot be posted as-is (e.g.,
   GitHub API rejects the body, a line anchor cannot be resolved), the
   agent **MUST** report the discrepancy explicitly (to the reviewer in
   interactive mode, or in the run/summary output in autonomous mode)
   rather than silently posting a shortened or altered variant.
7. **Resolving addressed findings (autonomous mode).** When a
   previously **agent-posted** finding's violation has been fixed in the
   current head SHA, the agent **MUST** reply to the thread noting the
   fix **and** resolve that review thread, so the PR's unresolved-thread
   count reflects only live issues. Constraints:
   - Only threads whose comments carry the
     `posted-by: arm-api-reviewer-agent` marker may be resolved. The
     agent **MUST NOT** resolve human-authored threads, nor
     `[EXISTING]` findings it did not originate.
   - Partial fixes (violation reduced but not eliminated) **MUST** stay
     open -- do not resolve.
   - Resolution is idempotent: if a later push reintroduces the
     violation, the agent re-posts the finding as net-new.
   - Resolution and the accompanying reply are attributed to the
     workflow's `github-token` identity (see the workflow's Required
     Secrets); they do **not** count against the inline-comment budget.
     In **interactive mode** the agent does not resolve threads on its own;
     it surfaces addressed findings to the human, who decides.

## Examples

**Negative (do NOT do):** Show the reviewer a finding with a JSON
code-block under **Fix:**, then build a multi-comment payload heredoc
that omits the code-block to keep the JSON string short.

**Positive (DO):** Build each finding's body string once with
hyperlinks, code blocks, and marker included; serialize that exact
string into the `body` field of each `comments[]` entry in the review
payload; after posting, re-fetch each comment and confirm the live body
matches.

## Telemetry-marker degradation

Telemetry marker assembly failures **MUST NOT** block posting; fall back
per the [protocol telemetry fallback policy](../../../agents/protocols/arm-api-review-critic.protocol.md#telemetry-fallback-policy-load-bearing).
A degraded marker still satisfies parity as long as the agreed-set
body and the posted body carry the **same** marker bytes.
