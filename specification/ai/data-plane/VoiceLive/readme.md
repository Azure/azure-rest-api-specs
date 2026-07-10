# VoiceLive data-plane TypeSpec

This folder contains the TypeSpec for the VoiceLive data-plane REST API.

## Contributing

This is a TypeSpec project. The generated swagger (OpenAPI) files under `stable/` and
`preview/` are the source of truth for doc generation and Swagger APIView. SDK code is
generated natively from TypeSpec as configured in `tspconfig.yaml`, not from this readme.

The default (latest) API version emitted for tooling is controlled by the
`@azure-tools/typespec-autorest` emitter in `tspconfig.yaml`.

### Compiling and sending a PR

Before you send a PR for changes in this folder, do the following.

Change to this folder:

```cmd
cd specification\ai\data-plane\VoiceLive
```

Make sure you have the latest tools:

```cmd
npm ci
```

Compile, validate, and re-format:

```cmd
npx tsv .
```

Fix any errors you see. This command also updates the generated swagger files under
`stable/` and `preview/`. Review those changes and include them in your PR.
