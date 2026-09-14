<!-- NOTE: This comment is for file maintainers only and is not rendered.
     Upstream alignment: 2026-08-13
     Derived from the Azure REST API Guidelines (vNext) and TypeSpec Azure
     resource-operation guidance. Upstream documents take precedence. -->

# Data-Plane Resource Modeling and Versioning

Use this reference only for semantic decisions that require understanding
resource intent, operation relationships, PR history, or API-version history.
Do not restate local compiler or linter diagnostics.

> **Authoritative upstream:** [actions](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#actions),
> [do not use actions for CRUD](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#actions-no-actions-for-crud),
> [collections](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#collections),
> [versioning](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#versioning),
> [no breaking changes](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#versioning-no-breaking-changes),
> and
> [no versions in paths](https://github.com/microsoft/api-guidelines/blob/vNext/azure/Guidelines.md#versioning-no-version-in-path).

## TypeSpec mapping

- Model resource CRUD with `StandardResourceOperations.ResourceRead<T>`,
  `ResourceList<T>`, `ResourceCreateOrUpdate<T>`, `ResourceUpdate<T>`, and
  `ResourceDelete<T>`. Use `ResourceAction` only for non-CRUD behavior.
- Express versioned additions, removals, and renames with `@added`, `@removed`,
  and `@renamedFrom`; do not delete or rename published declarations in place.
- Inspect `@route` values when deciding whether the PR introduces a
  version-bearing path.

## DP-MODEL-01: Actions must not disguise CRUD

- **Severity:** Warning; Blocking is permitted only for a new service's first
  stable version.
- **Strength:** `DO NOT` use actions for standard CRUD behavior.

A POST action is a defect when the caller could achieve the same result through
PUT, PATCH, or DELETE on an addressable resource.

Strong signals:

- the action name is a CRUD synonym such as `update`, `set`, `create`, `remove`,
  or `delete`;
- its request and response are the resource model;
- its only effect is assigning resource properties;
- a stateful concept has only verb-shaped POST endpoints.

Do not flag computations, meaningful state transitions, batch operations, or
structured searches that standard resource verbs cannot express.

A finding must name the resource and standard operation that replace the
action. "This looks like CRUD" is not actionable.

## DP-MODEL-02: Stateful concepts need stable addressability

- **Severity:** Warning.

A concept with independent identity and lifecycle should have a stable URL.
Flag a model that is created, read, or deleted only through parent actions when
the same concept has its own key and lifecycle.

Do not flag transient inputs, derived results, or values that exist only as part
of a parent.

## DP-VERSION-01: Stable API changes must remain compatible

- **Severity:** Blocking.
- **Strength:** `DO NOT` introduce breaking changes in a stable API.

Compare the changed surface with the most recent stable version. Flag:

- removed or renamed operations, response properties, union members, or error
  codes;
- changed routes or property types;
- optional request properties made required;
- required response properties made optional;
- open unions made closed;
- changed defaults that alter omitted-input behavior.

Breaking changes between preview versions, or between a preview and its first
stable replacement, are permitted. Do not report them as Blocking.

## DP-VERSION-03: Versioned changes need correct decorators

- **Severity:** Warning.

New declarations and members need the appropriate `@added` decorator; removals
and renames need versioning decorators rather than source deletion. Confirm the
effect against emitted prior-version Swagger when necessary.

Do not report decorator syntax diagnostics already emitted by the compiler.
The semantic finding is that the changed source leaks into, removes from, or
renames something in a previously published version.

## DP-VERSION-04: New routes must not embed service versions

- **Severity:** Blocking for a genuinely new route in a new service or new API
  version; Suggestion on a maintenance edit.
- **Strength:** `DO NOT` include service-version segments in operation paths.

Flag `/v1/`, `/v2.0/`, and similar version segments only when the PR introduces
or changes that route. Existing shipped routes are out of scope because changing
them would itself break callers.

Stay silent when an external protocol the service does not control mandates the
segment, such as OCI Distribution or Apache Atlas compatibility. An internal
versioning preference is not an exception.

## Out of scope

- Basic operation-template, route-decorator, version-declaration, and casing
  diagnostics.
- Runtime behavior and authorization enforcement.
- ARM resource lifecycle and provisioning-state rules.
- Speculative singleton, collection, or operation-symmetry questions without a
  concrete defect.
