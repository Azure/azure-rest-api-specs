# Private SDK native checks POC

This alternative uses the existing Azure Pipelines GitHub integration to report native
pipeline-definition results. GitHub reads checks and trusted default-branch configuration,
not ADO artifacts. No GitHub-to-ADO authentication, custom Checks API writes, new App, or
GitHub-writing credential in PR-executing jobs is needed. Public-repository consumers
retain their existing artifact-based behavior.

## Result contract

Provision distinct **pipeline definitions**, not just jobs or stages, for each language:

| Definition role | YAML entry point | Native success means |
| --- | --- | --- |
| Validation | `eng/pipelines/spec-gen-sdk-native-validation.yml` | Required generation/build passed, or the runner's runtime requiredness exempts this execution |
| Breaking present | `eng/pipelines/spec-gen-sdk-native-breaking-present.yml` | Successful generation and complete explicit analysis found a breaking change |
| Breaking absent | `eng/pipelines/spec-gen-sdk-native-breaking-absent.yml` | Successful generation and complete explicit analysis found no breaking changes |

Only native `success` and `failure` mappings are relied on. Read-only integration samples
verified ADO `succeeded` -> GitHub `success` and ADO `failed` -> GitHub `failure` for
Azure Pipelines (App ID `9426`, slug `azure-pipelines`). No mapping is assumed for
`partiallySucceeded`, cancellation, warnings, skipped analysis, or other states.

Each label predicate performs its **own generation and analysis**, using
`azsdk pkg detect-breaking-change` for every generated package of every applicable
TypeSpec project. A boolean must be returned for every package, with no generation
errors. Missing package paths, OpenAPI-only projects, empty package sets, skipped
generation, analyzer errors, and incomplete coverage prove neither predicate.
The existing manifest's `labelAction` is deliberately not evidence.

The private consumer authenticates the App, exact check name, definition ID, project
GUID, and PR head SHA. Native `external_id` is `definitionId|buildId|projectGuid`.
It selects the greatest ADO build ID, then greatest native check ID, **within each
definition**; malformed or ambiguous attempts cannot uncover an older success.
It fetches all check attempts rather than relying on GitHub's name-based latest filter.

Both label definitions must have completed with `success` or `failure`. Exactly one
success permits that definition's independently proven assertion: present adds the
configured label; absent removes it. A failure is never interpreted as the opposite
finding. Missing/running/unknown evidence, two successes, and two failures preserve
existing labels with a warning. A newer attempt of a predicate supersedes its older
success, even when it fails. Additions retain the existing target-branch restriction;
removals are not restricted. The live PR head is rechecked before label writes.

Validation definitions encode the runner's runtime requiredness, including the .NET
actual-generation exemption and provisioning-emitter exemptions. Trusted configuration
can additionally make a definition advisory; it does not reconstruct runtime requiredness.
A required native failure fails `SDK Validation Status`; missing/running/unknown required
checks leave it pending. No configured definitions also leaves it pending.

The native runner's exit status, not the legacy unconditional `|| true`, determines
the native Generate SDK task result. Its captured output has logging-command markers
escaped before replay so child `task.complete` commands cannot override the predicate.
The existing checkout authentication is unchanged. The native entry points do not
publish generated SDK artifacts or create SDK pull requests.

## Deployment prerequisites

Nothing is provisioned or triggered by this POC. All three entry points use
`trigger: none` and `pr: none`. The trusted configuration is intentionally empty,
so installing the private consumer before configuring definitions leaves status pending.

1. Copy the reviewed code to the private repository's trusted default branch. The new
   private workflow replaces the old private status/label jobs; deploy them together.
2. Create three private Azure Pipelines definitions per participating language, each
   pointing to its corresponding YAML entry point. Use the existing GitHub service
   connection/integration and existing private SDK checkout credentials. Set `SdkRepoUrl`
   to the appropriate private SDK repository and preserve existing emitter/toolchain
   variables. Lock down changes to the definitions and their signal roles.
3. Explicitly enable PR validation through the Azure Pipelines UI trigger override, with
   matching branch/path applicability across the three definitions. Validation must run
   for every PR on which the aggregate status is required; otherwise absent checks remain
   pending. Do not rely on a pipeline-resource-triggered run inheriting the originating
   PR/head association.
4. Ensure the private agents can install and run an azsdk CLI version with
   `pkg detect-breaking-change`. Unsupported languages/project shapes remain unknown,
   not a clean result. Validation-only definitions do not force this extra dependency.
5. In `.github/workflows/src/native-sdk-checks-config.ts`, add each language's exact
   native names (including the private ` - PR` suffix), provisioned numeric definition
   IDs, project GUID, required/advisory policy, and optional label predicate definitions.
   Do not substitute public definition IDs or guess private IDs. For example:

   ```ts
   {
     language: "azure-sdk-for-js",
     required: true,
     validation: { name: "SDK Validation - JS - PR", definitionId: validationId, projectId },
     breakingChange: {
       label: "BreakingChange-JavaScript-Sdk",
       present: { name: "SDK Breaking Present - JS - PR", definitionId: presentId, projectId },
       absent: { name: "SDK Breaking Absent - JS - PR", definitionId: absentId, projectId },
     },
   }
   ```

6. With separate authorization, verify actual private checks attach to the PR **head**
   SHA, use the expected external IDs/App/names, and report predicate exit codes as
   native `success`/`failure`. Exercise findings, clean analysis, analyzer crashes,
   no generation, canceled/missing checks, and same-head reruns before enabling the
   aggregate as a merge gate. Confirm branch protection uses the aggregate, not the
   intentionally failing nonmatching predicate check.

## POC limits

This costs **three independent generation/build executions per language**, plus explicit
analysis in the two label definitions. These are not paired signals from one common
generation attempt. Each can use a different SDK checkout snapshot/tool version; the
native external ID identifies only its own run. There is no common scan epoch or
atomic rerun across definitions. Contradictions preserve labels, and per-definition
freshness does not guarantee a unified generation snapshot.

Fresh azsdk analysis is a POC prerequisite, not a verified equivalence claim for every
legacy language's breaking-change labeling or suppression policy. Validate the selected
CLI's policy and package coverage for each language before deploying its predicates.

Private end-to-end provisioning and native state transport for these new definitions
have not been exercised. The verified public mapping samples do not establish that
private configuration, triggers, or permissions are already correct.

This is deliberately not a replacement for full SDK metadata transport: GitHub cannot
recover package lists, generated .NET files for SDK review, detailed runtime explanations,
or release-plan inputs from these native states. Generated-package review and release-plan
orchestration are outside this POC.
