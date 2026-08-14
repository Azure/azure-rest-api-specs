<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-05-31
     Source of truth for the Reviewer-Posted Parity contract referenced by
     `arm-api-review.instructions.md`, `openapi-review.instructions.md`, and
     `typespec-review.instructions.md`. Prior to consolidation the same
     hard-rules list was duplicated across all three instruction files; the
     duplicates drifted (marker form, severity glyphs). Edit here only. -->

# Reviewer-Posted Parity

**REQUIRED -- no divergence.**

Parity is expressed against the **agreed finding set** -- the reconciled and,
where a host enforces output limits, deterministically budgeted set of findings
the reviewer and critic have agreed to post individually. Candidates excluded
by a documented output budget are not entries in this set; the run must
disclose their count and themes without rendering them as canonical finding
bodies. Whatever is posted to the GitHub PR **MUST** be **byte-for-byte
identical** to the corresponding entries in that agreed finding set. There
**MUST** be no discrepancy in content, count, ordering, severity, rule IDs,
links, code blocks, examples, fix snippets, or the trailing per-comment
telemetry marker (the comment body's last line containing
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

## Cross-session reconciliation

The reconciliation contract is identical for every review entry point:

1. A human invokes the ARM API Reviewer in chat and later approves posting.
2. The automated workflow runs when a PR is ready for ARM review.
3. An authorized author or maintainer posts `/arm-review`.

The entry point changes who approves mutations, but it MUST NOT change how
prior feedback is discovered, matched, or reconciled. Before forming the
agreed finding set, every session MUST inventory all paginated PR discussion
surfaces:

- inline review threads and every comment in each thread, including resolved,
  outdated, and collapsed threads;
- top-level PR conversation comments (the issue-comment API surface);
- pull request review bodies, including COMMENT, APPROVE, and REQUEST_CHANGES
  reviews.

The inventory includes comments from humans, interactive agent sessions,
automated runs, and `/arm-review` runs. The
`posted-by: arm-api-reviewer-agent` marker determines whether the agent owns a
comment for resolution purposes; it MUST NOT determine whether the comment
counts as prior coverage. A human-authored comment can cover or contradict a
new candidate just as an agent-authored comment can.

### Finding identity and duplicate suppression

Match findings by semantic identity, not by author, entry point, comment type,
or exact line number. Two comments describe the same finding when they identify
the same rule or review topic, the same affected API element (JSON path,
TypeSpec model/property/operation, or equivalent file construct), and the same
underlying corrective outcome. Line movement, wording differences, severity
wording, or a missing telemetry marker do not make the finding new.

A prior comment counts as coverage only when it is actionable enough to
identify the affected element and the claimed issue or guidance. A generic
summary theme such as "naming issues were found" does not suppress a concrete
inline finding.

When actionable prior coverage exists, the new session MUST NOT post another
standalone finding. It records `SKIP-COVERED` or, when location/state changed,
replies to or updates the existing conversation according to the reconciliation
plan. This applies even when the prior item is top-level, resolved, outdated,
or lacks the agent marker.

### Contradiction handling

A contradiction exists when the new session would give materially incompatible
guidance for the same semantic finding, including when it:

- says a construct is required while an earlier comment says it is forbidden;
- says a violation remains while an earlier comment says it was fixed or
  compliant;
- changes the applicable rule, severity, classification, or required fix in a
  way that changes what the author should do.

Contradictions MUST use `CLARIFY-CONFLICT`, never `POST-NEW`:

- For an inline thread, reply in that thread with the prior position, current
  evidence at the pinned session SHA, the current guidance, and why the
  conclusion changed. Do not create a second finding elsewhere.
- If the contradicted inline thread is agent-origin and the old guidance is no
  longer valid, the plan may resolve it after posting the clarification. Never
  resolve a human-origin thread without explicit human consent.
- For top-level comments or review bodies, post one consolidated top-level
  clarification that links every contradicted comment/review and gives the same
  evidence and supersession statement. Do not repeat the findings as separate
  new comments.

If evidence is insufficient to determine which position is correct, say so in
the clarification and leave the existing thread unresolved. Silence is not
acceptable because it leaves mutually incompatible instructions on the PR.

The Critic MUST independently verify duplicate and contradiction decisions
against the complete discussion inventory. If any discussion surface could not
be fetched, reconciliation is incomplete and follows the existing
`reconciliation skipped` failure path rather than silently defaulting to
`POST-NEW`.

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
5. **Post-post verification (REQUIRED when the posting host permits it).**
   When the agent posts comments directly, it **MUST** immediately fetch the
   live comment bodies (`GET /repos/{owner}/{repo}/pulls/comments/{id}` for
   each created comment) and verify, for every comment:
   - body length matches the canonical text length (within normalisation
     tolerance for line endings only),
   - the rule ID hyperlinks are present,
   - any code-fence (` ``` `) blocks present in the canonical text are
     present in the posted body,
   - the telemetry marker containing `posted-by: arm-api-reviewer-agent`
     and the required marker fields is present.
     Posting-mode handling:
   - **Direct posting:** On any mismatch the agent **MUST** PATCH the affected
     comment(s) (`PATCH /repos/{owner}/{repo}/pulls/comments/{id}`) to restore
     the canonical text and re-verify before reporting completion to the user.
   - **Deferred safe-output posting:** A gh-aw autonomous run publishes through
     deferred `safe-outputs` after the agent has exited, so the agent cannot
     fetch the resulting comment in the same execution. In that mode it
     **MUST** submit the canonical body once as the safe-output body, without
     rebuilding or re-authoring it. Live-body verification belongs to the
     safe-output publisher or a post-publish integration check; if the host
     exposes such a hook, the same fetch and comparison above are required
     there.

6. **Failure handling.** If a finding cannot be posted or queued as-is (e.g.,
   GitHub API rejects the body, a line anchor cannot be resolved, or a safe
   output is rejected), the agent **MUST** report the discrepancy explicitly
   (to the reviewer in interactive mode, or in the run/summary output in
   autonomous mode) rather than silently posting a shortened or altered
   variant.
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
   - Resolution is idempotent: if a later push reintroduces the violation, the
     next session treats the resolved thread as prior coverage. Reply there or
     use the applicable line-shift/conflict action when possible; post a
     replacement only when the old thread cannot accurately carry the current
     location or guidance.
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
