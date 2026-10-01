---
applyTo:
  - "eng/**"
  - ".github/actions/**"
  - ".github/shared/**"
  - ".github/workflows/**"
excludeAgent: "cloud-agent"
---

# Copilot Code Review Instructions for Engineering Systems

Review engineering changes as end-to-end systems, not as isolated files or functions. Trace behavior
across callers, workflows, actions, and shared helpers, and verify that the implementation follows
the established architecture and conventions in adjacent code.

For GitHub Actions and code that calls GitHub APIs:

- Minimize API calls. Prefer trustworthy event payload data, reuse responses within a workflow run,
  and avoid fetching the same pull request, labels, artifacts, statuses, checks, or files in
  adjacent steps or helpers.
- Count calls across the complete execution path, including pagination, retries, workflow triggers,
  and follow-up jobs. Flag avoidable calls that occur on every run or multiply for large pull
  requests.
- Request only the data needed, use the maximum supported page size, stop pagination as soon as the
  decision can be made, and perform cheap eligibility checks before API calls.
- Preserve correctness while optimizing. Do not replace immutable, head-bound data with live pull
  request state, weaken stale-run protection, or reuse data across boundaries where it may have
  changed.
