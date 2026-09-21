# Azure TypeSpec Assessment Design

## Goal

Document the current architecture and invariants of
`.github/skills/azure-typespec-assessment`.

The assessment is a read-only review of the current TypeSpec Git diff. It
compares the merge base of `HEAD` and a selected branch with `HEAD` plus
staged, unstaged, and relevant untracked changes.

Included:

- semantic understanding from changed TypeSpec and AutoRest;
- REST breaking candidates from AutoRest;
- downstream SDK breaking candidates from TCGC;
- documentation-grounded Azure Guidelines assessment using deterministic
  reference-category tags, required-document routing, and targeted discovery;
- one deterministic check that each changed compiler declaration has nonempty
  effective documentation;
- optional bounded AI inference for source hunks that deterministic analysis
  cannot classify;
- one bounded Agent judgment;
- validated `assessment.json`;
- readable `assessment.html`.

All five dimensions are active. Documentation Completeness checks compiler
documentation presence without judging prose. Overall safety
continues to cover REST and downstream SDK compatibility only.
Changed declaration scope uses actual added and removed lines, including an
immediately attached documentation/decorator prefix. Declarations present only
as unified-diff context are excluded.

### Deferred: HTTP breaking-change tool integration

A future version may consume HTTP diffs from the breaking-change tool and
interpret them as REST compatibility evidence. This is not implemented in v1:
REST candidates still come from the existing AutoRest contract comparison.
Any integration must preserve baseline/API-version provenance, source linkage,
and the separation of REST compatibility from downstream SDK impact.

### Invocation and performance boundaries

Run the documented CLI directly, including when the installed skill is a
directory junction or symbolic link. The shared entrypoint guard resolves that
link; a successful command must produce its documented output, not silently
skip execution. Specification paths may be absolute or repository-relative;
normalize them relative to `--repo` before deriving sparse roots.

The coordinator is the first operational command for local, PR, and explicit
base/head assessments. PR mode accepts `--pr`, resolves metadata with one
authenticated GitHub request, fetches only missing objects, and derives changed
TypeSpec service roots. Explicit comparison mode accepts `--base` and `--head`.
Neither mode requires an outer checkout or manual repository/project discovery.
Local mode retains staged, unstaged, and untracked overlays; immutable PR/head
mode excludes them.

Production behavior lives under `scripts/`. Code under `evals/` and test files
is not imported or used by the runtime.

The coordinator bootstraps the skill's own locked dependencies before loading
the assessment implementation. When the installed `yaml` version is missing or
does not match `package-lock.json`, it runs lifecycle-script-free `npm ci` in
the skill directory under an installation lock. Normal downstream commands
reuse that installation because the coordinator is always the first command.

Separate invocation retries, dependency setup, compilation, analyzer work,
Agent/tool waits, and finalization when reporting elapsed time. The preparation
manifest's `totalMs` includes dependency setup, not just compiler work.
Preparation detects npm or pnpm from `package.json` and the repository
lockfile. npm retains the shared cached `node_modules` path; pnpm requires an
exact `packageManager` version, installs once per sparse worktree with a frozen
lockfile, and reuses a shared content-addressed store. Both modes disable
lifecycle scripts and verify required TypeSpec package versions against the
selected revision's lockfile. The dependency fingerprint includes package
metadata, lockfile and workspace configuration, platform, and architecture.
Do not skip compatibility checks or reuse a mismatched toolchain for speed.

## End-to-end flow

```text
                                                 Current TypeSpec Git diff
                                                              |
                                                              v
                                        Deterministic preparation and compilation
                                               (source index + AutoRest + TCGC)
                                                              |
                                                 preparation-manifest.json
                                                 source/source-index.json
                                                              |
              +-----------------------+-----------------------+-----------------------+-----------------------+
              |                       |                       |                       |                       |
              v                       v                       v                       v                       v
           Semantic                  REST                 Downstream           Azure Guidelines       Documentation Completeness
        Deterministic           Deterministic           Deterministic           Deterministic           Deterministic
         review units            candidates              candidates            search requests          review units
                                                                                                     (compiler declarations
                                                                                                      and presence)
              |                       |                       |                       |                       |
              +-----------------------+-----------------------+-----------------------+                       +--> Retain for guarded finalization
                                                              |
                                                              v
                                              Collect bounded Agent inputs
                                          (canonical artifacts + bounded references)
                                                              |
                                                              v
                                                       model-input.json
                                                              |
                                                              v
                                              Check deterministic hunk coverage
                                                              |
                                                       +------+------+
                                                       |             |
                                               all classified    unknown hunks
                                                       |             |
                                                       |             v
                                                       |      Add bounded inference
                                                       |      requests to Agent input
                                                       |             |
                                                       +------+------+
                                                              |
                                                              v
                                                  One bounded Agent judgment
              +-----------------------+-----------------------+-----------------------+
              |                       |                       |                       |
              v                       v                       v                       v
         Summarize each          Classify each           Classify each          Rank and fetch
         semantic intent         deterministic or        deterministic or       official guidance,
         once                    inferred REST           inferred SDK           then assess each
                                 candidate               candidate              intent once
              |                       |                       |                       |
              +-----------------------+-----------------------+-----------------------+
                                                              |
                                                              v
                                            agent-workspace/agent-decisions.json
                                                              |
                                                              v
                                              Deterministic materialization
                                       (canonical joins + ordering + validation)
                                                              |
                          +-----------------------------------+-----------------------------------+
                          |                                   |                                   |
                          v                                   v                                   v
               inference.json (when needed)      assessment-judgment.json      compliance-search-evidence.json
                                                                                 (Azure Guidelines evidence only)
                          |                                   |                                   |
                          +-----------------------------------+-----------------------------------+
                                                              |
                                                              v
                                          Materialized Agent artifacts       Documentation Completeness input
                                                       |                                      |
                                                       +------------------+-------------------+
                                                                          |
                                                                          v
                                                               Guarded finalization
                                                         (assemble, validate, and render)
                                                              |
                                                              v
                                            assessment.json + assessment.html
```

Preparation, dimension analysis, materialization, and coverage accounting are
deterministic. No Node.js script calls an LLM or performs Agentic Search. The
Agent writes one compact decision artifact from bounded input. Deterministic
materialization validates it, joins canonical evidence, and atomically writes
`inference.json` when needed, `compliance-search-evidence.json`, and
`assessment-judgment.json`. Guarded finalization validates and assembles those
artifacts into the report.

Azure Guidelines and documentation assessment branch from Semantic review
units rather than REST or downstream candidates. Documentation Completeness is
deterministic, bypasses Agent input and materialization, and joins the
materialized artifacts during guarded finalization. Documentation checks still
run when a hunk has no compatibility impact. Inference runs only for hunks
whose deterministic coverage status is `unknown`; the Agent records the compact
decision and the materializer writes `inference.json`.

## 1. Preparation manifest

File: `preparation-manifest.json`

```json
{
  "schemaVersion": 1,
  "repository": {
    "root": "C:\\repo",
    "remoteUrl": "https://github.com/Azure/azure-rest-api-specs"
  },
  "comparison": {
    "baseRef": "origin/main",
    "mergeBaseCommit": "base-sha",
    "headCommit": "head-sha",
    "workingTree": {
      "staged": true,
      "unstaged": true,
      "untracked": true
    }
  },
  "sparseCheckout": {
    "mode": "cone",
    "roots": ["specification/<service>"],
    "verified": true
  },
  "dependencySetup": {
    "baseline": {
      "manager": "npm|pnpm",
      "managerVersion": "11.8.0|null",
      "lockFile": "package-lock.json|pnpm-lock.yaml",
      "fingerprint": "<sha256>",
      "reused": false,
      "durationMs": 1000
    },
    "target": {
      "manager": "npm|pnpm",
      "managerVersion": "11.8.0|null",
      "lockFile": "package-lock.json|pnpm-lock.yaml",
      "fingerprint": "<sha256>",
      "reused": true,
      "durationMs": 100
    }
  },
  "changedFiles": [
    {
      "path": "specification/<service>/<project>/main.tsp",
      "status": "added|modified|removed",
      "origins": ["committed", "staged", "unstaged", "untracked"]
    }
  ],
  "projects": [
    {
      "id": "project-<hash>",
      "path": "specification/<service>/<project>",
      "sourceChangeIds": ["source-<hash>"],
      "artifactComparison": {
        "mode": "new-api-version|existing-api-version|unversioned",
        "baseline": {
          "sourceRevision": "base|current",
          "commit": "base-sha|head-sha",
          "apiVersion": "2025-01-01",
          "reason": "previous-latest-stable|previous-latest-preview|affected-existing-version|unversioned"
        },
        "target": {
          "sourceRevision": "current",
          "commit": "head-sha",
          "apiVersion": "2026-01-01-preview",
          "reason": "newest-added-version|affected-existing-version|unversioned"
        },
        "addedVersions": ["2026-01-01-preview"],
        "available": {
          "base": ["2025-01-01"],
          "current": ["2025-01-01", "2026-01-01-preview"]
        }
      },
      "artifacts": {
        "baseline": {
          "autorest": {
            "status": "succeeded|failed",
            "format": "swagger-2.0",
            "sourceRevision": "base|current",
            "sourceCommit": "base-sha|head-sha",
            "selectedApiVersion": "2025-01-01",
            "files": [
              {
                "path": "projects/<id>/baseline/autorest/stable/2025-01-01/openapi.json",
                "apiVersion": "2025-01-01",
                "documentRole": "primary|feature|common",
                "contentHash": "<sha256>"
              }
            ],
            "serviceManifestPath": "projects/<id>/baseline/autorest/service.yaml",
            "command": {
              "executable": "node_modules\\.bin\\tsp.cmd",
              "args": []
            },
            "exitCode": 0,
            "durationMs": 1000,
            "configPath": "worktrees/<sourceRevision>/<project>/tspconfig.yaml",
            "configHash": "<sha256>",
            "logPath": "logs/<id>-baseline-autorest.log"
          },
          "tcgc": {
            "status": "succeeded|failed",
            "format": "tcgc-yaml",
            "sourceRevision": "base|current",
            "sourceCommit": "base-sha|head-sha",
            "selectedApiVersion": "2025-01-01",
            "files": [
              {
                "path": "projects/<id>/baseline/tcgc/tcgc-output.yaml",
                "contentHash": "<sha256>"
              }
            ],
            "command": {
              "executable": "node_modules\\.bin\\tsp.cmd",
              "args": []
            },
            "exitCode": 0,
            "durationMs": 1000,
            "configPath": "worktrees/<sourceRevision>/<project>/tspconfig.yaml",
            "configHash": "<sha256>",
            "logPath": "logs/<id>-baseline-tcgc.log"
          }
        },
        "target": {
          "autorest": {},
          "tcgc": {}
        }
      }
    }
  ],
  "blockers": [],
  "timings": {
    "totalMs": 0
  }
}
```

Preparation rules:

1. Resolve `git merge-base HEAD <baseline>`.
2. Capture committed, staged, unstaged, and relevant untracked TypeSpec files.
3. Discover affected `tspconfig.yaml` project roots.
4. Create detached service-scoped sparse base/current worktrees for source
   analysis. Artifact roles may both use the current worktree.
5. Apply dirty overlays only to the temporary current worktree.
6. Detect and prepare the locked npm or pnpm toolchain for each worktree.
7. Select one source revision and API version for each artifact-comparison
   role.
8. Compile AutoRest and TCGC with the same source revision and API version for
   each role.
9. Preserve commands, logs, exit codes, timings, and hashes.

Dependency setup rules:

1. Select npm when `package-lock.json` is the sole lockfile and no package
   manager is declared. An exact npm declaration may also select it.
2. Select pnpm only when `packageManager` declares an exact pnpm version and
   `pnpm-lock.yaml` is present. Reject missing, ambiguous, or unsupported
   package-manager inputs.
3. Run npm with `npm ci`; cache the resulting `node_modules` by dependency
   fingerprint and junction it into matching sparse worktrees.
4. Run the declared pnpm version through `npx`, with `--frozen-lockfile`,
   `--ignore-scripts`, and a shared store. Install separately in each sparse
   worktree so workspace links resolve in that revision.
5. Preflight the required TypeSpec packages against the applicable npm or pnpm
   lockfile before compilation. Multi-document pnpm lockfiles are supported.
6. On Windows, invoke npm, pnpm, and TypeSpec JavaScript CLIs directly through
   Node rather than passing `.cmd` arguments through a shell.

API-version policy:

1. Source analysis always compares the merge-base source with current source,
   including dirty overlays.
2. When current source adds an API version:
   - baseline artifact: current source projected to the previous latest stable
     version;
   - if no previous stable exists, use the previous latest preview;
   - target artifact: current source projected to the newest added version.
3. When an existing API version is modified:
   - baseline artifact: merge-base source projected to the affected version;
   - target artifact: current source projected to the same affected version.
4. For an unversioned service:
   - baseline artifact: merge-base unversioned source;
   - target artifact: current unversioned source.
5. AutoRest and TCGC always use the same source revision and API version within
   each comparison role.

For PR 44988, both artifact roles use the head source:

```text
baseline = head source @ previous latest stable Network API version
target   = head source @ 2025-09-01
```

For PR 43308, which modifies an existing version:

```text
baseline = base source @ 2026-05-01-preview
target   = head source @ 2026-05-01-preview
```

Version-aware REST classification:

- In `new-api-version` mode, baseline-to-target wire differences describe
  version-scoped REST evolution and appear in Semantic operation cards.
- They do not create REST breaking findings solely because the newly added
  version differs from the previous version.
- The baseline projection must be successfully produced from current source;
  this proves the previous stable/preview version remains representable by the
  final TypeSpec.
- TCGC differences may still be downstream SDK breaking when the generated
  public method/type identity is reused across the version transition.
- In `existing-api-version` and `unversioned` modes, incompatible
  baseline-to-target wire differences are REST breaking candidates.

### Normative case: PR 44988

PR 44988 publishes Microsoft.Network API version `2025-09-01`. It uses
`new-api-version` artifact comparison: both roles compile the head source,
with the previous latest stable Network version as baseline and `2025-09-01`
as target.

The expected coherent Semantic intents are:

1. Publish the `2025-09-01` Network API version — 101 operations.
2. Add address prefix set child resources — 4 operations.
3. Add ExpressRoute LAG resources — 11 operations.
4. Allow AFC-managed firewall policy writes — 1 operation.
5. Add firewall policy Kubernetes selector groups — 4 operations.
6. Add first-party service tag resources — 6 operations.
7. Add network virtual appliance migration actions — 4 operations.
8. Add Connection Analyzer resources and query behavior — 6 operations.
9. Make service gateway update actions synchronous — 2 operations.
10. Add effective-route retrieval for virtual network gateways — 1 operation.
11. Add virtual-network IP configuration move behavior — 1 operation.

The API-version publication intent uses bounded rendering: show 3
representative operations and retain all 101 in JSON.

The service gateway intent has action `modify` and exactly two affected REST
operations:

- `ServiceGateways_UpdateAddressLocations`;
- `ServiceGateways_UpdateServices`.

The Semantic intent summarizes the shared change from LRO/202/Location
behavior to synchronous/200/`ServiceGatewayActionOkResponseBody` behavior in
`2025-09-01`. Its two operations remain deterministic supporting evidence;
they do not receive separate Semantic judgments. This is version-scoped REST
evolution, not a REST breaking finding.

Downstream contains two direct SDK method groups. Each merges `lro` to `basic`,
LRO metadata removal, response-type change, and explicitly unchanged
parameters. The versioned `updateAddressLocationsLro` and
`updateServicesLro` declarations are supporting TypeSpec evidence that
preserves the previous projection; they do not create additional target REST
operations because they retain the original operation IDs for older versions.

## 2. Source index

File: `source/source-index.json`

```json
{
  "schemaVersion": 1,
  "analysis": {
    "engine": "typespec-compiler",
    "compilerVersion": "<version>",
    "status": "ready|blocked"
  },
  "compilerEvidence": {
    "compiler-evidence-<hash>": {
      "id": "compiler-evidence-<hash>",
      "kind": "symbol-reference|template-instantiation|decorator-governance|operation-projection",
      "revision": "base|current",
      "sourceDeclarationId": "declaration-<hash>",
      "targetDeclarationId": "declaration-<hash>",
      "operationId": "Widgets_Get",
      "sourceLocation": {
        "path": "main.tsp",
        "startLine": 10,
        "endLine": 15
      }
    }
  },
  "referencedDeclarations": {
    "declaration-<hash>": {
      "id": "declaration-<hash>",
      "kind": "operation|model|template|trait|alias|enum|union",
      "qualifiedName": "Widgets.get",
      "revision": "base|current",
      "changed": false,
      "source": {
        "path": "main.tsp",
        "startLine": 30,
        "endLine": 35
      }
    }
  },
  "sourceChanges": [
    {
      "id": "source-<hash>",
      "path": "specification/<service>/<project>/models.tsp",
      "status": "added|modified|removed",
      "origins": ["committed", "unstaged"],
      "hunks": [
        {
          "id": "hunk-<hash>",
          "base": {
            "startLine": 10,
            "endLine": 12
          },
          "current": {
            "startLine": 10,
            "endLine": 15
          },
          "lines": [
            " model Widget {",
            "-  name: string;",
            "+  name: WidgetName;"
          ],
          "declarationOccurrenceIds": ["declaration-occurrence-<hash>"],
          "normalizedChanges": [
            {
              "kind": "type-change",
              "declarationOccurrenceId": "declaration-occurrence-<hash>",
              "before": "string",
              "after": "WidgetName"
            }
          ]
        }
      ],
      "declarations": [
        {
          "id": "declaration-<hash>",
          "occurrenceId": "declaration-occurrence-<hash>",
          "kind": "model|property|operation|interface|enum|union|alias",
          "qualifiedName": "Widgets.cancel",
          "compilerNodeKind": "OperationStatement",
          "decorators": ["@added(Versions.v2)"],
          "versionedMembers": ["@added(Versions.v2)"],
          "hunkIds": ["hunk-<hash>"],
          "references": [
            {
              "kind": "type-reference|template-reference|decorator-reference|import",
              "targetDeclarationId": "declaration-<hash>"
            }
          ],
          "instantiations": [
            {
              "templateDeclarationId": "declaration-<hash>",
              "operationDeclarationId": "declaration-<hash>",
              "compilerEvidenceId": "compiler-evidence-<hash>"
            }
          ],
          "source": {
            "revision": "base|current",
            "startLine": 10,
            "endLine": 15,
            "link": "https://github.com/...#L10-L15"
          }
        }
      ]
    }
  ]
}
```

Changed declarations/members are indexed with their complete changed-source
evidence. The bounded `referencedDeclarations` registry additionally retains
identity, kind, revision, and source location for unchanged declarations
required to prove a reference, template instantiation, or affected operation.
It does not retain unrelated unchanged declarations or unchanged source text.
Commit-backed source gets a GitHub link; dirty working-tree evidence uses local
path and line metadata.

Semantic source indexing requires the TypeSpec compiler AST/program for both
base and current revisions. It uses compiler node spans and symbol resolution
to associate hunks with declarations, references, decorators, imports, and
template instantiations. Regex or serialized-text matching is not an accepted
fallback for successful semantic analysis.

`normalizedChanges` records deterministic declaration-level transforms needed
for coherent grouping, such as type changes, decorator additions/removals,
operation signature changes, import changes, and documentation changes.

If compiler AST/program evidence cannot be produced, source indexing records a
blocker and the Semantic dimension becomes `not-assessed`. REST and downstream
dimensions may continue independently when their emitter evidence is
available. The report must not present regex-derived Semantic intents with
reduced or implied confidence.

## 3. Semantic analysis input

File: `dimensions/semantic-intents-input.json`

The original plan used AutoRest-change-first review units:

```json
{
  "schemaVersion": 1,
  "status": "ready|blocked",
  "facts": {
    "operation-<hash>": {
      "id": "operation-<hash>",
      "projectId": "project-<hash>",
      "comparisonRole": "baseline|target",
      "sourceRevision": "base|current",
      "sourceCommit": "base-sha|head-sha",
      "apiVersion": "2026-01-01-preview",
      "operationId": "Widgets_Get",
      "method": "get",
      "path": "/widgets/{id}",
      "parameters": [],
      "request": {},
      "responses": [],
      "paging": {},
      "lro": {}
    }
  },
  "reviewUnits": [
    {
      "id": "semantic-<hash>",
      "projectId": "project-<hash>",
      "resourceFamily": "Widgets",
      "changeKind": "added|modified|removed|version-propagation",
      "changedAspects": ["responses"],
      "sourceChangeIds": ["source-<hash>"],
      "declarationIds": ["declaration-<hash>"],
      "referenceCategories": ["arm-resource-type"],
      "referenceCategoryEvidence": [],
      "operationIds": ["operation-<hash>"],
      "beforeFactIds": ["operation-<hash>"],
      "afterFactIds": ["operation-<hash>"]
    }
  ],
  "blockers": []
}
```

The approved follow-up refactor changes this to TypeSpec-source-first:

```json
{
  "schemaVersion": 1,
  "status": "ready|blocked",
  "facts": {
    "operation-<hash>": {}
  },
  "reviewUnits": [
    {
      "id": "semantic-<hash>",
      "projectId": "project-<hash>",
      "action": "add|remove|modify",
      "changeKind": "add|remove|modify",
      "sourceChangeIds": ["source-<hash>"],
      "hunkIds": ["hunk-<hash>"],
      "declarationIds": ["declaration-<hash>"],
      "declarationNames": ["ScenarioRuns.cancel"],
      "groupingEvidence": [
        {
          "kind": "operation-references-declaration|template-instantiation|same-declaration-behavior|decorator-governance|same-operation-set|identical-declaration-transform|supporting-source-dependency",
          "fromHunkIds": ["hunk-<hash>"],
          "toHunkIds": ["hunk-<hash>"],
          "declarationIds": ["declaration-<hash>"],
          "factIds": ["operation-<hash>"]
        }
      ],
      "operations": [
        {
          "operationId": "ScenarioRuns_Cancel",
          "beforeFactId": "operation-<hash>",
          "afterFactId": "operation-<hash>",
          "restChanged": false,
          "matchBasis": "operation-identity|contract-containment|template-instantiation|version-decorator-governance",
          "mappingSummary": "Changed TypeSpec operation ScenarioRuns.cancel compiles to ScenarioRuns_Cancel.",
          "mappingEvidence": [
            {
              "kind": "operation-identity",
              "sourceChangeIds": ["source-<hash>"],
              "hunkIds": ["hunk-<hash>"],
              "declarationIds": ["declaration-<hash>"],
              "factIds": ["operation-<hash>"]
            }
          ]
        }
      ],
      "operationIds": ["operation-<hash>"],
      "beforeFactIds": ["operation-<hash>"],
      "afterFactIds": ["operation-<hash>"],
      "changedAspects": []
    }
  ],
  "blockers": []
}
```

Every meaningful changed TypeSpec hunk must be covered once even when there is
no directly affected REST operation or the REST contract is unchanged.

### Semantic intent grouping

Semantic intents are grouped by **coherent TypeSpec change**, not mechanically
by file, declaration, REST operation, or Git hunk. A coherent change is one
user-reviewable API behavior goal implemented by one or more related TypeSpec
hunks.

Cross-file grouping is allowed. For example, an LRO helper change, a polling
response model, and the operations that consume them may form one intent when
they jointly implement the same Location-based polling behavior.

Two hunks may be grouped only when deterministic TypeSpec evidence establishes
at least one of these relationships:

1. a changed operation directly references the changed model, alias, template,
   trait, or helper;
2. a changed template, trait, or helper is instantiated by the changed
   operation;
3. changed declarations are members of the same model or interface and express
   one indivisible behavior change;
4. a versioning or decorator change directly governs the changed declaration;
5. multiple changes have the same affected REST operation set and one cannot
   accurately describe the API behavior without the others.
6. independent declarations undergo the same normalized semantic transform,
   such as `string` to `Azure.Core.armResourceIdentifier` or a batch of
   language-specific `@clientName` additions.
7. an import-only, `using`-only, suppression-only, or documentation-only hunk
   directly supports another changed declaration in the same behavior change,
   and symbol/import resolution proves that dependency.

Do not group hunks merely because they are in the same file, project, resource
family, or pull request. Keep independent changes separate, including SDK
naming customizations, scalar/type corrections, documentation-only changes,
and unrelated operations that happen to use the same shared helper.

Identical transforms form their own coherent group; they do not merge with
other behavior groups. For example, all ARM identifier corrections may form
one intent, and all C# naming additions may form another, but neither merges
into the Location-based LRO intent.

Grouping is deterministic and happens before Agent judgment. The Agent writes
the title and summary for each supplied group but cannot merge, split, or move
hunks between groups.

### Bounded Semantic judgment

Semantic judgment is **intent-level only**. The Agent receives one compact
synopsis per deterministic review unit:

- action and grouped declaration names/kinds;
- changed TypeSpec constructs and up to three representative source excerpts;
- affected REST operation count and up to three representative operation
  identities;
- aggregate REST and downstream change signals; and
- deterministic grouping and mapping summaries.

The Agent produces one concise title and one behavior summary for the review
unit. It does not explain, classify, or restate every affected operation.
Complete operation facts, before/after contracts, and source inventories remain
deterministic evidence outside the Semantic prompt. They are available to REST
and downstream candidate judgment when needed, but are not duplicated into
Semantic analysis.

The summary describes the user-visible API goal shared by the group. It must
not enumerate all operations, declarations, or hunks. Operation count and
representative examples provide scale and traceability without expanding the
Agent workload with the size of the affected operation set.

Each non-standalone group records structured `groupingEvidence`. Every evidence
entry identifies the allowed relationship kind and the exact hunk,
declaration, and compiled fact IDs supporting that relationship. A group
containing one standalone hunk uses an empty `groupingEvidence` array.

Each meaningful hunk belongs to exactly one semantic intent. Declarations may
appear in more than one hunk, but each declaration-hunk occurrence belongs to
only one intent. A hunk with no indexed declaration is still retained and
grouped using its imports, decorators, references, and surrounding source
evidence. If no deterministic relationship to another hunk exists, it becomes
a standalone intent.

A coherent group has one `action`:

1. use `add` when every selected affected REST operation is newly introduced;
2. use `remove` when every selected affected REST operation is removed;
3. otherwise use `modify` when any existing declaration or operation is
   modified;
4. otherwise use `modify` when the group contains both removals and additions
   representing one replacement or rename;
5. otherwise use `add` when the group contains additions only;
6. otherwise use `remove` when the group contains removals only.

Supporting added or removed models, helpers, imports, decorators, or
documentation do not override a `modify` action for existing API behavior.
Therefore, PR 43308's Location-based LRO group is `modify` even though it adds
`ScenarioRunInProgressResponse`.

Conversely, supporting changes to an existing registration, import, version,
or compatibility file do not turn a newly introduced API surface into
`modify`. For example, an intent whose selected operations are all absent from
the baseline and present in the target is `add`, even when its coherent source
group also contains a modified `main.tsp`.

For PR 43308, the intended high-level grouping is:

1. semantic Location-based LRO behavior for scenario execution and
   cancellation, including the shared helper and polling response changes;
2. ARM resource identifier type corrections;
3. C# SDK naming customizations.

Other independently changed operations remain separate unless they satisfy the
coherence rules above.

### Affected REST operation mapping

List only REST operations that are directly affected by the TypeSpec change.
Operation mapping is deterministic and compiler-backed. The Agent cannot add,
remove, or select operation mappings.

Each mapped operation records structured `mappingEvidence` containing the
mapping kind and exact source-change, hunk, declaration, and compiled fact IDs.
It also records a deterministic `mappingSummary`. HTML shows only this concise
summary; complete mapping and grouping provenance remains in
`assessment.json`.

Allowed mapping evidence:

1. **Operation identity:** a changed TypeSpec operation maps to its exact
   compiled AutoRest operation. Identity normalization supports both interface
   members such as `Widgets.get` → `Widgets_Get` and top-level operations such
   as `createLedgerEntry` → `CreateLedgerEntry`; punctuation and casing alone
   do not prevent an otherwise exact identity match.
2. **Contract containment:** a changed model, property, enum, union, or alias
   maps to an operation only when that exact changed declaration is contained
   in the operation's compiled request, response, parameter, or response
   header contract.
3. **Template instantiation:** a changed template, trait, or helper maps only
   to operations proven by compiler/source provenance to instantiate it.
4. **Version/decorator governance:** a changed version or decorator maps only
   to operations it directly governs.

Do not map an operation merely because:

- it references a broader shared model that contains or is related to the
  changed declaration;
- it is in the same interface, resource family, file, or project;
- its SDK method eventually returns a type related to the changed TypeSpec;
- its normalized operation fact contains a matching name or serialized text;
- a downstream TCGC change suggests that the operation may be related.

Transitive references count only when the exact changed wire declaration is
present in that operation's compiled REST contract. Downstream SDK propagation
may link a finding to an already mapped intent, but it cannot add an affected
REST operation.

Examples:

- A change to `ScenarioRuns.get` maps only to `ScenarioRuns_Get`.
- `ScenarioRunInProgressResponse` maps to `ScenarioRuns_Get` because that
  operation directly emits the response.
- `ScenarioRuns_Cancel` and `ScenarioConfigurations_Execute` are not added to
  that response-model intent merely because their SDK methods eventually
  return `ScenarioRun`.
- A shared helper change may map to several operations only when each
  operation is proven to instantiate that helper.

For a changed template, trait, or helper, retain **every proven consumer** in
the deterministic affected-operation inventory. A consumer remains
semantically affected even when its normalized AutoRest and TCGC outputs are
both unchanged, because its compiled behavior depends directly on the changed
TypeSpec abstraction. The intent records aggregate counts for REST-changed,
downstream-changed, and unchanged consumers; it does not require a Semantic
assessment for each consumer.

Do not reduce the affected-operation set to only operations with breaking
findings. Findings describe compatibility outcomes; they do not define the
source-derived semantic impact set.

If no operation is proven, retain the Semantic intent and report
`No directly affected REST operation deterministically established`. Do not
list plausible or ambiguous operations.

## 4. REST breaking input

File: `dimensions/rest-breaking-input.json`

```json
{
  "schemaVersion": 1,
  "status": "ready|blocked",
  "facts": {
    "rest-fact-<hash>": {
      "id": "rest-fact-<hash>",
      "projectId": "project-<hash>",
      "comparisonRole": "baseline|target",
      "sourceRevision": "base|current",
      "sourceCommit": "base-sha|head-sha",
      "apiVersion": "2026-01-01-preview",
      "operationId": "Widgets_Create",
      "method": "put",
      "path": "/widgets/{id}",
      "parameters": [],
      "request": {},
      "responses": []
    }
  },
  "candidates": [
    {
      "id": "rest-<hash>",
      "rule": "required-property-added",
      "defaultSeverity": "high",
      "actual": "Current request requires property mode.",
      "expected": "Existing requests remain valid without mode.",
      "operationIds": ["Widgets_Create"],
      "sourceChangeIds": ["source-<hash>"],
      "declarationIds": ["declaration-<hash>"],
      "evidenceFactIds": ["rest-fact-<hash>"],
      "reviewRequired": true
    }
  ],
  "blockers": []
}
```

Compared REST cases:

- operation removal or HTTP method/path change;
- parameter removal, requiredness, location, and wire type;
- request requiredness and schema;
- response status/header/schema;
- serialized property names and required properties;
- enum value removal or closed-enum restriction;
- paging and LRO HTTP behavior.

## 5. Downstream SDK breaking input

File: `dimensions/downstream-breaking-input.json`

Canonical SDK method:

```json
{
  "id": "sdk-method-<hash>",
  "crossLanguageDefinitionId": "Microsoft.Chaos.ScenarioRuns.cancel",
  "client": "Microsoft.Chaos.ScenarioRuns",
  "name": "cancel",
  "kind": "basic|paging|lro|lropaging",
  "access": "public",
  "parameters": [
    {
      "position": 0,
      "name": "runId",
      "type": "string",
      "optional": false,
      "onClient": false
    }
  ],
  "responseType": "Microsoft.Chaos.ScenarioRun",
  "operation": {
    "kind": "http",
    "path": "/scenarios/{scenarioName}/runs/{runId}/cancel",
    "uriTemplate": "/scenarios/{scenarioName}/runs/{runId}/cancel{?api-version}",
    "verb": "post",
    "parameters": [],
    "bodyParam": null,
    "responses": [],
    "exceptions": []
  },
  "paging": {},
  "lro": {}
}
```

Dimension output:

```json
{
  "schemaVersion": 1,
  "status": "ready|blocked",
  "facts": {
    "sdk-fact-<hash>": {
      "id": "sdk-fact-<hash>",
      "projectId": "project-<hash>",
      "comparisonRole": "baseline|target",
      "sourceRevision": "base|current",
      "sourceCommit": "base-sha|head-sha",
      "apiVersion": "2026-01-01-preview",
      "factKind": "method|model|enum|union|client|customization",
      "kind": "basic|paging|lro|lropaging"
    }
  },
  "rootCauses": [
    {
      "id": "downstream-root-cause-<hash>",
      "kind": "method-return-propagation|type-contract-propagation|enum-union-propagation|unresolved",
      "directCandidateIds": ["downstream-<hash>"],
      "propagatedCandidateIds": ["downstream-<hash>"],
      "methodFactIds": ["sdk-fact-<hash>"],
      "typeFactIds": ["sdk-fact-<hash>"],
      "referenceEvidence": [
        {
          "fromFactId": "sdk-fact-<hash>",
          "toFactId": "sdk-fact-<hash>",
          "kind": "parameter|response|property|lro-result|paging-item",
          "memberName": "segment",
          "location": "request-path|request-query|request-header|request-body|response-header|response-body"
        }
      ]
    }
  ],
  "candidates": [
    {
      "id": "downstream-<hash>",
      "rule": "method-response-changed",
      "defaultSeverity": "high",
      "actual": "ScenarioRuns.cancel has a different response type.",
      "expected": "ScenarioRuns.cancel preserves its SDK contract.",
      "crossLanguageDefinitionId": "Microsoft.Chaos.ScenarioRuns.cancel",
      "rootCauseIds": ["downstream-root-cause-<hash>"],
      "sourceChangeIds": ["source-<hash>"],
      "declarationIds": ["declaration-<hash>"],
      "evidenceFactIds": ["sdk-fact-<hash>"],
      "reviewRequired": true
    }
  ],
  "blockers": []
}
```

`factKind` is the evidence discriminator used by assembly and validation.
`kind` retains the native TCGC entity kind. For method facts it is
`basic|paging|lro|lropaging`; non-method facts retain their own normalized
TCGC kind. Never infer `factKind` from `kind`.

The downstream analyzer builds `rootCauses` before Agent judgment by traversing
normalized TCGC method-to-type and type-to-type reference edges. Candidates
carry their deterministic `rootCauseIds`. The Agent approves or rejects
candidates but cannot create, merge, split, or assign root causes.

Downstream analysis is independent from REST compatibility. It does not join,
deduplicate, suppress, count, or present REST operations. Normalized TCGC HTTP
metadata is retained only when it identifies the SDK-facing location of a
method parameter or type member. That evidence produces the six locations
`request-path`, `request-query`, `request-header`, `request-body`,
`response-header`, and `response-body`; it does not create a downstream-to-REST
relationship.

For each project and comparison role, build one indexed TCGC reference graph.
Graph nodes are public methods and named SDK types. Directed edges represent
method parameters, method responses, paging items, LRO results, model
properties, inheritance, collection elements, and union variants. Build
forward and reverse adjacency maps once, then locate affected public methods
by traversing reverse edges from each changed type. Cache traversal by changed
type identity so multiple member candidates on one type share one lookup.
Cycles use visited sets. Retain one shortest path per affected method and only
the unchanged bridge facts on those paths.

The expected cost is linear graph construction plus traversal of the relevant
subgraph. The analyzer must not rescan every method and recursively walk every
model for each candidate.

### Deterministic candidate rules

The downstream analyzer emits these candidate rules:

| Category       | Rule                            | Detected change                                                             |
| -------------- | ------------------------------- | --------------------------------------------------------------------------- |
| Method         | `method-removed`                | An existing SDK method is no longer generated.                              |
| Method         | `method-location-changed`       | A method moves to another client or operation group.                        |
| Method         | `method-kind-changed`           | `basic`, `paging`, `lro`, or `lropaging` changes.                           |
| Method         | `method-parameters-changed`     | The ordered public parameter contract changes.                              |
| Method         | `method-response-changed`       | The public response type changes.                                           |
| Method         | `method-access-changed`         | A previously public method is no longer public.                             |
| Method         | `method-paging-changed`         | Language-neutral paging metadata or behavior changes.                       |
| Method         | `method-lro-changed`            | Language-neutral long-running-operation behavior changes.                   |
| Model          | `model-property-removed`        | A public model property is removed.                                         |
| Model          | `model-property-changed`        | Property type, optionality, flattening, or access changes.                  |
| Model          | `model-property-added-required` | A required property is added.                                               |
| Enum           | `enum-values-removed`           | An enum value is removed or its SDK-facing identity changes.                |
| Enum           | `enum-extensibility-changed`    | A public enum changes between fixed and extensible representations.         |
| Public surface | `public-surface-changed`        | A model, enum, or union changes access, usage, reachability, or is removed. |
| Client         | `client-location-changed`       | Client name, owner, or parent changes.                                      |
| Customization  | `customization-changed`         | SDK customization decorators change.                                        |

Candidates are deterministic review inputs, not final findings. The Agent
approves or rejects each candidate according to
`references/downstream-breaking-cases.md`; only approved candidates become
findings. Root causes are separate deterministic aggregation records that
connect related candidates and facts but are not candidate rules.

For `model-property-added-required` candidates, Agent judgment must use the
model's effective direction:

- approve when the model is used as request/input, because existing callers
  must supply the new required member;
- reject when the model is response/output-only, because receiving an
  additional required response member does not invalidate existing callers;
- approve when the model is used in both directions, because the request/input
  contract is breaking.

PR 43308 is the required regression: parameters remain equal while
`ScenarioRuns.cancel` and `ScenarioConfigurations.execute` change from
`basic`/void to `lro`/`ScenarioRun` with Location polling metadata.

LRO comparison uses the language-neutral LRO behavior contract, not a second
copy of the method HTTP signature. Compare final-state-via, polling and final
steps, status-monitor behavior, logical/envelope/final results, and result
paths. Retain the originating operation method/path identity for provenance,
but ignore `lro.operation.uriTemplate` differences that only repeat a public
method parameter change. A query parameter added to both the method and its
nested LRO operation URI produces one `method-parameters-changed` finding, not
an additional `method-lro-changed` finding.

### Downstream SDK method and type presentation

Confirmed direct method candidates are grouped by SDK method identity into
`methodGroups`. Confirmed model, enum, union, and other named-type candidates
are grouped into `typeImpacts` by project and cross-language SDK type identity.
Each impact retains all deterministically proven request/response locations.
Candidate judgment remains independent: presentation grouping never merges
Agent decisions.

Root-cause and affected-method relationships come only from deterministic TCGC
method-to-type reference paths. Matching by project, source file, REST
operation, name coincidence, or simultaneous usage changes is insufficient.
An unchanged public method is still an affected SDK method when a changed type
is reachable through its request, response, paging, or LRO contract.

Presentation is method-first: one card per distinct mapped SDK method combines
direct method changes and indirect type causes. The collapsed summary exposes
the target method name, cause, and related Semantic intent links.

Expanding a method card shows its normalized before/after contract and nested
type causes. Parameters, properties, and enum members are rows, not independent
cards. Each type cause retains its finding IDs and displays only verified
method-specific paths, request/response locations, and baseline/target roles.
An indirect impact does not imply a changed top-level method signature.

The renderer uses explicitly supplied, matching downstream graph evidence.
Without it, recorded method associations remain visible but precise paths and
locations are unavailable. Root-wide location unions must not be presented as
per-method evidence. REST operation identity, HTTP method, and route are not
part of the downstream assessment contract.

Retain confirmed types without proven method mappings in fallback cards with
an explicit unresolved relationship reason. Never infer methods from Semantic
intent operations or discard a finding solely to fit the layout. Finding,
changed-type, and mapped-method counts remain distinct.

The bounded judgment procedure and candidate-specific compatibility rules are
defined in [Downstream SDK Breaking Cases](../references/downstream-breaking-cases.md)
and [Downstream Candidate Rules](../references/downstream-candidate-rules.md).

### Semantic and finding relationships

Relationships between Semantic intents and confirmed findings are
**bidirectional** and deterministic:

- each REST finding records its related Semantic intent IDs;
- each downstream SDK method group and SDK type impact records its related
  Semantic intent IDs;
- each Semantic intent records its related REST finding, downstream method
  group, and SDK type impact IDs.

The primary affected-operation list inside a Semantic intent contains REST
operations only. Static impact links target related SDK method cards or
unmapped-type fallback cards. Selecting a link opens its enclosing details;
relationship labels do not toggle the Semantic intent.

Allowed relationship evidence:

1. REST finding to Semantic intent: exact project, API version, and REST
   operation identity.
2. Downstream method group to Semantic intent: exact changed TypeSpec
   declaration identity, or exact candidate source ownership.
3. SDK type impact to Semantic intent: exact changed TypeSpec declaration
   identity from its findings. A deterministic TCGC path identifies affected
   SDK methods but does not transfer REST operation ownership.
4. Unique source fallback: allowed only when one and only one Semantic intent
   owns the relevant changed declaration/hunk and no stronger identity mapping
   exists.

Project-wide source lists are not unique source evidence. A downstream
candidate referencing every changed file in a project cannot use source
fallback.

When deterministic evidence cannot identify one or more correct relationships,
leave the item unlinked and record an unresolved relationship reason in JSON.
Do not link every plausible intent and do not ask the Agent to choose.

Validation requires:

- all relationship IDs exist and are unique;
- every stored relationship is reciprocal;
- every relationship includes its match basis;
- its match basis is supported by deterministic evidence;
- rejected findings are never linked;
- ambiguous or unsupported relationships remain absent.

## 6. Documentation-grounded Azure Guidelines

Azure Guidelines is an independent assessment dimension. It consumes Semantic
intents and their bounded TypeSpec query profiles while retaining links to the
complete deterministic source evidence. It does not consume or derive
conclusions from downstream SDK breaking input. Documentation Completeness is a
separate deterministic dimension and does not use this search.

### Goal and evidence boundary

Azure Guidelines assesses each Semantic intent once against applicable first-party
TypeSpec and Azure TypeSpec documentation. The decision uses the intent's
changed TypeSpec constructs and source evidence, but it does not assess each
affected REST operation or generate a document-by-declaration decision matrix.
It does not infer rules from generated OpenAPI, TCGC output, compiler
diagnostics, catalog descriptions, prior reports, or model knowledge.

The search uses the local [agentic search
procedure](../references/agentic-search.md) and its [official document
catalog](../references/reference-document-links.md). The copied catalog is
navigation metadata. Only successfully fetched page content can establish an
expected Azure Guidelines pattern.

Prefer explanatory guidance with embedded examples. A standalone official
sample is useful for a distinct pattern, but its incidental choices are not
normative requirements. Keep experimental agent resource types and the
Azure.Core resource-operation interface guides out of this catalog.

### Query profile

Build one query profile per Semantic intent from deterministic evidence:

- ARM or data-plane service kind;
- intent action and summary;
- changed declaration kinds and qualified names;
- decorators and augment decorators;
- templates, traits, base resource types, and operation interfaces;
- versioning, paging, LRO, warning-suppression, and client-customization
  constructs;
- normalized added and removed TypeSpec tokens;
- up to three representative source excerpts; and
- affected-operation counts, without operation-by-operation contracts.

The deterministic request retains the complete source/hunk inventory for
traceability, but the Azure Guidelines prompt is bounded to the compact intent
profile above. Operation facts are excluded because Azure Guidelines evaluates the
TypeSpec design intent, not each compiled operation.

### Select guidance from category tags

After existing grouping, publication consolidation, and intent-type assignment
finish, deterministic annotation adds `referenceCategories` and supporting
evidence without changing IDs, hunk membership, or operation mappings. The
three existing `intentType` values remain unchanged.

Eight tags map to the catalog headings: `arm-resource-type`,
`arm-resource-operation`, `api-versioning`, `long-running-operation`, `paging`,
`models-and-enums`, `decorators`, and `warnings`. An intent may have several
tags. An empty array creates targeted discovery rather than an assumed pass.
Informational version intents retain their exclusions despite descriptive tags.

Canonical routing chooses documents from tags, service plane, and changed
constructs. Global scoring, ranking, and the four-document quota are removed.
Required selections cannot be displaced by unrelated documents. **Evolving
APIs** is primary for existing-version evolution, even without changed version
decorators. ARM paging requires ARM template guidance, not low-level data-plane
decorators.

Deduplicate required URLs and retrieve missing content concurrently. Reuse
sufficient content and original provenance already available in the Agent
session; `retrievalSource` distinguishes `network` from `session-reuse`.
Preserve original timestamps and content hashes. No persistent cache or loader
is introduced. Missing sections, lost context, or explicit refresh requests
require retrieval rather than unsupported citations.

For explicit uncovered concerns, the Agent searches the canonical catalog and
records selected/no-match/blocked discovery outcomes. Necessary references
outside the catalog are explicit coverage gaps, not invented catalog IDs.
Missing required content or blocked discovery affects its owning intents.
Do not fetch filler documents, repeat cyclic references, or silently discard
required guidance to meet a budget.

### Extract applicable guidance

Search each fetched page for exact query-profile terms and their surrounding
section. Retain:

- document title, canonical URL, section heading, retrieval timestamp, and
  content hash;
- a concise verbatim excerpt containing the normative guidance;
- one or two directly relevant TypeSpec examples, each at most 12 lines;
- the query terms that matched;
- `no-relevant-guidance` when the fetched page does not govern the intent.

Do not treat the catalog description, a search-result summary, or a generated
code example as documentation evidence. Additional selections require targeted
discovery provenance from the canonical catalog.

### Assess the Semantic intent once

After guidance extraction, produce exactly one Azure Guidelines decision for the
Semantic intent. The selected documents are evidence sources, not independent
assessment units. The decision records:

- Semantic intent ID and the source-change, hunk, and declaration IDs used as
  supporting evidence;
- applicable document URLs and guidance sections;
- `expected`: a concise synthesis of the applicable fetched guidance;
- `actual`: a concise description of the intent's changed TypeSpec pattern;
- `decision`: `applicable-pass`, `applicable-fail`,
  `no-applicable-guidance`, or `not-assessed`; and
- a short rationale grounded only in the expected and actual evidence.

`applicable-pass` requires at least one fetched guidance section that governs
the intent and no direct contradiction. `applicable-fail` requires a direct
contradiction between fetched guidance and changed code. Similar wire
behavior, an undocumented legacy helper, or a suppression is not equivalent to
the documented pattern. Use `no-applicable-guidance` when search completed but
no selected document governs the intent. Use `not-assessed` only when
retrieval, evidence, or execution is incomplete.

One failing intent produces one intent-level finding. The finding may cite
multiple source declarations and guidance sections, but it must describe one
coherent Azure Guidelines gap for the intent. Affected operations never receive
separate Azure Guidelines decisions or findings.

HTML may group several intent-level findings into one visual guideline issue
when they cite the same set of canonical guidance document sections and state
the same expected behavior. This is a presentation-only projection:

- `assessment.json` retains every intent-level finding and its stable ID;
- visible Azure Guidelines counts report the number of distinct visual
  guideline issues, while affected-intent detail and JSON retain the
  intent-level finding cardinality;
- shared expected behavior and guidance are rendered once;
- each affected Semantic intent retains its own actual behavior, changed-code
  evidence, finding anchor, and human-readable Semantic intent link; and
- an identical Agent-authored title alone is insufficient to group findings
  when the guidance identity or expected behavior differs.

### Dimension status and safety

- `failed`: one or more intent decisions are `applicable-fail`.
- `passed`: every Semantic intent is `applicable-pass` or
  `no-applicable-guidance`, with no incomplete evidence.
- `not-assessed`: required retrieval/review or targeted discovery is incomplete.

Documents with `no-relevant-guidance` support a
`no-applicable-guidance` decision but do not support a pass against a specific
rule.
Azure Guidelines status is reported independently and does not change
REST/downstream scoped code safety.

### Bounded Agent behavior

The Agent performs targeted discovery, document search, excerpt selection, and
one intent-level evidence comparison in the existing bounded judgment phase.
It may not change Semantic intent membership, invent source IDs, invent URLs,
or use unfetched knowledge. The judgment schema requires exactly one
Azure Guidelines decision per Semantic intent, and deterministic assembly rejects
unknown, duplicate, or missing intent decisions.

The same Agent phase records one shared retrieval and extracted evidence set
with its per-intent choices in
`agent-workspace/agent-decisions.json`. The compact versioned contract keeps
only Agent-authored summaries, decisions, discovery outcomes, original document
provenance and byte counts, extracted guidance, reviewed catalog IDs, failed
retrievals, confidence, and blockers. It does not repeat canonical catalog
metadata, query profiles, source/hunk IDs, accounting, or final output wrappers.

`materialize-assessment-results.mjs` then verifies canonical artifact hashes
and exact ID coverage/ownership. It joins canonical metadata, verifies required
selection and review coverage and targeted discovery outcomes, derives
accounting, and atomically writes `inference.json`
when required, `compliance-search-evidence.json`, and
`assessment-judgment.json`. It preserves Agent-supplied retrieval provenance
and derives each retained guidance excerpt's declaration applicability as the
stable union of canonical IDs resolved from intent-owned qualified declaration
names in judgments citing that catalog ID and section. Each name must resolve
exactly once within its owning request; unknown, duplicate, ambiguous, and
cross-intent names fail. Uncited excerpts are dropped. Legacy compact excerpt
applicability is ignored. The materializer performs no network fetch,
suppression analysis, or semantic judgment.
Guarded finalization remains authoritative for final assembly, validation, and
rendering.

The authoritative shared-evidence shape is defined in
`scripts/compliance-search-evidence.schema.json`. Version 3 replaces global
rankings with per-intent `documentSelections`, shared `documents`, discovery
results, retrieval attempts, and accounting. Selection records retain the
owning intent and deterministic rule or discovery rationale. Shared documents
contain original retrieval provenance and only cited normative excerpts.
Required selections are reconstructed from immutable requests; the Agent
cannot waive them. Older ranked evidence must be regenerated before entering
this workflow, not silently accepted as complete required-document coverage.

The HTML report will show Azure Guidelines by Semantic intent:

- overall status and coverage;
- selected documents, selection provenance, and session-reuse indicators;
- one intent-level expected/actual comparison with supporting TypeSpec
  evidence;
- failing intent assessments expanded by default;
- passing intent assessments collapsed by default;
- retrieval failures and unassessed intents explicitly, never as zero findings
  that imply success.

## 6.1. Documentation Completeness

File: `dimensions/document-quality-input.json`

Documentation Completeness asks one deterministic question:
**Does the TypeSpec compiler return a nonempty effective document for each
newly added operation, model, enum, or interface declaration?**

The source index records `documentationPresent` and `newDeclaration` facts for
changed compiler declarations in Semantic scope. Version 5 checks only newly
added operations, models, enums, and interfaces. Modified existing
declarations, properties, namespaces, and other declaration kinds are outside
scope. The compiler's effective document is authoritative for presence, so
inherited documentation counts as present. Empty or whitespace-only
documentation counts as missing.

The completeness artifact groups these declaration facts by Semantic intent.
It contains declaration identity, kind, source location, and the presence
boolean. It does not contain documentation text, a prose-quality rubric, or
Agent instructions. Missing-document findings retain a bounded exact TypeSpec
declaration snippet for report presentation.

Assembly creates one finding for every declaration whose presence value is
false. If compiler evidence or declaration scope is unavailable, the affected
intent is `not-assessed`; missing evidence never becomes a missing-document
finding. An intent with no eligible newly added declaration is
`not-applicable`.

The bounded Agent input and `assessment-judgment.json` contain no documentation
review units, criterion, or decisions. Documentation Completeness is assembled
independently after the Agent judges Semantic summaries, REST/downstream
candidates, and Azure Guidelines compliance.

Final data uses `assessmentVersion: 5` and records Semantic intent count,
eligible declaration count, documented declaration count, missing declaration
count, intent assessments, findings, and blockers. Historical v1-v4
documentation-quality data remains valid legacy report data. Documentation
never changes scoped REST/downstream safety.

## 7. Bounded Agent input

File: `model-input.json`

```json
{
  "schemaVersion": 1,
  "context": {
    "sourceComparison": {
      "baseCommit": "base-sha",
      "headCommit": "head-sha",
      "baseRef": "origin/main",
      "workingTree": {}
    },
    "projects": [
      {
        "id": "project-<hash>",
        "path": "specification/<service>/<project>",
        "artifactComparison": {
          "mode": "new-api-version",
          "baseline": {
            "sourceRevision": "current",
            "commit": "head-sha",
            "apiVersion": "2025-01-01"
          },
          "target": {
            "sourceRevision": "current",
            "commit": "head-sha",
            "apiVersion": "2026-01-01-preview"
          }
        }
      }
    ]
  },
  "artifactReferences": {
    "sourceIndex": "source/source-index.json",
    "semanticReviewUnits": "dimensions/semantic-intents-input.json",
    "restCandidates": "dimensions/rest-breaking-input.json",
    "downstreamCandidates": "dimensions/downstream-breaking-input.json",
    "complianceSearchRequests": "dimensions/compliance-search-requests.json",
    "documentQuality": "dimensions/document-quality-input.json"
  },
  "evidenceSets": {
    "evidence-set-<hash>": {
      "sourceChangeIds": ["source-<hash>"],
      "hunkIds": ["hunk-<hash>"],
      "declarationCount": 1,
      "evidenceFactIds": [],
      "evidenceRef": {
        "artifact": "dimensions/semantic-intents-input.json",
        "id": "semantic-<hash>"
      }
    }
  },
  "facts": {
    "operation-<hash>": {},
    "rest-fact-<hash>": {},
    "sdk-fact-<hash>": {}
  },
  "semanticReviewUnits": [
    {
      "reviewUnitId": "semantic-<hash>",
      "action": "add",
      "declarationKinds": ["model"],
      "qualifiedNames": ["Contoso.AddressPrefixSet"],
      "qualifiedNameCount": 1,
      "changedConstructs": ["TrackedResource"],
      "changedConstructCount": 1,
      "representativeSourceExcerpts": [
        {
          "hunkId": "hunk-<hash>",
          "text": "model AddressPrefixSet is TrackedResource<...>;"
        }
      ],
      "affectedOperationCount": 4,
      "representativeOperationIds": [
        "AddressPrefixSets_Get",
        "AddressPrefixSets_CreateOrUpdate",
        "AddressPrefixSets_Delete"
      ],
      "restChangedOperationCount": 4,
      "groupingSummaries": [
        "The resource model and lifecycle operations form one child-resource change."
      ],
      "evidenceSetId": "evidence-set-<hash>",
      "deterministicCoverage": {
        "restCandidateIds": [],
        "downstreamCandidateIds": [],
        "complianceSearchRequestIds": ["compliance-search-<hash>"],
        "relatedOperationIds": [
          "AddressPrefixSets_Get",
          "AddressPrefixSets_CreateOrUpdate",
          "AddressPrefixSets_Delete"
        ],
        "coveredHunkIds": ["hunk-<hash>"],
        "uncoveredHunkIds": [],
        "classifications": [
          {
            "hunkId": "hunk-<hash>",
            "status": "candidate-generated|no-impact|semantic-only|unknown|blocked",
            "reason": "declaration-and-operation-mapped"
          }
        ],
        "gaps": []
      },
      "inferenceRequired": false
    }
  ],
  "restCandidates": [],
  "downstreamRootCauses": [],
  "downstreamCandidates": [],
  "complianceSearchRequests": [
    {
      "requestId": "compliance-search-<hash>",
      "reviewUnitId": "semantic-<hash>",
      "evidenceSetId": "evidence-set-<hash>",
      "querySummary": {
        "servicePlane": "resource-manager",
        "action": "add",
        "declarationKinds": ["model"],
        "qualifiedNames": ["Contoso.AddressPrefixSet"],
        "qualifiedNameCount": 1,
        "symbols": ["TrackedResource"],
        "symbolCount": 1,
        "categories": ["resource", "operations", "versioning"],
        "changedTokens": ["AddressPrefixSet", "TrackedResource"],
        "changedTokenCount": 2,
        "affectedOperationCount": 4
      }
    }
  ],
  "inferenceRequests": [],
  "blockers": [],
  "inputAccounting": {
    "budgetTier": "small|medium|large|configured-maximum",
    "budgetBytes": 307200,
    "bytes": 0,
    "estimatedTokens": 0,
    "retained": {
      "evidenceSets": 0,
      "facts": 0,
      "semanticReviewUnits": 0,
      "restCandidates": 0,
      "downstreamRootCauses": 0,
      "downstreamCandidates": 0,
      "complianceSearchRequests": 0
    },
    "omittedRedundant": {
      "rawEmitterArtifacts": true,
      "compilerLogs": true,
      "unchangedInventories": true,
      "unreferencedFacts": true,
      "unreferencedDeterministicFacts": true,
      "sourceChanges": true,
      "repeatedDeclarationIds": true,
      "repeatedReviewUnitEvidence": true
    }
  }
}
```

Model input retains compact facts referenced by deterministic downstream
candidates and their shortest method-to-type paths, together with
inference-relevant facts. The retained SDK fact set is the union of candidate
`evidenceFactIds`, root-cause `methodFactIds` and `typeFactIds`,
`referenceEvidence.fromFactId` and `toFactId`, and inference-required fact IDs.
Unrelated SDK inventory remains omitted. Full source, declaration, candidate,
Azure Guidelines request evidence, and documentation evidence remain in the canonical artifacts named
by `artifactReferences`.
`evidenceSets` connects bounded judgment items to exact canonical entries
without repeating large declaration lists or operation facts. Qualified names,
changed constructs, and query terms are bounded summaries with total counts;
the Agent resolves the canonical entry when omitted members are material to a
decision. Required evidence is never silently dropped to fit the budget.

### 7.1 Deterministic coverage and optional inference

Coverage is calculated before `model-input.json` is written. For each Semantic
review unit, every member hunk receives exactly one deterministic status:

- `candidate-generated`: at least one mapped REST or downstream candidate;
- `no-impact`: the relevant deterministic contracts were compared and did not
  produce an impact candidate;
- `semantic-only`: the indexed change does not affect a REST or SDK contract;
- `unknown`: the source change cannot be mapped reliably to the available
  language-neutral artifacts;
- `blocked`: required deterministic artifacts or analysis are unavailable.

Only `unknown` hunks set `inferenceRequired: true`. An empty candidate list
alone does not trigger inference. Azure Guidelines retrieval failure also does not
trigger inference.

Each unknown hunk produces one bounded `inferenceRequests` entry:

```json
{
  "requestId": "inference-request-<hash>",
  "reviewUnitId": "semantic-<hash>",
  "sourceChangeId": "source-<hash>",
  "hunkId": "hunk-<hash>",
  "reason": "source-change-not-represented-in-language-neutral-artifacts",
  "sourceExcerpt": "@@clientLocation(..., \"!csharp,!go\");",
  "relatedOperationIds": [],
  "allowedDimensions": ["rest", "downstream"],
  "evidenceRef": {
    "artifact": "source/source-index.json",
    "sourceChangeId": "source-<hash>",
    "hunkId": "hunk-<hash>"
  }
}
```

When `inferenceRequests` is empty, `inference.json` must not be required. When
requests exist, the Agent writes one result per request to `inference.json`:

```json
{
  "schemaVersion": 1,
  "results": [
    {
      "requestId": "inference-request-<hash>",
      "reviewUnitId": "semantic-<hash>",
      "hunkId": "hunk-<hash>",
      "decision": "candidates",
      "rationale": "The scoped customization changes generated Go client placement.",
      "candidates": [
        {
          "id": "inferred-downstream-<hash>",
          "dimension": "downstream",
          "rule": "client-location-changed",
          "defaultSeverity": "high",
          "actual": "The affected operations move in the generated Go client hierarchy.",
          "expected": "Existing generated Go client placement remains stable.",
          "crossLanguageDefinitionId": "ProtectionContainersOperationGroup",
          "sourceChangeIds": ["source-<hash>"],
          "hunkIds": ["hunk-<hash>"],
          "operationIds": [],
          "evidenceFactIds": [],
          "reviewRequired": true
        }
      ]
    }
  ]
}
```

The other valid inference decisions are `no-impact` and `blocked`; both require
a rationale and contain no candidates. Inferred candidates must use only the
request's review unit, source, hunk, operations, and allowed dimensions.
Multiple requests from the same review unit and source may reference the same
identical inferred candidate when one SDK impact spans several adjacent hunks;
that candidate lists every covered request hunk and is deduplicated by ID.
Assembly rejects missing, conflicting, unknown, or out-of-scope inference
results. The Agent never modifies `model-input.json`.

## 8. Materialized Agent judgment

File: `assessment-judgment.json`

The Agent authors these choices in the compact decision file using prefilled
intent-scoped qualified declaration names rather than opaque IDs. The
deterministic materializer resolves those names within the owning request and
emits the existing judgment contract below; it does not choose decisions,
severities, evidence, or prose.

```json
{
  "schemaVersion": 1,
  "semanticIntents": [
    {
      "reviewUnitId": "semantic-<hash>",
      "title": "Return scenario-run resources from run actions",
      "summary": "The TypeSpec change makes scenario execution and cancellation return pollable scenario-run resources."
    }
  ],
  "restDecisions": [
    {
      "candidateId": "rest-<hash>",
      "decision": "approve|reject",
      "severity": "high|medium|low",
      "rationale": "Caller-visible compatibility rationale."
    }
  ],
  "downstreamDecisions": [
    {
      "candidateId": "downstream-<hash>",
      "decision": "approve|reject",
      "severity": "high|medium|low",
      "rationale": "Language-neutral SDK compatibility rationale."
    }
  ],
  "complianceDecisions": [
    {
      "reviewUnitId": "semantic-<hash>",
      "applicableGuidance": [
        {
          "canonicalDocumentUrl": "https://azure.github.io/typespec-azure/docs/...",
          "guidanceSection": "Resource types"
        }
      ],
      "sourceChangeIds": ["source-<hash>"],
      "hunkIds": ["hunk-<hash>"],
      "declarationIds": ["declaration-<hash>"],
      "decision": "applicable-pass|applicable-fail|no-applicable-guidance|not-assessed",
      "title": "Required for applicable-fail: concise Azure Guidelines gap title",
      "severity": "Required for applicable-fail: high|medium|low",
      "expected": "Concise synthesis of applicable fetched guidance.",
      "actual": "Concise description of the intent's changed TypeSpec pattern.",
      "rationale": "Evidence-grounded comparison rationale."
    }
  ],
  "overallConfidence": "high|medium|low",
  "blockers": []
}
```

Exactly one semantic result is required per review unit and one decision per
deterministic or inferred REST/downstream candidate. Root causes are
deterministic aggregation evidence and are not Agent decision units.

Every Semantic intent must have exactly one Azure Guidelines decision. Every
applicable guidance catalog ID in the compact input must identify a
successfully retrieved or session-reused `documents` entry, and all source, hunk, and
declaration IDs must already exist in canonical requests. Decisions may quote
only guidance recorded in compact fetched-document evidence; the Agent cannot
add URLs, evidence,
declarations, operations, or assessment units during judgment.
`applicable-pass` and `applicable-fail` require non-empty expected and actual
evidence. `applicable-fail` also requires a concise finding title and severity
for structured assessment metadata. `no-applicable-guidance` requires actual
changed-code evidence and a rationale explaining why the completed search
found no governing guidance. `not-assessed` requires actual evidence
and a retrieval, evidence, or intent-coverage blocker.

Documentation Completeness is not authored in this file. It is assembled from
compiler-derived declaration presence facts.

## 9. Final assessment

File: `assessment.json`

```json
{
  "schemaVersion": 1,
  "generatedAt": "2026-01-01T00:00:00.000Z",
  "title": "TypeSpec assessment: specification/<service>/<project>",
  "repository": {
    "root": "C:\\repo",
    "remoteUrl": "https://github.com/Azure/azure-rest-api-specs"
  },
  "comparison": {
    "baseRef": "origin/main",
    "baseCommit": "base-sha",
    "headCommit": "head-sha",
    "workingTree": {}
  },
  "artifactComparisons": [
    {
      "projectId": "project-<hash>",
      "mode": "new-api-version|existing-api-version|unversioned",
      "baseline": {
        "sourceRevision": "base|current",
        "commit": "base-sha|head-sha",
        "apiVersion": "2025-01-01",
        "reason": "previous-latest-stable|previous-latest-preview|affected-existing-version|unversioned"
      },
      "target": {
        "sourceRevision": "current",
        "commit": "head-sha",
        "apiVersion": "2026-01-01-preview",
        "reason": "newest-added-version|affected-existing-version|unversioned"
      }
    }
  ],
  "confidence": "high|medium|low",
  "safety": {
    "scope": "rest-and-downstream-only",
    "status": "passed|failed|not-assessed"
  },
  "dimensions": {
    "semantic": {
      "status": "assessed|not-assessed",
      "sourceHunkIds": ["hunk-<hash>"],
      "items": [
        {
          "id": "semantic-<hash>",
          "action": "add|remove|modify",
          "title": "Modify scenario run actions",
          "summary": "Source-first TypeSpec intent.",
          "sourceChangeIds": ["source-<hash>"],
          "hunkIds": ["hunk-<hash>"],
          "declarationIds": ["declaration-<hash>"],
          "groupingEvidence": [
            {
              "kind": "template-instantiation",
              "fromHunkIds": ["hunk-<hash>"],
              "toHunkIds": ["hunk-<hash>"],
              "declarationIds": ["declaration-<hash>"],
              "factIds": ["operation-<hash>"]
            }
          ],
          "operations": [
            {
              "operationId": "ScenarioRuns_Cancel",
              "apiVersion": "2026-05-01-preview",
              "method": "post",
              "path": "/scenarios/{scenarioName}/runs/{runId}/cancel",
              "restChanged": false,
              "changedAspects": [],
              "restOutcome": "HTTP signature and represented payload contract unchanged.",
              "matchBasis": "operation-identity",
              "mappingSummary": "Changed TypeSpec operation ScenarioRuns.cancel compiles to ScenarioRuns_Cancel.",
              "mappingEvidence": [
                {
                  "kind": "operation-identity",
                  "sourceChangeIds": ["source-<hash>"],
                  "hunkIds": ["hunk-<hash>"],
                  "declarationIds": ["declaration-<hash>"],
                  "factIds": ["operation-<hash>"]
                }
              ],
              "before": {},
              "after": {}
            }
          ],
          "sources": [],
          "relatedFindings": {
            "rest": [],
            "downstream": ["downstream-group-<hash>"],
            "typeImpact": []
          }
        }
      ],
      "blockers": []
    },
    "rest": {
      "status": "passed|failed|not-assessed",
      "findings": [],
      "rejectedCandidateCount": 0,
      "blockers": []
    },
    "downstream": {
      "status": "passed|failed|not-assessed",
      "findings": [],
      "methodGroups": [
        {
          "id": "downstream-group-<hash>",
          "symbol": "Microsoft.Chaos.ScenarioRuns.cancel",
          "apiVersion": "2026-05-01-preview",
          "parametersUnchanged": true,
          "deltas": [
            {
              "findingId": "downstream-<hash>",
              "rule": "method-kind-changed",
              "field": "kind",
              "severity": "high",
              "before": "basic",
              "after": "lro",
              "actual": "The SDK method kind changed from basic to lro.",
              "expected": "The SDK method kind remains stable.",
              "rationale": "Existing callers must use LRO APIs."
            }
          ],
          "relatedSemanticIntents": ["semantic-<hash>"]
        }
      ],
      "typeImpacts": [
        {
          "id": "sdk-type-impact-<hash>",
          "type": "Microsoft.Chaos.ScenarioRun",
          "locations": ["response-body"],
          "rootCauseIds": ["downstream-root-cause-<hash>"],
          "findingIds": ["downstream-<hash>"],
          "affectedMethodCount": 2,
          "affectedMethods": [
            {
              "symbol": "Microsoft.Chaos.ScenarioConfigurations.execute",
              "referenceFactIds": ["sdk-fact-<hash>"]
            },
            {
              "symbol": "Microsoft.Chaos.ScenarioRuns.cancel",
              "referenceFactIds": ["sdk-fact-<hash>"]
            }
          ],
          "relatedSemanticIntents": ["semantic-<hash>"],
          "unresolvedRelationshipReason": null
        }
      ],
      "rejectedCandidateCount": 0,
      "blockers": []
    },
    "compliance": {
      "status": "passed|failed|not-assessed",
      "summary": "Documentation-grounded Azure Guidelines result.",
      "coverage": {
        "semanticIntentCount": 1,
        "assessedIntentCount": 1,
        "selectedDocumentCount": 4,
        "unassessedIntentIds": []
      },
      "intentAssessments": [
        {
          "semanticIntentId": "semantic-<hash>",
          "sourceChangeIds": ["source-<hash>"],
          "hunkIds": ["hunk-<hash>"],
          "declarationIds": ["declaration-<hash>"],
          "documents": [
            {
              "catalogOrder": 3,
              "title": "ARM resource types and modeling",
              "canonicalUrl": "https://azure.github.io/typespec-azure/docs/...",
              "retrievalSource": "network",
              "retrievedAt": "2026-01-01T00:00:00.000Z",
              "contentHash": "sha256:<hash>",
              "guidance": [
                {
                  "section": "Resource types",
                  "excerpt": "Concise normative guidance.",
                  "queryTerms": ["TrackedResource"],
                  "examples": [],
                  "applicableDeclarationIds": ["declaration-<hash>"]
                }
              ],
              "noRelevantGuidance": false
            }
          ],
          "decision": "applicable-fail",
          "applicableGuidance": [
            {
              "canonicalDocumentUrl": "https://azure.github.io/typespec-azure/docs/...",
              "section": "Resource types"
            }
          ],
          "expected": "Use the documented resource template.",
          "actual": "The intent introduces the resource with a different pattern.",
          "gap": "The intent does not apply the required template.",
          "sourceLinks": [
            {
              "path": "specification/contoso/Contoso/main.tsp",
              "startLine": 40,
              "endLine": 44
            }
          ],
          "codeSnippets": ["model AddressPrefixSet { ... }"],
          "blockers": []
        }
      ],
      "findings": [
        {
          "id": "compliance-<hash>",
          "semanticIntentId": "semantic-<hash>",
          "applicableGuidance": [
            {
              "canonicalDocumentUrl": "https://azure.github.io/typespec-azure/docs/...",
              "section": "Resource types",
              "excerpt": "Concise normative guidance."
            }
          ],
          "declarationIds": ["declaration-<hash>"],
          "sourceChangeIds": ["source-<hash>"],
          "hunkIds": ["hunk-<hash>"],
          "expected": "Use the documented resource template.",
          "actual": "The intent introduces the resource with a different pattern.",
          "gap": "The intent does not apply the required template.",
          "sourceLinks": [
            {
              "path": "specification/contoso/Contoso/main.tsp",
              "startLine": 40,
              "endLine": 44
            }
          ],
          "codeSnippets": ["model AddressPrefixSet { ... }"]
        }
      ],
      "retrievalFailures": [],
      "blockers": []
    },
    "documentQuality": {
      "status": "not-assessed",
      "summary": "Documentation assessment is incomplete.",
      "coverage": {
        "semanticIntentCount": 1,
        "assessedIntentCount": 0,
        "documentCount": 0,
        "assessedDocumentCount": 0,
        "checkCount": 0,
        "assessedCheckCount": 0,
        "unassessedIntentIds": ["semantic-<hash>"],
        "notApplicableIntentIds": []
      },
      "intentAssessments": [
        {
          "reviewUnitId": "semantic-<hash>",
          "status": "not-assessed",
          "reason": "Associated source context is unavailable.",
          "documents": [],
          "checks": []
        }
      ],
      "findings": [],
      "blockers": ["Associated source context is unavailable."]
    }
  },
  "changedFiles": [],
  "projects": [],
  "blockers": [],
  "provenance": {
    "modelInput": "model-input.json",
    "complianceSearchEvidence": "compliance-search-evidence.json",
    "judgment": "assessment-judgment.json",
    "preparationManifest": "preparation-manifest.json"
  },
  "inputAccounting": {},
  "timings": {}
}
```

### Downstream SDK method groups

Every downstream method group merges all confirmed direct deltas for one
project and SDK method identity. Each delta retains its underlying finding ID,
rule, severity, concise actual/expected behavior, and rationale, and adds
structured `field`, `before`, and `after` values.

Structured fields include:

- `kind`: `basic|paging|lro|lropaging`;
- `parameters`: a changed-only parameter diff containing added, removed,
  modified, and reordered parameters plus the unchanged parameter count;
- `responseType`: stable cross-language type identity or `void`;
- `lro`: final-state-via, logical result, polling step, and final result;
- `paging`: item and continuation metadata;
- `access`: public accessibility;
- `client`: owning operation group/client.

When parameters are equal but another method aspect changes, set
`parametersUnchanged: true` and render `Parameters: unchanged`. Do not imply a
parameter change from a method-kind, response, LRO, or paging change.

When parameters change, the parameter delta uses `changes` instead of complete
`before` and `after` arrays. It records:

- `added`: the projected parameter and target position;
- `removed`: the projected parameter and baseline position;
- `modified`: the before/after projection and changed attributes;
- `reordered`: the relative baseline/target positions among retained
  parameters;
- `unchangedCount`: retained parameters whose attributes and relative order
  did not change.

Adding a parameter does not mark retained parameters as reordered when their
relative order is unchanged.

HTML renders changed parameters and method deltas from this structured data;
the presentation contract is defined in [HTML requirements](#11-html-requirements).
Method cards are collapsed by default and contain SDK method identity, a
`Contract area | Before | After` table, a highlighted breaking rationale, and
related Semantic intent links. They do not show HTTP method, route, REST
operation identity, or REST findings. Render only changed parameter and method
rows: additions/removals use `not present` on the missing side, modifications
show projected before/after signatures, reordering uses one-based positions,
and retained unchanged parameters contribute only to the summary count.

REST and downstream dimensions report independently. Assembly does not
suppress downstream findings because a related wire contract is REST breaking,
and it does not emit `impliedByRest`.

## 10. Validation

Assembly validates the small Agent answer and joins complete deterministic
evidence. Final validation independently checks:

1. allowed schemas and enums;
2. exact review-unit and REST/downstream candidate coverage, with every
   candidate covered exactly once;
3. no invented or duplicate IDs;
4. complete actual/expected/evidence/source for findings;
5. exact one-time changed TypeSpec hunk coverage;
6. complete REST operation evidence;
7. reciprocal semantic/finding relationships;
8. complete downstream aggregation traceability;
9. derived counts, dimension status, and scoped safety;
10. required and positively discovered documents retrieved or reused and
    reviewed for each owning intent, or explicit incomplete-coverage blockers;
11. unique canonical documents, selection provenance, completed discovery
    requests, and query profiles identical to deterministic requests;
12. canonical URL, retrieval timestamp, content hash, section, excerpt, and
    matched-term provenance for every guidance item;
13. exact one-time Azure Guidelines decision coverage for every Semantic intent;
14. intent-level Azure Guidelines findings with complete source IDs, applicable
    guidance links, expected guidance, actual TypeSpec pattern, gap, and
    changed-code snippets;
15. catalog descriptions and unfetched content are never used as guidance;
16. Azure Guidelines and documentation statuses follow their separate evidence
    and coverage;
17. exact documentation unit/document/check coverage, with one `description`
    decision per eligible target description;
18. documentation findings quote actual target text, retain canonical source
    context, and contain no authored severity or fabricated evidence;
19. missing documentation input remains explicitly `not-assessed` for legacy
    artifacts; missing decisions for new input are rejected.

## 11. HTML requirements

The normative report content, ordering, and status requirements are defined in
[`references/output-contract.md`](../references/output-contract.md). This section
defines the renderer's presentation and evidence-grouping behavior.

### Documentation Completeness cards

Keep the main documentation section focused on missing-document findings and
compact declaration coverage. Use **Documentation Completeness** for the
heading, summary label, and failed impact prefix. Preserve the internal
`documentQuality` data key and existing section/finding anchors.

Each finding shows the changed declaration identity, the fact that the compiler
returned no nonempty effective document, the suggested addition, and its source
location. Do not render document text or compare it with code. The summary card
shows finding count and checked declaration count.
**Suggested change** uses `expected` as guidance, not quoted replacement text.
No generated code summary, replacement description, or new judgment field is
introduced. Keep missing current evidence explicit rather than substituting
baseline text. Supporting TypeSpec is collapsed, retaining exact source,
full paths, baseline/current and inherited-origin context. A single snapshot
uses full width. Related type definitions require unambiguous compiler references,
same-intent/revision evidence and exact source ownership. Do not guess from prose
or repeat source already contained in the assessed declaration. Escape all text,
including highlight content.

Omit passed, incomplete, and neutral documentation groups, non-finding description
browsers, recorded summaries, and detailed documentation coverage from the HTML.
Complete judgments, retained descriptions, limitations, and original audit states
remain in JSON. The shared renderer returns main `html` and an empty `appendixHtml`
for compatibility; the general appendix is unchanged. Fragment navigation still
reveals enclosing details for retained finding and intent links.
Use **description** in UI labels while preserving the normative criterion and
literal evidence; label historical two-check judgments as legacy. Failed documentation
links in Semantic intent summaries use the existing red `.impact` treatment
and contribute to `Impacts (N)` alongside REST/downstream targets. Preserve their
stable finding destinations. Only findings contribute to impact counts and the
overall code-quality result, alongside compatibility and Azure Guidelines.
The separate REST/downstream safety contract never changes.

### REST contract cards

REST breaking findings use the same visual hierarchy as downstream SDK type
cards. The renderer groups confirmed REST findings by stable wire-contract
identity, such as a model, enum, request parameter type, or response header
type. One contract produces one default-collapsed card and retains every
deterministically affected REST operation.

Presentation rules:

1. The summary shows stable REST contract identity, a `REST contract` tag,
   distinct contract-delta count, and distinct affected REST operation count.
   It does not show severity labels or severity-colored borders.
2. The card is collapsed by default. Hash navigation opens the selected card
   and its folded ancestors.
3. The expanded body starts with contract identity, followed by one compact
   `Contract area | Before | After` table.
4. Multiple findings for the same contract become rows in that table; do not
   repeat full cards or unchanged request/response content.
5. Contract identities come from exact normalized AutoRest schema references
   or enum metadata. A removed property's own type is preferred; otherwise use
   the nearest containing named contract. Source-file or display-name
   coincidence is insufficient.
6. Human-readable contract areas replace internal rule IDs, for example
   `response 200.segment.fileItems[].fileType`, `include`, or
   `x-ms-file-file-type`.
7. Removed values use removal styling and added/replacement values use
   addition styling, matching downstream method cards.
8. One concise rationale follows the table in the same highlighted
   `Why this is breaking` callout used by downstream SDK cards. Per-row
   rationales are shown only when they materially differ.
9. The complete affected-operation list follows the rationale in a nested
   details element that is collapsed by default. Its summary shows the
   distinct operation count; expanded rows show operation ID, selected API
   version, HTTP method, and path.
10. The footer contains only human-readable links to related Semantic intents.
    Do not repeat Changed TypeSpec source links in the REST card; complete
    source evidence remains in the Semantic intent and appendix.
11. A REST finding without a proven contract identity remains visible as a
    default-collapsed `Unmapped REST contract change` card. Do not infer a
    contract from source-file coincidence.
12. Stable finding anchors remain inside the aggregate card so existing deep
    links continue to work. JSON retains every underlying finding once.
13. The visible REST count is the number of distinct contract cards plus
    unmapped cards, not the raw finding-row count.

### Azure Guidelines rendering

Azure Guidelines rendering is source-first:

- show status, assessed-intent coverage, distinct guideline-issue count, and
  affected-intent count;
- group repeated visual findings only by identical canonical guidance-section
  identity and normalized expected behavior, never by title alone;
- render one shared expected/guidance block and one actual-evidence entry per
  affected Semantic intent, preserving every finding anchor and intent link;
- under **Actual**, show at most two changed-code snippets ranked by relevance;
- show category badges on Semantic intents and shared selected documents with
  selection reasons, original retrieval provenance, and canonical source links;
- show one fetched-guidance synthesis beside the intent's representative
  changed TypeSpec evidence;
- expand `applicable-fail` intent assessments by default;
- collapse `applicable-pass` intent assessments by default;
- render retrieval failures, catalog exhaustion, and `not-assessed` intents
  explicitly rather than presenting zero findings as a pass.

### Semantic rendering

Semantic operation rendering is bounded:

- render a concise aggregate impact sentence and no more than three
  representative expandable operation cards for every intent;
- choose representatives deterministically in stable operation-ID order;
- state how many operations are omitted from HTML;
- retain the complete affected-operation inventory in `assessment.json`.

Each operation card shows the operation ID, selected API version, HTTP
method/path, concise mapping reason, REST before/after delta or explicit
unchanged statement, and downstream outcome. It is deterministic supporting
evidence, not a separate Semantic or Azure Guidelines assessment, and it does not
repeat TypeSpec code.

### Shared contract rows

Semantic operation cards and REST breaking cards use the same contract-delta
row presentation as SDK method and SDK type cards:

- the columns are `Contract area | Before | After`;
- the first cell uses a two-line hierarchy: a human-readable contract-area
  kind such as `Query parameter`, `Response body property`, `Method parameter`,
  `Response header`, or `Enum member`, followed by the concrete member name or
  path in code font;
- Before and After use the same removal/addition color treatment;
- REST and Semantic operation rows derive the area kind from normalized wire
  location and schema path;
- SDK method parameter rows use normalized TCGC HTTP metadata to show their
  request path, query, header, or body location when unambiguous, and otherwise
  use `Method parameter`;
- SDK type property rows derive the concrete property name, type, optionality,
  and SDK usage role from baseline/target TCGC facts and retained reference
  paths;
  a property is labeled `Request body property` or `Response body property`
  only when that concrete member appears in the corresponding normalized body
  schema, not merely because its containing SDK type is reachable from that
  schema;
- a generated SDK property corresponding to a normalized response header is
  labeled `Response header property`; request/response body reachability of the
  containing type must not override member-level header evidence;
- deterministic TCGC comparison may still emit a property-removal candidate
  when an implicit result shape is rewritten as an explicit response model;
  downstream Agent judgment applies the documented response-model
  compatibility case and rejects the candidate when the generated SDK member
  and operation behavior are preserved;
- when member-level body or header evidence is absent or ambiguous, the
  contract area falls back to `Model property`;
- internal rules such as `model-property-removed` or
  `method-parameters-changed` never appear as contract-area members, and full
  expected/actual finding sentences never replace concise member values;
- a Semantic operation card selects confirmed REST findings whose
  `operationIds` contain the operation and whose `relatedSemanticIntents`
  contain the current intent;
- selected findings reuse the same deterministic contract-area and
  before/after derivation used by REST breaking cards;
- when no confirmed fine-grained REST finding exists, the operation card
  deterministically compares the normalized before/after operation facts and
  expands changed top-level aspects into the narrowest available contract
  areas: individual parameters, request body/schema paths, response status,
  body/schema paths and headers, paging fields, LRO fields, method, path, or
  whole operation;
- a top-level aspect name is used only when the normalized evidence cannot
  identify a narrower changed path, and identical summaries such as unchanged
  response-status lists must not be presented as the explanation of a deeper
  change;
- when normalized structural comparison produces no changed contract row, the
  operation card omits the Before/After table and states `HTTP signature and
represented payload contract unchanged.` even if upstream version-specific
  reference metadata populated `changedAspects`; and
- REST breaking cards continue grouping rows by stable REST contract identity,
  while Semantic operation cards group the applicable rows under each
  representative operation.

### Semantic source evidence

Each Semantic intent is collapsed by default and shows exactly one escaped
TypeSpec code example. The example is nested in a second disclosure that is
also collapsed by default. It is presentation-only and does not narrow the
intent's evidence:

- prefer hunks retained by operation-specific compiler evidence;
- then prefer hunks attached to a changed declaration;
- then prefer a hunk with a substantive changed line rather than only an
  import, using, or blank-line change;
- use source path, current/base start line, and hunk ID as deterministic final
  tie-breakers.

Label the code as a representative example and link readers to the Appendix
for complete evidence. If the intent has no provable hunk, state
`No representative TypeSpec example available` rather than showing unrelated
code. The complete source and hunk inventory remains in `assessment.json` and
in a collapsed Appendix section.

Operation code evidence is scoped to that operation. Primitive source mapping
records source-change, hunk, and declaration IDs on every operation mapping.
When coherent units merge, duplicate mappings for one operation retain only
the highest-authority mapping evidence:

- API-version governance for publication intents;
- exact operation identity for operation changes;
- compiled contract containment;
- compiler-reference fallback.

The renderer must never pass intent-level source hunks to operation cards.
Operation-specific source evidence remains in `assessment.json` for
traceability and representative-example selection, but code is rendered once
at the Semantic-intent level.

### Header and appendix

The header's `TypeSpec source diff` line shows only the Git source commits:

```text
TypeSpec source diff: <base-commit> → <head-commit>
```

The appendix's `Projects and compiler status` table records the exact API
version passed to each baseline and target emitter invocation:

```text
baseline <commit>@<api-version> → target <commit>@<api-version>
```

The header follows a summary-dashboard hierarchy:

1. uppercase `TypeSpec Assessment` eyebrow;
2. prominent assessment title;
3. the single source/artifact pair or multi-project appendix link on one
   metadata line;
4. six summary cards: overall code quality, then the five dimensions in this
   order: Semantic intents, Azure Guidelines, REST breaking changes, downstream
   breaking changes, and Documentation Completeness.

Card headings contain only an icon beside the title; counts appear below, not as
a separate oversized primary value. Quality cards show finding counts rather than
Pass/Fail/N/A text. Overall sums the REST, downstream, Azure Guidelines, and Documentation Completeness
finding counts, excluding Semantic intents. Its status icon indicates failure
when findings exist and pass otherwise. It remains non-clickable.
Coverage limitations and original assessment states remain in JSON, with general
assessment limits in the appendix; a finding-based pass does not claim complete
assessment coverage. Documentation Completeness details are not rendered in the appendix.
The Semantic card is informational: an information icon sits beside its title,
with intent, distinct affected-operation, and add/modify/remove counts below. It has no Pass,
Fail, or N/A status tag, regardless of the recorded semantic review state.
Quality cards count underlying recorded findings, not grouped operations,
affected SDK methods, or distinct visual guideline issues. Legacy downstream
entries that only repeat approved REST findings are excluded. The Azure Guidelines
card retains covered-intent counts in its detail. Status icons and colors
communicate `passed`, `failed`, or `not-assessed`. A zero finding count must not
imply a pass when evidence retrieval or intent coverage is incomplete.

Each dimension summary card is a full-card link to its report section:

- REST breaking changes → `#rest-breaking`;
- downstream breaking changes → `#downstream-breaking`;
- Azure Guidelines → `#azure-compliance`;
- Documentation Completeness → `#document-quality`;
- Semantic intents → `#semantic-intents`.

Main sections with findings precede those without findings. Within each group,
follow the dimension-card order, not the number of findings. Semantic intents
are explanations, not findings, and belong in the no-findings group. The appendix
remains last.

Linked dimension cards expose visible hover and keyboard-focus states without
changing their status colors; the static Overall card does not behave like a link.

Immediately below the header, render **Preview Notice** as a compact
default-collapsed disclosure bar. Its collapsed summary is one line and should
occupy approximately 46 pixels vertically. Expanding it reveals the complete
notice in a compact two-column layout on wide screens and one column on narrow
screens:

> The TypeSpec Assessment Assistant is currently in preview. Its goal is to
> help service developers build confidence earlier in the TypeSpec authoring
> workflow by providing contextual analysis, risk identification, and guidance
> on potential downstream impacts.
>
> This report is intended as a review reference and learning aid only. It does
> not replace official ARM API, Azure API Stewardship, Azure Breaking Change
> reviews, and should not be treated as authoritative review feedback or
> approval for specification changes. Official validation tools, generated
> artifacts, and reviewer feedback remain the source of truth for merge and
> release decisions.

The report does not render a separate `Assessment comparison` section. Each
project records the complete artifact comparison once in the appendix with:

- comparison mode;
- baseline role, source revision, full commit SHA, and API version;
- target role, source revision, full commit SHA, and API version;
- selection reason for each role;
- AutoRest and TCGC status for each role.

For an existing-version change, the appendix comparison is:

```text
source:    <base-commit> → <head-commit>
artifacts: <base-commit>@<affected-version> →
           <head-commit>@<affected-version>
```

For a newly added version such as PR 44988, the appendix comparison is:

```text
source:    9f0ad696... → 780a61ace...
artifacts: 780a61ace...@<previous-latest-stable> →
           780a61ace...@2025-09-01
```

The report explicitly states when the Git base commit is used only for the
TypeSpec source diff and is not used to produce the baseline emitter artifact.
Never label a head-source artifact as a base-commit artifact.

## 12. Files

| Area                             | Source of truth                                                                                                   |
| -------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| Skill workflow and boundaries    | `SKILL.md`, `references/workflow.md`                                                                              |
| Judgment rules                   | `references/classification.md`, `references/downstream-breaking-cases.md`                                         |
| Azure Guidelines retrieval       | `references/agentic-search.md`, `references/reference-document-links.md`                                          |
| Source-only documentation checks | `references/document-quality.md`, `scripts/document-quality-input.mjs`, `scripts/document-quality-assessment.mjs` |
| Output contract                  | `references/output-contract.md`, `scripts/*.schema.json`                                                          |
| Skill dependency bootstrap       | `scripts/skill-dependencies.mjs`, `scripts/npm-command.mjs`                                                       |
| Deterministic preparation        | `scripts/prepare-assessment.mjs`, `scripts/package-manager.mjs`, `scripts/run-assessment-analysis.mjs`            |
| Dimension analyzers              | `scripts/analyze-*.mjs`                                                                                           |
| Assembly and validation          | `scripts/assemble-assessment.mjs`, `scripts/validate-assessment.mjs`                                              |
| HTML presentation                | `scripts/assessment-display.mjs`, `scripts/render-assessment-html.mjs`                                            |
| Regression coverage              | `scripts/*.test.mjs`, `evals/`                                                                                    |

Preserve local assessment reports and user-owned eval changes.

## 13. Completion criteria

- One command prepares deterministic evidence and bounded Agent input.
- AutoRest and TCGC use the same source revision and API version within each
  artifact-comparison role.
- Semantic analysis covers changed TypeSpec source before calculating REST
  impact.
- REST and downstream analyzers follow emitter boundaries.
- Every Semantic intent produces one bounded Azure Guidelines query profile from its
  changed constructs, representative source evidence, and aggregate operation
  counts.
- Deterministic category routing selects required official documents with
  targeted discovery for gaps, shared same-session content reuse, and explicit
  failures rather than a global document-count cutoff.
- Fetched guidance has canonical URL, content hash, section, excerpt, and
  query-term provenance.
- Every Semantic review unit records deterministic hunk coverage directly in
  `model-input.json`.
- AI inference is skipped when all hunks are deterministically classified and
  runs only for explicit `unknown` hunk requests.
- When inference runs, `inference.json` has exact request coverage and only
  bounded, source-linked inferred candidates.
- Agent judgment has one concise Semantic result and one Azure Guidelines decision
  per intent, plus exact deterministic and inferred REST/downstream candidate
  coverage.
- Every eligible newly added operation, model, enum, and interface records
  compiler-resolved effective-document presence exactly once; documentation
  text is never compared with code.
- Documentation findings do not introduce guessed severity or change scoped
  REST/downstream safety.
- Final JSON rejects unsupported or incomplete results.
- HTML presents selected documentation and intent-level Azure Guidelines results
  without conflating them with scoped REST/downstream code safety.
- Focused tests, 12 retained report replays, strict skill lint, and real PR
  43308, 44882, and 44988 smoke tests pass.
- PR 44988 produces 11 coherent Semantic intents, no REST breaking finding for
  the new-version transition, and two grouped Service Gateway downstream SDK
  method breaks. ARM resource-operation intents retrieve and review the
  governing operation-template guidance without changing their group boundaries.

## 14. Technical challenges

The primary technical challenge is constructing and reconciling several
incomplete graphs of the same API change:

| Graph          | Source                         | Represents                                                                 |
| -------------- | ------------------------------ | -------------------------------------------------------------------------- |
| Source graph   | TypeSpec compiler and Git diff | Hunks, declarations, decorators, references, and versions                  |
| REST graph     | AutoRest output                | Operations, routes, parameters, schemas, headers, paging, and LRO behavior |
| SDK graph      | TCGC output                    | Clients, methods, parameters, return types, models, enums, and unions      |
| Guidance graph | Official documents             | Azure requirements applicable to each Semantic intent                      |

The assessment must connect these graphs without losing provenance:

```text
TypeSpec hunk
  -> declaration
  -> Semantic intent
  -> REST operation and schema
  -> SDK client, method, and type
  -> applicable Azure guidance
```

The main challenges are:

Goal: repeatable and traceble report

1. correlate semantic intents with downstream breakings, rest breakings, Azure guidelines and doc correctness.
2. model input too large, token cost and performance latency
3. how to display the info. e.g. downstream breaking can be found from sdk type or from sdk method. how to display it?
4. so many edge cases
   The deterministic coverage ledger and completeness invariant are defined in
   [Deterministic coverage and optional inference](#71-deterministic-coverage-and-optional-inference).
