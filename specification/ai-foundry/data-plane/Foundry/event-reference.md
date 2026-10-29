# Voice-agent reference generation

The client and server unions in `src/voice-agents/protocol.tsp` are the source of
truth for the voice-agent WebSocket reference. Their
`x-foundry-event-direction` annotations identify the two event sets.

`tsp compile .` runs `emitters/voice-event-reference.mjs` as the sole OpenAPI
writer. It wraps `@typespec/openapi3`'s `getOpenAPI3` API and accepts its emitter
options under `foundry-voice-events` in `tspconfig.yaml`. Do not also enable the
standard OpenAPI emitter for the same output paths.

The wrapper first generates the REST projection with `omit-unreachable-types:
true`. A second projection sets it to `false`, then retains only the two
annotated event unions and their transitive schema dependencies. It adds these
schemas to the v1 REST document without changing REST operations or existing
schemas. Conflicting definitions fail compilation instead of overwriting one
another. This preserves wire encodings such as Unix timestamps,
integer-millisecond durations, and base64 audio without exporting unrelated
unreachable models.

The combined reference is generated in both formats:

- `openapi3/v1/microsoft-foundry-openapi3.json`
- `openapi3/v1/microsoft-foundry-openapi3.yaml`

Other API versions retain their REST-only output. Event schemas are included
directly in the v1 OpenAPI files; no separate event-schema file is generated.
Commit the generated artifacts alongside their TypeSpec changes; do not edit
them by hand.

Run the emitter's focused extraction, combination, and serialization checks
from the repository root:

```sh
node --test specification/ai-foundry/data-plane/Foundry/emitters/voice-event-reference.test.mjs
```

Reference ingestion can consume the combined OpenAPI YAML as a single input.
The renderer must enumerate the `x-foundry-event-direction` roots and their
schemas even though HTTP operations do not reference them. These schemas describe
WebSocket frame payloads, not HTTP response bodies or a complete WebSocket
protocol; the existing `101` handshake has no response body. The documentation
refresh must use the Git branch and commit containing the generated files.
OpenAI's client/server organization is a presentation precedent, not a second
source of event definitions.
