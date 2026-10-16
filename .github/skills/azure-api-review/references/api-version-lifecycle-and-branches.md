<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-15
     Derived from:
       - Azure Developer Experience docs: design/api-specs-pr/api-versions-and-branches
         (https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-versions-and-branches)
       - ARM Resource Provider docs:
         rp_onboarding/afec/featureexposurecontrol
         (https://eng.ms/docs/products/arm/rp_onboarding/afec/featureexposurecontrol)
     The upstream references take precedence if this file conflicts with them.
     Known upstream typo: the private-preview section says a folder must "have
     `-prefix` in its folder name"; it means `-preview`. Encoded correctly here. -->

# API Version Lifecycle and Branch Placement

An API version is a TypeSpec or OpenAPI contract identified by its
`api-version` value, and it lives in its own directory. Which lifecycle stage it
is in determines **which repository and branch it may appear in**, and how its
folder must be named.

These are placement rules, not schema rules. They are checked against the
pull request's target repository and branch plus the directory the version sits
in, so they apply even when the spec content itself is correct.

**Authoritative references:**

- [API versions and branches][api-versions-and-branches] (Azure Developer
  Experience docs). Read this for branch protection details, mirroring
  behavior, and internal-only services.
- [Feature Exposure Control (AFEC)][feature-exposure-control] (ARM Resource
  Provider docs). Read this for AFEC onboarding and implementation details.
- [Supported GitHub repos/branches][supported-arm-branches] (ARM RPaaS
  onboarding). Check this for supported ARM targets; do not assume that an
  existing branch is a supported publication destination.

[api-versions-and-branches]: https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-versions-and-branches
[feature-exposure-control]: https://eng.ms/docs/products/arm/rp_onboarding/afec/featureexposurecontrol
[supported-arm-branches]: https://eng.ms/docs/products/arm/rpaas/swaggeronboarding#supported-github-reposbranches

---

## Lifecycle stages

| Stage               | Released to                | Lives in                                                    |
| ------------------- | -------------------------- | ----------------------------------------------------------- |
| Generally available | All Azure customers        | Public specs repo `main`                                    |
| Public preview      | All Azure customers        | Public specs repo `main`                                    |
| Private preview     | A limited set of customers | Private specs repo only; ARM specs on `RPSaaSMaster`        |
| In development      | Nobody; no customers yet   | Not in public `main`; may be in a public `release-*` branch |
| Closing down        | Existing customers only    | Stays in the repo until fully deprecated, then removed      |

A version with **no customers** is `in development`, not `private preview`. The
presence of at least one customer is what distinguishes the two.

---

## Azure Feature Exposure Control (AFEC) for ARM private previews

Azure Feature Exposure Control (AFEC) is ARM's mechanism for limiting access to
a resource provider feature to approved subscriptions. An API version is
AFEC-gated when access to it depends on an Azure feature registration, so only
customers admitted to the private preview can use that version. See [Feature
Exposure Control (AFEC)][feature-exposure-control] for onboarding and
implementation details.

Within this lifecycle model, AFEC gating is required for ARM private previews
and must be removed before public preview or general availability. AFEC does not
replace repository and branch placement: an ARM private-preview specification
remains in the private specs repo on `RPSaaSMaster`, while a public preview or
generally available specification belongs in the public repo without feature
gating.

---

## APIVER-PRIVATE-IN-PUBLIC -- private preview must not reach the public repo

A `private preview` API version **MUST NOT** be present in the public specs
repo, on `main` **or any other branch**.

For ARM specs, a private preview version belongs on the `RPSaaSMaster` branch of
the private specs repo, and must be access-controlled with Azure Feature
Exposure Control (AFEC) flags.

Data-plane private previews may sit on any private-repo branch except `main` and
the `RPaaS*` branches, and do not require AFEC gating, because data-plane
services are expected to have their own preview onboarding mechanism.

**Severity: Blocking.** Publishing a private preview to the public repository
exposes a contract that was deliberately limited to selected customers.

**Not a violation: a deliberate promotion.** Copying specs from the private repo
to the public repo is how a `private preview` becomes a `public preview`, so the
mere fact that a previously private version now appears in a public pull request
is not by itself a finding. Treat it as a promotion, not a leak, when the version
satisfies APIVER-PREVIEW-FOLDER and any feature-flag gating is being removed as
part of the change. Flag it only when the pull request is copying the version
across while it is still meant to stay private, for example when the folder still
declares a stage the placement contradicts.

When this rule does fire, the fix is the documented move process at
[aka.ms/azsdk/move-pr](https://aka.ms/azsdk/move-pr), which also covers
disabling feature flags and publishing customer-facing documentation. Point the
author there rather than asking them to simply delete the files.

## APIVER-PRIVATE-FOLDER -- private preview uses preview folder and suffix

A private-preview version in the private repository **MUST** sit under
`preview/` and end in `-preview`, for example `2026-01-01-preview`. This applies
to ARM and data-plane private previews even though their branch and feature-flag
requirements differ.

**Severity: Blocking.**

## APIVER-DEV-IN-MAIN -- in-development versions must not reach public `main`

An `in development` API version **MUST NOT** be present in the public specs repo
`main` branch at all. It may exist in a public `release-*` feature branch while
it is being built.

Note that this is about `main` specifically: a `release-*` branch is the correct
home for work in progress.

**Severity: Blocking** when the pull request targets public `main`.

## APIVER-GA-FOLDER -- GA versions use a `stable` folder with no preview suffix

For a version to be generally available it **MUST**:

- be in the public specs repo `main` branch;
- sit under a parent `stable` folder, with **no** `-preview` suffix on the
  version folder name;
- not be gated by any feature flag, including AFEC flags.

A GA version behind a feature flag is not generally available, whatever the
folder says.

**Severity: Blocking.**

## APIVER-PREVIEW-FOLDER -- public preview versions use a `preview` folder and suffix

For a version to be in public preview it **MUST**:

- be in the public specs repo `main` branch;
- sit under a parent `preview` folder **and** carry a `-preview` suffix in the
  version folder name, for example `2026-01-01-preview`;
- not be gated by any feature flag, including AFEC flags.

A folder named `2026-01-01-preview` under `stable/`, or `2026-01-01` under
`preview/`, is a mismatch between the declared stage and the actual placement.

**Severity: Blocking.**

## APIVER-STAGE-MISMATCH -- the stage claimed must match the placement

When a pull request description, changelog, declared API-version value, or version
folder implies one lifecycle stage but the placement implies another, flag the
mismatch rather than guessing which one is intended. State both signals so the
author can correct the right one.

**Severity: Warning**, raised to **Blocking** when the mismatch would publish a
private preview or an in-development version to the public repository.

## ARM target repository and branch validation

For **every ARM spec PR**, validate the target repository and branch before
applying the lifecycle and folder checks. Use PR **base** metadata, not the
author's fork or source branch. The following ARM-specific checks supplement,
and do not change, the data-plane rules above.

| Target repository               | Target branch          | Intended use                                                                |
| ------------------------------- | ---------------------- | --------------------------------------------------------------------------- |
| `Azure/azure-rest-api-specs`      | `main`                 | Publication of public preview and GA contracts                              |
| `Azure/azure-rest-api-specs`      | `release-*`            | In-development work before publication, not private previews                 |
| `Azure/azure-rest-api-specs-pr`   | `main`                 | Read-only mirror of public `main`; never a direct PR destination             |
| `Azure/azure-rest-api-specs-pr`   | `RPSaaSMaster`          | ARM private-preview publication, with AFEC gating; not unreleased development |
| `Azure/azure-rest-api-specs-pr`   | `RPSaaSDev`             | ARM development/testing, not customer-facing publication                     |
| `Azure/azure-rest-api-specs-pr`   | `InternalARMContracts`  | Internal-only ARM contracts, not customer-facing public or private previews   |

Consult the authoritative references for current support and exceptions. If
they cannot be accessed, disclose that limitation rather than claiming to have
verified the live branch list.

- **APIVER-PRIVATE-MAIN (Blocking):** Reject direct PRs to private `main` even
  when the folder and lifecycle otherwise match. Public preview/GA changes
  belong in public `main` and reach private `main` through mirroring. For other
  stages, recommend the corresponding supported private branch instead.
- **APIVER-ARM-BRANCH (Blocking for a confirmed mismatch):** Flag use of
  `RPSaaSMaster`, `RPSaaSDev`, or `InternalARMContracts` in the wrong repository
  or for an incompatible lifecycle. In particular, development versions must
  not target publication branches (`main` in public or `RPSaaSMaster` in
  private); use public `release-*` or private `RPSaaSDev` as appropriate.
  Internal-only contracts belong on private `InternalARMContracts`; a private
  preview with customers is not an internal-only contract. Do not infer
  internal-only status merely because the repository is private.
- **APIVER-OBSOLETE-BRANCH (Warning / clarification):** Treat `dev-*` and
  `ARMCoreRPDev` as obsolete targets, not supported alternatives. Ask the author
  to confirm the intended lifecycle and move to a supported target from the
  onboarding guidance; do not recommend creating or reviving these branches.
- **APIVER-BRANCH-CLARIFY (Warning / clarification):** For any other target
  repository/branch combination, post a clarifying comment asking which
  supported onboarding workflow and lifecycle it serves. Do not silently
  accept an unrecognized branch or invent a blocking policy violation.
  Likewise, request missing base metadata or lifecycle evidence instead of
  assuming `main` or guessing a destination.

Do not reject legitimate private-to-public promotion or in-development work on
public `release-*`. Do not flag unchanged historical versions merely because a
PR also contains a version at a different lifecycle stage.

### Required review comment

Report these checks in `versioning-and-compatibility`. A repository/branch
finding has no JSON property or meaningful source line: post it as a PR-level
comment rather than fabricating a JSON path or inline location. Deduplicate
findings that share the same cause.

Include the observed **base repository and branch**, affected **version path/name**
(and declared API-version value if different), lifecycle evidence, a linked rule
ID, the **expected branch/lifecycle**, and a concise remediation (retarget or move
the PR, correct the folder/suffix, or confirm the intended lifecycle). For unknown
targets, state that the expected destination depends on the author's clarification
and link the supported repos/branches guidance. Never claim a branch violation
when only the source branch is known.

---

## Applying these rules

Determine four things before flagging:

1. **The repository** the pull request targets, public or private.
2. **The branch** it targets. This is `base.ref` on the
   `pull_request_read(method: "get")` response.
3. **The folder** the version sits in, `stable` or `preview`, and whether the
   folder name carries a `-preview` suffix.
4. **The lifecycle evidence**, from the PR description, changed specifications,
   or release documentation, including customer availability and feature gating.
   Compare the version folder/name with the declared API-version value (for
   OpenAPI, `info.version`); report discrepancies rather than silently choosing
   one. A `-preview` suffix alone cannot distinguish private from public preview.

Findings from this file belong to the `versioning-and-compatibility` category.

**Only flag APIVER-DEV-IN-MAIN when the branch is actually known.** A
`release-*` branch is a legitimate home for in-development work that would be a
violation on `main`, so skip that rule rather than assuming `main` when
`base.ref` could not be read. APIVER-PRIVATE-IN-PUBLIC depends on the repository,
not the branch: a version that is still private preview is prohibited from
every branch in the public repository. The folder rules, APIVER-PRIVATE-FOLDER, APIVER-GA-FOLDER, and
APIVER-PREVIEW-FOLDER, need no branch and still apply.

Do not infer a lifecycle stage from the API version date alone. A date-stamped
folder says nothing about whether the version has customers or is feature-flag
gated, and both are load-bearing in the definitions above. If the stage cannot
be established from the pull request, say so rather than assuming.

Some situations legitimately fall outside this model. When a version does not
fit any stage cleanly, point the author at ARM API Review Office Hours
([aka.ms/armofficehoursinfo](https://aka.ms/armofficehoursinfo)) rather than
forcing it into one.
