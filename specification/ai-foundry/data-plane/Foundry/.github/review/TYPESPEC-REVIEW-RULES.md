# LLM Instructions: TypeSpec Review Rules

Use these rules as review heuristics when assessing TypeSpec changes. They were distilled from historical repository review feedback, not from a single normative specification. Verify each concern against the actual service contract, generated SDK impact, and current repository patterns; do not report a heuristic as a defect without evidence in the change.

## Review approach

- Review the full change surface. For changes to models, routes, or names, consider related `client.tsp` customizations, emitter metadata, generated-language naming, documentation, and compatibility projections. (`pr-47071.md:11-13`; `pr-46314.md:11-19`)
- Keep related declarations synchronized when removing or relocating an operation/model, including naming, access, metadata, and route/customization entries. (`pr-46418.md:11`; `pr-47071.md:13`)
- Prefer established shared repository patterns for operations, jobs, pagination, errors, and service declarations over a locally divergent contract. (`pr-43961.md:11` rule 5; `pr-46314.md:13` rule 2)
- Weigh evidence carefully: reviewer guidance is not equivalent to an independently verified test. Author-reported validation, bot status, merge status, and empty approvals do not establish that a design is correct. (`pr-46316.md:13-17`; `pr-47719.md:13-18`)

## Contract and compatibility

- Check wire compatibility before making discriminators required, changing property types or order, removing operations, or altering pagination. Consider existing payloads and generated SDK signatures; preserve ordering where union/member order is significant. (`pr-46672.md:11` rules 1, 2, 5; `pr-47619.md:11`)
- Keep REST contract names and shapes service-accurate. Address language-specific SDK names, grouping, alternate types, and compatibility exceptions with language-scoped `client.tsp` customizations rather than changing the wire schema to solve an SDK-only concern. (`pr-43961.md:11` rules 3, 6; `pr-47714.md:11`; `pr-47793.md:11`; `pr-47303.md:11`)
- Keep SDK-only preservation/customization decorators in the appropriate `client.tsp`, not on REST-route declarations; use parameter-level customization only when necessary. (`pr-45805.md:15`; `pr-46063.md:17`)
- Model polymorphism explicitly when consumers need to distinguish payload shapes: use a discriminated base and typed variants, retain subtype discriminator literals, avoid redundant inherited properties, and allow unknown future string values when the contract is extensible. (`pr-46314.md:11` rules 1, 4; `pr-46316.md:11` rules 1, 3; `pr-46672.md:11` rule 2)
- Use distinct types when codes represent different semantic domains (for example, lifecycle reasons versus operation or aggregate-job status). Do not combine them merely because their wire values look similar. (`pr-46316.md:11` rule 2)
- Choose collection shape from the contract: named properties for fixed fields, dictionaries for dynamic uniform key/value maps, and arrays when entries may repeat or carry their own metadata. (`pr-46314.md:11` rule 3; `pr-47272.md:11`)
- During refactors, preserve existing optionality, length/range constraints, defaults, and documented values unless the service contract intentionally changes. (`pr-46316.md:11` rule 3; `pr-43961.md:11` rules 1, 2, 4; `pr-47719.md:11`)
- Model omission, explicit `null`, defaults, and update/no-change semantics separately when the service distinguishes them; do not infer one behavior from another. (`pr-45984.md:17`)
- Use extensible string unions when known values should be documented but future service values must remain accepted; use closed unions only when the contract is genuinely closed. (`pr-46316.md:11` rule 1; `pr-43961.md:11` rule 7)
- Treat request and response representations independently. Select schemas and media types for each direction based on actual service support rather than mirroring the request shape. (`pr-45805.md:13`)

## TypeSpec and SDK-facing design

- Document public models, operations, and parameters. Explain behavior, valid values, bounds, defaults, and context; ensure prose agrees with declared types and decorators. (`pr-43961.md:11` rules 1, 2; `pr-46672.md:17`; `pr-46530.md:11`)
- Declare defaults and constraints only when supported by service behavior. A default must be fixed server behavior, not a dynamically derived value. Do not invent bounds; keep documented limits consistent with the declarations. (`pr-43961.md:11` rule 2; `pr-47719.md:11`; `pr-46925.md:11`)
- Document serialized structured query parameters, including required URL encoding and whether caller-supplied values override server defaults. (`pr-46433.md:13`)
- Choose aliases versus models based on generated SDK intent: aliases can support spread-only reuse without introducing a model type; use models or inheritance when consumers need a reusable SDK hierarchy or specialization. (`pr-46672.md:15,26`)
- Reuse imported/upstream declarations only where their contract matches. Omit or replace incompatible fields, but do not redeclare fields already supplied by an authoritative imported model. (`pr-47071.md:11`)
- Apply shared operation/job patterns and API-version/error conventions. Use `@list` only for operations that are actually paginated. (`pr-43961.md:11` rule 5; `pr-46314.md:13`)
- For asynchronous operations returning `Operation-Location`, document the related polling/status-monitor operation and how clients use it. (`pr-39565.md:11`)
- Keep concrete operations within the intended service interface; a namespace-level operation can unintentionally emit a root `POST /`. (`pr-46247.md:11`)
- Treat request-body parameter names as potentially SDK-visible method arguments; choose descriptive names and check language-specific naming behavior. (`pr-43961.md:11` rule 6; `pr-46314.md:11` rule 5)
- For repository-owned linter rulesets, preserve upstream rules and keep rule enablement guidance consistent across rulesets, templates, and documentation. (`pr-46750.md:11` rules 1–3)

## Scope and uncertainty

- Language-specific mappings, renames, alternate types, visibility, paging options, and manual SDK entries are scoped customization decisions, not universal REST/TypeSpec rules. (`pr-47619.md:11`; `pr-47135.md:11`; `pr-47575.md:11`)
- Duration encoding, dictionary mappings, and shared-type mappings depend on the wire contract, emitter, and toolchain. Verify the specific case rather than generalizing. (`pr-46672.md:21`; `pr-47272.md:11`)
- Preview/GA promotion, API-version changes, and removals require service- and release-specific compatibility analysis; historical examples do not establish a universal rule. (`pr-46830.md`; `pr-46404.md`; `pr-46423.md`)
- Compatibility decisions are API-version-specific: do not assume legacy request fields must always remain, nor that preview migrations can discard old contracts; verify supported consumers and version guarantees. (`pr-46247.md:17`; `pr-47330.md:13`)
- Job resource shape changes (for example, separating submitted inputs from persisted resource properties), replacement SDK names, and preservation of legacy client names are scenario-specific; document migration paths where applicable. (`pr-46955.md:11-13`; `pr-47378.md:11`)
- Dependency changes should keep pins, lockfiles, and generated output synchronized; regeneration is a toolchain check, not evidence that the API contract changed. (`pr-47140.md:13`)
- Linter enablement feedback conflicts: some material describes project-level opt-in, while other guidance requests repository-wide enablement documentation. Treat the intended policy as unresolved and verify current repository guidance before commenting. (`pr-46750.md:13-15`)

## Finding-writing checklist

For each potential finding, state the affected TypeSpec element, the concrete contract or SDK consequence, and why the change causes it. Cite the applicable source/spec evidence. Separate confirmed behavior from assumptions, and omit findings that rely only on historical examples or author-reported checks.
