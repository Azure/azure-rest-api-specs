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

**Required first action:** open the [workflow](./references/workflow.md) and
[issue template](./references/issue-template.md) with a file-read tool before
answering any turn, including recovery or fixture questions.

## Workflow

1. Research first; clarify in plain language without requiring contract or
   infrastructure expertise.
2. Check all open ARM API Reviewer issues in public
   `Azure/azure-rest-api-specs`. Return an exact duplicate's full URL and stop.
3. Separate reports, observations, hypotheses, and confirmed causes. Use
   public evidence and existing guidance. Never publish private evidence,
   internal URLs, local paths, or secrets.
4. Use only Summary, Issue, Evidence, Solution, and References sections.
   Summary is 2-3 sentences covering the issue and possible solutions.
   Solution includes design, implementation, validation, and limitations.
   Prefix the title with `ARM API Reviewer agent:`; no emoji or em dashes.
5. Show title, body, destination, labels, and assignee in the main chat, and
   whether push access lets them apply. Propose Copilot only for ready work.
   Say "Awaiting your approval. No issue has been created." Pause without
   repeated prompts. A filing request or autopilot is not approval. Material
   edits need renewed approval.
6. Recheck duplicates, create once, and verify the published issue.
   Investigate ambiguous results before retrying; never claim unverified
   success.

Publish only in public `Azure/azure-rest-api-specs`.
Do not modify existing issues, post PR comments, or implement the fix.

## Examples

"The ARM reviewer did not start. Help me report it."

## Troubleshooting

Blocked research or missing approval means retain a draft without publishing.
