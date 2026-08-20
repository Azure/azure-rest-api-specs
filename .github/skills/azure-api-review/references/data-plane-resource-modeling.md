<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-07-24
     Derived from:
       - Azure REST API Guidelines (vNext)
         https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md
       - TypeSpec Azure library docs (Azure.Core resource operation templates)
         https://azure.github.io/typespec-azure/docs/intro/
     The upstream documents always take precedence if there is a conflict.
     Rules here are agent-owned (see data-plane-linter-rule-coverage.md);
     do not restate anything the azure-core linter already enforces. -->

# Data-Plane Resource Modeling

Applies to data-plane TypeSpec (`specification/**/data-plane/**/*.tsp`). For ARM
control-plane resource rules, see
[`tracked-resource-lifecycle.md`](tracked-resource-lifecycle.md) instead --
none of it applies here.

> **Authoritative upstream:** [performing an action](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#actions),
> [do not use actions for CRUD](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#actions-no-actions-for-crud),
> [collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections),
> [API versioning](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#versioning),
> [no breaking changes](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#versioning-no-breaking-changes),
> and
> [no versions in paths](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#versioning-no-version-in-path)
> in the Azure REST API Guidelines. This file translates those requirements into
> reviewer checks; the upstream Guidelines take precedence.

`@azure-tools/typespec-azure-core/use-standard-operations` forces operations
through `Azure.Core` templates, which makes the mechanical half of the
Guidelines' resource rules true by construction. It does **not** decide whether
the resource should exist, whether the shape is the right one, or whether a POST
action is a CRUD operation wearing a disguise. That judgment is this file.

---

## DP-MODEL-01: Actions must not be CRUD in disguise

- **Rule ID:** `DP-MODEL-01`
- **Canonical name:** `actions-no-actions-for-crud`
- **Severity:** Warning (Blocking in a **new** service's first stable version)

A POST action **MUST NOT** perform an operation that the standard resource verbs
already express. Actions exist for behavior that is not create, read, replace,
update, delete, or list.

### Detection signals

Flag a POST action when **any** of these hold:

1. The action name is a CRUD synonym: `:update`, `:modify`, `:set`, `:save`,
   `:create`, `:add`, `:remove`, `:delete`, `:get`, `:fetch`, `:read`, `:list`,
   `:getAll`, `:query` (when `:query` merely filters a collection).
2. The action's request body is the resource model, or a subset of it, and its
   response is the same resource model.
3. The action's only effect is to write one or more properties that are already
   part of the resource's own schema.
4. There is no addressable resource at all, and every operation is a POST to a
   verb-shaped path (`/analyze`, `/process`, `/getItems`) -- the whole service
   is RPC over HTTP.

### Legitimate actions -- do not flag

An action is legitimate when it does something the verbs cannot express:

- It performs a **computation** that returns a derived result without mutating
  addressable state (`:analyze`, `:score`, `:translate`, `:embed`).
- It performs a **state transition** with semantics beyond a property write
  (`:cancel`, `:rotate`, `:regenerateKey`, `:publish`, `:failover`) -- where the
  service does work, not just a field assignment.
- It is a **bulk / batch** operation over many resources that cannot be
  expressed as a single-resource verb.
- It is a **search / query** whose request is genuinely too large or too
  structured for a URL, and which returns a projection rather than the resource.

The distinguishing question is: _if I removed this action, could a caller
achieve the same result with PUT/PATCH/DELETE on the resource?_ If yes, it is
CRUD in disguise. If no, it is an action.

### Fix

```tsp
// BAD -- a PATCH wearing a POST costume
@action("updateWidget")
op updateWidget(@path widgetName: string, body: Widget): Widget;

// GOOD -- the standard operation expresses this
op createOrUpdate is StandardResourceOperations.ResourceCreateOrUpdate<Widget>;
```

When flagging, name the specific standard operation that replaces the action.
A finding that says "this looks like CRUD" without naming the replacement is
not actionable.

---

## DP-MODEL-02: Addressability

- **Rule ID:** `DP-MODEL-02`
- **Severity:** Warning

Anything with an independent identity and lifecycle **SHOULD** be an addressable
resource with a stable URL. Anything without one **SHOULD NOT** be.

Flag when:

- A concept is created, retrieved, and deleted through actions on a parent
  rather than through its own path -- it wants to be a resource.
- A model has a `name`/`id` key property but no path that addresses it
  individually.
- Conversely: a resource path exists for something with no independent
  lifecycle, whose only operation is a read that always returns with the parent.

## DP-MODEL-03: Collection vs. singleton

- **Rule ID:** `DP-MODEL-03`
- **Severity:** Suggestion

A singleton (a resource path with no key segment) is correct only when there can
never be more than one instance for the given scope. If the service can
plausibly grow to multiple instances, a collection is the non-breaking choice --
converting a singleton into a collection later is a breaking change.

Ask: _could a customer ever want two of these?_ If the answer is "probably not
today, but maybe", prefer the collection.

## DP-MODEL-04: Operation symmetry

- **Rule ID:** `DP-MODEL-04`
- **Severity:** Question

Resources **SHOULD** expose a coherent set of operations. Flag asymmetries; each
one is a question the author should answer, not automatically a defect.

**This rule produces Questions, never findings.** The Guidelines contain no
`DO` requiring a delete operation, and plenty of legitimate resources have
none: append-only audit logs, immutable records, singletons created with their
parent, resources whose deletion is expressed as a reset or a state
transition. An asymmetry is a prompt to ask, so it belongs in the `Questions`
section of the report -- as a bullet, with no rule-ID heading and no severity
glyph. It is never a bracketed finding at Suggestion or above.

**Do not raise it at all when the specification already answers the
question** — a `@doc` explaining that a configuration cannot be deleted, only
reset, _is_ the cleanup story. Asking again is noise, and asking on every
resource that lacks a delete is how this rule becomes the reviewer's verbal
tic. If several resources in one PR share the same asymmetry, raise it **once**
for the service, not once per resource.

| Shape found                  | Question to raise                                                             |
| ---------------------------- | ----------------------------------------------------------------------------- |
| Create without read          | How does a caller confirm what was created, or read it back after a restart?  |
| Read without list            | How does a caller discover instances they did not create in this session?     |
| List without read            | Why can an item be enumerated but not addressed individually?                 |
| Create/update without delete | Is this resource genuinely permanent? What is the cleanup story?              |
| Delete without read          | How does a caller confirm the delete, or check existence first?               |
| Update without create        | Where do instances come from -- is creation implicit, and is that documented? |

Use the graph pass from [`think-in-graphs.md`](think-in-graphs.md) to find these;
they are hard to see in a linear read of a multi-file TypeSpec project.

## DP-MODEL-05: Sub-resource vs. inline collection

- **Rule ID:** `DP-MODEL-05`
- **Severity:** Suggestion

See [`data-plane-design-decisions.md`](data-plane-design-decisions.md) `DDP-001`
for the full trade-off matrix. Never blocking; present the trade-off and ask.

---

## Versioning and breaking changes

**This section is agent-owned in full.** The
`@azure-tools/typespec-azure-core/non-breaking-versioning` rule is explicitly
**disabled** (`false`) in the `@azure-tools/typespec-azure-rulesets/data-plane`
ruleset -- see [`data-plane-linter-rule-coverage.md`](data-plane-linter-rule-coverage.md).
Nothing mechanical checks data-plane backward compatibility. If the agent stays
silent here, nobody catches it.

### DP-VERSION-01: Breaking changes in a stable version

- **Rule ID:** `DP-VERSION-01`
- **Severity:** Blocking

Comparing the new version against the most recent **stable** version, flag:

| Change                                        | Why it breaks                                              |
| --------------------------------------------- | ---------------------------------------------------------- |
| Property removed from a response model        | Deserializers and customer code referencing it fail.       |
| Property type changed                         | Deserialization failure.                                   |
| Optional property made required in a request  | Previously valid calls now rejected.                       |
| Required property made optional in a response | Callers that assumed presence break.                       |
| Union member removed, or an open union closed | Values the service may still emit no longer deserialize.   |
| Operation removed or renamed                  | Compiled SDK calls break.                                  |
| Route changed for an existing operation       | Direct REST callers break.                                 |
| Default value changed                         | Silent behavior change for callers that omit the property. |
| Error `code` value removed or renamed         | Caller error handling keyed on the code breaks.            |

### DP-VERSION-02: Preview versions

- **Rule ID:** `DP-VERSION-02`
- **Severity:** Suggestion

Breaking changes **between preview versions**, and between a preview and the
stable version that supersedes it, are permitted. Do **not** flag them as
blocking. This is a high-frequency false positive: a reviewer that treats every
preview delta as a break becomes noise immediately.

Do raise, as a suggestion, a preview-to-preview break that looks unintentional
(for example, a property renamed with no corresponding rename elsewhere).

### DP-VERSION-03: Versioning decorator correctness

- **Rule ID:** `DP-VERSION-03`
- **Severity:** Warning

- New models, properties, operations, and union members introduced in a new
  version **MUST** carry `@added(Versions.<version>)`.
- Removals **MUST** use `@removed(Versions.<version>)` rather than deleting the
  declaration, so prior versions still emit correctly.
- Renames **MUST** use `@renamedFrom`, not a delete-plus-add pair.
- A property added without `@added` silently appears in **every** prior version's
  emitted swagger. Check the generated output under `stable/`/`preview/` to
  confirm; this is a case where reading the emitted swagger as evidence is
  required, not optional.

### DP-VERSION-04: Version segments in newly-added routes

- **Rule ID:** `DP-VERSION-04`
- **Severity:** Blocking permitted, but only for a genuinely new route -- see below
- **Upstream anchor:** `versioning-no-version-in-path` --
  ":no_entry: **DO NOT** include a version number segment in any operation path."

The api-version belongs in a query parameter, not the path. A path segment like
`/v1/` or `/v2.0/` pins every caller to a version at the URL level, which is the
opposite of how Azure services version.

**Only flag a version-like path segment on a route this PR adds or modifies.**
That restriction is the whole rule, so apply it before anything else.

#### Why the restriction exists

This guideline had a lint rule proposed for it. The rule was **withdrawn**: it
fired on 254 sites across the spec corpus and **every single one was
unfixable**, because renaming a published route is a breaking change. A finding
nobody can act on is noise, however correct it is.

What a linter cannot see, and you can, is **which routes are new**. A linter is
handed one compiled program with no notion of history, so an existing `/v2/` and
a brand-new `/v3/` look identical to it. You read the PR diff. A new API
introducing `/v1/` is a real, actionable finding -- the author can still change
it, and it costs nothing today and a major version later. That is the entire
value you add here, so spend your effort on the new/pre-existing distinction
rather than on detecting the segment.

See the "Not a rule" section of
[`data-plane-linter-rule-coverage.md`](data-plane-linter-rule-coverage.md)
for the measurement.

#### Stay silent when

- **The route already exists.** Not in the diff, not your business. Changing it
  is a `DP-VERSION-01` breaking change, so the "fix" would be worse than the
  defect.
- **An external standard mandates the segment.** Some services implement a
  wire protocol they do not own, and the path shape is a conformance
  requirement rather than a design choice. Known examples -- container
  registries carrying `/v2/` from the **OCI Distribution Spec**, catalog
  services carrying `/atlas/v2/` for **Apache Atlas** compatibility.

  Treat those as **illustrations of the pattern, not an allowlist**. The
  question is never "is this service on the list" but "is this segment dictated
  by a protocol the service must conform to". A spec implementing a documented
  third-party protocol is the general case; those two are simply the instances
  seen so far.

- **The spec documents such a rationale.** Note carefully what the condition is:
  `versioning-no-version-in-path` is an unconditional `DO NOT` with **no
  upstream exception clause**. The external-standard carve-out below is _this
  skill's own_ narrow judgment, not a Guideline `unless`, and it is the only
  rationale that earns silence here.

  The condition is: **an external protocol the service does not control dictates
  the path shape.** Nothing else qualifies. Apply it strictly, because a `DO NOT`
  with a self-granted exception is exactly how a rule quietly stops meaning
  anything.

  | Rationale                                                                | Verdict                                                                                                     |
  | ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------- |
  | "The OCI Distribution Spec defines the registry API as rooted at `/v2/`" | **Meets it.** Silent.                                                                                       |
  | "Apache Atlas compatibility requires `/atlas/v2/`"                       | **Meets it.** Silent.                                                                                       |
  | "Our evaluation engine is versioned separately from the service"         | **Fails.** An internal design preference. The `api-version` query parameter already carries version intent. |
  | "Callers pin the engine build they tested against"                       | **Fails.** A real need, but it argues for _some_ versioning mechanism, not for one in the path.             |

  A confident, well-written paragraph is not evidence of external conformance.
  Ask what document mandates the shape and who publishes it; if the answer is
  "we decided", the exception does not apply. Where the rationale fails, **say
  so in the finding** -- name the argument and explain why an internal
  preference cannot override a `DO NOT` -- rather than raising the finding as
  though no rationale were offered.

#### Severity

The upstream verb is `DO NOT`, so Blocking **is** permitted -- but only for a
new route in a new or preview API, where the author can still act. Anything
touching a shipped stable path is capped at Suggestion, because the fix is a
breaking change and the trade-off is the author's to make, not yours.

#### Caveat: this rule rests on an untested assumption

**The premise -- that you can reliably tell a newly-added route from a
pre-existing one -- is an assumption, not a demonstrated capability.** The
information is available to you (you read the PR through the GitHub API, and
`Step 1 -- Pin and classify` records both head and base SHA), but **nothing has
yet tested whether you actually use it** for this judgment. The eval stimuli for
this rule have never been executed.

If a measured run shows the distinction cannot be made reliably, the honest
conclusion is that this guideline has **no automated enforcement at all** --
neither lint nor agent -- and that is a more useful thing to know than a rule
that quietly reproduces the 254-unfixable-findings failure in a different
costume. Do not paper over it.

---

## What this file does not cover

- Whether the service actually enforces any of the constraints above at
  runtime -- unobservable, see the 🚫 Runtime section of
  [`data-plane-linter-rule-coverage.md`](data-plane-linter-rule-coverage.md).
- Casing, `enum`-vs-`union`, discriminator extensibility, `@route` usage, and
  the rest of the 🔒 list -- the linter owns those and the agent is silent.
- ARM resource lifecycle, `provisioningState`, tracked-resource rules -- a
  different plane entirely.
