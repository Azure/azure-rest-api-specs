# Python preview generation and Loom parity

## Route ownership refactor (2026-09-23)

The HTTP routes and all 15 service operations remain defined once in
`session-finetuning/routes.tsp`. The Python client file contains no routed
interfaces or operation aliases. Supported Python-scoped `@clientName`,
`@clientLocation`, and `@scope` decorators reuse the service operations while
retaining exactly the existing 13-operation selection and five SDK groups.
All model mappings, per-call API-version behavior, and legacy polling/pagination
customizations remain SDK-only. The shared operation template is unchanged;
the separate `FoundryDataPlaneRequiredPreviewOperation` migration is not included.

The starting public TypeSpec and SDK commits are respectively
`a170cb1188d5fc706a6433a0c95a13caf30c72fe` and
`df4b722725386974c26463fb375ba7e27f6511fb`. Isolated baseline and candidate
emissions with identical maintained Python hooks have byte-identical generated
Python and assembled runtime. All four full REST outputs are byte-identical.
Only 26 APIView operation identities now refer to the original service rather
than aliases; this is metadata, not an API or wire change.

Baseline and candidate each pass 501 regression tests and the existing full
Loom API/behavior comparison; the installed candidate wheel passes these checks
as well. No runtime, tests, verifiers, comparison exceptions, or Loom files were
changed. The 13 former facade lint suppressions disappeared with the aliases;
the historical CI counts below predate this refactor.

The TypeSpec refactor is committed separately from its SDK metadata update.
The SDK source pointer and provenance identify the commit containing this
refactor; the starting commits above remain the comparison baselines.

The customer-facing target is the tested SDK at Loom commit
`485774df502642879fdf3a53777be4a0d95155dc`, with the approved distribution/import
rename to `azure-ai-finetuningsessions` / `azure.ai.finetuningsessions`.

**The parity baseline regenerates from TypeSpec inputs plus supported,
maintained Python hooks.** SDK commit
`39c2b3c882526897619785089074176b367099a6`, pinned to TypeSpec
`d912f0d0bc6af9e87e0c0833922dd85fa32abf97`, matches that target's public API and
offline behavior; internal source files are deliberately not a byte-identical
Loom copy. The baseline results below are historical. Subsequent SDK review
fixes and the current local CI-repair snapshot are separate from exact baseline
parity; the final new source pointer has not yet been established here.

## Separation from the REST contract

[client.tsp](https://github.com/Azure/azure-rest-api-specs/blob/haarunkumar/finetuning-sessions-spec/specification/ai-foundry/data-plane/Foundry/src/sdk-python-azure-ai-finetuningsessions/client.tsp) selects the existing shared Foundry service and operation
groups. Python-scoped `@alternateType` maps its raw models to the tested preview
shapes in [loom-models.tsp](https://github.com/Azure/azure-rest-api-specs/blob/haarunkumar/finetuning-sessions-spec/specification/ai-foundry/data-plane/Foundry/src/sdk-python-azure-ai-finetuningsessions/loom-models.tsp). This includes model optionality,
required constructor arguments, enum members, discriminator inheritance, and
read-only fields. The SDK-specific file is not imported by the REST entry point.

The real service continues to use HTTP 200 submissions, request identifiers,
`pending` / `completed` / `failed` polling, required sampling checkpoint IDs,
and `/fine_tuning/sessions` routes. No HTTP 202 response or normalized operation
result was inserted into its contract. At the parity baseline, all four full
Foundry OpenAPI outputs were byte-identical before and after the client-only
changes. The current repair comparison has only the three description changes
recorded below, not an HTTP, structural schema, or protocol change.

## Generation/customization responsibilities

| Area | Maintained source |
|---|---|
| 36 generated models and 7 enums | SDK-only TypeSpec model projection, Python-scoped `@alternateType` |
| Client/group names, per-call `api_version`, `begin_*` names, non-pageable lists | TypeSpec client decorators |
| Training, retries, chunking, errors, IDs, heartbeat | Original Loom root/aio hooks, exception/logging modules; executable training bodies unchanged at parity baseline, with subsequent SDK review fixes tracked separately |
| Authentication and public exports previously edited into generated files | Supported root/aio subclasses, `__all__`, and `patch_sdk()` hooks |
| Raw `body` / `operation_id` signatures, JSON create, legacy pollers | Supported operation subclasses; generated request builders reused |
| Legacy raw sampling without the modern required checkpoint query | One maintained request builder in the compatibility helper, not a weakened REST parameter |
| Nested nullable sampling tuples and exact `Dict` annotation | Supported model subclasses with exact overloads and serialization |

The legacy raw operation API intentionally retains existing quirks: synchronous
`begin_*` initial responses accept HTTP 200, while asynchronous `begin_*` initial
responses require HTTP 202. The tested training conveniences bypass those
legacy pollers and implement the actual HTTP 200/request-ID protocol. Fixing the
raw polling quirk remains a separate API decision. Awaited heartbeat shutdown
was added in subsequent SDK review fixes, not in the exact parity baseline.

## Historical tooling and parity evidence

The package-local SDK emitter manifest and lock pin Python emitter `0.61.3`,
`http-client-python` `0.28.3`, compiler `1.11.0`, and TCGC `0.67.3`. This preserves
the tested serialization/model helper implementation. An old emitter alone was
not sufficient: the SDK-only model mapping and maintained hooks are necessary.

Azure SDK MCP's customization workflow was consulted. With its existing Copilot
CLI configured, it returned `ManualInterventionRequired` for substantial custom
training integration, not a successful automatic implementation. The subsequent
implementation uses documented Python hooks, not generated-code rewriting.

Baseline local acceptance results:

- Two independent clean emissions: all 21 generated files match, and the full
   runtime including pre-seeded maintained hooks matches after emitter formatting.
- 434 unchanged upstream tests pass against the generated SDK and installed wheel.
- 20 paired convenience cases: 134 requests and 2,246 checks per SDK, no API allowances.
- All 45 exported models/enums, 76 model construction/serialization cases,
   client/operation signatures and overloads, and 336 raw-operation cases match.
- Full Foundry compilation: 29 warnings, four OpenAPI files unchanged.
- Scoped pinned Python generation: 99 warnings, zero errors. This is not a claim
   of warning-free repository CI, API review approval, or live GPU validation.

The immutable source pin above keeps the baseline independently reproducible,
separate from subsequent SDK review fixes. No Loom working-tree changes or public
review fixes are part of this baseline. It is not the final source pin for the
CI-repair batch below.

## CI repair validation (2026-09-22)

### Compiler and REST comparison

- Compiler **1.16** passes the full Foundry REST and Python entry points with
   warnings treated as errors. All changed TypeSpec files pass formatting. This is
   distinct from the historical compiler 1.11.0/pinned-emitter warning counts.
- Exact REST output comparison proves that the only changes are **three
   expected descriptions** on `OpenAI.Error.details`, `additionalInfo`, and
   `debugInfo`. No HTTP behavior, structural schema, wire type, or
   protocol changed.
- **14 C#-only `clientName` mappings** give raw types `Content`/`Result` names
   to address non-Python naming lint. Python names/types and wire types remain
   unchanged. This is not a cross-language readiness claim: other-language SDKs
   still require their own CI validation.

### Exact-node compatibility exceptions

A standard-RPC trial was rejected because it introduced new path warnings; it
was not adopted as a route or protocol repair. The retained exceptions are:

| Category | Retained count |
|---|---|
| Raw-operation `use-standard-operations` | 15 |
| Facade `use-standard-operations` | 13 |
| Legacy augments | 9 |
| Inheritance | 1 |

Each exception targets its exact node and records a known compatibility reason.
These exceptions must retain human review; warnings-as-errors success does not
mean zero exceptions or automatic approval of the preview API design.

### Generation and remaining validation

The TypeSpec default `generate-packaging-files=true` fixes missing Python
project packaging metadata in clean output. Maintained-SDK generation instead
explicitly overrides `generate-packaging-files=false` to retain reviewed package
metadata. **Actual MCP SDK generation passed**, unlike the earlier automatic
customizer result. Two independent pinned emissions match all **21 generated
inventory entries** and the complete maintained runtime, including the generated
model documentation-only update. The generated models' executable AST is unchanged.

SDK baseline CI build `6867846` exposed the Python 3.10
`typing.get_overloads` import failure. Overloads are now inspected through AST
on every Python version. Local tests pass **500 with 1 skip on Python 3.10**
(the eager-task test needs Python 3.12+) and **501 on Python 3.13**. The SDK's
local Pylint, actual-sdist strict Sphinx, MCP README, and root CSpell results and
retained exceptions are recorded in
[GENERATION.md](https://github.com/Azure/azure-sdk-for-python/blob/feature/finetuning-sessions-sdk/sdk/ai/azure-ai-finetuningsessions/GENERATION.md)
and [REVIEW.md](https://github.com/Azure/azure-sdk-for-python/blob/feature/finetuning-sessions-sdk/sdk/ai/azure-ai-finetuningsessions/REVIEW.md).

Final formatting, two-emission reproducibility, and the full compatibility gate
pass locally: 20 paired cases, 45 public types, and 336 raw-operation cases, with
only the previously recorded review contracts. The SDK source pointer is updated
after this TypeSpec commit. Remote CI must rerun after push; local validation
does not claim that external gates or human review are complete.

The PyPI package name is **not reserved** and requires the approved reservation
pipeline. REST `api-doc-preview` is blocked by a missing repository script and
an invalid infrastructure AAD client secret. These are external blockers, not
reasons to invent an SDK/specification code fix or bypass authentication.
