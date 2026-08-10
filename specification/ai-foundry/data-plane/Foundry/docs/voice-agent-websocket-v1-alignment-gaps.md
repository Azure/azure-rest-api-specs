<!-- cspell:ignore byom pcma pcmu viseme -->

# Voice Agent WebSocket v1 Service–TypeSpec Alignment

This report records the customer-facing WebSocket contract review for
[PR #45143](https://github.com/Azure/azure-rest-api-specs/pull/45143). It is limited to the stable `v1`
voice-agent WebSocket route and its JSON event data models; persisted conversation REST routes are out of
scope.

The comparison used:

- Voice Agent Orchestrator `origin/main` at `9cdb0e810ccc8ed761a48621cb75b00af6d197f8` (2026-08-04),
  including the canonical models in `ga_interface_types.py`, shared runtime models, and v1 unit tests;
- Voice Agent service `origin/master` at `cd5e9fa4320e6743422b18ed6d01004406de1348` (2026-08-03),
  including the public WebSocket controller, session mapper, orchestration bridge, and focused unit tests;
- the TypeSpec and generated OpenAPI in this PR;
- the voice-agent control-plane models from
  [PR #45185](https://github.com/Azure/azure-rest-api-specs/pull/45185), which this PR is based on and
  reuses for session voice, audio format, noise reduction, transcription, VAD, greeting, MCP scheduling,
  and output modalities;
- the Voice Live v1 property-retyping pattern from
  [PR #44893](https://github.com/Azure/azure-rest-api-specs/pull/44893); and
- the API review discussion in
  [PR #43970](https://github.com/Azure/azure-rest-api-specs/pull/43970).

## Summary

All identified P0 service/TypeSpec mismatches are fixed. The public contract uses direction-specific v1
session models composed from the control-plane models in PR #45185, with WebSocket-only overrides only where
the runtime wire contract differs. It also uses runtime-compatible response items and explicit models for the
service event extensions. Internal Voice Live exchanges remain excluded.

| Priority | Status | Finding                                                                               | Resolution                                                                                                                                                               |
| -------- | ------ | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| P0       | Fixed  | Session input/output formats reused permissive OpenAI/REST shapes                     | Reused the structured PR #45185 format limited to `audio/pcm`, `audio/pcma`, and `audio/pcmu`; only the input override remains nullable                                  |
| P0       | Fixed  | Nested audio fields differed from the runtime                                         | Aligned input/output format, transcription, noise reduction, turn detection, echo cancellation, voice, speed, and timestamps                                             |
| P0       | Fixed  | Session VAD, transcription, modality, and audio models drifted from the control plane | Reused PR #45185 models and retained WebSocket-only wrappers only for nullable input overrides, echo cancellation, and runtime EOU options                               |
| P0       | Fixed  | Session voice choices did not match stable v1                                         | Uses the extensible `voice`, `voice_type`, and `voice_locale` string fields without changing the `voice` property type                                                     |
| P0       | Fixed  | WebSocket tools drifted from persisted-agent tools                                    | Reused Realtime function, control-plane toolbox/system, and scheduling models; retained only MCP runtime authorization fields                                            |
| P0       | Fixed  | Forced function selection referenced the generic Responses API model                  | Added and referenced the Realtime-specific `OpenAI.RealtimeToolChoiceFunction` wire model                                                                                |
| P0       | Fixed  | `session.update`, response-create, and service session state were raw OpenAI models   | Added direction-specific models with the exact stable-v1 field names                                                                                                     |
| P0       | Fixed  | Response and item models lost service fields                                          | Added cost estimates, structured content formats, Foundry/web/file/workflow output items, truncated items, and transcription phrases                                     |
| P0       | Fixed  | Response items and content-part events shared incompatible content discriminators     | Split item content (`output_text`/`output_audio`) from `response.content_part.*` event content (`text`/`audio`) to match OpenAI Realtime and the service wire projection |
| P0       | Fixed  | Public service events were missing or too optional                                    | Added animation, rate-limit, and web/file-search events and aligned event requiredness                                                                                   |
| P0       | Fixed  | Stable v1 added `gpt-transcribe` and `gpt-live-transcribe` after the initial review   | Added both public literals to the shared control-plane transcription model and made model selection required                                                             |
| P0       | Fixed  | The transcription union advertised internal or legacy Azure/MAI model names           | Kept `azure-speech` and the canonical `mai-transcribe`; removed `azure-mrs`, `mai-transcribe-1`, and `mai-transcribe-1.5`                                                |
| P0       | Fixed  | The browser-compatible agent-version query alias was missing                          | Added the public `x-agent-version-override` query parameter implemented by the Voice Agent service                                                                       |
| P0       | Fixed  | Internal session/BYOM events were public                                              | Kept `session.close`, `session.done`, `byom_credential.update`, and `byom_credential.updated` out of the customer contract                                               |
| P0       | Fixed  | Successful upgrade was modeled with a JSON body                                       | The HTTP `101` response is bodyless; event models describe subsequent WebSocket text frames                                                                              |
| P1       | Open   | Binary WebSocket audio frames are not represented                                     | Document raw binary-frame direction, format selection, and fragmentation outside the JSON event union                                                                    |
| P1       | Open   | OpenAPI event unions do not emit a `type` discriminator mapping                       | Refactor the event hierarchy when the emitter can preserve the broad OpenAI plus Foundry event surface                                                                   |
| P2       | Open   | SDK usage customization lives in protocol TypeSpec                                    | Move `@usage` customization to `client.tsp` without changing the wire schemas                                                                                            |

## Fixed contract details

### Audio input and output

The stable v1 session format is a structured object:

```json
{
  "type": "audio/pcm",
  "rate": 24000
}
```

Only `audio/pcm`, `audio/pcma`, and `audio/pcmu` are advertised. The control-plane `VoiceAudioFormat` model is used by
`session.update.audio`, `session.created`/`session.updated`, response-specific audio overrides, and returned
input/output content parts. The stable-v1 TypeSpec intentionally exposes only this structured format; legacy
format strings remain a dated-preview compatibility detail in the runtime adapter.

The complete public input shape now includes `format`, `noise_reduction`, `transcription`, `turn_detection`,
and `echo_cancellation`. Internal multichannel fields are excluded. The shared control-plane and WebSocket
output shape includes `format`, `voice`, `speed`, and `output_audio_timestamp_types`.

The public transcription model list includes `gpt-transcribe` and `gpt-live-transcribe`. It exposes
`azure-speech` and only the canonical MAI name, `mai-transcribe`; the internal or legacy names `azure-mrs`,
`mai-transcribe-1`, `mai-transcribe-1.5`, and `azure-fast-transcription` are intentionally excluded. Turn
detection includes server VAD, OpenAI semantic VAD, Azure semantic VAD, and Azure multilingual semantic VAD.
Clients disable turn detection with `null`; `{ "type": "none" }` is not public. Public end-of-utterance, interruption, idle-timeout,
speech-duration, language, and auto-truncation controls are represented; internal detector-tuning fields are
not.

The WebSocket avatar model uses the control-plane `video_avatar` and `photo_avatar` discriminator values and
includes ICE servers, video resolution/crop/background/encoding, scene
placement, `websocket-binary`, and audit-audio output. The deprecated private `image_prompt_url` field remains
excluded.

### Stable voice shape

The control-plane and WebSocket contracts preserve `voice` as an extensible string and add optional
`voice_type` and `voice_locale` strings. This avoids changing the existing property type while allowing new
providers and voice families without revising the model. For example:

```json
{
  "voice": "alloy",
  "voice_type": "azure-standard",
  "voice_locale": "en-US"
}
```

### Session and response payloads

`VoiceAgentSessionUpdateConfig` now matches the stable runtime request fields, while
`VoiceAgentSessionResponseConfig` composes its common fields from that request model and separately overrides
server-authoritative state. Both directions reuse the control-plane voice fields, audio format, noise reduction,
transcription, VAD, greeting, MCP scheduling, and modality models. This avoids accepting response fields in
`session.update`, avoids dropping effective session fields from `session.created` or `session.updated`, and
prevents the persisted and runtime contracts from drifting independently.

`response.create` now uses the stable nested `audio.output` shape and supports the service's response-only
controls. `response.created` and `response.done` use the service response object, including
`estimated_cost`, `conversation_id`, `modalities`, `voice`, `output_audio_format`, and metadata.

Response message content includes service `audio` and `format` properties. Its assistant content uses the
OpenAI Realtime item discriminators `output_text` and `output_audio`. In contrast,
`response.content_part.added` and `response.content_part.done` use the event-part discriminators `text` and
`audio`; these are separate wire models rather than one permissive union. The output union also includes MCP,
workflow, web-search, and file-search item kinds implemented by the orchestrator.

### Event alignment

The event surface now includes:

- `response.animation_blendshapes.delta` / `.done`;
- `response.animation_viseme.delta` / `.done`;
- `rate_limits.updated`;
- web-search and file-search lifecycle events;
- enriched `conversation.item.truncated.item`;
- transcription `phrases` with word timing; and
- the existing warning, avatar, audio-timestamp, video, and MCP families.

All custom models derived from the runtime server-message base now require `event_id`.

### Connection route

The public Agent Service route accepts `agent_session_id` and the browser-compatible
`x-agent-version-override` query alias. The latter selects a specific persisted agent version for the
session without requiring a custom WebSocket upgrade header. The `realtime` subprotocol and
`x-ms-voice-structured-inputs` header are also represented. Internal session-configuration and identity
override headers remain excluded.

## Intentional exclusions

Do not add the following implementation-only or Voice Live internal fields/events to the Voice Agent
customer contract:

- `x-ms-voice-session-override`;
- `session.close` and `session.done`;
- `byom_credential.update` and `byom_credential.updated`;
- emotion-hypothesis and emotion-animation payloads;
- image prompt URL fields;
- input-text delta/done events;
- Azure fast-transcription internals;
- internal VAD tuning fields, including detector window/phone/vowel and assistant-only developer knobs;
- keyword-interrupt and appended-text-after-truncation internals; and
- internal agent-version and identity override headers.

## Remaining non-P0 work

1. Add narrative transport documentation for raw binary audio frames. Binary data must not be inserted into
   the JSON event union.
2. Emit discriminator mappings for the large client/server event unions without losing the imported OpenAI
   event variants.
3. Move SDK-specific `@usage` customization out of `protocol.tsp`.

## Verification checklist

- [x] The WebSocket operation is part of the v1 contract; the repository's synthetic `virtual-public-preview` projection is emitted automatically.
- [x] The request and response session models are direction-specific.
- [x] Common session fields reuse the PR #45185 control-plane models where the wire shapes match.
- [x] Audio and voice models match the canonical v1 runtime schema.
- [x] Public VAD, transcription, animation, avatar, tool, and greeting fields match the runtime.
- [x] Response/item properties are retyped instead of only renaming event wrappers.
- [x] Internal session finalization, BYOM credential, emotion, and override fields are absent.
- [x] The HTTP `101` response has no entity body.
- [x] Public Agent Service WebSocket route parameters match the current controller.
- [x] The voice-agent TypeSpec projection compiles with no diagnostics.
- [ ] Add binary-frame transport documentation.
- [ ] Complete event discriminator and SDK-generation cleanup.
