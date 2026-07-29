<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-05-31
     Source of truth for the Reviewer-Posted Parity contract referenced by
     `arm-api-review.instructions.md`, `openapi-review.instructions.md`, and
     `typespec-review.instructions.md`. Prior to consolidation the same
     hard-rules list was duplicated across all three instruction files; the
     duplicates drifted (marker form, severity glyphs). Edit here only. -->

# Reviewer-Posted Parity

**REQUIRED -- no divergence.**

The set of findings posted to the GitHub PR **MUST** be **byte-for-byte
identical** to the set of findings shown to the reviewer in chat. There
**MUST** be no discrepancy in content, count, ordering, severity, rule
IDs, links, code blocks, examples, fix snippets, or the trailing
per-comment telemetry marker (the comment body's last line containing
`posted-by: arm-api-reviewer-agent` plus the required fields defined in
the [protocol per-comment marker schema](../../../agents/protocols/arm-api-review-critic.protocol.md#per-comment-telemetry-marker-step-6-canonical-body-and-step-8-posting)).

## Hard rules

1. **Single source of truth.** Build each comment body **once** as the
   canonical text for that finding. The text rendered to the reviewer in
   chat and the text written into the GitHub review payload **MUST**
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
4. **Exact one-to-one mapping.** Every finding shown to the reviewer
   **MUST** map to exactly one inline comment in the posted review. The
   reviewer **MUST NOT** see N findings and the PR receive N-1
   (something dropped) or N+1 (something added). Severity tags
   (`🔴 Blocking`, `🟠 Warning`, `🔵 Suggestion`) and `[NEW]` /
   `[EXISTING]` classifications **MUST** match.
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
   agent **MUST** report the discrepancy explicitly to the reviewer
   rather than silently posting a shortened or altered variant.

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
A degraded marker still satisfies parity as long as the chat-rendered
body and the posted body carry the **same** marker bytes.
