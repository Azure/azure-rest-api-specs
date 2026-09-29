# Release plan automation

Creates or updates the release plan for a merged spec PR's API version, saves the triggering main-branch
SHA, and requests SDK generation from that saved SHA. Requires Node.js >=24.14.1, pnpm dependencies, and an
authenticated `azsdk` executable (override its path with `AZSDK`).

## Commands

Run these entry points from the repository root:

- `node eng/tools/release-plan/cmd/create-release-plan.js --pr-number <number> --workspace <spec-checkout> --output-file <artifact-path>`
  discovers one project and API version from metadata at the PR's merge commit. Alternatively use
  `--commit-sha <full-sha>`; when both inputs are supplied, they must identify the same merge commit.
- `node eng/tools/release-plan/cmd/create-release-plan.js --release-plan-id <id> --output-file <artifact-path>`
  retrieves the stored target without discovering metadata, changing the plan, or checking out code.
- `node eng/tools/release-plan/cmd/update-sdk-details.js --artifact-file <artifact-path> --workspace <spec-checkout>`
  refreshes an in-progress plan from discovery. ID-only, stale-event, and not-found artifacts are skipped.
- `node eng/tools/release-plan/cmd/generate-sdk.js --artifact-file <artifact-path> --workspace <spec-checkout>`
  requests eligible management-plane SDKs. The CLI reads the SHA from the saved release plan.

Use `--repo Azure/azure-rest-api-specs-pr` for private specs and `--test-release-plan true` when creating
test plans. Private previews retain API-version/project/PR identity checks and the general update that
can finish a merged tracking plan; they do not receive public-target flags or generate SDKs.

## Automatic SHA updates

The pipeline passes `Build.SourceVersion` explicitly; it never substitutes a developer checkout's HEAD.
An initial PR creates plan P with SHA A. A later PR for the same project, API version, and release type
updates the same P to SHA B, even without a `new-api-version` label. Generation then uses B. A different
API version uses a separate plan. Replayed events preserve the saved target; older events do not roll it back.

## Target and checkout requirements

- Prepare a clean, separate checkout at the event's full merge SHA before discovery or public SDK
  details updates. Keep the artifact outside that checkout. Automation never switches, resets,
  stashes, or fetches the checkout.
- Same-version updates require complete commit ancestry (pipeline checkout: `fetchDepth: 0`). Missing
  or divergent history fails closed; older events cannot roll back a newer pin.
- API-version detection continues to use the existing TypeSpec metadata emitter and selection logic.
- A combined PR/project/version lookup selects by project/version/release type, not strictly by PR.
  Returned identities are checked before updating; lookup failures never authorize creation.
- Automation supplies the CLI's existing `--api-version`, `--spec-commit-sha`, and `--confirm-target`
  inputs itself. Updates pass `--expected-target-revision` from discovery; the SDK-details stage uses
  the artifact's observed revision. No manual confirmation is required for each merged PR. A revision
  conflict stops processing without a blind retry.
- Generation validates the artifact against the current plan and passes its plan ID, API version, and
  SDK release type. It does not override the SHA. ID-only generation never reads current metadata.

## Validation and rollout

From this package, run `pnpm check` for type checking, lint, formatting checks, and tests. Tests mock
Git, GitHub, and azsdk boundaries; no release plans or SDK pipelines are created.
Run `Invoke-Pester eng/scripts/Tests/Release-Plan-Pipeline.Tests.ps1` from the repository root to check
pipeline argument construction with `pnpm` and `git` mocked.

Deploy a compatible azsdk CLI before enabling this automation: `release-plan update` and
`update-spec-pr` must accept `--expected-target-revision`, and generation must consume the saved SHA.
Unsupported CLI options, confirmation previews, and structured failures stop the workflow rather than
falling back to an unpinned target.

Tests include initial creation, same-version follow-up, metadata refresh, and generation using the
newly saved SHA. Generation completion, SDK publishing, and notification policies are unchanged.

### Live checkout probe

`eng/pipelines/release-plan-sha-test.yml` is a manual-only pipeline named
`TEST - release-plan SHA handoff 16848`. Queue it with an explicit native source version and source ref.
It compares the agent's Git HEAD with `Build.SourceVersion` and publishes `sha-handoff-evidence`.
SDK pipeline parameters are recorded but never used to generate SDKs, create PRs, or publish packages.
The probe verifies SHA transport and checkout, not TypeSpec compilation or SDK output. Only test-tagged
release plans should be used for caller-side persistence tests; retire them after validation.
