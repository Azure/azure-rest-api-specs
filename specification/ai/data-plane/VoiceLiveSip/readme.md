# VoiceLiveSip

> see https://aka.ms/autorest

This is the AutoRest configuration file for VoiceLiveSip.

## Configuration

### Basic Information

This is a TypeSpec project so this readme only points to the outputted swagger files.
This is used for some tools such as doc generation and swagger apiview generation it isn't used for SDK code gen as we
use the native TypeSpec code generation configured in the tspconfig.yaml file. The default (latest)
API version is controlled by the `@azure-tools/typespec-autorest` emitter in tspconfig.yaml.

```yaml
openapi-type: data-plane
tag: package-2026-07-31-preview
```

### Suppressions

The blind-transfer (`Calls_Refer`) operation returns `202 Accepted` to acknowledge an event-driven asynchronous transfer whose completion is reported through `realtime.call.transfer.succeeded` / `realtime.call.transfer.failed` webhook events. It is not a pollable Azure long-running operation and exposes no `Operation-Location` polling endpoint, so the Azure LRO conventions do not apply.

```yaml
directive:
  - suppress: LroExtension
    from: VoiceLiveSip.json
    where: $.paths["/voice-agent/realtime/sip/calls/{call_id}/refer"].post
    reason: REFER returns 202 to acknowledge an event-driven asynchronous transfer whose completion is delivered via realtime.call.transfer.* webhook events. It is not a pollable Azure long-running operation and has no Operation-Location polling endpoint, so x-ms-long-running-operation does not apply.
  - suppress: LroHeaders
    from: VoiceLiveSip.json
    where: $.paths["/voice-agent/realtime/sip/calls/{call_id}/refer"].post.responses.202
    reason: The 202 acknowledges an event-driven asynchronous transfer whose completion is delivered via realtime.call.transfer.* webhook events; there is no Operation-Location polling endpoint to advertise.
```

### Tag: package-2026-07-31-preview

These settings apply only when `--tag=package-2026-07-31-preview` is specified on the command line.

```yaml $(tag) == 'package-2026-07-31-preview'
input-file:
  - preview/2026-07-31-preview/VoiceLiveSip.json
```
