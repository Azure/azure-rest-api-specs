# Voice Live v1

Voice Live v1 uses the existing WebSocket route with a label-based API version:

```text
wss://<resource-host>/voice-live/realtime?api-version=v1&model=<model-name>
```

Authentication is header-only:

- Microsoft Entra ID through the `Authorization` header.
- API key through the `api-key` header.

Credential-bearing query parameters are not supported.

The TypeSpec source imports the exact-pinned `@azure-tools/openai-typespec/models/realtime` package and composes Voice Live extensions over the OpenAI Realtime GA models. The WebSocket transport remains hand-written by the SDKs.

Validate the source from the azure-rest-api-specs repository root:

```shell
npx tsp compile specification/ai/data-plane/VoiceLive/v1/main.tsp --config specification/ai/data-plane/VoiceLive/tspconfig.yaml --no-emit
```

Emit the OpenAPI 3 contract:

```shell
npx tsp compile specification/ai/data-plane/VoiceLive/v1/main.tsp \
  --emit @typespec/openapi3 \
  --option '@typespec/openapi3.emitter-output-dir={cwd}/specification/ai/data-plane/VoiceLive' \
  --option '@typespec/openapi3.output-file=openapi3/v1/VoiceLive.json' \
  --option '@typespec/openapi3.file-type=json' \
  --option '@typespec/openapi3.omit-unreachable-types=true'
```
