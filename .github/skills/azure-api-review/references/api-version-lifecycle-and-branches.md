<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-27
     Derived from:
       - Azure Developer Experience docs: design/api-specs-pr/api-versions-and-branches
         (https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-versions-and-branches)
     The upstream document always takes precedence if there is a conflict.
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

**Authoritative reference:**

- [API versions and branches][api-versions-and-branches] (Azure Developer
  Experience docs). Read this for branch protection details, mirroring
  behavior, and internal-only services.

[api-versions-and-branches]: https://eng.ms/docs/products/azure-developer-experience/design/api-specs-pr/api-versions-and-branches

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

When a pull request description, changelog, or version folder implies one
lifecycle stage but the placement implies another, flag the mismatch rather than
guessing which one is intended. State both signals so the author can correct the
right one.

**Severity: Warning**, raised to **Blocking** when the mismatch would publish a
private preview or an in-development version to the public repository.

---

## Applying these rules

Determine three things before flagging:

1. **The repository** the pull request targets, public or private.
2. **The branch** it targets. This is `base.ref` on the
   `pull_request_read(method: "get")` response.
3. **The folder** the version sits in, `stable` or `preview`, and whether the
   folder name carries a `-preview` suffix.

Findings from this file belong to the `versioning-and-compatibility` category.

**Only flag a branch-keyed rule when the branch is actually known.**
APIVER-DEV-IN-MAIN and APIVER-PRIVATE-IN-PUBLIC both turn on which branch is
being targeted, and a `release-*` branch is a legitimate home for work that
would be a violation on `main`. If `base.ref` could not be read, skip those two
rules rather than assuming `main`. The folder rules, APIVER-GA-FOLDER and
APIVER-PREVIEW-FOLDER, need no branch and still apply.

Do not infer a lifecycle stage from the API version date alone. A date-stamped
folder says nothing about whether the version has customers or is feature-flag
gated, and both are load-bearing in the definitions above. If the stage cannot
be established from the pull request, say so rather than assuming.

Some situations legitimately fall outside this model. When a version does not
fit any stage cleanly, point the author at ARM API Review Office Hours
([aka.ms/armofficehoursinfo](https://aka.ms/armofficehoursinfo)) rather than
forcing it into one.
