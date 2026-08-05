# VoiceLive

VoiceLive is a TypeSpec-defined data-plane API. It follows the Azure AI Foundry
pattern (see `specification/ai-foundry/data-plane/Foundry`): it consumes the OpenAI
Realtime TypeSpec and emits **OpenAPI 3.1 only** (both `.json` and `.yaml`) via the
`@typespec/openapi3` emitter configured in [tspconfig.yaml](tspconfig.yaml).

It intentionally does **not** provide a lowercase `readme.md` AutoRest configuration:
the OpenAI Realtime models use `oneOf` unions and bare numeric scalars that the
Swagger 2.0 `@azure-tools/typespec-autorest` emitter cannot represent, and the AutoRest
schema validator only supports OpenAPI 3.0.x. The OpenAPI 3.1 documents are the
canonical contract for this service.

## Outputs

| Version | JSON | YAML |
| --- | --- | --- |
| v1 (stable) | `openapi3/v1/VoiceLive.json` | `openapi3/v1/VoiceLive.yaml` |
| virtual-public-preview | `openapi3/virtual-public-preview/VoiceLive.json` | `openapi3/virtual-public-preview/VoiceLive.yaml` |

## Contributing

VoiceLive uses the **label-based (`v1`) versioning** pattern. For authoring rules — how to add
GA and preview features, promote preview to GA, handle breaking changes, and compile/send a PR
— see [CONTRIBUTING.md](CONTRIBUTING.md). For the full design and rationale, see
[docs/versioning.md](docs/versioning.md).
