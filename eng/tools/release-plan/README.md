# Release plan automation

Discovers a versioned release plan from a merged spec PR, refreshes its SDK details, and generates SDKs
from its confirmed target. Requires Node.js >=24.14.1, the repository's pnpm dependencies, and an
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
  requests eligible management-plane SDKs using the artifact's API version and stored commit pin.

Use `--repo Azure/azure-rest-api-specs-pr` for private specs and `--test-release-plan true` when creating
test plans. Private previews retain API-version/project/PR identity checks and the general update that
can finish a merged tracking plan; they do not receive public-target flags or generate SDKs.

## Target and checkout requirements

- Prepare a clean, separate checkout at the event's full merge SHA before discovery or public SDK
  details updates. Keep the artifact outside that checkout. Automation never switches, resets,
  stashes, or fetches the checkout.
- Same-version updates require complete commit ancestry (pipeline checkout: `fetchDepth: 0`). Missing
  or divergent history fails closed; older events cannot roll back a newer pin.
- Recognized SDK metadata configurations must have a package and agree on one concrete API version.
  Non-SDK emitters such as AutoRest's `unknown` entry are ignored, not used as version fallbacks.
- A combined PR/project/version lookup selects by project/version/release type, not strictly by PR.
  Returned identities are checked before updating; lookup failures never authorize creation.
- Public mutations supply `--api-version`, `--spec-commit-sha`, and `--confirm-target` together.
  Confirmation authorizes that specific target, not a newly inferred default. Updates also supply
  `--expected-spec-commit-sha` from discovery (or `none` for an observed unpinned plan); SDK details
  updates use the artifact's pin. A concurrency conflict stops processing without a blind retry.
- SDK generation validates the unchanged artifact against the current plan and passes
  `--require-merged-spec true`. ID-only generation uses the stored target, never current metadata.

## Validation and rollout

From this package, run `pnpm check` for type checking, lint, formatting checks, and tests. Tests mock
Git, GitHub, and azsdk boundaries; no release plans or SDK pipelines are created.

Deploy a compatible azsdk CLI before enabling this automation: `release-plan update` and
`update-spec-pr` must accept `--expected-spec-commit-sha`, and generation must support the version,
commit, and merged-spec arguments above. Unsupported CLI options, confirmation previews, and
structured failures stop the workflow rather than falling back to an unpinned target.

For generation completion guards, the selected spec commit must also contain the compatible
generation pipeline template and `Confirm-ReleasePlan-Generation.ps1` helper. Historical snapshots
with older pipeline definitions are not protected merely by upgrading the CLI. The worker checks
its saved build inputs before pushing SDK changes and conditionally records only the current build's
result before adding the auto-release label. These checks validate job provenance, not the API version
actually emitted in every language's generated code.

