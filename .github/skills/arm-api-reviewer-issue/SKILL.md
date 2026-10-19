---
name: arm-api-reviewer-issue
description: >
  Report issues about the ARM API Reviewer agent only. USE FOR: ARM reviewer
  feedback, file an ARM reviewer issue, its API-guidance interpretation,
  review process, and repository workflows. DO NOT USE FOR: Data-Plane API
  Reviewer feedback or issues, general service API bugs, SDK generation, or
  posting PR comments. Do not draft or file ARM issues for excluded requests.
license: MIT
metadata:
  version: "1.0.0"
---

# Submit an ARM API Reviewer issue

**WORKFLOW SKILL**

Read the [workflow](./references/workflow.md) and
[issue template](./references/issue-template.md) before research or drafting.
Do not draft from this entry point alone.

## Workflow

1. Research first; clarify in plain language without requiring contract or
   infrastructure expertise.
2. Check all open issues labeled `ARM API Reviewer agent` in public
   `Azure/azure-rest-api-specs`. Return an exact duplicate's link and stop.
3. Separate reports, observations, hypotheses, and confirmed causes. Include
   public evidence, bounded impact, and existing guidance.
   Never publish private evidence, internal URLs, local paths, or secrets.
4. Use only Summary, Issue, Evidence, Solution, and References sections.
   Summary is 2-3 sentences covering the issue and possible solutions.
   Solution includes design, implementation, validation, and limitations.
   Prefix the title with `ARM API Reviewer agent:`.
   Use plain language; no emoji or em dashes.
5. Show title, body, destination, and labels in the main chat. Say "Awaiting your approval.
   No issue has been created." Pause for explicit approval without repeated
   prompts. A filing request or autopilot is not approval. Material edits need
   renewed approval.
6. Recheck duplicates and mutable facts, create once, and verify the published
   issue. On ambiguous results, investigate before retrying; never claim success
   without verification.

Publish only in public `Azure/azure-rest-api-specs` with the mandatory label.
Do not modify existing issues, post PR comments, or implement the proposed fix.

## Examples

"The ARM reviewer did not start. Help me report it."
"The reviewer flagged a pattern our guidance permits."

## Troubleshooting

Blocked research or missing approval means retain a draft without publishing.
