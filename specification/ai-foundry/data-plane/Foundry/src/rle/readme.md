# Reinforcement Learning Environments

RLE registers immutable environment versions and executes scored rollouts using
Gym/OpenEnv, a same-project Foundry Hosted Agent, or an external HTTPS harness.
The [developer experience spec](https://github.com/coreai-microsoft/foundrysdk_specs/pull/394)
covers publication, training, evaluation and inspection.

## Contract scope

- Environment registration, latest/exact-version reads, version/task listing and deletion.
- Harbor task archive upload-target issuance and finalization, with
  project-scoped content-hash reuse and per-task image readiness.
- Execute Rollout through the client-facing `:executeRollout` action and the
  backend-native `/rollout` route.
- Instance group and instance lifecycle through both pinned-version and
  environment-name paths.
- Job metadata/metric/rollout reads and rollout metadata/result/event reads.

The service inherits the Foundry project endpoint and Microsoft Entra
authentication. Operations require the RLE read, write or delete data action
appropriate to the operation, plus project/model/feature enablement.
Runtime credentials and workspace infrastructure routes are not public API inputs.

OpenEnv reset/step/state/MCP proxying and binary rollout WebSockets are runtime
protocols, not JSON resource operations. They are not represented as ordinary
HTTP model methods here. The asynchronous rollout client uses that separate
transport; HTTP execution uses the same task/policy/result contract.
Signed archive bytes are uploaded directly to project storage, not to an RLE
JSON endpoint. Sandbox-pool management, rollout-to-sandbox bindings and
producer-side job/metric writes are outside this draft's scope.
High-level training submission/cancellation remains on the existing fine-tuning
API, not an RLE job-create action.

## Compatibility decisions

The draft describes implemented wire behavior rather than asserting a service
migration:

- Management fields use camelCase; rollout/defaults fields use snake_case.
- Registration presents top-level model/train/rollout defaults. The service's
  nested `defaults` input alias is not exposed as a second authoring shape.
- Lists use `data` and `nextContinuationToken`. TypeSpec pagination annotations
  identify the request/response token without inventing `nextLink`.
- Registration is a non-repeatable POST, returns 201/Location, and starts image
  conversion. Read `diskImageConversionStatus`; there is no LRO poller contract.
  Harbor versions use per-task readiness from the tasks list instead of the
  environment-level image status.
- Harbor selects a published task with `task: {"name":"..."}` and a package
  harness such as `opencode` or `terminus-2`. It does not accept BYOH/Hosted
  Agent harnesses or per-rollout image/bundle overrides.
- Rollout IDs are one-shot reservations, not idempotency keys. A timeout after
  admission has an unknown outcome; a retryable dependency error does not permit
  replaying the same ID.
- The structured error is top-level `code`/`message`; environment input validation
  can also return a string. Capacity errors can include `Retry-After`.
- The existing project service's `v1` and virtual-preview projections are retained.
  The `api-version` query is declared but not hard-coded: current management and
  rollout clients select different version strings. Version convergence and
  gateway publication of backend-native routes require API-owner agreement.

Four narrowly scoped linter exception categories preserve these existing contracts:
nonstandard resource operations, mixed string/object errors, the lack of a
shared model base for that error union, and Harbor's empty feature-gate 404
alongside its default error payload. Suppression approval remains required;
compilation does not constitute API approval.

The Harbor `no-error-status-codes` exception applies to the operation foundation
and both upload operations. When the feature is disabled, the backend returns
404 with no response body; it does not return the default structured/string
error payload. Keep the explicit empty 404 so generated clients do not assume
an error body exists. An authorized API reviewer must approve this exception
through the repository's suppression-review process.

Formal API review follows experience-spec sign-off. Public package distribution
does not establish regional endpoint availability or SDK release readiness.

The request/response examples are illustrative, not live service captures.
The opaque capture graph is abbreviated; its internal transport schema is not
defined by this API.
