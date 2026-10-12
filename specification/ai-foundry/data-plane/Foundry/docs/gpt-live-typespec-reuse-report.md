# GPT Live TypeSpec: reuse and extensions

Updated October 12, 2026.

- TypeSpec base: Azure `azure-rest-api-specs` main `7ff49991176`, synchronized before PR creation.
- Native dependency: `@azure-tools/openai-typespec` **1.29.0**, replacing 1.28.0.
- Implementation reference: Vienna `origin/master` **0c9308ec2af11**, fetched October 12.
- Scope: TypeSpec and emitted OpenAPI only. No Vienna runtime changes or SDK package release.

## Design

```text
AgentDefinition                         kind discriminator
└─ VoiceAgentDefinition                 kind: voice
   ├─ RealtimeVoiceAgentDefinition      sub_protocol: realtime
   │  └─ Existing realtime/cascaded configuration
   └─ LiveVoiceAgentDefinition          sub_protocol: live
      ├─ OpenAI Live configuration types
      └─ Delegation:
         ├─ OpenAI client
         ├─ OpenAI responses
         └─ Foundry foundry_managed_agent

Inference events                       native type discriminator
├─ OpenAI.LiveClientEvent               reused, not copied or extended
└─ OpenAI.LiveServerEvent               native events plus Foundry additions
   ├─ session.started                  optional Foundry conversation_id
   └─ session.managed_delegation.*
      ├─ started
      ├─ progress
      ├─ completed
      ├─ failed
      └─ cancel

Stored conversation items              read APIs only, with store: true
├─ Existing native Realtime item types  reused unchanged
└─ live_delegation                     one item per native delegation ID
   ├─ input                            provenance and captured context
   └─ output                           backend results / client receipts / managed execution
```

The agent definition remains flat. No common audio union is added to the voice base.
`sub_protocol` never becomes an inference-event property. An agent cannot switch protocols;
a different protocol requires a different agent.

## What we reuse and what we extend

| Surface | Reuse | Foundry extension or boundary |
|---|---|---|
| Audio | `OpenAI.LiveInitialSessionAudioParam`, including native formats and voice settings | None. Realtime keeps its separate `VoiceAgentAudioConfig`. |
| Initial context | `OpenAI.LiveInitialItem[]` | Preserve the native 128-item limit. |
| Client capabilities | `OpenAI.LiveClientConfigParam` | None; importing the type does not enable WebRTC in Foundry. |
| Native delegation | `OpenAI.LiveClientDelegationParam` and `OpenAI.LiveResponsesDelegationParam`, including backend configuration/tools | A Foundry-only `VoiceAgentLiveDelegation` union adds `foundry_managed_agent`. Native session-configuration delegation unions remain untouched. |
| Inference | Native client/server model identities and existing event payloads | Following the Realtime extension pattern, add five Foundry server subclasses and discriminator literals, plus optional `conversation_id` on the primary `session.started` event. No projected turns or `sub_protocol` on events. |
| Agent management | Existing agent CRUD, versioning, `kind: voice`, and shared voice base | Two definition subclasses selected by `sub_protocol`, with a project deployment name, structured inputs, and Foundry persistence policy. |
| Connection | Existing Foundry project auth/preview/version-selection conventions | `GET /agents/{agent_name}/endpoint/protocols/voice/live/sessions`, returning HTTP 101. No negotiated realtime subprotocol and no HTTP request body. |
| Persistence | Existing voice conversation/audio retrieval experience and native Realtime item models | A read-only `VoiceConversationItem` union adds `live_delegation` without changing either inference hierarchy. Foundry projects persisted speech turns from the native timeline; delegation remains a separate item. Agent `store` does not mean native Live recording/fork storage. |

The hand-maintained native models in `live-models.tsp` have been removed. The file now contains
only native package imports and the Foundry delegation extension. The native event roots are
retained for SDK generation through `@usage`; WebSocket frames are not HTTP bodies, so they are
not modeled as a POST request or a 101 response body.

OpenAI 1.29.0's Live model entrypoint references `target_uri` without importing its declaration.
The additional **model-only** webhook import resolves this published-package issue. No native
HTTP operation entrypoint is imported and no installed package files are patched.

## Managed prompt-agent delegation

The latest Vienna implementation uses this canonical definition:

```json
{
  "kind": "voice",
  "sub_protocol": "live",
  "model_type": "self_deployed",
  "model": "gpt-live-1",
  "instructions": "Be a friendly English teacher. Delegate detailed grammar explanations.",
  "delegation": {
    "type": "foundry_managed_agent",
    "agent_name": "english-teacher",
    "result_format": "tagged_text"
  },
  "store": true
}
```

- `agent_name`: same-project prompt agent, matching Vienna's 1–63 character name pattern.
- `agent_version`: optional positive-integer string, at most 20 digits; omission/null resolves
  the active version once per connection.
- `result_format`: `tagged_text`, the only current format and the default.
- `managed_prompt_agent` is an accepted legacy spelling in Vienna, not a new SDK variant.
- Foundry translates this configuration to native **client delegation**. Validated output is
  injected through native commentary/thinking messages. Hosted targets and legacy draft result
  formats are not advertised.

## Foundry server-event extensions

These are the target TypeSpec contracts. Most already match Vienna; the removal of `request`
and separate `cancel` notification require a later Vienna update.

| Event | Meaning and additional data |
|---|---|
| `session.started` | Optional top-level `conversation_id` identifies the stored Foundry voice conversation. Native `session.id` remains the Live session ID. The field is absent when not storing. |
| `session.managed_delegation.started` | Valid context is ready and the managed invocation is starting. |
| `session.managed_delegation.progress` | Cumulative validated commentary/background context and optional accepted `output_items`, before the backend finishes. |
| `session.managed_delegation.completed` | Backend execution and native context injection succeeded; includes nullable `backend_conversation_id`. Does not assert completed speech/playback. |
| `session.managed_delegation.failed` | Execution/injection failed. Includes nullable `failure_context_status`, and may retain earlier accepted `output_items` after partial failure. Failed result text is not emitted as guidance. |
| `session.managed_delegation.cancel` | The invocation was cancelled or superseded. May retain earlier accepted `output_items`; does not imply successful execution or recall already accepted guidance. This is a **server notification**, not a client command. |

There is no `session.managed_delegation.request` variant.

All five managed events have typed correlation and execution metadata: `event_id`, `delegation_id`,
`agent_name`, pinned `agent_version`, `result_format`, nullable `response_id`/`error_code`,
`has_spoken_text`, `has_background_context`, `mcp_call_count`, `stream`, and `offset_ms`.
Optional `backend_store` describes backend Responses persistence, not voice persistence.

`output_items` is typed: each entry has `output_index` and accepted `appends` containing a native
append event ID, commentary/thinking type, content, and acceptance status. This is not raw tool
output. No lifecycle event carries the backend request body. The optional diagnostic request is
retained only in the stored managed-execution item described below.

The notifications are best-effort, independently of voice `store`. Correlate by native
`delegation_id`, not by projected turns. `spoken_text` is accepted speakable guidance, **not**
an assistant transcript. `background_context` is validated context, not private model reasoning.
Failure-context `accepted` means Live accepted the failure notification, not that delegation succeeded.

Implementation uses `copyVariants` and native server subclasses for new event types, and
`copyProperties` on `OpenAI.LiveServerEventLiveSessionStarted` for correlation. It does not replace
the native session object, modify client events, or add this primary-connection field to sideband events.

## Persisted delegation item

**Vienna already stores `type: "live_delegation"`** using its extensible `UnknownOutputItem`
carrier. The missing part was a named TypeSpec model for SDK consumers. `VoiceLiveDelegationConversationItem`
now describes it in conversation item list/get, response item list, and `VoiceResponse.output`.

The persistence-only union reuses all seven existing native item variants plus the new item.
It does **not** add a new child or discriminator value to `OpenAI.RealtimeConversationItem`,
so realtime `conversation.item.create` and both protocols' inference events remain separate.

| Field | Meaning |
|---|---|
| `id`, `created_at` | Foundry item ID and service-observed Unix creation time. |
| `delegation_id`, `target`, `offset_ms?` | Native correlation, `client` or `responses`, and optional native timeline offset. Foundry-managed delegation has native target `client`. |
| `response_id?` | Associated persisted voice turn, omitted if the association cannot be resolved. It is not the backend response ID. |
| `status`, `capture_status`, `capture_reason?` | Execution outcome versus completeness of bounded capture; cancellation is `cancelled`. |
| `input` | Caption-derived context, or provenance indicating that the exact prepared managed request is retained. |
| `output.responses` | Observed backend response text/items, including separate tool continuations. |
| `output.client_messages` | Submitted append content and accepted/rejected/unconfirmed receipts. |
| `output.managed_prompt_agent?` | Managed target/version, execution outcome, optional prepared `request`, backend `response_id`, validated guidance, and accepted outputs. |

Illustrative stored item (not a newly captured service response):

```json
{
  "type": "live_delegation",
  "id": "item_delegation_1",
  "created_at": 1791763200,
  "delegation_id": "del_1",
  "response_id": "resp_voice_1",
  "target": "client",
  "offset_ms": 1200,
  "status": "completed",
  "capture_status": "complete",
  "input": {
    "source": "live_transcript_context",
    "exact_backend_request_available": false,
    "truncated": false,
    "messages": [{ "role": "user", "text": "Please explain the past tense." }]
  },
  "output": {
    "responses": [],
    "client_messages": [{
      "event_id": "evt_append",
      "type": "session.commentary.append",
      "content": "The past tense of go is went.",
      "status": "accepted"
    }]
  }
}
```

This item is only retained with `store: true`; it is not a transcript or an inference event.
Removing the transient request notification does not remove the gated stored request.
The item and its input/output/receipt structures are typed. The prepared request and heterogeneous,
possibly partial native backend output objects use `Record<unknown>` rather than an inaccurate
completed-Response schema.

### Later Vienna alignment

1. Stop emitting `session.managed_delegation.request`.
2. Emit `session.managed_delegation.cancel` for cancelled/superseded managed executions instead
   of reporting them as `failed`. Genuine errors, including backend timeout, remain `failed`.
3. Keep existing stored `live_delegation` capture; its cancelled execution status already exists.

No Vienna code was changed in this update.

## Remaining boundaries

1. **Startup ownership:** Foundry sends `session.start` from the stored definition. The native
   catalog includes that event, but application clients on the Foundry route must not send it.
2. **Legacy definitions:** Missing `sub_protocol` still means realtime in the service.
   The discriminated schema describes explicit protocol selection; automatic legacy omission
   handling and omission-preserving SDK round trips are not proven by TypeSpec compilation.
3. **Existing scalar convention:** Foundry already maps OpenAI `integer`/`numeric` to
   `int64`/`float64`. This is unchanged and is applied equally to both sides of the native
   model comparison.
4. **Transport scope:** Native SIP, sideband, fork, WebRTC REST operations, and recording
   download are not exposed merely by importing their model catalog.

## Validation

- ✅ **20/20 contract tests pass**, covering both API versions, all 152 native Live models with an explicit allowlist
  for the server extensions, discriminator unions, direct configuration reuse, managed-agent
  constraints, handshake shape, typed event/persistence examples, malformed-payload rejection,
  cancellation direction, and isolation of persisted delegation from realtime inference.
- ✅ SDK model metadata includes all five managed-delegation classes and optional
  `session.started.conversation_id` under the native Live server-event hierarchy, plus typed
  stored delegation models. No removed request-event model remains.
- ✅ **Repository TypeSpec validation passes** in a clean source snapshot: 5 checks passed,
  4 skipped, and 3 covered by existing repository suppressions. Compilation uses warnings as
  errors. Before committing, a clean snapshot was used to satisfy the validator's clean-checkout
  guard without changing the feature worktree.
- ✅ Foundry OpenAPI is regenerated for `v1` and `virtual-public-preview`; compiling the clean
  snapshot leaves no generated-file differences.
- ✅ Customer SDK TypeSpec entrypoints compile: C# Projects Agents, Java Agents, and Python/JavaScript
  Projects. Two stale Java references were moved from the voice base to the realtime subclass.
- ✅ Realtime regression comparison covers **214 schemas and 14 routes per API version**:
  213 schemas and 11 routes are unchanged. The intentional persistence changes are
  `VoiceResponse.output` and the three item-read operations,
  now exposing the read-only union. Existing item models, speech/audio retrieval, and realtime
  WebSocket behavior are unchanged. Upstream 1.29.0 adds `deprecated: true` to
  `OpenAI.MCPTool.connector_id`; its accepted values and optionality are unchanged.
- ✅ Frozen-lockfile installation, changed-TypeSpec formatting, test-file formatting, and
  whitespace checks pass using Node 24.14.1, pnpm 12.6.0, and TypeSpec 1.17.0.
- ❌ The internal **C# service-contract** entrypoint fails with duplicate OpenAI symbols before
  and after this change, caused by its existing normal/client-emitter imports and
  `ItemResourceType` alias. It is not counted as a passing SDK target.
- No generated SDK binary validation or service E2E was run. The TypeSpec validation MCP is
  unavailable in this task; repository CLI validation is used instead.

Run the checked-in contract tests from the repo root:

```sh
pnpm exec node --test specification/ai-foundry/data-plane/Foundry/tests/live-contract.test.mjs
```

## References

- Native source: installed `@azure-tools/openai-typespec@1.29.0`, `src/live/models.tsp`.
- Vienna: `Customizations/Agents/live/LiveVoiceDelegation.cs`,
  `Customizations/Agents/live/LiveConversationModels.cs`,
  `Customizations/Validators/LiveAgentValidators.cs`, `GptLiveProtocol.cs`,
  `GptLiveManagedPromptAgentResolver.cs`, `GptLiveManagedDelegationCoordinator.cs`,
  `GptLiveDelegationCapture.cs`, and `GptLiveRecording.cs`.
- [TypeSpec model composition and inheritance](https://typespec.io/docs/language-basics/models/)
- [TypeSpec unions](https://typespec.io/docs/language-basics/unions/)
- [TypeSpec built-in decorators](https://typespec.io/docs/standard-library/built-in-decorators/)
- [OpenAI Live primary WebSocket](https://developers.openai.com/api/reference/resources/live/primary-websocket)
