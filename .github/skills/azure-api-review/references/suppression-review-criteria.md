<!-- Upstream alignment: 2026-04-15 -->

# Suppression Review Criteria

This reference defines the decision framework for evaluating
`readme.md` suppressions in API specification PRs. It applies to both
human ARM API reviewers and the automated review agent.

**Authoritative references:**

- [Suppress validation failures on a PR](https://aka.ms/pr-suppressions)
- [PR review workflow diagram](https://aka.ms/azsdk/pr-diagram)

---

## Suppression Types

Suppressions in `readme.md` silence linter rule violations. They are
scoped to the tag block they appear in (see `RPC-SUPPRESS-SCOPE` in
the ARM review instructions).

| Suppression target      | Approval owner                                                            |
| ----------------------- | ------------------------------------------------------------------------- |
| ARM / LintDiff failures | ARM API review team                                                       |
| SDK automation failures | SDK automation team                                                       |
| Breaking changes        | Breaking change reviewers (use breaking change process, not suppressions) |

**Breaking changes MUST NOT be handled through suppressions.** Authors
must follow the breaking change approval process instead.

---

## Decision Framework

### Approve a suppression if

1. **False alarm** -- the linter rule is provably incorrect for this
   code. Document the false alarm in weekly notes so it can be fixed in
   the linter.
2. **Pre-existing violation** -- the linter rule flags an error for a
   type or API that existed prior to the current PR (carried forward
   from a previous version). Document so the false alarm can be fixed.

### Push the author to fix the violation if

1. The violation is for a **new resource type or API** being introduced
   and the author cannot explain why the rule does not apply to their
   scenario.
2. The same anti-pattern exists in **earlier preview versions** but has
   **not yet leaked to a stable version**. Now is the time to fix it
   before it becomes entrenched.
3. The approval criteria above are not met.

### Escalate to peer review if

1. The violation is for a **new resource type or API** and the author
   provides a **reasonable justification** for why the rule does not
   apply. Multiple reviewers should evaluate the justification before
   approval.
2. The anti-pattern is being **replicated from an already-shipped stable
   version** to a new API or type. Based on peer discussion:
   - **Approve** if fixing the violation would make the new APIs look
     significantly different from the established stable pattern (e.g.,
     `202` for long-running PUT is already shipped stable).
   - **Push to fix** if fixing does not significantly vary behavior
     (e.g., adding `Location` header for LROs, or adding a resource
     name pattern).

---

## Suppressions That Are Never Valid

- **Lack of time is not a valid reason.** If there is heavy pushback
  citing deadlines, ask the author to **remove the suppression** from
  the `readme.md` and file a work item to fix the violation in the next
  version. Leaving the suppression out ensures S360 items are raised as
  a tracking mechanism.
- **"Back-compat with preview"** is not sufficient justification for a
  GA (stable) version. Preview was the time to let it slide; GA is the
  deadline to fix.
- **Security-related rule suppressions** (`secret-prop`,
  `security-definition-missing`) require extra scrutiny and should
  almost never be suppressed.

---

## GA vs. Preview Rigor (RPC-SUPPRESS-GA)

Suppressions carried forward from preview API versions are **not
automatically acceptable** in GA (stable) versions. For GA releases,
each suppression must be individually challenged:

- Can the underlying violation now be fixed?
- `PathForResourceAction` suppressions in GA are **blocking** (prevent
  proper RBAC action registration).
- `LroLocationHeader` suppressions in GA are **blocking** (indicate
  incorrect async patterns).

---

## Suppression Scoping Rules (RPC-SUPPRESS-SCOPE)

- Suppressions are scoped to the `readme.md` tag block they appear in.
  A suppression under `package-2025-03-01` does **not** apply to
  `package-2025-07-01`.
- When a PR adds a new package tag, verify carried-over suppressions are
  duplicated/moved to the new tag's suppressions list.
- Suppressions **MUST** include specific `from` and `where` clauses.
  Blanket suppressions that target an entire file without specifying the
  JSON path are not allowed.

---

## Warnings Should Not Be Suppressed (RPC-SUPPRESS-WARN)

Warnings (e.g., `EnumInsteadOfBoolean`, `AvoidAdditionalProperties`)
**SHOULD NOT** be suppressed in `readme.md`. Only errors require
suppression to unblock CI. If a warning is being suppressed, the author
should either fix the issue or leave the warning unsuppressed.
