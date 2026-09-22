# Python preview generation and Loom parity

The customer-facing target is the tested SDK at Loom commit
`485774df502642879fdf3a53777be4a0d95155dc`, with the approved distribution/import
rename to `azure-ai-finetuningsessions` / `azure.ai.finetuningsessions`.

**The local public SDK now regenerates from these TypeSpec inputs plus supported,
maintained Python hooks.** Its public API and offline behavior match that target;
internal source files are deliberately not a byte-identical Loom copy.

## Separation from the REST contract

[client.tsp](client.tsp) selects the existing shared Foundry service and operation
groups. Python-scoped `@alternateType` maps its raw models to the tested preview
shapes in [loom-models.tsp](loom-models.tsp). This includes model optionality,
required constructor arguments, enum members, discriminator inheritance, and
read-only fields. The SDK-specific file is not imported by the REST entry point.

The real service continues to use HTTP 200 submissions, request identifiers,
`pending` / `completed` / `failed` polling, required sampling checkpoint IDs,
and `/fine_tuning/sessions` routes. No HTTP 202 response or normalized operation
result was inserted into its contract. All four full Foundry OpenAPI outputs
were byte-identical before and after the client-only changes.

## Generation/customization responsibilities

| Area | Maintained source |
|---|---|
| 36 generated models and 7 enums | SDK-only TypeSpec model projection, Python-scoped `@alternateType` |
| Client/group names, per-call `api_version`, `begin_*` names, non-pageable lists | TypeSpec client decorators |
| Training, retries, chunking, errors, IDs, heartbeat | Original Loom root/aio hooks, exception/logging modules; executable training bodies unchanged |
| Authentication and public exports previously edited into generated files | Supported root/aio subclasses, `__all__`, and `patch_sdk()` hooks |
| Raw `body` / `operation_id` signatures, JSON create, legacy pollers | Supported operation subclasses; generated request builders reused |
| Legacy raw sampling without the modern required checkpoint query | One maintained request builder in the compatibility helper, not a weakened REST parameter |
| Nested nullable sampling tuples and exact `Dict` annotation | Supported model subclasses with exact overloads and serialization |

The legacy raw operation API intentionally retains existing quirks: synchronous
`begin_*` initial responses accept HTTP 200, while asynchronous `begin_*` initial
responses require HTTP 202. The tested training conveniences bypass those
legacy pollers and implement the actual HTTP 200/request-ID protocol. Fixing the
quirk or heartbeat shutdown is a later review change, not part of parity.

## Tooling and evidence

The package-local SDK emitter manifest and lock pin Python emitter `0.61.3`,
`http-client-python` `0.28.3`, compiler `1.11.0`, and TCGC `0.67.3`. This preserves
the tested serialization/model helper implementation. An old emitter alone was
not sufficient: the SDK-only model mapping and maintained hooks are necessary.

Azure SDK MCP's customization workflow was consulted. With its existing Copilot
CLI configured, it returned `ManualInterventionRequired` for substantial custom
training integration, not a successful automatic implementation. The subsequent
implementation uses documented Python hooks, not generated-code rewriting.

Local acceptance results:

- Two independent clean emissions: all 21 generated files match, and the full
   runtime including pre-seeded maintained hooks matches after emitter formatting.
- 434 unchanged upstream tests pass against the generated SDK and installed wheel.
- 20 paired convenience cases: 134 requests and 2,246 checks per SDK, no API allowances.
- All 45 exported models/enums, 76 model construction/serialization cases,
   client/operation signatures and overloads, and 336 raw-operation cases match.
- Full Foundry compilation: 29 warnings, four OpenAPI files unchanged.
- Scoped pinned Python generation: 99 warnings, zero errors. This is not a claim
   of warning-free repository CI, API review approval, or live GPU validation.

The SDK source pointer must pin the commit containing these inputs before remote
generation/PR CI/release. The baseline is committed separately from subsequent
SDK review fixes so exact preview parity remains independently reproducible.
No Loom working-tree changes or public review fixes are part of this baseline.
