# Spec: Voice-First Agents

- Design source: [coreai-microsoft/foundrysdk_specs PR 215](https://github.com/coreai-microsoft/foundrysdk_specs/pull/215), source commit `080fa9cdd77cc894b3b8d308a3823b5397c53567`
- Canonical TypeSpec snapshot: [`feature/voice-agent-batch2`](https://github.com/Azure/azure-rest-api-specs/tree/feature/voice-agent-batch2/specification/ai-foundry/data-plane/Foundry/src/voice-agents), commit `959894f28ce0c52303f730962b4777c25ed65ecf`
- TypeSpec: [Unified Voice Agents API and v1 data plane](https://github.com/Azure/azure-rest-api-specs/pull/45357)
- PM One Pager: [Voice Agent product doc](https://onedrive.cloud.microsoft/:w:/a@dm6bb6lu/S/cQrservdSNt9QIj2sWNEFjfMEgUC4y5ZSTx9oJbN4y5ZPdoWuw) (Dong, Qinying)
- Tech Spec: [Voice Agent - Detailed Design](https://msdata.visualstudio.com/Vienna/_git/vienna?path=/src/azureml-api/src/Agents/docs/voice-agent/prompt-voice-agent-design.md);
  [Agentic creation design](https://msdata.visualstudio.com/Vienna/_git/vienna?path=/src/azureml-api/src/Agents/docs/voice-agent/voice-agent-agentic-creation-design.md&version=GBmaster)
  (internal, Agents service repo)
- TypeSpec owners: Yulin Li(yulili), Zheng Niu(zhn)
- Service Owners: Foundry Voice Agents service team
- SDK Owners: Kun Cong, Xiting Zhang
- Target Release: Public Preview - August 30, 2026

## What are the business goals for this feature?

Make **voice a first-class Foundry agent experience alongside prompt and hosted agents**, rather than a
configuration layered on top of a prompt agent. The customer journey presents three peer, top-level choices:
**prompt, hosted, or voice**. This keeps each experience independent and lets voice evolve for its distinct
customers, runtime constraints, and product requirements.

The product boundary is reflected consistently:

1. **Product and portal:** prompt, hosted, and voice agents can appear together in the same Foundry project and
   share common project assets and operational experiences.
2. **REST API:** prompt, hosted, and voice agents use the standard `/agents` resource family. Voice remains a
   distinct definition kind (`kind = "voice"`), not a separate CRUD namespace.
3. **SDK:** voice management, realtime WebSocket sessions, and stored conversations are exposed through the
   existing unified Foundry Agents SDK surface (`AIProjectClient.agents`).
4. **Shared platform services:** common specification sources, service infrastructure, connections, toolboxes,
   tracing, and supported evaluation experiences are reused across agent kinds.

A developer describes the agent once — model, prompt, audio stack, tools, optional avatar, and storage policy —
and Foundry stands up a managed, low-latency **speech-to-speech** experience: it terminates the client audio
connection, bridges to the managed **Voice Live** backend, drives model inference, routes tool calls, optionally
persists the conversation, and emits unified Foundry traces. The developer never has to assemble an
STT→LLM→TTS pipeline, manage realtime WebSocket plumbing, wire tool auth, or adopt a vendor-specific tracing
portal.

This spec covers a complete voice-agent workflow: **create** (declarative create/version + guided
authoring), **call** (the managed live voice session), **conversation** (opt-in persistence with read-only
retrieval of transcripts/audio), and **tracing** (session-scoped, customer-owned). **WebRTC** and **telephony
(SIP)** channels, first-class **evaluation & optimization**, and **versioned experimentation** (A/B and staged
rollout across immutable versions) are out of scope and will be specified separately.

Public Preview deliberately keeps this surface lean. It supports the core Voice Agent lifecycle, native
function and MCP tools, toolbox-backed Foundry tools, and the `end_conversation` voice control. It does **not**
support Skills or inline Foundry server-side tools. Toolboxes that reference Skills remain usable, but Voice
Agents ignore those Skill references and use only the toolbox's directly declared tools. Direct Foundry tools,
Skills, and telephony controls such as transfer and DTMF are post-Public Preview convergence work.

We know we're successful when a developer can **build, run, and observe** a voice agent on Foundry:

1. **Create quickly, ready to use** — go from zero to a deployed, callable voice agent in **under five minutes**
   (via guided authoring or a template), with no async provisioning: the agent is immediately reachable at its
   own voice endpoint.
2. **Smooth, low-latency conversation** — hold a natural, real-time conversation that meets the conversational
   bar: **sub-1s P50 end-to-end response latency** and a low, observable **time-to-first-audio (TTFA)** on
   defined benchmarks, with natural turn-taking and barge-in, at parity with leading voice-first stacks.
3. **See what happened** — for calls that opt into storage (`store = true`), retrieve the conversation,
   Voice Live responses (status, usage, and output items), complete item history, per-item audio, and merged
   recording. For every call, inspect a **session-scoped trace** (one trace per voice session, with per-turn
   child spans carrying TTFA, per-stage latency waterfall, and token usage) in the developer's **own**
   Application Insights / monitoring — no vendor portal.
4. **Be ready to evaluate and optimize** — stored calls provide transcripts and recordings, while every call
   emits a session trace, so a future eval-and-optimize workflow has the substrate it needs. First-class
   evaluation & optimization remains out of scope for this spec.

The headline adoption metric: **90%+ of created voice agents reach their first successful live
session** (connect → speak → receive an audio response) within the same development session — a
create-to-first-success funnel, not a per-session runtime error rate.

## Problem Statement

### How do developers solve this problem today?

Before this feature, a developer who wants a voice agent on Azure has no first-class, declarative option. They must either
hand-assemble a cascaded pipeline (Speech-to-Text → a chat model → Text-to-Speech) or integrate directly with
a realtime/Voice Live WebSocket and own all of the orchestration themselves:

1. **Stand up and manage a realtime WebSocket** to the speech backend, including audio framing, turn
   detection, and barge-in handling.
2. **Hold and refresh model authorization** for the speech-to-speech model out of band.
3. **Implement tool-calling plumbing** — intercept function calls off the audio stream, execute them, and
   feed results back into the turn — with no shared notion of Foundry tools, toolboxes, or connections.
4. **Persist transcripts and audio themselves**, including offloading large audio out of any primary store.
5. **Build their own observability** or accept a vendor's portal — competitor voice stacks (OpenAI, ElevenLabs)
   surface traces only in *their* portals, not the customer's own Application Insights / monitoring backend.

```python
# Without Voice-First Agents, the developer owns the realtime pipeline, tool loop, storage, and tracing.
import os, asyncio, websockets, json
from azure.identity import DefaultAzureCredential

credential = DefaultAzureCredential()
token = credential.get_token("https://cognitiveservices.azure.com/.default").token

async def run():
    # 1. Manually open a realtime WS to the speech backend and configure the session
    async with websockets.connect(
        os.environ["VOICE_LIVE_WS_URL"],
        additional_headers={"Authorization": f"Bearer {token}"},
    ) as ws:
        await ws.send(json.dumps({
            "type": "session.update",
            "session": {
                "instructions": "You are a friendly voice assistant.",
                "audio": {"input": {"format": {"type": "audio/pcm", "rate": 24000}}},
                # 2. developer also has to inject model auth, voice, turn detection, tools...
            },
        }))
        # 3. developer hand-rolls: stream mic audio in, read events out, detect function_call,
        #    execute the tool, send function_call_output, resume the turn, handle barge-in...
        # 4. developer separately writes transcripts + audio to their own storage
        # 5. developer separately builds tracing, or uses the vendor portal
        async for raw in ws:
            event = json.loads(raw)
            ...  # hundreds of lines of orchestration the developer must own

asyncio.run(run())
```

This is a large amount of undifferentiated plumbing, and it does not compose with the Foundry agent model the
developer already uses for prompt and hosted agents (versioning, tools/toolboxes, connections, conversations,
and tracing).
Meanwhile voice-first competitors — ElevenLabs's no-code, template-driven agents and OpenAI's Realtime API —
let developers stand up a voice agent in minutes, so the bar is a declarative, first-class voice agent rather
than a hand-built pipeline. Foundry's differentiation is to meet that bar on **any** model (BYOM), with
first-class Foundry tools/toolboxes and connections, and with **customer-owned** observability instead of a
vendor portal.

### Why does this problem require adding a new service API?

A voice agent cannot be solved purely client-side. The service must:

1. **Orchestrate the live session** — terminate the client audio WebSocket, open an upstream connection to
   Voice Live, and bidirectionally bridge audio + control frames, inspecting frames to route tool calls and
   drive `session.update`.
2. **Own model authorization** — resolve the agent's model (a Voice Live-hosted **`managed`** model or a
   customer **`self_deployed`** BYOM deployment), hand the resolved model + authorization to Voice Live, and
   refresh it mid-session, without the customer ever connecting to Voice Live directly.
3. **Resolve and route tools** — native functions back to the client; MCP / system / toolbox tools executed by
   Voice Live with the agent resolving auth via Foundry connections.
4. **Apply the storage policy** — when `store = true`, auto-create the conversation, write transcripts + tool
   events, and offload audio to blob storage, all server-side; when `store = false` (the default), persist
   nothing.
5. **Emit unified, customer-owned tracing** — one shared **`invoke_agent` root span** per voice session, with
   `voice.turn` and `execute_tool` descendants, delivered through the same customer-owned tracing pipeline
   (OTLP → the customer's own Application Insights / A365) every Foundry agent uses, not a vendor portal.
6. **Hold the conversational latency bar** — inserting an orchestrator between the client and Voice Live adds a
   hop, so the service must be engineered to add minimal overhead rather than naively proxy: stream audio
   events without buffering whole turns, keep tool-routing and `session.update` handling off the audio
   critical path, and co-locate the bridge with the Voice Live backend. The goal is end-to-end response
   latency at the conversational bar — **sub-1s P50 on defined benchmarks** and a low **time-to-first-audio
   (TTFA)**, at parity with leading voice-first stacks — and because the same orchestrator sees every stage it
   measures per-stage latency (STT/LLM/TTS, Voice Live + transport overhead) and surfaces it on the customer
   trace (Requirement #13). A purely client-side design cannot make or observe these optimizations.

Adding `kind = "voice"` to the standard Agents resource and SDK gives developers a coherent voice-specific
experience while preserving one Foundry agent lifecycle, client, identity namespace, and operational model.

## OpenAI Surface Strategy Decision

This feature spans three customer-facing areas: **agent-definition CRUD**, the **live voice session**, and a
voice-specific, read-only hierarchy for **stored conversations, responses, and items**.

**Decision:** use the unified Foundry-native Agents surface. Voice-agent management uses `/agents/**` with
`definition.kind = "voice"` and the existing `AIProjectClient.agents` SDK surface. The live session uses the
dedicated `voice` protocol under the same agent endpoint routing family,
`/agents/{agent_name}/endpoint/protocols/voice`, with the Voice Agent v1 contract backed by Voice Live v1.
Stored conversations are children of that protocol endpoint:
`/agents/{agent_name}/endpoint/protocols/voice/conversations/...`. They do **not** reuse OpenAI Responses API
resources, whose lifecycle and item model are different.

This route-level decision is orthogonal to how the underlying *models* are authored. At the model level the
implementation reuses the canonical `@azure-tools/openai-typespec` **Realtime** definitions (not Responses API
definitions) wherever the persisted wire shape is wire-compatible — it does not fork equivalent OpenAI Realtime
schemas locally — and extends those upstream leaf models only to add Foundry persistence fields such as
`created_at` and `response_id`. Foundry defines its own models only where a concept is genuinely new (the
`VoiceConversation` envelope, item-audio metadata/routes) or the persisted shape cannot reuse the upstream model
as-is (`VoiceResponse` reprojects persisted output items and keeps a flat `voice` string while adding optional
`voice_type` / `voice_locale`, and the local `VoiceConversationItem` union — see
[Persisted conversation data model](#persisted-conversation-data-model) for the full reuse-vs-local breakdown).

The rationale across each dimension the surface decision must cover:

| Dimension | Decision & rationale |
|---|---|
| Selected option | Use `/agents/**` for prompt, hosted, and voice management; use `/agents/{agent_name}/endpoint/protocols/voice` and its child `/conversations` hierarchy for voice runtime and stored calls. |
| Customer-facing "when to use what" guidance | Choose prompt, hosted, or voice at the top level, then use one Agents SDK and resource lifecycle. Voice agents are distinguished by `kind = "voice"`. Customers never call Voice Live directly. A server-side OpenAI-targeted application may connect its OpenAI SDK directly to the agent-bound Foundry endpoint; browser/mobile clients use a customer middle tier because they cannot safely hold the Foundry credential. |
| Feature overlap assessment | Agent identity, CRUD, versions, connections, and SDK ergonomics are shared. Voice adds a distinct definition, realtime protocol, audio configuration, and stored-call model. OpenAI Responses API resources are not compatible substitutes for persisted voice calls. |
| Portability requirement | Persisted response/item discriminators, status values, content-part types, output relationships, and usage fields align with Voice Agent v1 and its Voice Live v1 foundations, so developers see the same concepts live and after the session. Foundry adds durable timestamps/paging and binary-audio child routes; latency telemetry stays in tracing. |
| Compatibility contract | Canonical OpenAI Realtime session, audio-buffer, conversation-item, response, function, and MCP events remain valid; Foundry extensions are additive and portable clients ignore unknown event types. `response.create.response.audio.output` keeps the compatible flat output shape. The service applies mutable overrides such as `voice`, `voice_locale`, and `format`, but rejects a changed `voice_type`. The live `response.created.response` and `response.done.response` payloads expose the resolved `voice`, `voice_type`, `voice_locale`, and `format` fields and retain `conversation_id`. A completed `response.done.response` round-trips as persisted `VoiceResponse` with durable timestamps added; items from `conversation.item.created/retrieved` and `response.output_item.*` round-trip as `VoiceConversationItem`. Persisted audio is represented by metadata in JSON and retrieved through dedicated WAV endpoints. Scenario 1, Part B validates the live flow through the helper's OpenAI Realtime connection. |
| Voice Live extension shape | Foundry adds durable conversation identity, timestamps, response/item pagination, retention/delete semantics, and audio routes without changing Voice Live discriminator values or embedding OpenAI Responses API types. Latency and interruption telemetry remain on the trace surface. |
| Branding/provider considerations | The model is BYOM-capable and not OpenAI-only. The provider-neutral Foundry Agents SDK avoids forcing an OpenAI-branded management client. |
| Concrete customer impact example | Before: a developer hand-builds a realtime WebSocket, tool loop, storage, and tracing. After: `AIProjectClient.agents` creates and manages a `VoiceAgentDefinition`; the application uses either the unified client or an OpenAI-compatible middle-tier route for the live session; and `AIProjectClient.agents` retrieves stored calls (Scenarios 1-3). |
| Alternatives considered | (a) Put everything under `/openai/realtime` - rejected because it has no Foundry agent definition/versioning/tools/identity lifecycle. (b) Use a dedicated `/voice_agents` resource and SDK - rejected because it duplicates the Agents lifecycle and fragments customer code. (c) Reuse OpenAI Responses/Conversations resources - rejected because Voice Live responses/items and persisted audio have different semantics. |

### Simplification roadmap alignment

This spec supports roadmap workstream **#6, Voice Live Integration** and the SDK convergence north star by
replacing unstructured voice metadata with typed Foundry models while preserving **one client, one Agents
resource family, and one project identity model**. Voice Live v1 remains the specialized runtime behind the
standard Foundry Agents surface.

## Voice Agent Experience Model

### Customer choice model

The customer-facing choice order is:

1. **Prompt agent:** declarative, instruction-driven agent behavior.
2. **Hosted agent:** customer-authored code or container hosted as an agent.
3. **Voice agent:** realtime speech interaction with voice-specific runtime semantics.

These are peer product and UX choices, not a modality/implementation hierarchy. This spec defines the voice
experience with `VoiceAgentDefinition` and `kind = "voice"`.

### Why voice is a top-level agent type

Voice is not a prompt agent with speech added on top. It has unique runtime requirements:

1. **Real-time communication protocol (WebRTC/WebSocket) instead of request/response interaction.** This spec
   delivers the service-terminated WebSocket protocol; WebRTC is a follow-up channel.
2. **Latency-sensitive orchestration, where every 100 ms impacts the user experience.** The runtime is
   optimized around sub-1s P50 response latency and low time-to-first-audio (TTFA).
3. **Turn-taking and interruption (barge-in) handling.** The runtime must detect speech boundaries, stop or
   truncate output when the user interrupts, and resume without losing conversation state.
4. **Response-length optimization, since long answers work in text but feel unnatural in conversation.**
   Voice instructions and generation defaults therefore favor concise, conversational responses.
5. **Streaming input and output, where users speak and hear responses continuously.** The service processes
   input audio and emits audio, transcripts, and control events incrementally rather than buffering a complete
   turn.

These differences make voice a top-level **agent type** rather than another prompt-agent channel. Its
definition and runtime are voice-specific, while identity, CRUD, versions, and SDK access stay unified with
the broader Agents platform.

### Shared capabilities and deliberate differences

- **Unified public management surface.** Prompt, hosted, and voice use `/agents` and
  `AIProjectClient.agents`; `definition.kind` selects the agent type.
- **Shared platform capabilities.** All agent kinds reuse Foundry projects, connections, Toolbox APIs, common
  resource/version envelopes, supported evaluation inputs, and the customer-owned tracing pipeline.
- **Tools at capability parity via the shared toolbox.** Native function and MCP tools are direct; Foundry
  server-side tools reach a voice agent through the shared toolbox, off the audio path.

### Prompt and voice capability matrix

| Capability | Prompt agent | Voice agent | Relationship |
|---|---|---|---|
| Product discovery | Prompt experience in the Foundry project | Voice experience in the same Foundry project | **Shared portal, separate product choices** |
| Management API | `/agents/**` | `/agents/**`, `kind = voice` | **Unified** |
| Python SDK | `AIProjectClient.agents` | `AIProjectClient.agents`, including `get_voice_connection(...)` for live sessions | **Unified** |
| Agent CRUD + immutable versioning | Yes | Yes, using the standard routes with `VoiceAgentDefinition` | **Shared lifecycle** |
| Guided authoring / generate | `POST /agents:generate` with kind-specific inputs | `POST /agents:generate`, `kind = voice` | **Unified action** |
| Foundry connections | Yes | Yes — same | **Shared** |
| Toolbox APIs | Yes | Yes — same | **Shared** |
| Server-side tools (`web_search`, `azure_ai_search`, `file_search`, `openapi`, …) | Declared directly | Via **toolbox** MCP (off audio path) for Public Preview | **Capability parity; direct-shape convergence deferred** |
| Skills | Supported through the shared Skills model | Not supported for Public Preview; Skill references on an attached toolbox are ignored | **Post-Public Preview gap** |
| Native function tools | Yes | Yes (client-executed) | **Shared** |
| MCP tools | `OpenAI.MCPTool` | Same `OpenAI.MCPTool` definition | **Shared definition** |
| System tools (Voice Live controls) | No — not a prompt-agent concept | `end_conversation` for Public Preview; transfer/DTMF deferred with telephony | **Voice-only** |
| Conversation store | Read/write | Read-only Voice Live responses/items (service is sole writer); conversation delete supported | Shared storage, voice-specific schema |
| Customer-owned tracing (OTLP → App Insights) | Per-invoke trace | Session-scoped trace + per-turn spans + TTFA | **Shared pipeline** (voice adds spans) |
| Structured inputs | Yes | Yes — rendered per session | **Shared** |
| Invocation | Responses API (`/responses`) — shared Agent Service surface | Realtime **voice** WebSocket only | **Voice-only** (no text fallback) |
| Output modality | Text | Audio (+ transcript, visemes, avatar) | Voice-only additions |
| Image **input** (multi-modal) | Yes | Yes | **Shared** |
| Image **generation** | Via tools | Not supported | Text/tool surface only |
| Avatar / video output | No | Yes | Voice-only |
| Audio persistence / merged recording | No | Yes (single `store` flag, default off) | Voice-only |
| Conversation delete & data retention | Text conversation contract | Voice-specific persisted hierarchy; delete cascades to audio | **Shared policy, separate schemas** |
| Managed / harness / long-running back-end | Supported by the managed-agent model | Voice-as-front-end integration is outside this contract | **Separate integration** |
| Evaluation & optimization | Text evaluation | Text-based evaluation can consume voice transcripts/traces; audio/E2E evals are a separate workstream | **Partly shared** |
| Versioned experimentation (A/B / staged rollout) | Built on shared immutable versions | Out of scope | Separate specification |
| CLI (azd) | Text workflow | Voice workflow + realtime smoke test | Separate workflows in one CLI |

### Tools and toolbox integration

The voice definition accepts four tool kinds routed by the live session: native `function`
(client-executed), `mcp`, `system` (Voice Live controls such as `end_conversation`), and `toolbox`. The `mcp`
variant is the same `OpenAI.MCPTool` used in `PromptAgentDefinition.tools`, including its project-connection
reference and approval configuration.

Service-executed MCP and toolbox tools expose the same optional top-level **`response_scheduling`** property.
It is not nested inside the MCP or toolbox configuration. Native functions and system tools do not expose
this property: the client explicitly resumes a function call, while a system tool's response behavior is
intrinsic to that control. The values for MCP and toolbox tools are:

- `none` (default): do not add service-controlled response scheduling; preserve the existing Voice Live and
  OpenAI Realtime behavior.
- `when_idle`: create the follow-up when no response is active.
- `interrupt`: interrupt the active response and create the follow-up.
- `skip_if_busy`: create the follow-up only when no response is active; otherwise skip it.

Putting `response_scheduling` on the shared schedulable-tool contract lets voice agents reuse the existing
`MCPTool` and `ToolboxTool` models without voice-specific subclasses or scheduling-only wrappers. The wire
property name does not change, so existing MCP callers remain compatible.

MCP execution does not keep the response that requested the tool open. After end-of-utterance detection (or an
explicit client commit), **R1** emits the MCP call arguments and then completes. Voice Live executes the tool;
when the tool output is available, `response_scheduling` determines whether a separate **R2** is created for
the assistant audio. `interim_response`, when configured for the `tool` trigger, may produce separate interim
speech while the tool is running; it does not move the tool result back into R1 or replace the R2 scheduling
decision.

Prompt-agent server-side tools such as `web_search`, `azure_ai_search`, `file_search`, and `openapi` are
packaged in a versioned **toolbox** for Voice Agents in Public Preview. Voice Live calls the toolbox MCP
endpoint off the audio critical path. This keeps the Public Preview live-session routing contract small and
lets the same toolbox be reused across prompt and voice agents.

**Skills behavior for Public Preview is deterministic:** when an attached toolbox version contains
`skills` references, Voice Agents ignore the references. The session still starts, and tools declared directly
on that toolbox version remain available; Skill instructions, content, and Skill-derived tools are not loaded
into the voice session. This avoids making a toolbox unusable merely because another agent type uses its Skills,
without implying that Voice Agents support Skills.

Voice-specific runtime controls use the `system` tool kind rather than creating variants of shared MCP or
function tools. Public Preview includes `end_conversation`. Telephony/audio controls such as call transfer and
DTMF handling are deferred with the telephony surface. `response_scheduling` is a property of service-executed
MCP and toolbox tools, not a separate tool kind.

The API and portal expose this model at different levels:

- **Service (API):** the toolbox stays an explicit, first-class resource; the data-plane contract does **not**
  hide it. Keeping the toolbox visible is what enables reuse, versioning, and clear connection dependencies, and
  it lets a toolbox authored once be shared across prompt and voice agents.
- **UX (portal):** the portal, as a client of that API, is where complexity is simplified for point-and-click
  developers — it packages the selected server-side tools into a toolbox on their behalf, so they never have to
  understand or hand-author the intermediate resource. This is a UX affordance layered on top of the explicit
  API, not a change to the service.
- **Code-first:** developers call the explicit toolbox API directly and benefit from reuse, versioning, and
  dependency tracking.

**Post-Public Preview convergence roadmap:** add Voice Agent support for versioned Skills using the same shared
Skill model as prompt and managed agents, and evaluate direct declaration of Foundry server-side tools based on
Public Preview customer feedback. These additions must not introduce voice-specific copies of shared tool or
Skill types. Until the follow-on contracts ship, toolbox is the supported Foundry-tool path and Skills remain
ignored as defined above.

### Migration: moving from prompt to voice

A prompt agent cannot be flipped to `voice` in place. An AI-assisted migration flow:

1. Reads the existing prompt-agent definition as migration input.
2. Reuses its connections and packages applicable server-side tools into a shared **toolbox**.
3. Rewrites the instructions for spoken conversation and generates the voice-specific settings.
4. Creates a new `/agents` resource with `kind = "voice"` while leaving the source prompt agent unchanged.

The result is **create-alongside, reusing shared assets**: both agents run as distinct identities, and the
developer can compare or roll back without reconstructing the prompt agent. Developers can perform the same
steps explicitly with guided authoring (Scenario 2) and the voice-agent/toolbox APIs.

Creating the voice agent does **not** create a new agent-scoped managed identity by default. Voice-agent service
execution uses the Foundry project's managed identity, and tools normally reuse project connections, so
create-alongside does not require duplicating the project's external role assignments. Migration must still
inventory tool connections: a connection that explicitly selects an assigned managed identity or another
external credential keeps that identity and its existing permissions.

## Requirements

After we deliver voice agents, users will be able to:

**Management (agent definition and lifecycle)**
1. Manage prompt, hosted, and voice agents through the unified Foundry Agents SDK
   (`AIProjectClient.agents`) and `/agents/**` REST surface.
2. Create, update (new immutable version when the definition changes), get, list, enable, disable, and delete a
   `voice` agent through the standard Agents lifecycle. `GET /agents?kind=voice` filters the shared collection.
3. Declare the agent's **model** with two fields (required, user-selected up front): **`model_type`** —
   `managed` (Voice Live-hosted, e.g. `gpt-realtime`) or `self_deployed` (**BYOM** — the customer's own
   Foundry deployment) — and **`model`** (the Voice Live-hosted model name, or the BYOM deployment name).
   Plus the **prompt** (templated with structured inputs), **audio stack** (`audio.input` / `audio.output`
   format, voice, turn detection, noise reduction, transcription, and `output_modalities`), **tools**, an
   optional **avatar**, and **`store`** (conversation-logging switch, default `false`; see Requirement #12).
4. Run the agent in either **realtime** (native speech-to-speech) or **cascaded** (STT→LLM→TTS) mode —
   Foundry **derives** which one from the selected model, so there is **no `architecture` field to set**.
5. Use **guided authoring** through `POST /agents:generate` with `kind = "voice"`; only `name` and `use_case`
   are additionally required. `goal`, `model_type`, `model`,
   `description`, `tools`, and `draft` are optional; `model_type` defaults to `managed`, `model` defaults to
   `gpt-realtime` for managed agents, and a model is required for `self_deployed`. Foundry expands the selected
   scenario into editable instructions, a template greeting with structured inputs, and a tuned audio
   configuration. It passes business tools through, adds `end_conversation`, and fixes
   `output_modalities = ["audio"]` (audio plus its transcript). `draft = true` creates an unpublished candidate
   for review before standard publication.
6. For Public Preview, declare tools from the voice agent's **four — and only four — tool kinds**:
   **native function** tools
   (executed by the **client** at session time), **MCP** tools, **system** tools (Voice Live built-in control,
   e.g. end/close the conversation), and **toolbox** tools (the latter three executed by **Voice Live**; the
   agent resolves auth via Foundry connections). **This is a deliberate difference from prompt agents:** a
   voice agent does **not** declare server-side tools directly — there is no `web_search`, `azure_ai_search`,
   `file_search`, `openapi`, `browser_automation`, `fabric_iq`, etc. in its `tools`. Those are packaged in a
   Foundry **toolbox** and run by Voice Live through the toolbox MCP endpoint (see the Toolbox tool
   terminology and Scenario 2). Set follow-up response behavior with the common top-level
   `response_scheduling` property on MCP and toolbox tools; `none` is the compatibility-preserving default,
   and native function and system tools do not accept the property. When an attached toolbox contains Skill
   references, ignore those references and load only its directly declared tools. Skills, inline Foundry tools,
   and telephony controls beyond `end_conversation` are deferred until after Public Preview.

**Portal and shared project experience**
7. Discover and manage prompt, hosted, and voice agents in the same Foundry project UI and unified Agents SDK,
   while presenting the agent kinds as distinct top-level product choices.

**Data plane (live voice session)**
8. Connect a server-side application directly, or a browser/mobile application through a **customer-hosted
   middle tier**, to a voice agent over a realtime audio WebSocket at a stable per-agent endpoint. The direct
   server-side client or middle tier holds the Foundry credential. A middle tier forwards Voice Agent v1 JSON
   text frames bidirectionally without buffering whole turns; audio is base64-encoded in the JSON events, and
   the browser/mobile application never receives the credential. Sessions are subject to a maximum duration
   (default 30 minutes), after which the service sends a WebSocket Close (1001) with a reason.
   The async Python SDK exposes
   `project_client.agents.get_voice_connection(agent_name=...)`, which returns an OpenAI Realtime-compatible
   async connection manager bound to the agent endpoint and hides URL construction, Entra token acquisition /
   refresh, `api-version`, preview headers, and connection query/header mapping.
9. Override only the Voice Live session fields supported by `session.update`, without creating a new agent
   version: instructions, temperature, maximum output tokens, output modalities, animation, audio formats,
   input noise reduction / echo cancellation / turn detection, input-transcription settings other than
   `model`, output voice settings other than `voice_type`, tools, tool choice, parallel tool calls, reasoning,
   interim-response settings, and metadata. The output voice name can change only before the first audio
   response, matching Voice Live. The agent model, avatar, `voice_type`, and input-transcription `model` remain
   fixed from the persisted definition. The wire schema remains compatible with the full Voice Live session
   shape; the service rejects attempts to change those fixed values. Valid overrides are merged onto the
   definition defaults.

**Conversation (retrieve)**
10. Retrieve stored voice conversations through a **read-only hierarchy** (with conversation-level delete):
   list conversations for an agent, get one conversation, list/get its Voice Live responses, list items across
   the conversation or within one response, and get item details. The REST models align with the Voice Agent
   v1 / Voice Live v1 contract — they are **not** OpenAI Responses API resources. Where the persisted shape is
   wire-compatible, item and content models are the canonical `@azure-tools/openai-typespec` Realtime
   definitions extended only with Foundry persistence fields (`created_at`, `response_id`);
   `VoiceConversation` is Foundry-local because there is no upstream durable envelope; `VoiceResponse` is a
   Foundry-local persistence projection that reprojects durable output items and keeps the upstream flat voice
   field while adding provider-neutral voice type/locale and durable linkage/timestamps (see
   [Model reuse rules](#model-reuse-rules)). Response objects preserve status, status details, output-item
   relationships, and token usage; item objects preserve the seven voice-applicable kinds (message, function
   call/output, MCP tool listing/call/approval request/approval response) and their role-appropriate content
   parts (`input_text`; `input_text` / `input_audio` / `input_image`; `output_text` / `output_audio`).
11. Retrieve stored audio separately from JSON: get metadata and stream WAV bytes for one message item; get
   metadata and stream the whole-call merged stereo recording (user-left / agent-right). Binary audio is never
   inlined as base64 and no SAS URL is handed to the client.
12. Govern the entire hierarchy with a **single `store` flag** (definition-level, **default `false`**) that
   mirrors the text prompt agent's `store`. With **`store = true`**, the session persists the conversation,
   Voice Live responses, conversation items, response token usage, and raw per-item audio. With
   **`store = false`**, it persists **nothing** and no conversation is surfaced. `store` is overridable per
   session (either direction, at connect time via `?store=`). Stored data follows a **60-day default retention
   window** aligned with the platform conversation/session TTL and enforced by a blob-lifecycle policy.
   Deleting the conversation cascades to its responses, items, and audio.

**Tracing and evaluation**
13. Get a **session-scoped trace** delivered through the same customer-owned tracing pipeline as every Foundry
   agent kind (OTLP → the **customer's own Application Insights / A365**). A shared **`invoke_agent` root span**
   (`ActivityKind.Server`) covers the whole session. Each response turn emits a **`voice.turn`** child with
   stage descendants (`speech_to_text`, `chat`, `execute_tool`, `text_to_speech`) and carries explicit
   **time-to-first-audio (TTFA)**, the per-stage **latency waterfall** (transport, STT/ASR, LLM, tool, TTS,
   avatar rendering, turn detection), per-turn token usage, and interruption/barge-in attributes.
14. Use supported Foundry text evaluators against persisted voice transcripts and traces. Audio-native,
   conversation-quality, and end-to-end task-success evaluation are tracked outside this spec.

**CLI (azd)**
15. Create/update a voice agent and run a quick voice smoke test from `azd`, and inspect the agent without
   needing ARM or `az` CLI.

> **Voice-only invocation:** A `voice` agent is invoked **exclusively** through its realtime voice
> session (the `voice` endpoint protocol); there is **no text-only invoke fallback** on a voice agent.
> Developers who need a prompt or hosted experience use the corresponding top-level agent type.

> **Multi-modal:** A `voice` agent accepts **image input** alongside audio (a caller/app may supply an
> image for the agent to reason about), and supports **avatar/video output**. It does **not generate images** —
> image generation stays on the appropriate text/tool surfaces. (See the parity matrix above.)

## API Surface

| # | Method | Path | Description |
|---|--------|------|-------------|
| 1 | `POST` | `/agents` | Create an agent whose definition has `kind = "voice"` (201) |
| 2 | `GET` | `/agents?kind=voice` | List voice agents from the shared collection (paged) |
| 3 | `GET` | `/agents/{agent_name}` | Get an agent; the returned definition discriminator identifies voice |
| 4 | `POST` | `/agents/{agent_name}` | Idempotently reconcile a full definition (`Agents.updateAgent`); append an immutable version only when changed |
| 5 | `DELETE` | `/agents/{agent_name}` | Delete the agent and all versions (204) |
| 6 | `POST` | `/agents/{agent_name}:enable` | Enable the agent (idempotent, 204) |
| 7 | `POST` | `/agents/{agent_name}:disable` | Disable the agent (idempotent, 204) |
| 8 | `POST` | `/agents:generate` | Generate and create a complete agent; `kind = "voice"` selects voice authoring |
| 9 | `POST` | `/agents/{agent_name}/versions` | Create the agent + first version atomically when absent; otherwise append a service-assigned immutable version |
| 10 | `GET` | `/agents/{agent_name}/versions` | List versions; `include_drafts` defaults to `false` |
| 11 | `GET` | `/agents/{agent_name}/versions/{agent_version}` | Get one version |
| 12 | `DELETE` | `/agents/{agent_name}/versions/{agent_version}` | Delete one version (204) |
| 13 | `GET` (WS upgrade) | `/agents/{agent_name}/endpoint/protocols/voice` | Open a realtime voice session; successful upgrade returns a bodyless 101 response |
| 14 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations` | List stored conversations for the voice agent (paged) |
| 15 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}` | Get one stored voice conversation |
| 16 | `DELETE` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}` | Delete the conversation and cascade to responses, items, and audio (204) |
| 17 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses` | List persisted Voice Live responses (paged) |
| 18 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses/{response_id}` | Get one persisted response |
| 19 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses/{response_id}/items` | List one response's output items (paged) |
| 20 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items` | List the complete ordered conversation history (paged) |
| 21 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}` | Get one conversation item |
| 22 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio` | Get item-audio metadata; BYOS uses optional `blob_uri` |
| 23 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio/content` | Stream managed-storage item WAV; BYOS returns 409 |
| 24 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio` | Get merged-recording metadata after successful finalization; active or failed finalization returns 409 |
| 25 | `GET` | `/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio/content` | Stream managed-storage merged stereo WAV; BYOS, active, or failed finalization returns 409 |

> Every operation requires the standard `api-version` query parameter; it is omitted from the path column so
> the resource hierarchy remains readable.
>
> **Why row 4 uses POST:** Agent definitions are immutable versions. This operation does not replace an
> existing version (`PUT`) or partially mutate one (`PATCH`); it submits a candidate definition and appends a
> new version only when its content changes. This is the shared Agents versioning
> contract.
>
> **Agents versioning semantics (rows 4 and 9):** Row 4 is the recommended idempotent reconcile operation for
> declarative clients and CI/CD: it is the REST/TypeSpec `Agents.updateAgent` operation used by `azd deploy`,
> not a separate Python convenience method. Unchanged content returns the current latest version. Row 9 is the
> low-level append primitive and always
> creates a new service-assigned version for an existing agent, even when the submitted definition is
> identical. For a new `agent_name`, row 9 atomically creates the agent and its first version; this is the
> operation used by the shipped `AIProjectClient.agents.create_version(...)` convenience method. Agent version
> identifiers are service-generated and immutable; caller-supplied version identifiers and
> `PUT /agents/{agent_name}/versions/{agent_version}` are not part of the Agents contract. Callers persist the
> version returned by either POST when deterministic downstream references are needed.
>
> All routes are **data-plane** (under the Foundry project endpoint — no ARM). Rows 1–12 use the standard Agents
> service family; voice is selected by the `kind` discriminator. Imperative Python uses
> `AIProjectClient.agents.create_version(...)` for row 9, while declarative `azd deploy` uses row 4. Row 13 is
> the voice realtime WebSocket protocol. Rows 14–25 form a
> **voice-specific persisted resource hierarchy**, not an alias of OpenAI Responses or OpenAI Conversations. The service is the sole
> writer: there are no create/update/delete operations for individual responses or items. Conversation-level
> delete is the customer's explicit data-deletion control and cascades through every child resource. All
> persisted routes require `store = true` (else `404`). Binary audio routes stream through the service; JSON
> contains transcripts and audio metadata only, never base64 audio or SAS URLs.
>
> **Pagination:** Every list operation in this table (rows 2, 10, 14, 17, 19, and 20) returns
> `AgentsPagedResult<T>` with `data`, `first_id`, `last_id`, and `has_more`; it does not include an `object`
> field. SDK iterators hide cursor management.
>
> **Session identity:** A caller MAY supply `agent_session_id` to correlate the live connection, but it does not
> replay or reattach a Voice Live session. When storage is enabled, the server-minted `conversation_id`
> (surfaced as optional `session.created.conversation_id`) is the canonical durable handle for post-call
> retrieval. Row 14 lets callers recover
> conversation ids after a client restart and supports audit/history workflows.
>
> **Agent-name namespace:** All agent kinds share one project-scoped name namespace. Creating
> a voice agent with a name already used by another agent kind returns `409`. The protocol route resolves that
> shared identity and requires its definition kind to be `voice`.
>
> **Voice protocol root:** `/agents/{agent_name}/endpoint/protocols/voice` is a first-party Foundry project
> endpoint. Foundry terminates the live-session socket and owns authentication, authorization, quota, tracing,
> guardrails, and the Voice Live bridge. Stored conversations are child resources under the same protocol root;
> Voice Live remains an internal dependency. Management, the voice protocol, and conversation retrieval all
> share the `/agents/{agent_name}` identity. Conversations stay under the protocol because they exist only as
> outputs of that protocol and other endpoint protocols may own different history models. `endpoint` is the
> singleton below the agent identifier; `protocols/voice` is a fixed protocol namespace and selector, not a
> separately managed collection or resource hierarchy.
>
> **Error behavior (selected):** `400` connect-time/create validation (e.g. missing `model` / `model_type`,
> voice/model mismatch); `401` for missing or invalid credentials; `403` when the authenticated identity lacks
> the required project/agent data action; `404` for an unknown agent/conversation/response/item, every
> persisted route when
> `store = false`, or an audio request for an item without stored audio; `409` duplicate project-wide agent
> name, duplicate version, opening a session on a disabled agent, or a merged-recording request while
> conversation finalization is pending or failed. A disabled-agent WebSocket request fails before the `101`
> upgrade with
> `code = agent_disabled`; enable the agent before retrying. Any `/audio/content` route also returns `409` for
> BYOS because the caller must download directly from customer storage. `429` throttling includes
> `Retry-After`; SDKs retry with bounded exponential backoff, and direct callers should wait for that interval
> before reconnecting or repeating a conversation read. The service sends WebSocket Close `1001` on max
> session duration. A tool that can't be
> resolved at connect time is **dropped and surfaced** as a realtime
> `error` event (`code` ∈ `tool_connection_unresolved` / `tool_credential_unresolved` /
> `tool_toolbox_unresolved` / `tool_unsupported`) while the **session stays open** (fail-open). Error responses
> use the shared Foundry error shape. Guided authoring returns `400` for an invalid request or generated
> definition and `503` when the Voice Live authoring service is unavailable or exceeds its outer deadline.
> Authoring `503` is retriable: use capped exponential backoff with jitter. The standard create path is not
> entered until authoring returns a valid definition, so retrying the same name is safe; callers can GET the
> agent by name before retrying if the client lost the final response.
>
> **Merged-recording recovery:** Wait until
> `GET .../conversations/{conversation_id}` reports `status = completed` before requesting merged-recording
> metadata or content. While `status = in_progress`, `409 recording_not_ready` is retriable with exponential
> backoff (honor `Retry-After`). `status = failed` is terminal; merged-recording metadata/content returns
> `409 recording_unavailable`, while any responses, items, or item audio written before failure remain readable.
> A BYOS `409` is also terminal for `/audio/content`; use the metadata resource's `blob_uri` instead.
>
> The unified TypeSpec contract for these routes is tracked in
> [Azure/azure-rest-api-specs#45357](https://github.com/Azure/azure-rest-api-specs/pull/45357); spec promotion
> depends on that PR.

### Persisted conversation data model

The post-call API persists the Voice Agent v1 / Voice Live v1 hierarchy rather than translating it into OpenAI
Responses API resources. At the model level, each resource is one of three kinds: **(a)** reused as-is from the
canonical `@azure-tools/openai-typespec` Realtime definitions, **(b)** an upstream Realtime model extended with
Foundry persistence fields, or **(c)** a Foundry-local definition for a concept that is new or wire-incompatible
with upstream. The origin column below follows the [model reuse rules](#model-reuse-rules).

| Resource | Origin | Shape and behavior |
|---|---|---|
| `VoiceConversation` | **(c) Foundry-local** | Envelope: `id`, `object = "voice.conversation"`, `status` (`in_progress` / `completed` / `failed`), `created_at`, optional terminal `completed_at`, `metadata`, optional `usage?: RealtimeResponseUsage`, and optional `last_error?: ApiError`. `usage` is absent while the conversation is `in_progress` and is populated after successful completion with the final aggregate token usage across all responses. `last_error` is present only for `failed`. The conversation is the retention/delete boundary and parent for responses, items, and recording. There is no equivalent durable, retrievable conversation envelope upstream. |
| `VoiceResponse` | **(c) Foundry-local** | `id`, `object = "realtime.response"`, `status` (`in_progress`, `completed`, `cancelled`, `incomplete`, `failed`), optional `status_details`, `output`, `usage`, `conversation_id`, `audio.output` (flat optional `voice`, `voice_type`, `voice_locale`, and `format` fields), `output_modalities`, `temperature`, and `max_output_tokens`; Foundry adds `created_at` / `completed_at` for durable ordering. The local projection replaces upstream output with persisted `VoiceConversationItem` values and adds extensible provider/type and locale fields to the flat audio-output projection. Response detail returns output inline; the response-items route provides the same output as a paged collection. Conversation items carry `response_id` for cross-resource linkage. |
| `VoiceConversationItem` | **(c) Foundry-local union** | Seven-kind discriminated union for voice conversation history: `message` (roles `user`, `assistant`, `system`), `function_call`, `function_call_output`, `mcp_list_tools`, `mcp_call`, `mcp_approval_request`, and `mcp_approval_response`. Common persisted fields include `id`, `object = "conversation.item"`, applicable `status`, `created_at`, and optional `response_id`. The union itself is Foundry-local because upstream currently splits message items and non-message items across disconnected discriminator roots; each **leaf** kind is **(b)** the corresponding upstream Realtime item model (role-specific system/user/assistant message items, function-call and function-call-output items, and MCP list-tools/call/approval-request/approval-response items) extended only with the Foundry persistence fields above. Server-side search and other toolbox operations flow through the persisted MCP call item rather than separate search/agent item kinds. |
| Message content | **(a) reused** | Upstream Realtime content-part discriminators and their per-role constraints: `input_text` (system/user); `input_text` \| `input_audio` \| `input_image` (user); `output_text` \| `output_audio` (assistant). Persisted audio parts carry transcripts but **not** base64 audio; metadata and bytes come from the item's `/audio` and `/audio/content` resources. |
| `RealtimeResponseUsage` | **(a) reused** | The upstream Realtime response usage model: `total_tokens`, `input_tokens`, `output_tokens`, plus `input_token_details` / `output_token_details` (`cached_tokens`, `text_tokens`, `audio_tokens`, and output `reasoning_tokens`). |
| `VoiceItemAudioResponse` | **(c) Foundry-local** | Item-audio metadata: `conversation_id`, `item_id`, optional stream `role` (`user` / `agent`), `format` (`wav`), `codec` (`pcm16` / `pcmu` / `pcma`), `sample_rate`, `channels`, `start_offset_ms`, and `duration_ms`. `blob_uri` is optional and BYOS-only; it is absent for Foundry-managed storage. |
| `VoiceRecordingResponse` | **(c) Foundry-local** | Common merged-recording metadata (`conversation_id`, `format`, `sample_rate`, `channels`, fixed `channel_layout` with user-left/agent-right, and `duration_ms`) is returned after successful conversation finalization. `blob_uri` is optional and present only for BYOS, without a SAS token. It is absent for Foundry-managed storage. |

`in_progress` covers both an active WebSocket and post-session persistence finalization. `completed` means
finalization succeeded; it includes normal client close, `end_conversation`, the max-duration `1001` close, and
a client/network disconnect when the service can still finalize the stored call. `failed` means a service,
bridge, storage, or unrecoverable transport failure prevented finalization. It is terminal: partial persisted
responses, items, and item audio remain readable, but the merged recording is unavailable.

`GET .../responses/{response_id}` returns response output inline, while
`GET .../responses/{response_id}/items` provides the same output as a paged projection. `GET .../items` is the
complete ordered conversation history, including user input and client-created tool outputs that are not
response output. Each response-owned item carries `response_id`; `GET .../items/{item_id}` is the canonical
item-detail operation.

The content API deliberately excludes performance telemetry. `VoiceResponse.usage` retains the official Voice
Live per-response token accounting, and `VoiceConversation.usage` exposes only its final post-completion
aggregate. TTFT, TTFA, inter-token latency, stage latency, interruption, and barge-in are emitted only through
customer tracing/Application Insights and do not appear on `VoiceConversation`, `VoiceResponse`, or
`VoiceConversationItem`.

### Model reuse rules

Persisted and live-session models follow these rules:

1. **Reuse canonical upstream models wherever the wire shape is compatible.** The `@azure-tools/openai-typespec`
   package's **Realtime** definitions (not Responses API definitions) are the source of truth for any Foundry
   model whose persisted or live shape matches OpenAI Realtime. Foundry does not copy or fork an equivalent
   OpenAI Realtime schema locally just to have a local name for it.
2. **Extend upstream leaf models only to add Foundry persistence fields.** Where a message/tool-call/MCP item
   needs to be durably retrievable, Foundry extends the upstream leaf model with `created_at` (a Unix timestamp
   encoded as `datetime`) and `response_id` — it does not redefine the item's own fields.
3. **Define Foundry-local models only for genuinely new concepts or projections that cannot reuse upstream
   as-is.** This includes:
   the `VoiceConversation` persistence envelope (no upstream equivalent); dedicated persisted audio-metadata
   resources and routes, since audio bytes are never inlined in a persisted conversation item; `VoiceResponse`
   because it reprojects output as persisted `VoiceConversationItem` values and keeps the upstream flat `voice`
   string while adding optional provider-neutral `voice_type` and `voice_locale` fields; and the
   `VoiceConversationItem` union, because upstream currently splits message items and non-message items across
   disconnected discriminator roots rather than one union Foundry can persist and paginate uniformly.
4. **Treat every Foundry-local definition as a compatibility adapter.** Local models exist only for a missing
   upstream concept or an incompatible wire shape.
5. **Foundry-specific persistence fields and semantics are preserved regardless of origin** — `created_at`,
   `completed_at`, `response_id` linkage, aggregate conversation usage, and the separate audio-retrieval APIs
   apply uniformly whether the underlying model is reused, extended, or Foundry-local.

### Guided authoring

**`POST /agents:generate`** turns kind-specific inputs into a complete, editable agent definition and creates
the agent through the standard Agents path. For `kind = "voice"`, it uses the voice scenario catalog and
returns an `AgentObject` whose latest definition is `VoiceAgentDefinition`.

The returned `AgentObject` embeds the shared singleton `versions.latest`; this is the created version, not the
paged result returned by `GET /agents/{agent_name}/versions`.

#### Input contract

| Field | Requirement | Behavior |
|---|---|---|
| `kind` | Required | `voice` selects the Voice Agent authoring pipeline |
| `name` | Required | DNS-valid agent name; passed through unchanged |
| `use_case` | Required | Selects one scenario template |
| `goal` | Optional | Refines language, instructions, greeting values, and audio settings; the scenario template is sufficient when omitted |
| `model_type` | Optional | Defaults to `managed`; may be `self_deployed` |
| `model` | Conditional | Defaults to `gpt-realtime` for `managed`; required for `self_deployed` |
| `description` | Optional | Passed through unchanged |
| `tools` | Optional | Business tools are passed through unchanged |
| `draft` | Optional | Defaults to `false`; `true` creates an unpublished candidate version |

`agent_type` is not part of the contract; persona and industry are implicit in `use_case`.

The scenario catalog is:

- `retail_banking_self_service`
- `insurance_claim_and_policy_servicing`
- `patient_access_and_scheduling`
- `health_plan_member_services`
- `airline_and_travel_servicing`
- `travel_concierge`
- `ai_tutor_and_role_play_coach`
- `recruiting_and_hr_agent`

During migration, callers that still send `agent_type` are accepted but the field is ignored. Agents already
persisted with earlier `use_case` values remain readable; new catalog enforcement requires a versioned
old-to-new mapping.

#### Generated definition

| Field | Source |
|---|---|
| `kind` | Fixed to `voice` |
| `output_modalities` | Fixed to `["audio"]`; audio includes the spoken output and text transcript |
| `model_type`, `model`, `description` | Request values with the defaults above |
| `tools` | All request tools plus the platform `end_conversation` system tool when not already supplied |
| `instructions` | Scenario template, optionally refined by `goal`; always includes identity, scope, and human-handoff guardrails |
| `greeting` | Generated in deterministic `template` mode |
| `structured_inputs` | Derived with the greeting from scenario placeholders and values extracted from `goal` |
| `audio` | Scenario- and language-tuned voice, VAD, transcription, noise reduction, format, and speed |

Every generated field remains editable through the standard update and version endpoints.

#### Authoring pipeline and failure behavior

The Voice Live authoring service owns the scenario assets and runs the pipeline:

1. Resolve a BCP-47 language from `goal`, defaulting to `en-US`.
2. Load the template selected by `use_case`. Each template has Personality, Environment, Tone, Goal, and
   Guardrails sections plus typed placeholder, voice, and default-greeting metadata.
3. Generate greeting/structured inputs, instructions, and audio settings; attach tools deterministically.
4. Validate the assembled `VoiceAgentDefinition` and pass it to the standard create path.

A missing `goal` uses the template's default greeting and marks unresolved template placeholders as required
session-time structured inputs. Voice Live executes its internal authoring routines through the Copilot SDK
against its Azure OpenAI deployment; these routines are implementation details, not customer-facing Foundry
Skills. The Agent Service forwards the normalized request over service-to-service auth and retains the existing
public `POST /agents:generate` route.

A generator-level timeout or malformed result uses that field's scenario default and does not fail the whole
request. Guided authoring is a **synchronous, blocking** operation with a 12-second service deadline. SDKs and
direct HTTP callers should configure a request timeout of at least 15 seconds. If the authoring service is
unreachable or the deadline expires, Foundry returns `503` rather than returning a low-quality static
definition. Invalid caller input or an invalid generated definition returns `400`.

With `draft = false`, the operation publishes the generated version. With `draft = true`, it records an
unpublished candidate excluded from default `latest` resolution; callers publish a refined definition through
the standard version path.

## Data-Plane Voice Session Protocol

The live session uses the customer-facing **Voice Agent v1** WebSocket contract. Foundry
terminates the client socket at `/agents/{agent_name}/endpoint/protocols/voice`, applies the persisted Voice
Agent v1 definition, resolves tools, and bridges the session to the managed **Voice Live v1** backend. The
customer never connects to Voice Live directly.

Server-side applications can connect directly to Foundry with an Entra credential. Browser and mobile
applications use **app -> customer middle tier -> Foundry** because their WebSocket clients cannot safely hold
or set the Foundry authorization credential. The middle tier opens one upstream Foundry WebSocket per app
session and forwards JSON text frames in both directions, preserving frame ordering and the `realtime`
subprotocol without buffering a complete utterance or response. Audio is base64-encoded in
`input_audio_buffer.append` and `response.output_audio.delta` events.

### Voice Agent v1 connection

The direct server-side client or middle tier sends an HTTP GET with `Upgrade: websocket`. A successful upgrade
returns a bodyless `101` response. The connection accepts:

- `api-version=v1`;
- `agent_session_id` query parameter for caller correlation;
- optional `store` boolean query parameter to override the persisted definition's conversation-storage default
  for this session in either direction;
- `x-agent-version-override` query parameter to select a persisted agent version;
- optional `Sec-WebSocket-Protocol: realtime`; and
- optional `x-ms-voice-structured-inputs` containing a JSON object of per-session structured inputs.

After the upgrade, the direction-specific `VoiceAgentClientEvent` and `VoiceAgentServerEvent` unions model the
JSON events. Input and output audio use base64 content in their respective events.

### Voice Agent v1 event contract

Voice Agent v1 composes canonical OpenAI Realtime GA event shapes with Voice Live v1 and Foundry extensions.
The request and response session models are intentionally direction-specific:

- `VoiceAgentSessionUpdateConfig` keeps the compatible Voice Live session shape. The service applies the
  Requirement #9 allowlist and rejects changes to fixed definition fields such as avatar, `voice_type`, and
  input-transcription model.
- `VoiceAgentSessionResponseConfig` composes the common request fields and adds server-authoritative state such
  as session id, selected model, expiration, effective audio, handoff state, and idle timeout.
- Shared typed voice, audio format, noise reduction, transcription, VAD, greeting, common tool response
  scheduling, and output modality models come from the Voice Agent v1 management contract.
- WebSocket-only models are used where the live wire differs: nullable input overrides, echo cancellation, MCP
  runtime authorization, richer end-of-utterance settings, avatar transport, and effective handoff state.

### Contract layering

| Layer | Source | In the voice agent session |
|-------|--------|----------------------------|
| HTTP upgrade | Voice Agent v1 | Stable Foundry route, query/header parameters, optional `realtime` subprotocol, and bodyless 101 response. |
| Baseline JSON events | OpenAI Realtime GA | Session, audio-buffer, conversation-item, response, content-part, tool-call, error, and rate-limit event families. |
| Voice configuration | Voice Live v1 + Voice Agent management | Structured `audio/pcm`, `audio/pcma`, and `audio/pcmu` formats; typed OpenAI/Azure voices; transcription; VAD; noise reduction; echo cancellation; greeting; output timestamps; and modalities. |
| Voice Agent v1 extensions | Voice Agent v1 | Direction-specific session models, structured inputs, MCP runtime authorization, common tool response scheduling, toolbox/system tools, response cost estimates, workflow/web/file-search items, handoff, warning, avatar, animation, audio-timestamp, and video events. |
| Persistence | Voice Agent persistence contract | `VoiceConversation` envelope, durable response/item timestamps and paging, item-audio metadata, merged-recording metadata, and WAV child routes. |

### Authentication & tool resolution

Clients authenticate to the **Foundry project endpoint** with the standard credential used by every other
agent kind (`DefaultAzureCredential` / the project's data-plane RBAC); the customer never holds a Voice Live
credential. Tool auth is resolved **server-side before the session**: **native function** tools are forwarded
to the client; **MCP** tools may use service-resolved project connections and expose the Voice Agent v1 runtime
authorization union (bearer token, assigned managed identity, or `null`); **system** tools are built-ins; and
**toolbox** tools are executed in-service. A declared tool that fails to resolve is dropped and surfaced as a
realtime `error` event (fail-open) while the session continues.

| Group | Representative events (client → / → server) | Notes |
|-------|---------------------------------------------|-------|
| Session | `session.update` → `session.created` / `session.updated` | Direction-specific client-settable and effective session configuration. When persistence is enabled, `session.created` may include the canonical post-call `conversation_id`; callers can recover an omitted id through the list-conversations API. |
| Input audio | `input_audio_buffer.append` / `commit` / `clear` → `input_audio_buffer.committed` / `input_audio_buffer.speech_started` / `input_audio_buffer.speech_stopped` / `input_audio_buffer.timeout_triggered` | Audio bytes are base64-encoded in JSON events using the selected structured audio format. |
| Conversation items | `conversation.item.create` / `retrieve` / `truncate` / `delete` → `conversation.item.created` / `retrieved` / `truncated` / `deleted` | Items form the ordered conversation history and include messages, native function calls/outputs, and MCP listing/call/approval events. |
| Response lifecycle | `response.create` / `response.cancel` → `response.created` / `response.done` | `response.create.response.audio.output` keeps the compatible flat shape; the service applies mutable overrides such as `voice`, `voice_locale`, and `format` and rejects a changed `voice_type`. Both server events expose the resolved flat fields; `response.done` also carries final per-turn token usage. |
| Response output | `response.output_item.added` / `.done`, `response.content_part.added` / `.done` | Associates output items and content parts with `response_id`, `output_index`, and `content_index`. |
| Output streaming | `response.output_text.delta` / `.done`, `response.output_audio.delta` / `.done`, `response.output_audio_transcript.delta` / `.done` | Voice Agent v1 streaming event names. |
| Tool calls | `response.function_call_arguments.delta` / `.done`; MCP `response.mcp_call.*` | Native → forwarded to the client; MCP / system / toolbox executed by Voice Live. |
| Foundry tools | `response.web_search_call.*`, `response.file_search_call.*`, workflow output items | Voice Agent v1 extensions implemented by the orchestrator. |
| Handoff | `session.handoff.started` / `.completed` / `.aborted` | Required lifecycle identifiers and duration/reason fields. |
| Rich media | `response.audio_timestamp.*`, `response.animation_blendshapes.*`, `response.animation_viseme.*`, `response.video.delta`, `session.avatar.connect` / `.connecting` | Voice Live v1 and Voice Agent v1 media extensions. |
| Errors & limits | `error`, `warning`, `rate_limits.updated` | Errors include tool-resolution details; warnings are non-fatal. |

#### MCP turn ordering

End-of-utterance detection has the same response semantics whether it comes from server VAD, smart EOU, or an
explicit `input_audio_buffer.commit`:

| Phase | Ordered events |
|-------|----------------|
| Tool request (R1) | `response.created` → `response.mcp_call_arguments.delta` / `.done` → `response.done` |
| Tool execution | `response.mcp_call.in_progress` → `.completed` or `.failed` |
| Optional interim speech | A separate interim response may be emitted while the tool is pending when the `tool` trigger is configured. |
| Tool-result follow-up (R2) | When `response_scheduling` selects a follow-up: `response.created` → assistant audio/transcript events → `response.done`. |

R1 is complete once it has emitted the MCP call; the MCP output never reopens R1. `none` produces no R2 and
preserves baseline Voice Live / OpenAI Realtime behavior,
while `when_idle`, `interrupt`, and `skip_if_busy` apply their documented rules to creation of R2.

### OpenAI SDK compatibility

Voice Agent v1 preserves canonical OpenAI Realtime client events and baseline server events wherever their
wire shapes match. An OpenAI-targeted application can therefore use the `openai` Python package for session,
audio-buffer, conversation-item, response, function, and MCP event flows. Foundry-specific events and fields
are additive; portable applications ignore event types they do not recognize. This is an optional compatibility
path for live-session clients, not a new management SDK dependency: agent lifecycle and persisted conversation
APIs remain on `AIProjectClient.agents`.

A server-side OpenAI SDK application can connect directly to
`/agents/{agent_name}/endpoint/protocols/voice` with its Foundry credential. The Foundry SDK helper
`project_client.agents.get_voice_connection(...)` is the supported compatibility boundary: it returns an
OpenAI Realtime connection manager whose helpers and event models come from the OpenAI Python SDK, while hiding
the agent-specific URL and authentication adaptation from application code. Scenario 1, Part B validates this
direct flow.

### Intentional public-contract exclusions

Voice Agent v1 does not expose Voice Live internal control exchanges or implementation-only overrides:

- `session.close` and `session.done`;
- `byom_credential.update` and `byom_credential.updated`;
- `x-ms-voice-session-override` and internal identity/version override headers;
- emotion-hypothesis/animation payloads and deprecated image-prompt fields;
- internal VAD detector tuning and legacy transcription model names; or
- `{ "type": "none" }` VAD (clients disable turn detection with `null`).

### References

- [Unified Voice Agents API and v1 data-plane TypeSpec PR #45357](https://github.com/Azure/azure-rest-api-specs/pull/45357)
- OpenAI Python SDK — [Azure Realtime example](https://github.com/openai/openai-python/blob/main/examples/realtime/azure_realtime.py)
- OpenAI Realtime API — [guide](https://developers.openai.com/api/docs/guides/realtime) and
  [client/server event reference](https://developers.openai.com/api/reference/resources/realtime).
- Azure **Voice Live v1** — [API overview](https://learn.microsoft.com/azure/ai-services/speech-service/voice-live)
  [2026-06-01-preview API reference](https://learn.microsoft.com/azure/ai-services/speech-service/voice-live-api-reference-2026-06-01-preview),
  and [how-to](https://learn.microsoft.com/azure/ai-services/speech-service/voice-live-how-to) (session config,
  Azure extensions, avatar, `agent_id` / `project_id`, `api-version`).
- Azure OpenAI **Realtime audio events** reference (Azure deviations) —
  [realtime-audio-reference](https://learn.microsoft.com/azure/ai-foundry/openai/realtime-audio-reference).

## Terminology

- **Voice agent** (`voice`): A first-class Foundry agent modality whose `VoiceAgentDefinition` (model,
  instructions, audio stack, tools, avatar, and storage policy) drives a managed speech-to-speech experience.
  It is managed through the standard `/agents` resource and `AIProjectClient.agents` SDK surface. Every
  definition change produces a new immutable version.
- **Agent name**: A project-scoped identity shared by prompt, hosted, and voice agents. The same name cannot be
  used by two agent kinds in one project.
- **AIProjectClient**: The unified Foundry project client in `azure-ai-projects`. Its `agents` operation group
  manages every agent kind, opens agent-bound Voice Agent v1 WebSocket sessions, and exposes voice
  conversations and audio.
- **Voice connection helper** (`AIProjectClient.agents.get_voice_connection`): Async Python SDK helper that
  returns a lazy OpenAI `AsyncRealtimeConnectionManager` bound to one Voice Agent. Entering it with
  `async with` acquires and refreshes the project Entra credential, opens the agent-bound Voice Agent v1
  WebSocket, and yields the OpenAI `AsyncRealtimeConnection` with canonical session, audio-buffer,
  conversation-item, response, function, and MCP helpers/events. Parameters map the complete public connection
  contract: required `agent_name`; optional `agent_session_id`, `store`, `version_override`,
  `structured_inputs`, `foundry_features`, and `websocket_connection_options`. The helper owns the endpoint URL,
  `api-version`, preview headers, `x-agent-version-override`, and `x-ms-voice-structured-inputs` serialization;
  callers do not construct URLs, acquire tokens, or patch OpenAI SDK internals.
- **Middle tier**: Customer-hosted application backend that holds the Foundry credential, opens the upstream
  Voice Agent v1 WebSocket, and forwards ordered JSON text frames between the app and Foundry without whole-turn
  buffering. Audio is base64-encoded inside those events. Browser/mobile applications use this topology because
  the device does not receive a Foundry credential; trusted server-side applications can connect directly with
  the voice connection helper.
- **Voice Agents preview opt-in** (`AgentDefinitionOptInKeys.VOICE_AGENTS_V1_PREVIEW`): The SDK value that sends
  `Foundry-Features: VoiceAgents=V1Preview` for preview operations. It is required while Voice Agents is in
  preview; omitting it makes the preview routes unavailable and returns `404`. The opt-in is removed when the
  feature reaches GA.
- **Voice Live**: The managed Azure speech-to-speech backend (STT/TTS, turn-taking, realtime model wiring)
  that powers this feature — built and operated by the **same Foundry Voice Agents team** (an internal
  component, not a cross-team dependency). Customers never connect to it directly.
- **Architecture**: How the model serves the turn — `realtime` (native speech-to-speech, low latency) or
  `cascaded` (STT → text LLM → TTS). **Derived server-side from the selected model** — not a user-set
  field (Requirement #4; see Dependencies & Commitment Status).
- **Model (`model_type` + `model`)**: The model is selected by two fields. **`model_type`** is `managed`
  (Voice Live runs the named model on its own infra — e.g. `gpt-realtime`) or `self_deployed` (**BYOM** —
  Voice Live calls the customer's own Foundry deployment). **`model`** is the Voice Live-hosted model name
  (managed) or the customer's deployment name (self_deployed). In both cases Foundry resolves the model and
  hands it (+ authorization, for BYOM) to Voice Live; the customer never connects to Voice Live directly.
  `model_type` is orthogonal to `architecture` (realtime vs cascaded), which Foundry derives **server-side** by
  resolving the model to its **true backend model name** (for BYOM, via the Cognitive Services RP, since a
  deployment name can differ from the model it serves) and checking for a **`realtime` marker** (e.g.
  `gpt-realtime`, `gpt-4o-realtime-preview` → native speech-to-speech; otherwise cascaded). The resolved-name
  marker is authoritative, so **no separate Model-Catalog capability flag is needed** and there is **no
  `architecture` field**.
- **Audio stack**: The `audio` config following the OpenAI Realtime session schema, nested under
  **`audio.input`** (format, `noise_reduction`, `turn_detection`, `transcription`) and **`audio.output`**
  (format, `voice`, `speed`), plus **`output_modalities`**. Voice agents normally use `["audio"]`, which
  carries both spoken output and its text transcript; `["text"]` is text-only. Do not combine both values
  because the audio modality already includes the transcript. The spoken **language/locale** is set via the
  output `voice` (e.g. an Azure voice's `locale`) and the input `transcription` language; Voice Live supports
  140+ locales.
- **Voice conversation** (`VoiceConversation`): The persisted envelope for one stored live session. It owns
  ordered responses/items and the whole-call recording, and is the retention/delete boundary. Its optional
  `usage` is absent while the session is in progress and contains final aggregate token usage after completion.
  `failed` is a terminal finalization failure with optional `last_error`; partial child resources remain
  readable, but merged audio is unavailable. Foundry-local — see
  [Model reuse rules](#model-reuse-rules).
- **Voice response** (`VoiceResponse`): A persisted Voice Live `RealtimeResponse`-shaped object, created at
  `response.created` and finalized at `response.done`; it carries status, output-item relationships, response
  configuration, and token usage. It is distinct from an OpenAI Responses API response. Defined Foundry-locally
  as a persisted projection that uses `VoiceConversationItem` output and whose `audio.output` keeps flat
  `voice`, `voice_type`, and `voice_locale` fields. `response.create` keeps that compatible shape, and the
  service rejects attempts to change the fixed `voice_type`. Its `usage` / `status_details` sub-shapes reuse
  the compatible upstream Realtime models.
- **Voice conversation item** (`VoiceConversationItem`): A Foundry-local discriminated union over persisted
  conversation-history items — user/system/assistant messages, native function calls/outputs, and MCP
  listing/call/approval events — because upstream currently splits message items and non-message items across
  disconnected discriminator roots. Each leaf kind reuses the corresponding `@azure-tools/openai-typespec`
  Realtime item model, extended only with Foundry persistence fields (`created_at`, `response_id`). Toolbox-backed
  server-side tools are represented by their MCP call items. Message content uses the upstream Realtime
  content-part discriminators; stored binary audio is retrieved separately.
- **Conversation logging** (`store`): Definition setting, **default `false`**, mirroring the text prompt agent's
  `store`. A **single** switch for **all** persistence (there is no separate audio-only flag): `store = true`
  logs the conversation, responses, items, response token usage, and raw audio (audio offloaded to Blob);
  `store = false`
  logs **nothing** — no conversation is surfaced and every read returns `404`. Overridable per session in
  either direction via `?store=`.
- **Bring Your Own Storage (BYOS)**: A storage mode in which persisted audio is written to customer-owned
  storage. Metadata returns a `blob_uri` without SAS; the customer downloads with its own credential, and
  Foundry does not proxy bytes through `audio/content`.
- **Avatar**: Optional visual avatar configuration for the voice agent.
- **Merged session recording**: A single whole-call **stereo WAV** export — **user/input audio on the left
  channel, agent/output audio on the right** — aligned on one timeline and **derived** (built once, then
  durably cached) from the per-turn segments **after the session ends**. `GET .../conversations/{id}/audio`
  returns common metadata for every storage mode. With **BYOS**, it also returns an optional `blob_uri`
  pointing to customer storage (no SAS); the customer downloads directly using their storage credentials, and
  `/audio/content` returns `409`. With **Foundry-managed storage**, `blob_uri` is absent and
  `GET .../conversations/{id}/audio/content` streams the WAV through the service. Requests before session end
  return `409` in either mode.
- **Guided authoring**: A unified Agents creation action. With `kind = "voice"`, it requires only an agent
  `name` and scenario `use_case`.
  Voice Live combines the scenario template with an optional `goal` to generate editable instructions,
  greeting/structured inputs, and audio settings through `POST /agents:generate`.
- **Scenario template**: A Voice Live-owned authoring asset with Personality, Environment, Tone, Goal, and
  Guardrails sections plus machine-readable placeholders, recommended/default voices, and a default greeting.
- **Draft agent version**: A recorded but unpublished candidate version (`draft = true`) shared across agent
  kinds. Drafts are excluded from default `latest` resolution, are not auto-promoted, and appear in version
  listings only with `include_drafts = true`. Guided voice generation uses this existing lifecycle.
- **Native function tool**: A tool whose call is forwarded to and executed by the **client**; the client
  returns the result to resume the turn.
- **MCP tool**: The shared `OpenAI.MCPTool` definition used by prompt and voice agents. The voice-agent service
  resolves its project connection and runtime authorization before Voice Live invokes the MCP server.
- **System tool**: A **Voice Live** built-in control tool that acts on the live session itself — e.g.
  `end_conversation` (end / close the call) and other in-session control actions; executed natively by Voice
  Live, with no customer code and no external auth.
- **Toolbox tool**: A reference to a Foundry **toolbox** (a versioned bundle of tools) exposed as an MCP
  endpoint; Voice Live calls it and the Foundry tool server runs the tool, with auth resolved via the
  connector gateway / Foundry connections. **This is how a voice agent uses the server-side tools a prompt
  agent would declare directly** — `web_search`, `azure_ai_search`, `file_search`, `openapi`, `a2a`,
  `browser_automation`, `fabric_iq`, `code_interpreter`, etc. — because a voice agent's own `tools` accepts
  only the four kinds above. Author the toolbox once (`POST /toolboxes/{name}/versions`) and reference it by
  name + version. **Why the difference:** server-side tools must execute inside Voice Live, off the audio
  critical path; packaging them as a toolbox MCP endpoint keeps the voice agent's own `tools` to the four
  kinds the live session routes directly, and lets the same `ToolboxTool` model and toolbox be reused across
  prompt and voice agents.
- **Toolbox Skills behavior (Public Preview)**: If a referenced toolbox version contains `skills`, Voice Agents
  ignore those Skill references and continue with only the toolbox's directly declared tools. No Skill
  instructions, content, or Skill-derived tools are loaded into the live session. Native Voice Agent Skills
  support is post-Public Preview work.
- **Tool response scheduling** (`response_scheduling`): A common top-level property on service-executed MCP
  and toolbox tools. Values are `none` (default), `when_idle`, `interrupt`, and `skip_if_busy`. `none` preserves
  baseline Voice Live / OpenAI Realtime behavior by creating no service-scheduled follow-up response.
  `VoiceSystemTool` has no scheduling property, and native function continuation is controlled by the client.
- **Time-to-first-audio (TTFA)**: The user-perceived latency from end-of-speech to the first audio byte of
  the agent's response — surfaced on the per-turn trace span.
- **Structured inputs**: Named, typed slots referenced in `instructions` (e.g. `{{agent_persona}}`) that the
  service renders **per session** before `session.update`, so one definition can serve different per-call
  prompts without new versions.
- **Default voice instructions**: When the developer does not supply `instructions`, Foundry applies a
  recommended default tuned for spoken conversation — a concise, low-latency persona (short one-to-two-sentence
  replies, no markdown/formatting read aloud, graceful handling of interruptions/barge-in, and an explicit
  hand-off-to-a-human path). Guided authoring (Scenario 2) generates instructions in this same style, and the
  default is fully editable via versioning.
- **Guided-authoring `use_case` values**: `retail_banking_self_service`,
  `insurance_claim_and_policy_servicing`, `patient_access_and_scheduling`,
  `health_plan_member_services`, `airline_and_travel_servicing`, `travel_concierge`,
  `ai_tutor_and_role_play_coach`, and `recruiting_and_hr_agent`.
- **Realtime event names**: Session event-type strings (e.g. `conversation.item.created`,
  `response.output_item.done`, `response.output_audio.delta`) follow the Voice Agent v1 wire contract
  (dot-separated) and are exempt from the Foundry `snake_case` enum-value rule. See
  [Data-Plane Voice Session Protocol](#data-plane-voice-session-protocol).
- **Audio format type strings**: MIME-style values such as `audio/pcm`, `audio/pcma`, and `audio/pcmu` follow
  the Voice Live v1 / OpenAI Realtime wire contract and are exempt from the Foundry `snake_case` enum-value
  rule.
- **`FOUNDRY_PROJECT_ENDPOINT`** (env var): The Foundry project endpoint used by `AIProjectClient`, for
  example `https://<account>.services.ai.azure.com/api/projects/<project>`.
- **`AZURE_VOICE_AGENTS_MODEL`** (env var): The service-managed model name or customer deployment name passed
  as `model`.
- **`AZURE_VOICE_AGENTS_MODEL_TYPE`** (env var): `managed` or `self_deployed`; defaults to `managed` when unset.
- **`CONVERSATION_ID`** (env var): When `store = true`, the conversation id surfaced by the target live contract
  or recovered afterward with `AIProjectClient.agents.voice_conversations.list(...)`, used to retrieve
  transcripts and audio.
- **`AZURE_VOICE_AGENTS_MCP_CONNECTION_ID`** (env var): The Foundry project connection backing the shared
  prompt/voice MCP tool definition.

## Hero Code Samples

### Scenario 1, Part A: Create a voice agent with a Foundry toolbox

A developer defines a voice agent declaratively — a selected model (managed or BYOM), a templated prompt, an
audio stack, a couple of tools, and an optional avatar — and creates it. The agent is immediately "ready" (no
async provisioning) and gets a stable voice endpoint.

> **Prerequisites:** This sample assumes:
> - The `azure-ai-projects` package is installed.
> - `$FOUNDRY_PROJECT_ENDPOINT` is a Foundry project endpoint.
> - `$AZURE_VOICE_AGENTS_MODEL` names a voice-capable managed model or customer deployment.
> - A Foundry toolbox named `contoso-support-kb`, version `2`, exists in the project.

```python
import asyncio
import os
from azure.ai.projects.aio import AIProjectClient
from azure.ai.projects.models import (
    AgentDefinitionOptInKeys,
    ServerVadTurnDetection,
    VoiceAgentDefinition,
    VoiceAudioConfig,
    VoiceAudioFormat,
    VoiceAudioInputConfig,
    VoiceAudioOutputConfig,
    VoiceOutputModality,
    VoiceSystemTool,
    ToolboxTool,
)
from azure.core.exceptions import HttpResponseError
from azure.identity.aio import DefaultAzureCredential

PREVIEW = AgentDefinitionOptInKeys.VOICE_AGENTS_V1_PREVIEW

async def main():
    credential = DefaultAzureCredential()
    async with credential, AIProjectClient(
        endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
        credential=credential,
    ) as project_client:
        try:
            version = await project_client.agents.create_version(
                agent_name="contoso-support-voice",
                description="Concise voice support for Contoso customers.",
                definition=VoiceAgentDefinition(
                    model_type=os.getenv(
                        "AZURE_VOICE_AGENTS_MODEL_TYPE",
                        "managed",
                    ),
                    model=os.getenv(
                        "AZURE_VOICE_AGENTS_MODEL",
                        "gpt-realtime",
                    ),
                    instructions=(
                        "You are a friendly phone support agent. Keep replies concise, "
                        "allow callers to interrupt, and offer a human handoff when needed."
                    ),
                    audio=VoiceAudioConfig(
                        input=VoiceAudioInputConfig(
                            format=VoiceAudioFormat(
                                type="audio/pcm",
                                rate=24000,
                            ),
                            turn_detection=ServerVadTurnDetection(
                                threshold=0.5,
                                prefix_padding_ms=300,
                                silence_duration_ms=700,
                            ),
                        ),
                        output=VoiceAudioOutputConfig(
                            format=VoiceAudioFormat(
                                type="audio/pcm",
                                rate=24000,
                            ),
                            voice=os.getenv(
                                "AZURE_VOICE_AGENTS_VOICE",
                                "en-US-AvaNeural",
                            ),
                            voice_type="azure-standard",
                            voice_locale="en-US",
                        ),
                    ),
                    # Audio includes the text transcript; TEXT is a separate text-only mode.
                    output_modalities=[VoiceOutputModality.AUDIO],
                    tools=[
                        # MCP and toolbox tools share response_scheduling.
                        ToolboxTool(
                            toolbox_name="contoso-support-kb",
                            toolbox_version="2",
                            response_scheduling="when_idle",
                        ),
                        VoiceSystemTool(name="end_conversation"),
                    ],
                    # Persist only selected sessions; Part B opts this call in.
                    store=False,
                ),
                foundry_features=PREVIEW,
            )
        except HttpResponseError as error:
            if error.status_code == 400:
                raise RuntimeError(
                    "The model, voice, and audio settings are incompatible. "
                    "Choose a voice supported by the selected model and retry."
                ) from error
            raise
        print(
            "Created voice agent 'contoso-support-voice' "
            f"v{version.version}"
        )
        print("Continue with Scenario 1, Part B to call the toolbox-backed agent.")

asyncio.run(main())
```

### Scenario 1, Part B: Connect directly with the OpenAI Python SDK

A server-side application asks `AIProjectClient.agents` for an **OpenAI Realtime-compatible connection**
already bound to the agent endpoint, streams a raw PCM recording, and saves the response audio. The helper
reuses the project client's credential and hides endpoint construction, token refresh, API-version / preview
headers, and OpenAI SDK URL adaptation. This scenario isolates the OpenAI-compatible session/audio path; Part A
and the protocol section cover toolbox execution and `response_scheduling`.

> **Prerequisites:** This sample assumes:
> - The `contoso-support-voice` agent from Scenario 1, Part A already exists.
> - `caller-input.pcm` contains mono, signed 16-bit PCM at 24 kHz.
> - The `azure-ai-projects`, `azure-identity`, `aiohttp`, and `openai[realtime]` packages are installed.
> - The server-side identity has data-plane access to the Foundry project.
> - Python 3.10 or later.
>
> The client code uses the OpenAI SDK's canonical Realtime helpers. Foundry extension events remain additive.

```python
import asyncio
import base64
import os
from pathlib import Path

from azure.ai.projects.aio import AIProjectClient
from azure.ai.projects.models import AgentDefinitionOptInKeys
from azure.identity.aio import DefaultAzureCredential

AGENT_NAME = os.getenv("VOICE_AGENT_NAME", "contoso-support-voice")
INPUT_AUDIO = Path("caller-input.pcm")
OUTPUT_AUDIO = Path("agent-response.pcm")
PREVIEW = AgentDefinitionOptInKeys.VOICE_AGENTS_V1_PREVIEW


async def send_recording(connection):
    """Send 100 ms PCM frames with canonical OpenAI Realtime helpers."""
    chunk_size = 4800
    with INPUT_AUDIO.open("rb") as source:
        while frame := source.read(chunk_size):
            await connection.input_audio_buffer.append(
                audio=base64.b64encode(frame).decode("ascii")
            )
            await asyncio.sleep(0.1)
    # Part A configured server VAD. Trailing silence lets it detect EOU and
    # commit automatically; sending commit here could race that auto-commit.
    for _ in range(10):
        await connection.input_audio_buffer.append(
            audio=base64.b64encode(bytes(chunk_size)).decode("ascii")
        )
        await asyncio.sleep(0.1)


async def call_foundry_with_openai_sdk(project_client):
    """Use an OpenAI Realtime connection bound by the Foundry SDK."""
    OUTPUT_AUDIO.write_bytes(b"")
    manager = project_client.agents.get_voice_connection(
        agent_name=AGENT_NAME,
        # Override the persisted store=False setting for this call.
        store=True,
        foundry_features=PREVIEW,
        websocket_connection_options={"max_size": None},
    )

    async with manager as connection:
        print(f"Connected directly to voice agent '{AGENT_NAME}'")
        sender = asyncio.create_task(send_recording(connection))
        conversation_id = None
        received_audio = False
        try:
            async for event in connection:
                if event.type == "session.created":
                    conversation_id = getattr(event, "conversation_id", None)
                elif event.type == "response.output_audio.delta":
                    received_audio = True
                    with OUTPUT_AUDIO.open("ab") as sink:
                        sink.write(base64.b64decode(event.delta))
                elif event.type == "response.output_audio_transcript.done":
                    print(f"Agent: {event.transcript}")
                elif event.type == "error":
                    raise RuntimeError(f"Realtime error: {event.error}")
                elif event.type == "response.done" and received_audio:
                    break
        finally:
            sender.cancel()
            await asyncio.gather(sender, return_exceptions=True)
    if OUTPUT_AUDIO.stat().st_size == 0:
        raise RuntimeError("No response audio was received")
    if conversation_id:
        print(f"Persisted conversation: {conversation_id}")


async def main():
    credential = DefaultAzureCredential()
    async with credential, AIProjectClient(
        endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
        credential=credential,
    ) as project_client:
        await call_foundry_with_openai_sdk(project_client)
    print(f"Saved response audio to {OUTPUT_AUDIO.resolve()}")

asyncio.run(main())
```

Use this direct pattern only in trusted server-side code; browser and mobile applications still require a
middle tier so credentials never reach the device. During preview, callers whose deployment persists the call
but omits `session.created.conversation_id` can recover it afterward with
`AIProjectClient.agents.voice_conversations.list(AGENT_NAME)`.

### Scenario 2: Minimal agentic creation — inspect, refine, and publish

A developer supplies only a name and use case. Foundry selects the scenario template, defaults to the managed
`gpt-realtime` model, and generates a working draft with instructions, greeting, structured inputs, audio
settings, and the `end_conversation` system tool. The developer reviews the generated fields, refines one, and
publishes a release as a new immutable version.

```python
import asyncio
import os

from azure.ai.projects.aio import AIProjectClient
from azure.ai.projects.models import AgentDefinitionOptInKeys
from azure.identity.aio import DefaultAzureCredential

PREVIEW = AgentDefinitionOptInKeys.VOICE_AGENTS_V1_PREVIEW


async def main():
    credential = DefaultAzureCredential()
    async with credential, AIProjectClient(
        endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
        credential=credential,
    ) as project_client:
        draft_agent = await project_client.agents.generate(
            kind="voice",
            name="contoso-airline-voice",
            use_case="airline_and_travel_servicing",
            draft=True,
            foundry_features=PREVIEW,
        )

        # AgentObject embeds the created version as the singleton versions.latest.
        draft_version = draft_agent.versions.latest
        generated = draft_version.definition
        print(f"Greeting: {generated.greeting.text}")
        print(f"Voice: {generated.audio.output.voice}")

        # Generated fields are ordinary definition fields and remain editable.
        generated.instructions += (
            "\nConfirm the booking reference before disclosing itinerary details."
        )
        published = await project_client.agents.create_version(
            agent_name="contoso-airline-voice",
            definition=generated,
            foundry_features=PREVIEW,
        )
        print(
            f"Published 'contoso-airline-voice' v{published.version}; "
            "use the Scenario 1, Part B connection pattern to talk to it."
        )

asyncio.run(main())
```

### Scenario 3: Retrieve the conversation, audio, and trace (observability)

After a call, a developer retrieves the persisted voice conversation, inspects each Voice Live response
(status, usage, output items), walks the complete conversation history, downloads item/whole-call audio, and
views the **session-scoped** trace in their own Application Insights. These are voice-history resources, not
OpenAI Responses API objects. Tracing uses the shared `invoke_agent` root span with `voice.turn` and stage/tool
descendants.

> **Prerequisites:** This sample assumes:
> - A completed voice session from Scenario 1, Part B, with its returned or list-recovered conversation id in
>   `$CONVERSATION_ID`.
> - An Application Insights resource connected to the Foundry project (for the trace). For an existing
>   resource, set its connection string in the active environment with
>   `azd env set APPLICATIONINSIGHTS_CONNECTION_STRING "<connection-string>"`.
> - The agent (or that session) ran with **`store = true`** (explicit opt-in) — required for the per-item audio and
>   merged-recording calls below; otherwise those routes return `404`.
> - For BYOS, the caller has read permission on the customer storage object returned in `blob_uri`.

```python
import asyncio
import os
from pathlib import Path

from azure.ai.projects.aio import AIProjectClient
from azure.ai.projects.models import AgentDefinitionOptInKeys
from azure.core.exceptions import HttpResponseError
from azure.identity.aio import DefaultAzureCredential

PREVIEW = AgentDefinitionOptInKeys.VOICE_AGENTS_V1_PREVIEW


async def write_stream(stream, path: Path):
    data = bytearray()
    async for chunk in stream:
        data.extend(chunk)
    await asyncio.to_thread(path.write_bytes, data)


async def main():
    agent_name = "contoso-support-voice"
    conversation_id = os.environ["CONVERSATION_ID"]
    credential = DefaultAzureCredential()
    async with credential, AIProjectClient(
        endpoint=os.environ["FOUNDRY_PROJECT_ENDPOINT"],
        credential=credential,
    ) as project_client:
        conversations = project_client.agents.voice_conversations
        async for saved in conversations.list(
            agent_name,
            foundry_features=PREVIEW,
        ):
            print(f"Stored conversation: {saved.id} ({saved.status})")

        try:
            conversation = await conversations.get(
                agent_name,
                conversation_id,
                foundry_features=PREVIEW,
            )
        except HttpResponseError as error:
            if error.status_code == 404:
                raise RuntimeError(
                    "Conversation was not persisted. Create the agent or "
                    "session with store=True before retrieving history."
                ) from error
            raise
        print(f"Conversation {conversation.id}: {conversation.status}")

        async for response in conversations.list_responses(
            agent_name,
            conversation_id,
            foundry_features=PREVIEW,
        ):
            total_tokens = response.usage.total_tokens if response.usage else 0
            print(
                f"Response {response.id}: {response.status}; "
                f"tokens={total_tokens}"
            )

        async for item in conversations.list_items(
            agent_name,
            conversation_id,
            foundry_features=PREVIEW,
        ):
            has_audio = False
            if item.type == "message":
                for part in item.content:
                    has_audio = has_audio or part.type in {
                        "input_audio",
                        "output_audio",
                    }
                    text = (
                        getattr(part, "text", None)
                        or getattr(part, "transcript", None)
                    )
                    if text:
                        print(f"[{item.role}] {text}")

            if has_audio:
                item_audio = await conversations.get_item_audio(
                    agent_name,
                    conversation_id,
                    item.id,
                    foundry_features=PREVIEW,
                )
                if item_audio.blob_uri:
                    print(
                        f"Item {item.id} audio is in customer storage: "
                        f"{item_audio.blob_uri}"
                    )
                else:
                    stream = await conversations.download_item_audio(
                        agent_name,
                        conversation_id,
                        item.id,
                        foundry_features=PREVIEW,
                    )
                    output = Path(f"{item.id}.wav")
                    await write_stream(stream, output)
                    print(f"Saved item audio to {output.resolve()}")

        if conversation.status == "in_progress":
            raise RuntimeError(
                "Conversation finalization is still in progress. Retry later."
            )
        if conversation.status == "failed":
            detail = (
                conversation.last_error.message
                if conversation.last_error
                else "No service error detail was returned."
            )
            raise RuntimeError(
                "Conversation finalization failed; merged audio is unavailable. "
                f"{detail}"
            )
        if conversation.status != "completed":
            raise RuntimeError(
                f"Unsupported conversation status: {conversation.status}"
            )

        recording = await conversations.get_audio(
            agent_name,
            conversation_id,
            foundry_features=PREVIEW,
        )
        if recording.blob_uri:
            print(f"Merged recording is in customer storage: {recording.blob_uri}")
        else:
            stream = await conversations.download_audio(
                agent_name,
                conversation_id,
                foundry_features=PREVIEW,
            )
            output = Path("contoso-support-call.wav")
            await write_stream(stream, output)
            print(
                f"Saved {recording.duration_ms} ms stereo call to "
                f"{output.resolve()}"
            )

        print(
            "Query Application Insights by gen_ai.conversation.id="
            f"{conversation_id} to inspect the session trace."
        )

asyncio.run(main())
```

### Scenario 4: Additional use cases

- **Cascaded vs. realtime**: Pick a `cascaded` (STT→LLM→TTS) model for finer transcript control, or a
  `realtime` (native speech-to-speech) model for lowest latency — Foundry derives which from the selected
  model (no field to set).
- **Toolbox-backed knowledge**: A voice agent answers from a toolbox (e.g. an Azure AI Search-backed KB)
  executed by Voice Live via the toolbox MCP endpoint, with auth resolved from a Foundry connection.
- **Toolbox containing Skills (Public Preview)**: The voice session ignores the toolbox's Skill references and
  uses only tools declared directly on the toolbox version. Direct Voice Agent Skills support is deferred.
- **Direct Foundry tools (post-Public Preview)**: Evaluate direct `web_search`, `azure_ai_search`,
  `file_search`, `openapi`, and future shared tool declarations using the same models as prompt and managed
  agents; do not introduce voice-specific copies.
- **Per-session overrides**: Override the explicit `session.update` allowlist in Requirement #9 for one call
  without minting a new agent version. The avatar, `voice_type`, and input-transcription model remain fixed from
  the persisted definition.
- **Avatar session**: Enable an avatar in the definition and render the avatar video stream alongside audio.
- **Telephony front-end (out of scope)**: The same agent definition can serve a telephony/SIP front-end that
  fronts the voice endpoint (separate transport work; the agent definition is unchanged). Transfer and DTMF
  system tools ship with that later telephony scope, not Public Preview.
- **WebRTC channel (out of scope)**: A browser/mobile **WebRTC** transport can front the same voice endpoint for
  direct in-app audio (low-latency client ingress), complementing the server-side WebSocket.
- **Evaluation & optimization**: Run supported text evaluators over persisted transcripts/traces. Audio-native,
  conversation-quality, and end-to-end task-success evaluation remain a separate workstream.
- **Versioned experimentation (out of scope)**: A/B and staged rollout across the agent's immutable versions
  to compare quality / latency in production before promoting a version.

## CLI Expectations (azd)

`azd` presents prompt, hosted, and voice in one Foundry agent workflow backed by the standard Agents API and
SDK. The interaction presents **prompt, hosted, or voice** as the top-level choice. A voice-agent workflow
scaffolds a voice definition, provisions the project, deploys through `/agents`, and offers a realtime
microphone smoke test.

### CLI Workflow Scenarios

#### Scenario 1: Create a voice agent and smoke-test it (greenfield)

```bash
# Scaffold a voice agent from the curated sample catalog.
# Interactive UX: Agent experience=voice.
azd ai agent init -m foundry-voice-agent-quickstart --agent-name support-voice-agent

# Provision the project and deploy through the standard Agents surface.
azd up

# Exercise the realtime voice protocol (microphone in, speaker out).
azd ai agent invoke --voice
```

#### Scenario 2: Minimal agentic creation (brownfield — existing project)

```bash
# The active azd environment already targets an existing Foundry project.
# azd normalizes the kebab-case flag value to the API's snake_case use_case.
azd ai agent create \
  --kind voice \
  --name my-airline-agent \
  --use-case airline-and-travel-servicing
```

#### Scenario 3: Iterative inner-loop & CI

Voice-agent authoring is **iterative**: edit `agent.yaml` (or the linked definition) → `azd deploy` to
idempotently reconcile through `POST /agents/{agent_name}` → smoke-test → repeat. The definition is checked
into the repo, and `azd deploy` (or `azd up --no-prompt`) performs the same reconcile **non-interactively in
CI** on merge: unchanged content returns the existing latest version, while changed content mints a new
immutable version. The interactive voice test is inner-loop only. Voice evaluation CLI commands are out of
scope for this spec (design §8.5).

### AZD Environment Scoping

- `azd up` / `azd provision` creates/selects the Foundry project and outputs `FOUNDRY_PROJECT_ENDPOINT`; for
  brownfield, `azd ai agent init --project-id <id>` targets an existing project (`FOUNDRY_PROJECT_ID`).
- `azd ai agent init` writes the voice agent identity and definition to **`agent.yaml`** plus an `azure.yaml`
  service entry; `azd deploy` maps to the idempotent row 4 reconcile operation.
- `azd ai agent create --kind voice --name <name> --use-case <scenario>` invokes agentic creation against the
  Foundry project selected by the active environment; kebab-case CLI scenario names are serialized as
  snake_case.
- Generated code consumes `FOUNDRY_PROJECT_ENDPOINT`; voice-specific model selections remain in
  `AZURE_VOICE_AGENTS_MODEL_TYPE` and `AZURE_VOICE_AGENTS_MODEL`.
- Tracing scope: connecting an Application Insights resource to the project (or
  `azd env set APPLICATIONINSIGHTS_CONNECTION_STRING`) routes the agent's customer traces to the developer's
  own APM.

## Dependencies & Commitment Status

The table lists dependencies owned outside the Foundry Voice Agents service team.

| Dependency | Team | DRI | Status |
|------------|------|-----|--------|
| Voice management, conversation operations, and `get_voice_connection(...)` OpenAI Realtime helper on the unified `AIProjectClient.agents` surface | Foundry SDK | Kun Cong / Xiting Zhang | Committed; helper contract added from SDK review |
| Converge voice management and guided authoring from `/voice_agents` to `/agents` with `kind = voice` | Agents API / TypeSpec | Yulin Li (yulili) / Zheng Niu (zhn) | Committed; TypeSpec PR #45357 open |
| Share top-level `response_scheduling` across MCP and toolbox tools, with compatibility-preserving `none` as the default | Agents API / SDK | Vivek / Yulin Li (yulili) | Committed; TypeSpec PR #45357 requires value/default alignment |
| BYOM deployment→model resolution for architecture derivation (Cognitive Services RP / IRM `GetDeployment` → true model name; the `realtime` marker classifies realtime vs. cascaded) | Cognitive Services RP | Zheng Niu (zhn) | Committed (reused) |
| Toolbox MCP execution of server-side tools (Voice Live → toolbox MCP → tool server) | Agents Toolbox / Tool Server | Zheng Niu (zhn) | Committed |
| AACS content-safety guardrails for the managed voice surface | Responsible AI | Ethan Zhao (chaoqunzhao) | Committed (placement resolved) |
| Customer trace delivery and shared portal tracing UX (OTLP → Application Insights / A365) | Agents Service / Observability | Hanchi Wang | Committed; service/UX sequencing in progress |
| Transcript/trace-based evaluators for voice agents; define audio-native and E2E evaluation scope | Evaluation | Shivank Goel | In Progress / follow-up scope |

## Open Questions

| # | Question | On Point | Target Date | Notes |
|---|----------|----------|-------------|-------|
| 1 | **Use-case catalog migration:** what old-to-new mapping and API version govern enforcement of the eight agentic-creation scenarios? | Voice Agents API / SDK | 2026-08-14 | Existing persisted values remain readable and `agent_type` is tolerated but ignored during migration. |
| 2 | **Evaluation scope:** which transcript/trace evaluators are supported for public preview, and which audio-native, conversation-quality, and end-to-end evaluators are explicitly deferred? | Hanchi Wang / Shivank Goel | 2026-08-21 | Shared tracing/eval platform is agreed; capability completeness is not. |
| 3 | **Managed-agent / harness integration:** can a voice agent front a back-end managed / harness / long-running agent while preserving progress and interruption semantics? | Managed Agent / Harness owners | 2026-08-21 | Define interop without splitting the unified Agents API or SDK. |


## Normative complete TypeSpec

This section is the complete Voice Agents TypeSpec module from `feature/voice-agent-batch2` at commit `959894f28ce0c52303f730962b4777c25ed65ecf`. It is normative for this document. The four source files are reproduced in full and in compiler import order; no unchanged declarations are omitted. Shared Foundry and OpenAI library types referenced by imports remain defined by their canonical packages and shared Foundry modules.

### `agents.tsp`

Canonical path: `specification/ai-foundry/data-plane/Foundry/src/voice-agents/agents.tsp`

```typespec
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/versioning";
import "@azure-tools/openai-typespec/models/realtime";
import "../common/servicepatterns.tsp";
import "../agents/models.tsp";
import "../openai/responses/models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ============================================================================
// Voice agent definition and configuration models. Voice agents are a
// first-class `kind` on the shared `/agents` resource and reuse the standard
// agent lifecycle, versioning, identity, and SDK surface.
// ============================================================================

const VoiceAgentRequiredPreview = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

@doc("Additional fields that a voice-agent session may include in service outputs.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentSessionIncludeOption {
  input_audio_transcription_logprobs: "item.input_audio_transcription.logprobs",
  input_audio_transcription_phrases: "item.input_audio_transcription.phrases",
  file_search_call_results: "file_search_call.results",
}

@doc("The maximum output-token count or the literal `inf`.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentMaxOutputTokens {
  count: int32,
  unlimited: "inf",
}

@doc("A condition that may trigger an interim response.")
union VoiceAgentInterimResponseTrigger {
  latency: "latency",
  tool: "tool",
}

@doc("Fields shared by interim-response configurations.")
@discriminator("type")
model VoiceAgentInterimResponseConfig {
  @doc("The interim-response implementation.")
  type: string;

  @doc("Conditions that may trigger one interim response.")
  triggers?: VoiceAgentInterimResponseTrigger[] = #[
    VoiceAgentInterimResponseTrigger.latency
  ];

  @doc("The latency threshold in milliseconds.")
  @minValue(0)
  latency_threshold_ms?: int32 = 2000;
}

@doc("A static interim response selected from configured text.")
model VoiceAgentStaticInterimResponseConfig
  extends VoiceAgentInterimResponseConfig {
  type: "static_interim_response";

  @doc("Candidate text values for the interim response.")
  texts?: string[];
}

@doc("An interim response generated by a language model.")
model VoiceAgentLlmInterimResponseConfig
  extends VoiceAgentInterimResponseConfig {
  type: "llm_interim_response";

  @doc("The model used to generate interim responses.")
  `model`?: string;

  @doc("Optional instructions for generating interim responses.")
  instructions?: string;

  @doc("The maximum completion-token count for an interim response.")
  @minValue(1)
  max_completion_tokens?: int32 = 50;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Interim response settings are selected by their `type` property."
@doc("Interim-response settings for latency and tool execution.")
@oneOf
union VoiceAgentInterimResponse {
  static: VoiceAgentStaticInterimResponseConfig,
  llm: VoiceAgentLlmInterimResponseConfig,
}

@doc("""
  The voice agent definition. Its configuration (model, instructions, audio, tools, and optional avatar) drives a
  managed speech-to-speech experience. Establish realtime voice sessions through
  `GET /agents/{agent_name}/endpoint/protocols/voice`. Every create or update produces a new immutable version.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentDefinition extends AgentDefinition {
  @doc("The kind discriminator for a voice agent definition. Always `voice`.")
  kind: AgentKind.voice;

  @doc("How the model backing this agent is served. Together with `model`, this selects the model up front. `managed` uses a service-managed model; `self_deployed` uses the customer's own Foundry deployment. This is independent of the architecture (realtime or cascaded), which the service derives from the selected model.")
  model_type: VoiceModelType;

  @doc("The model to use for this agent, paired with `model_type`: the service-managed model name when `model_type` is `managed`, or the customer's Foundry deployment name when `model_type` is `self_deployed`. The model must support realtime or cascaded voice. The service derives the architecture from the selected model.")
  `model`: string;

  @doc("A system (or developer) message inserted into the model's context. Supports template substitution via `structured_inputs`, rendered per session before the live session starts.")
  instructions?: string;

  @doc("Optional session-start greeting. Template mode speaks exact rendered text; LLM-generated mode asks the session model to author the opening response and may use configured tools.")
  greeting?: VoiceGreetingConfig;

  @doc("""
    The audio configuration, including input and output formats, voice, turn detection, noise reduction, and
    transcription. These values are session defaults; a client may override supported fields when connecting.
    """)
  audio?: VoiceAudioConfig;

  @doc("""
    The output modalities the agent produces. Defaults to `["audio"]`. `animation` and `avatar` are available
    when an avatar is configured.
    """)
  output_modalities?: VoiceOutputModality[] = #[VoiceOutputModality.audio];

  @doc("The maximum output-token count for one response.")
  max_output_tokens?: VoiceAgentMaxOutputTokens;

  @doc("Additional fields to include in service outputs.")
  include?: VoiceAgentSessionIncludeOption[];

  @doc("Interim-response settings for latency and tool execution.")
  interim_response?: VoiceAgentInterimResponse;

  @doc("Optional avatar configuration. These values are session defaults and may be overridden when connecting.")
  avatar?: VoiceAvatarConfig;

  @doc("""
    The tools the voice agent may use. Supported tool kinds are `function` (executed by the client), `mcp`,
    `system` (service-managed session controls), and `toolbox`. Server-side tools such as `web_search`,
    `azure_ai_search`, and `openapi` are provided through a toolbox rather than declared directly.
    """)
  tools?: VoiceAgentTool[];

  @doc("""
    How the model chooses tools for generated responses. `none` prevents tool calls, `auto` lets the model decide,
    `required` requires at least one tool call, and a specific function or MCP tool can be selected with an object.
    Defaults to `auto`.
    """)
  tool_choice?: VoiceAgentToolChoice = OpenAI.ToolChoiceOptions.auto;

  @doc("Whether the model may call multiple tools in parallel.")
  parallel_tool_calls?: boolean;

  @doc("Set of structured inputs that participate in prompt template substitution, rendered per session before the live session starts.")
  structured_inputs?: Record<StructuredInputDefinition>;

  @doc("""
    Whether conversations with this agent are persisted. A single, all-or-nothing persistence switch that defaults to
    `false` (privacy-safe: off by default). When `true`, Foundry persists the full conversation — the transcript/event
    timeline and raw audio. When `false`, nothing is persisted and no conversation is surfaced. There is no separate
    audio-logging control; audio is persisted only as part of this switch. Latency/performance telemetry (e.g.
    time-to-first-audio, inter-token latency, interruption) is observability-only (customer trace / App Insights) and
    is not part of the persisted conversation content.
    """)
  store?: boolean = false;
}

@doc("Session-start greeting configuration for a voice agent.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceGreetingConfig {
  @doc("The greeting mode.")
  type: string;
}

@doc("A deterministic greeting rendered with the voice agent's structured inputs and synthesized without model-authored generation.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model TemplateVoiceGreetingConfig extends VoiceGreetingConfig {
  type: "template";

  @doc("The Handlebars text template spoken at session start.")
  @minLength(1)
  text: string;
}

@doc("A greeting authored by the session model from a scoped opening-turn prompt.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model LlmGeneratedVoiceGreetingConfig extends VoiceGreetingConfig {
  type: "llm_generated";

  @doc("The Handlebars prompt that guides the opening turn.")
  @minLength(1)
  prompt: string;

  @doc("The tool-selection policy for the opening response. Defaults to `none`.")
  tool_choice?: VoiceAgentToolChoice = OpenAI.ToolChoiceOptions.none;
}

@doc("""
  How the model backing a voice agent is served. This is independent of the architecture (realtime or cascaded),
  which the service derives from the selected model.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceModelType {
  string,

  @doc("The service hosts and manages the named model, for example `gpt-realtime`.")
  managed: "managed",

  @doc("The service uses the customer's own Foundry deployment named by `model`.")
  self_deployed: "self_deployed",
}

@doc("A tool usable by a voice agent.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentTool {
  @doc("The tool kind.")
  type: string;
}

@doc("A native function tool executed by the client.")
model VoiceAgentFunctionTool extends VoiceAgentTool {
  ...OmitProperties<OpenAI.RealtimeFunctionTool, "type" | "name">;
  type: "function";

  @doc("The function name.")
  @minLength(1)
  name: string;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Tool choice may be a mode, a forced function, or an MCP tool."
@doc("Tool-selection behavior for a voice agent.")
@oneOf
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentToolChoice {
  mode: OpenAI.ToolChoiceOptions,
  function: OpenAI.ToolChoiceFunction,
  mcp: OpenAI.ToolChoiceMCP,
}

@doc("When a tool invocation creates a follow-up response. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAgentToolResponseScheduling {
  string,

  @doc("Do not create a follow-up response after the service-executed tool invocation completes.")
  silent: "silent",

  @doc("Create a follow-up response when the conversation is idle.")
  when_idle: "when_idle",

  @doc("Interrupt the active response and create a follow-up response.")
  interrupt: "interrupt",

  @doc("Create a follow-up response only when no response is active.")
  skip_if_busy: "skip_if_busy",
}

@doc("An MCP tool available to a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAgentMcpTool extends VoiceAgentTool {
  ...OmitProperties<
    OpenAI.MCPTool,
    "type" | "connector_id" | "tunnel_id" | "server_url"
  >;
  type: "mcp";

  @doc("The URL for the MCP server.")
  server_url?: url;

  @doc("When the MCP invocation creates a follow-up response. Defaults to `when_idle`.")
  response_scheduling?: VoiceAgentToolResponseScheduling = VoiceAgentToolResponseScheduling.when_idle;
}

@doc("A service-managed control that acts on the active voice session without customer code or external authentication.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceSystemTool extends VoiceAgentTool {
  @doc("The type of the tool. Always `system`.")
  type: "system";

  @doc("The service-managed control action. Known values are stable; additional values may be added over time.")
  name: VoiceSystemToolName;

  @doc("An optional description of the system tool.")
  description?: string;
}

@doc("A service-managed voice-session control action. Known values are stable; additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceSystemToolName {
  string,

  @doc("Ends the active conversation.")
  end_conversation: "end_conversation",
}

@doc("A reference to a Foundry toolbox, which is a versioned bundle of tools executed through its MCP endpoint.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceToolboxTool extends VoiceAgentTool {
  @doc("The type of the tool. Always `toolbox`.")
  type: "toolbox";

  @doc("The name of the toolbox to attach.")
  toolbox_name: string;

  @doc("The immutable version of the toolbox to attach.")
  toolbox_version: string;

  @doc("When the toolbox invocation creates a follow-up response. Defaults to `when_idle`.")
  response_scheduling?: VoiceAgentToolResponseScheduling = VoiceAgentToolResponseScheduling.when_idle;
}

@doc("""
  The audio configuration for a voice agent. These values are session defaults and may be overridden when connecting.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioConfig {
  @doc("Input (microphone) audio configuration.")
  input?: VoiceAudioInputConfig;

  @doc("Output (agent speech) audio configuration.")
  output?: VoiceAudioOutputConfig;
}

@doc("Input audio configuration for a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioInputConfig {
  @doc("The input audio format.")
  format?: VoiceAudioFormat;

  @doc("Input noise reduction. Set to null to disable.")
  noise_reduction?: VoiceNoiseReduction | null;

  @doc("Turn (end-of-speech) detection. Server-side turn detection is enabled by default; set to null to disable it, in which case the client must trigger responses manually.")
  turn_detection?: VoiceAgentTurnDetection | null;

  @doc("Optional server-side echo cancellation settings.")
  echo_cancellation?: VoiceAgentEchoCancellation | null;

  @doc("Asynchronous input-audio transcription. Set to null to disable transcription.")
  transcription?: VoiceInputTranscription | null;
}

@doc("""
  Output audio configuration for a voice agent.
  Provider-specific fields are selected by `voice_type`:
  - `openai`: `voice` and `speed`.
  - `azure-standard`: `voice`, `voice_locale`, `speed`, `voice_temperature`, `custom_lexicon_url`,
    `custom_text_normalization_url`, `prefer_locales`, `style`, `pitch`, and `volume`.
  - `azure-custom`: all `azure-standard` fields except `style`, plus `custom_voice_endpoint_id`.
  - `azure-personal`: all `azure-standard` fields except `style`, plus `personal_voice_model`.
  - `avatar-voice-sync`: all `azure-standard` fields except `voice` and `style`, plus `personal_voice_model`; the voice name is derived from the avatar.
  - `azure-realtime-native`: `voice` and `speed`.
  `format` and `output_audio_timestamp_types` apply to every voice type.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioOutputConfig {
  @doc("The output audio format. Applies to every `voice_type` and defaults to 24 kHz PCM.")
  format?: VoiceAudioFormat;

  @doc("The voice name or identifier. Applies to `openai`, `azure-standard`, `azure-custom`, `azure-personal`, and `azure-realtime-native`. It does not apply to `avatar-voice-sync`, which derives the voice name from the avatar.")
  voice?: string;

  @doc("The voice implementation. Known values are `openai`, `azure-standard`, `azure-custom`, `azure-personal`, `avatar-voice-sync`, and `azure-realtime-native`. The string is extensible so future values do not require SDK type changes.")
  voice_type?: string;

  @doc("The enforced BCP-47 output locale. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  voice_locale?: string;

  @doc("The numeric output speed multiplier. Applies to all known `voice_type` values and defaults to 1.")
  @minValue(0.25)
  @maxValue(1.5)
  speed?: float32 = 1;

  @doc("The voice variation temperature. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  @minValue(0)
  @maxValue(1)
  voice_temperature?: float32;

  @doc("The URL of a custom pronunciation lexicon. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  custom_lexicon_url?: url;

  @doc("The URL of a custom text-normalization configuration. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  custom_text_normalization_url?: url;

  @doc("Preferred BCP-47 locales for multilingual synthesis. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  prefer_locales?: string[];

  @doc("The voice speaking style. Applies only when `voice_type` is `azure-standard`.")
  style?: string;

  @doc("The voice pitch adjustment. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  pitch?: string;

  @doc("The voice volume adjustment. Applies to `azure-standard`, `azure-custom`, `azure-personal`, and `avatar-voice-sync`.")
  volume?: string;

  @doc("The Azure custom-voice deployment endpoint identifier. Applies only when `voice_type` is `azure-custom`.")
  custom_voice_endpoint_id?: string;

  @doc("The Azure personal or avatar voice model. Applies only when `voice_type` is `azure-personal` or `avatar-voice-sync`.")
  personal_voice_model?: string;

  @doc("Timestamp kinds to include with output audio. Applies to every `voice_type`.")
  output_audio_timestamp_types?: VoiceAudioTimestampType[];
}

@doc("An output-audio timestamp kind supported by a voice agent.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioTimestampType {
  @doc("Word-level timestamps.")
  word: "word",
}

@doc("An audio format. Follows the OpenAI Realtime session schema; `type` carries the media subtype.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioFormat {
  @doc("The audio format type, e.g. 'audio/pcm' (16-bit PCM), 'audio/pcmu' (G.711 mu-law), or 'audio/pcma' (G.711 A-law).")
  type: VoiceAudioFormatType;

  @doc("The sample rate in Hz. Applies to 'audio/pcm' (e.g. 24000); omit for telephony G.711 formats (8 kHz).")
  rate?: int32;
}

@doc("The audio format type. Values follow the OpenAI Realtime wire schema and are exempt from the snake_case enum-value rule.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioFormatType {
  string,

  @doc("16-bit PCM.")
  pcm: "audio/pcm",

  @doc("G.711 mu-law (telephony).")
  pcmu: "audio/pcmu",

  @doc("G.711 A-law (telephony).")
  pcma: "audio/pcma",
}

@doc("Input audio noise reduction configuration.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceNoiseReduction {
  @doc("The noise reduction mode.")
  type: VoiceNoiseReductionType;
}

@doc("The input audio noise reduction mode.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceNoiseReductionType {
  string,
  near_field: "near_field",
  far_field: "far_field",

  @doc("Azure deep noise suppression.")
  azure_deep_noise_suppression: "azure_deep_noise_suppression",
}

@doc("The turn-detection strategy. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceTurnDetectionType {
  string,

  @doc("Server-side voice activity detection.")
  server_vad: "server_vad",

  @doc("Semantic voice activity detection.")
  semantic_vad: "semantic_vad",

  @doc("Azure semantic voice activity detection.")
  azure_semantic_vad: "azure_semantic_vad",

  @doc("English-optimized Azure semantic voice activity detection.")
  azure_semantic_vad_en: "azure_semantic_vad_en",

  @doc("Multilingual Azure semantic voice activity detection.")
  azure_semantic_vad_multilingual: "azure_semantic_vad_multilingual",
}

@doc("Turn-detection configuration for a voice agent.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceTurnDetection {
  @doc("The turn-detection strategy.")
  type: VoiceTurnDetectionType;

  @doc("Whether the input audio buffer is truncated automatically when speech stops.")
  auto_truncate?: boolean = false;
}

@doc("Server-side voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceServerVadTurnDetection extends VoiceTurnDetection {
  ...OmitProperties<OpenAI.RealtimeTurnDetectionServerVad, "type">;
  type: VoiceTurnDetectionType.server_vad;

  @doc("Minimum speech duration required to trigger detection, in milliseconds.")
  @minValue(0)
  speech_duration_ms?: int32;

  @doc("Semantic end-of-utterance detection configuration. Set to null to disable it.")
  end_of_utterance_detection?: VoiceEndOfUtteranceDetection | null;
}

@doc("The semantic end-of-utterance detection model.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceEndOfUtteranceDetectionModel {
  string,

  @doc("The default semantic detection model.")
  semantic_detection_v1: "semantic_detection_v1",

  @doc("The English-optimized semantic detection model.")
  semantic_detection_v1_en: "semantic_detection_v1_en",

  @doc("The multilingual semantic detection model.")
  semantic_detection_v1_multilingual: "semantic_detection_v1_multilingual",

  @doc("The smart end-of-turn detection model.")
  smart_end_of_turn_detection: "smart_end_of_turn_detection",
}

@doc("The sensitivity threshold for semantic end-of-utterance detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceEndOfUtteranceThresholdLevel {
  string,

  @doc("The low sensitivity threshold.")
  low: "low",

  @doc("The medium sensitivity threshold.")
  medium: "medium",

  @doc("The high sensitivity threshold.")
  high: "high",

  @doc("The service-selected sensitivity threshold.")
  default: "default",
}

#suppress "@azure-tools/typespec-azure-core/known-encoding" "The existing voice-agent wire contract requires integer-millisecond durations."
@doc("Semantic end-of-utterance detection configuration.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceEndOfUtteranceDetection {
  @doc("The semantic detection model.")
  `model`: VoiceEndOfUtteranceDetectionModel;

  @doc("The sensitivity threshold.")
  threshold_level?: VoiceEndOfUtteranceThresholdLevel;

  @doc("The detection timeout in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  timeout_ms?: duration;
}

/** Options shared by Azure semantic voice activity detection configurations. */
#suppress "@azure-tools/typespec-azure-core/known-encoding" "The existing voice-agent wire contract requires integer-millisecond durations."
alias VoiceAzureSemanticVadOptions = {
  @doc("Activation threshold for voice activity detection, from 0 to 1.")
  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  @doc("Audio to include before detected speech, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  prefix_padding_ms?: duration;

  @doc("Silence required to end speech detection, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  silence_duration_ms?: duration;

  @doc("Maximum idle time before the detector ends the turn, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  idle_timeout_ms?: duration;

  @doc("Semantic end-of-utterance detection configuration. Set to null to disable it.")
  end_of_utterance_detection?: VoiceEndOfUtteranceDetection | null;

  @doc("Minimum speech duration required to trigger detection, in milliseconds.")
  @encode(DurationKnownEncoding.milliseconds, int32)
  @minValue(duration.fromISO("PT0S"))
  speech_duration_ms?: duration;

  @doc("Whether filler words are removed from transcription.")
  remove_filler_words?: boolean = false;

  @doc("Whether a response is created automatically when speech stops.")
  create_response?: boolean = true;

  @doc("Whether user speech may interrupt the agent's response.")
  interrupt_response?: boolean = true;
};

@doc("Azure semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAzureSemanticVadTurnDetection extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.azure_semantic_vad;
  ...VoiceAzureSemanticVadOptions;

  @doc("BCP-47 language codes used for speech detection.")
  languages?: string[];
}

@doc("English-optimized Azure semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAzureSemanticVadEnTurnDetection extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.azure_semantic_vad_en;
  ...VoiceAzureSemanticVadOptions;
}

@doc("Multilingual Azure semantic voice activity detection.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAzureSemanticVadMultilingualTurnDetection
  extends VoiceTurnDetection {
  type: VoiceTurnDetectionType.azure_semantic_vad_multilingual;
  ...VoiceAzureSemanticVadOptions;

  @doc("BCP-47 language codes used for speech detection.")
  languages?: string[];
}

@doc("OpenAI semantic VAD turn-detection settings.")
model VoiceAgentSemanticVadTurnDetection extends VoiceTurnDetection {
  ...OmitProperties<OpenAI.RealtimeTurnDetectionSemanticVad, "type">;
  type: VoiceTurnDetectionType.semantic_vad;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Turn-detection settings are selected by their `type` property."
@doc("Turn-detection settings accepted by a stable voice-agent session.")
@oneOf
@Azure.ClientGenerator.Core.alternateType(VoiceTurnDetection, "csharp")
union VoiceAgentTurnDetection {
  server_vad: VoiceServerVadTurnDetection,
  semantic_vad: VoiceAgentSemanticVadTurnDetection,
  azure_semantic_vad: VoiceAzureSemanticVadTurnDetection,
  azure_semantic_vad_en: VoiceAzureSemanticVadEnTurnDetection,
  azure_semantic_vad_multilingual: VoiceAzureSemanticVadMultilingualTurnDetection,
}

@doc("The source of reference audio used for echo cancellation.")
union VoiceAgentEchoCancellationReferenceSource {
  server: "server",
  client: "client",
}

@doc("Server-side echo cancellation settings for input audio.")
model VoiceAgentEchoCancellation {
  @doc("The echo cancellation implementation. Always `server_echo_cancellation`.")
  type: "server_echo_cancellation";

  @doc("Whether reference audio comes from server playback or a client-provided channel.")
  reference_source?: VoiceAgentEchoCancellationReferenceSource = VoiceAgentEchoCancellationReferenceSource.server;

  @doc("The number of input channels. Use two interleaved channels when `reference_source` is `client`.")
  @minValue(1)
  @maxValue(2)
  channels?: int32 = 1;
}

@doc("""
  The input-audio transcription model. Mirrors the transcription models supported by the managed
  voice backend, covering the OpenAI Realtime transcription models plus the Azure and MAI models.
  Additional values may be added over time.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceInputTranscriptionModel {
  string,

  @doc("OpenAI Whisper.")
  whisper_1: "whisper-1",

  @doc("OpenAI GPT Realtime Whisper.")
  gpt_realtime_whisper: "gpt-realtime-whisper",

  @doc("OpenAI GPT-4o transcribe.")
  gpt_4o_transcribe: "gpt-4o-transcribe",

  @doc("OpenAI GPT-4o mini transcribe.")
  gpt_4o_mini_transcribe: "gpt-4o-mini-transcribe",

  @doc("OpenAI GPT-4o transcribe with speaker diarization.")
  gpt_4o_transcribe_diarize: "gpt-4o-transcribe-diarize",

  @doc("OpenAI GPT Transcribe.")
  gpt_transcribe: "gpt-transcribe",

  @doc("OpenAI GPT Live Transcribe.")
  gpt_live_transcribe: "gpt-live-transcribe",

  @doc("MAI transcription.")
  mai_transcribe: "mai-transcribe",

  @doc("Azure AI Speech to text.")
  azure_speech: "azure-speech",
}

@doc("""
  Asynchronous input-audio transcription configuration. Extends the OpenAI Realtime transcription
  options with the Azure and MAI transcription models, custom speech models, and phrase hints.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceInputTranscription {
  ...OmitProperties<OpenAI.AudioTranscription, "model">;

  @doc("The transcription model to use.")
  `model`: VoiceInputTranscriptionModel;

  @doc("Optional custom speech model configuration, keyed by locale.")
  custom_speech?: Record<string>;

  @doc("Optional phrase hints that bias recognition toward domain terms.")
  phrase_list?: string[];
}

@doc("The avatar video resolution.")
model VoiceAgentAvatarVideoResolution {
  @minValue(1)
  width: int32;

  @minValue(1)
  height: int32;
}

@doc("The rectangular crop applied to avatar video.")
model VoiceAgentAvatarVideoCrop {
  @minItems(2)
  @maxItems(2)
  bottom_right: uint32[];

  @minItems(2)
  @maxItems(2)
  top_left: uint32[];
}

@doc("The avatar video background.")
model VoiceAgentAvatarVideoBackground {
  image_url?: url;
  color?: string;
}

@doc("Avatar video encoder and presentation settings.")
model VoiceAgentAvatarVideoParams {
  bitrate?: int32 = 2000000;
  codec?: "h264" = "h264";
  crop?: VoiceAgentAvatarVideoCrop;
  resolution?: VoiceAgentAvatarVideoResolution;
  background?: VoiceAgentAvatarVideoBackground;

  @minValue(1)
  @maxValue(2000)
  gop_size?: int32 = 10;
}

@doc("Avatar placement and motion settings.")
model VoiceAgentAvatarScene {
  @minValueExclusive(0)
  zoom?: float32 = 1;

  @minValue(-1)
  @maxValue(1)
  position_x?: float32 = 0;

  @minValue(-1)
  @maxValue(1)
  position_y?: float32 = 0;

  @minValue(-3.141592653589793)
  @maxValue(3.141592653589793)
  rotation_x?: float32 = 0;

  @minValue(-3.141592653589793)
  @maxValue(3.141592653589793)
  rotation_y?: float32 = 0;

  @minValue(-3.141592653589793)
  @maxValue(3.141592653589793)
  rotation_z?: float32 = 0;

  @minValueExclusive(0)
  @maxValue(1)
  amplitude?: float32 = 1;
}

@doc("""
  Avatar configuration for a voice agent. These values are session defaults and may be overridden when connecting.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAvatarConfig {
  @doc("The avatar type.")
  type: VoiceAvatarType;

  @doc("The avatar character identifier, e.g. 'lisa'.")
  character: string;

  @doc("The avatar style, e.g. 'casual-sitting'.")
  style?: string;

  @doc("Whether the avatar is a customer-customized avatar. Defaults to false.")
  customized?: boolean = false;

  @doc("The transport used to deliver the avatar video stream.")
  output_protocol?: VoiceAvatarOutputProtocol;

  @doc("The avatar model identifier.")
  `model`?: string;

  @doc("Avatar video encoder and presentation settings.")
  video?: VoiceAgentAvatarVideoParams;

  @doc("Avatar placement and motion settings.")
  scene?: VoiceAgentAvatarScene;

  @doc("Whether audit audio is emitted with avatar output. Defaults to false.")
  output_audit_audio?: boolean = false;
}

@doc("The avatar type.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAvatarType {
  string,
  video_avatar: "video_avatar",
  photo_avatar: "photo_avatar",
}

@doc("The transport used to deliver the avatar video stream.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAvatarOutputProtocol {
  string,
  webrtc: "webrtc",
  websocket: "websocket",

  @doc("Binary WebSocket transport.")
  websocket_binary: "websocket-binary",
}

@doc("An output modality the agent may produce. `animation` and `avatar` are used when an avatar is configured.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceOutputModality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

@doc("""
  The inputs for generating a voice agent. Only `kind` and `name` are always required.
  The authoring service expands these inputs into a full, editable `VoiceAgentDefinition`, which is then created through `POST /agents`.
  The generated `instructions` and audio/voice settings are stored as separate fields on the resulting agent
  definition, so the caller can edit or override any of them afterward via standard agent versioning.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model GenerateVoiceAgentRequest extends GenerateAgentRequest {
  @doc("The agent kind. Always `voice`.")
  kind: AgentKind.voice;

  @doc("The unique name for the agent to create. Must be a non-empty DNS-like agent name.")
  @minLength(1)
  @maxLength(63)
  name: string;

  @doc("Optional inference mode. When omitted, the authoring service uses `managed`. When supplied, use `managed` or `self_deployed`.")
  model_type?: VoiceModelType;

  @doc("Optional model identifier. Required when `model_type` is `self_deployed`; optional when `model_type` is `managed` or omitted. The service never invents a customer deployment name.")
  @maxLength(256)
  `model`?: string;

  @doc("An optional authoring use case. An empty string is accepted.")
  @maxLength(128)
  use_case?: string;

  @doc("An optional natural-language description of what the agent should do. When supplied, it seeds the generated instructions.")
  @maxLength(4096)
  goal?: string;

  @doc("An optional agent description. The authoring service resolves its fallback when omitted.")
  @maxLength(512)
  description?: string;

  @doc("Optional tools carried through verbatim onto the generated agent (see `VoiceAgentTool`).")
  tools?: VoiceAgentTool[];

  @doc("(Preview) When `true`, the generated voice agent is created as a draft — an editable, unpublished version the caller can review and refine before publishing it via the standard create/version path. The service defaults to `false` if a value is not specified by the caller, in which case the agent is created and published normally.")
  @extension(
    "x-ms-foundry-meta",
    #{
      conditional_previews: #[AgentDefinitionOptInKeys.draft_agents_v1_preview],
    }
  )
  draft?: boolean = false;
}
```

### `models.tsp`

Canonical path: `specification/ai-foundry/data-plane/Foundry/src/voice-agents/models.tsp`

```typespec
import "@typespec/http";
import "@typespec/openapi";
import "../agents/models.tsp";
import "./agents.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ============================================================================
// Persisted voice conversation resources.
//
// These models describe the durable, read-only projection of a voice agent's
// conversation using conversation, response, item, and usage resources. Raw
// audio bytes are streamed through the dedicated item and recording routes.
// ============================================================================

@doc("""
  The lifecycle status of a persisted voice conversation:
  - `in_progress`: the live session is active, or post-session persistence finalization is pending.
  - `completed`: finalization succeeded after normal or client close, `end_conversation`, a max-duration `1001`
    close, or a client or network disconnect that the service can still finalize.
  - `failed`: a terminal service, bridge, storage, or unrecoverable transport failure prevented finalization.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceConversationStatus {
  string,

  @doc("The live session is active, or post-session persistence finalization is still pending.")
  in_progress: "in_progress",

  @doc("Persistence finalization succeeded. This includes normal or client-initiated close, the `end_conversation` system tool, a max-duration `1001` close, and client or network disconnects that the service can still finalize.")
  completed: "completed",

  @doc("A terminal service, bridge, storage, or unrecoverable transport failure prevented persistence finalization.")
  failed: "failed",
}

@doc("""
  A persisted voice conversation. The Foundry envelope that owns a voice agent's stored
  transcript, responses, per-turn metrics, and audio. It is the parent, retention, and delete boundary:
  deleting it cascades to its responses, items, metrics, and audio. When finalization fails, any partial persisted
  responses, items, and item audio remain readable.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceConversation {
  @doc("The unique id of the conversation.")
  id: string;

  @doc("The object type. Always `voice.conversation`.")
  object: "voice.conversation";

  @doc("The lifecycle status of the conversation.")
  status: VoiceConversationStatus;

  @doc("The Unix timestamp (in seconds) for when the conversation was created.")
  created_at: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when session and persistence finalization reached the terminal `completed` or `failed` status. Absent while `status` is `in_progress`.")
  completed_at?: FoundryTimestamp;

  @doc("A set of key-value pairs attached to the conversation.")
  metadata?: Record<string>;

  @doc("Final aggregate token usage across all responses in this conversation. Absent while `status` is `in_progress` and populated after successful `completed` finalization; it may be absent when `status` is `failed`, and values are not guaranteed to be reported incrementally.")
  usage?: OpenAI.RealtimeResponseUsage;

  @doc("The terminal error that prevented persistence finalization. Present only when `status` is `failed`.")
  last_error?: ApiError;
}

// ---------------------------------------------------------------------------
// Shared voice response audio
// ---------------------------------------------------------------------------
//
// Live WebSocket events and persisted responses use the same flat output projection so provider and
// locale extensions stay aligned with the OpenAI-compatible voice and format fields.

@doc("The flat response audio-output projection, with optional `voice`, `voice_type`, `voice_locale`, and `format` fields.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponseAudioOutput {
  @doc("The voice name used for the response's audio output.")
  voice?: string;

  @doc("The extensible provider/type of the voice used for the response's audio output.")
  voice_type?: string;

  @doc("The BCP-47 locale of the voice used for the response's audio output.")
  voice_locale?: string;

  @doc("The audio format used for the response's audio output.")
  format?: OpenAI.RealtimeAudioFormats;
}

@doc("Audio configuration for a response. Follows the OpenAI Realtime GA `audio` object shape.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponseAudio {
  @doc("The audio output configuration used for the response.")
  output?: VoiceResponseAudioOutput;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the shared OpenAI response contract while the persisted projection replaces audio, output, and metadata."
@doc("""
  A persisted voice response representing one model inference turn within a conversation. In list results the
  `output` projection may be omitted; retrieve the
  full response (`GET .../responses/{response_id}`) or the paged response-items route
  (`GET .../responses/{response_id}/items`) for its output items. `created_at`/`completed_at` are Foundry
  durable ordering extensions.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceResponse extends OmitProperties<
  OpenAI.RealtimeResponse,
  "audio" | "output" | "metadata"
> {
  @doc("The unique id of the response.")
  id: string;

  @doc("The output items produced by the response. May be omitted in list results; retrieve the full response (GET .../responses/{response_id}) or use the paged response-items route (GET .../responses/{response_id}/items) for its output items. Each item's `response_id` also links it back to this response in the conversation-level items list.")
  output?: VoiceConversationItem[];

  @doc("The id of the conversation this response belongs to.")
  conversation_id: string;

  @doc("The audio configuration used for the response, including the voice and audio format used for output.")
  audio?: VoiceResponseAudio;

  @doc("A set of key-value pairs attached to the response.")
  metadata?: Record<string>;

  @doc("The sampling temperature used for the response.")
  temperature?: float32;

  @doc("The Unix timestamp (in seconds) for when the response was created.")
  created_at?: FoundryTimestamp;

  @doc("The Unix timestamp (in seconds) for when the response completed.")
  completed_at?: FoundryTimestamp;
}

// Message content parts reuse OpenAI's Realtime message content models directly (per-role, inline
// `text`/`audio`/`image_url`/`transcript`/`detail` fields, matching the OpenAI GA wire format exactly,
// including base64 inline audio), already available in this program via
// ./src/openai/responses/main.tsp -> @azure-tools/openai-typespec's realtime models.tsp:
//   - OpenAI.RealtimeConversationItemMessageSystemContent (system: input_text only)
//   - OpenAI.RealtimeConversationItemMessageUserContent (user: input_text | input_audio | input_image)
//   - OpenAI.RealtimeConversationItemMessageAssistantContent (assistant: output_text | output_audio)
// See the three role variants (VoiceSystemMessageItem, VoiceUserMessageItem, VoiceAssistantMessageItem)
// below, each of which extends its OpenAI role-specific message model directly.

// ---------------------------------------------------------------------------
// Conversation items — OpenAI Realtime fields with Foundry persistence data
// ---------------------------------------------------------------------------

@doc("The type of a persisted voice conversation item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceConversationItemType {
  string,

  @doc("A message item.")
  message: "message",

  @doc("A function-call request item.")
  function_call: "function_call",

  @doc("A function-call output item.")
  function_call_output: "function_call_output",

  @doc("An MCP list-tools item.")
  mcp_list_tools: "mcp_list_tools",

  @doc("An MCP call item.")
  mcp_call: "mcp_call",

  @doc("An MCP approval request item.")
  mcp_approval_request: "mcp_approval_request",

  @doc("An MCP approval response item.")
  mcp_approval_response: "mcp_approval_response",
}

@doc("A persisted item in a voice conversation.")
@discriminator("type")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceConversationItem {
  @doc("The type of the conversation item.")
  type: VoiceConversationItemType;

  @doc("The Unix timestamp (in seconds) for when the item was persisted.")
  created_at?: FoundryTimestamp;

  @doc("The id of the response that produced this item, when applicable.")
  response_id?: string;
}

@doc("A persisted message item in a voice conversation.")
@discriminator("role")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMessageItem extends VoiceConversationItem {
  type: VoiceConversationItemType.message;

  @doc("The role of the message sender.")
  role: OpenAI.RealtimeConversationItemMessageType;
}

@doc("A system message item. Only `input_text` content is valid for system messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceSystemMessageItem extends VoiceMessageItem {
  ...OmitProperties<
    OpenAI.RealtimeConversationItemMessageSystem,
    "type" | "role"
  >;
  role: OpenAI.RealtimeConversationItemMessageType.system;
}

@doc("A user message item. `input_text`, `input_audio`, and `input_image` content are valid for user messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceUserMessageItem extends VoiceMessageItem {
  ...OmitProperties<
    OpenAI.RealtimeConversationItemMessageUser,
    "type" | "role"
  >;
  role: OpenAI.RealtimeConversationItemMessageType.user;
}

@doc("An assistant message item. Only `output_text` and `output_audio` content are valid for assistant messages.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAssistantMessageItem extends VoiceMessageItem {
  ...OmitProperties<
    OpenAI.RealtimeConversationItemMessageAssistant,
    "type" | "role"
  >;
  role: OpenAI.RealtimeConversationItemMessageType.assistant;
}

@doc("A function call request item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceFunctionCallItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeConversationItemFunctionCall, "type">;
  type: VoiceConversationItemType.function_call;
}

@doc("A function call output item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceFunctionCallOutputItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeConversationItemFunctionCallOutput, "type">;
  type: VoiceConversationItemType.function_call_output;

  @doc("The name of the function that was called. A Foundry extension: OpenAI's function_call_output does not carry the function name, only `call_id`.")
  name?: string;
}

@doc("An MCP list-tools item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpListToolsItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPListTools, "type">;
  type: VoiceConversationItemType.mcp_list_tools;
}

@doc("An MCP call item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpCallItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPToolCall, "type">;
  type: VoiceConversationItemType.mcp_call;
}

@doc("An MCP approval request item.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpApprovalRequestItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPApprovalRequest, "type">;
  type: VoiceConversationItemType.mcp_approval_request;
}

@doc("An MCP approval response item (client-created).")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceMcpApprovalResponseItem extends VoiceConversationItem {
  ...OmitProperties<OpenAI.RealtimeMCPApprovalResponse, "type">;
  type: VoiceConversationItemType.mcp_approval_response;
}

// ---------------------------------------------------------------------------
// Audio streaming
// ---------------------------------------------------------------------------

@doc("A voice-audio participant role. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioRole {
  string,

  @doc("Audio produced by the user.")
  user: "user",

  @doc("Audio produced by the agent.")
  agent: "agent",
}

@doc("An audio container format. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioContainerFormat {
  string,

  @doc("Waveform Audio File Format.")
  wav: "wav",
}

@doc("An audio codec. Additional values may be added over time.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
union VoiceAudioCodec {
  string,

  @doc("16-bit pulse-code modulation.")
  pcm16: "pcm16",

  @doc("G.711 mu-law.")
  pcmu: "pcmu",

  @doc("G.711 A-law.")
  pcma: "pcma",
}

#suppress "@azure-tools/typespec-azure-core/known-encoding" "The existing voice recording contract requires integer-millisecond durations."
@doc("A duration encoded as an integer number of milliseconds.")
@encode(DurationKnownEncoding.milliseconds, int32)
scalar VoiceDurationMilliseconds extends duration;

@doc("""
  Metadata for a single conversation item's audio segment. For bring-your-own-storage (BYOS), the response includes
  `blob_uri`, a direct customer-storage URI without a SAS token, that the customer accesses with their own
  credentials. For Foundry-managed storage, `blob_uri` is absent and the bytes are streamed through the item's
  `/audio/content` route.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceItemAudioResponse {
  @doc("The id of the conversation the item belongs to.")
  conversation_id: string;

  @doc("The id of the item this audio belongs to.")
  item_id: string;

  @doc("The role the audio belongs to.")
  role?: VoiceAudioRole;

  @doc("The container format of the audio.")
  format?: VoiceAudioContainerFormat;

  @doc("The audio codec.")
  codec?: VoiceAudioCodec;

  @doc("The sample rate in Hz.")
  sample_rate?: int32;

  @doc("The number of audio channels.")
  channels?: int32;

  @doc("The offset from the session start at which this segment begins.")
  start_offset_ms?: VoiceDurationMilliseconds;

  @doc("The duration of the audio segment.")
  duration_ms?: VoiceDurationMilliseconds;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the item's `/audio/content` route instead.")
  blob_uri?: url;
}

@doc("A streamed WAV (`audio/wav`) audio response. The bytes are streamed through the service; no SAS URL is returned.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceAudioStreamResponse {
  @doc("The content type of the streamed audio.")
  @header("Content-Type")
  contentType: "audio/wav";

  @doc("The WAV audio bytes.")
  @body
  content: bytes;
}

@doc("The role assigned to each channel of a merged stereo voice recording.")
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceRecordingChannelLayout {
  @doc("The role carried on the left channel. Always `user`.")
  left: "user";

  @doc("The role carried on the right channel. Always `agent`.")
  right: "agent";
}

@doc("""
  Metadata for the merged, whole-call stereo recording of a voice conversation (user audio on the left channel,
  agent audio on the right). Built once from the per-turn segments after the session ends and durably cached.
  The common metadata (format, sample rate, channels, channel layout, duration) is returned for both
  Foundry-managed and bring-your-own-storage (BYOS) recordings. For BYOS the response also includes `blob_uri`,
  the URI of the recording in the customer's own storage (no SAS token), which the customer downloads using their
  own storage credentials. For Foundry-managed storage `blob_uri` is absent and the bytes are streamed via the
  `/audio/content` route instead.
  """)
@extension("x-ms-foundry-meta", VoiceAgentRequiredPreview)
model VoiceRecordingResponse {
  @doc("The id of the conversation this recording belongs to.")
  conversation_id: string;

  @doc("The container format of the recording.")
  format: VoiceAudioContainerFormat;

  @doc("The sample rate of the recording in Hz, e.g. 24000.")
  sample_rate: int32;

  @doc("The number of audio channels. The merged recording is stereo (`2`).")
  channels: int32;

  @doc("The role assigned to each stereo channel.")
  channel_layout: VoiceRecordingChannelLayout;

  @doc("The total duration of the recording.")
  duration_ms: VoiceDurationMilliseconds;

  @doc("For bring-your-own-storage (BYOS) recordings only: the URI of the recording in the customer's own storage, without a SAS token. The customer downloads it using their own storage credentials. Absent for Foundry-managed storage, where the bytes are streamed via the `/audio/content` route instead.")
  blob_uri?: url;
}
```

### `protocol.tsp`

Canonical path: `specification/ai-foundry/data-plane/Foundry/src/voice-agents/protocol.tsp`

```typespec
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";
import "../openai/realtime/models.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Azure.AI.Projects;

// cspell:ignore kbps viseme

alias VoiceAgentClientEventUsage = Usage.input | Usage.json;
alias VoiceAgentServerEventUsage = Usage.output | Usage.json;
alias VoiceAgentWebSocketMessageUsage = Usage.input | Usage.output | Usage.json;

@doc("The WebSocket subprotocol supported by a voice-agent connection.")
union VoiceAgentWebSocketSubprotocol {
  realtime: "realtime",
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "A WebSocket message may be sent by either the client or the server."
@doc("A JSON text message exchanged over an established voice-agent WebSocket. Audio bytes are base64-encoded in JSON event fields.")
@usage(VoiceAgentWebSocketMessageUsage)
@oneOf
union VoiceAgentWebSocketMessage {
  client: VoiceAgentClientEvent,
  server: VoiceAgentServerEvent,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Client WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by a client over a voice-agent WebSocket.")
@usage(VoiceAgentClientEventUsage)
@oneOf
union VoiceAgentClientEvent {
  conversation_item_create: VoiceAgentClientEventConversationItemCreate,
  conversation_item_delete: VoiceAgentClientEventConversationItemDelete,
  conversation_item_retrieve: VoiceAgentClientEventConversationItemRetrieve,
  conversation_item_truncate: VoiceAgentClientEventConversationItemTruncate,
  input_audio_buffer_append: VoiceAgentClientEventInputAudioBufferAppend,
  input_audio_buffer_clear: VoiceAgentClientEventInputAudioBufferClear,
  input_audio_buffer_commit: VoiceAgentClientEventInputAudioBufferCommit,
  output_audio_buffer_clear: VoiceAgentClientEventOutputAudioBufferClear,
  response_cancel: VoiceAgentClientEventResponseCancel,
  response_create: VoiceAgentClientEventResponseCreate,
  session_update: VoiceAgentClientEventSessionUpdate,
  session_avatar_connect: VoiceAgentClientEventSessionAvatarConnect,
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Server WebSocket messages are selected by their `type` property."
@doc("A stable v1 message sent by the service over a voice-agent WebSocket.")
@usage(VoiceAgentServerEventUsage)
@oneOf
union VoiceAgentServerEvent {
  conversation_item_added: VoiceAgentServerEventConversationItemAdded,
  conversation_item_created: VoiceAgentServerEventConversationItemCreated,
  conversation_item_deleted: VoiceAgentServerEventConversationItemDeleted,
  conversation_item_done: VoiceAgentServerEventConversationItemDone,
  conversation_item_input_audio_transcription_completed: VoiceAgentServerEventConversationItemInputAudioTranscriptionCompleted,
  conversation_item_input_audio_transcription_delta: VoiceAgentServerEventConversationItemInputAudioTranscriptionDelta,
  conversation_item_input_audio_transcription_failed: VoiceAgentServerEventConversationItemInputAudioTranscriptionFailed,
  conversation_item_input_audio_transcription_segment: VoiceAgentServerEventConversationItemInputAudioTranscriptionSegment,
  conversation_item_retrieved: VoiceAgentServerEventConversationItemRetrieved,
  conversation_item_truncated: VoiceAgentServerEventConversationItemTruncated,
  input_audio_buffer_cleared: VoiceAgentServerEventInputAudioBufferCleared,
  input_audio_buffer_committed: VoiceAgentServerEventInputAudioBufferCommitted,
  input_audio_buffer_speech_started: VoiceAgentServerEventInputAudioBufferSpeechStarted,
  input_audio_buffer_speech_stopped: VoiceAgentServerEventInputAudioBufferSpeechStopped,
  input_audio_buffer_timeout_triggered: VoiceAgentServerEventInputAudioBufferTimeoutTriggered,
  mcp_list_tools_completed: VoiceAgentServerEventMcpListToolsCompleted,
  mcp_list_tools_failed: VoiceAgentServerEventMcpListToolsFailed,
  mcp_list_tools_in_progress: VoiceAgentServerEventMcpListToolsInProgress,
  output_audio_buffer_cleared: VoiceAgentServerEventOutputAudioBufferCleared,
  rate_limits_updated: VoiceAgentServerEventRateLimitsUpdated,
  response_output_audio_delta: VoiceAgentServerEventResponseAudioDelta,
  response_output_audio_done: VoiceAgentServerEventResponseAudioDone,
  response_output_audio_transcript_delta: VoiceAgentServerEventResponseAudioTranscriptDelta,
  response_output_audio_transcript_done: VoiceAgentServerEventResponseAudioTranscriptDone,
  response_content_part_added: OpenAI.RealtimeServerEventResponseContentPartAdded,
  response_content_part_done: VoiceAgentServerEventResponseContentPartDone,
  response_created: VoiceAgentServerEventResponseCreated,
  response_done: VoiceAgentServerEventResponseDone,
  response_function_call_arguments_delta: VoiceAgentServerEventResponseFunctionCallArgumentsDelta,
  response_function_call_arguments_done: VoiceAgentServerEventResponseFunctionCallArgumentsDone,
  response_mcp_call_arguments_delta: VoiceAgentServerEventResponseMcpCallArgumentsDelta,
  response_mcp_call_arguments_done: VoiceAgentServerEventResponseMcpCallArgumentsDone,
  response_mcp_call_completed: VoiceAgentServerEventResponseMcpCallCompleted,
  response_mcp_call_failed: VoiceAgentServerEventResponseMcpCallFailed,
  response_mcp_call_in_progress: VoiceAgentServerEventResponseMcpCallInProgress,
  response_output_item_added: VoiceAgentServerEventResponseOutputItemAdded,
  response_output_item_done: VoiceAgentServerEventResponseOutputItemDone,
  response_output_text_delta: VoiceAgentServerEventResponseTextDelta,
  response_output_text_done: VoiceAgentServerEventResponseTextDone,
  session_created: VoiceAgentServerEventSessionCreated,
  session_updated: VoiceAgentServerEventSessionUpdated,
  error: OpenAI.RealtimeServerEventError,
  warning: VoiceAgentServerEventWarning,
  session_avatar_connecting: VoiceAgentServerEventSessionAvatarConnecting,
  session_avatar_switch_to_speaking: VoiceAgentServerEventSessionAvatarSwitchToSpeaking,
  session_avatar_switch_to_idle: VoiceAgentServerEventSessionAvatarSwitchToIdle,
  response_audio_timestamp_delta: VoiceAgentServerEventResponseAudioTimestampDelta,
  response_audio_timestamp_done: VoiceAgentServerEventResponseAudioTimestampDone,
  response_animation_blendshapes_delta: VoiceAgentServerEventResponseAnimationBlendshapesDelta,
  response_animation_blendshapes_done: VoiceAgentServerEventResponseAnimationBlendshapesDone,
  response_animation_viseme_delta: VoiceAgentServerEventResponseAnimationVisemeDelta,
  response_animation_viseme_done: VoiceAgentServerEventResponseAnimationVisemeDone,
  response_video_delta: VoiceAgentServerEventResponseVideoDelta,
}

@doc("An animation output produced by a voice-agent session.")
union VoiceAgentAnimationOutputType {
  blendshapes: "blendshapes",
  viseme_id: "viseme_id",
}

@doc("Animation settings for a voice-agent session.")
model VoiceAgentAnimationConfig {
  @doc("The animation model name.")
  model_name?: string = "default";

  @doc("The requested animation output kinds.")
  outputs?: VoiceAgentAnimationOutputType[] = #[
    VoiceAgentAnimationOutputType.blendshapes
  ];
}

@doc("An ICE server used for avatar WebRTC negotiation.")
model VoiceAgentAvatarIceServer {
  urls: url[];
  username?: string | null;

  @secret
  credential?: string | null;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "The session model is a wire-compatible specialization of the persisted avatar configuration and adds only runtime transport fields."
@doc("Avatar settings accepted by the stable voice-agent WebSocket contract.")
model VoiceAgentSessionAvatarConfig extends VoiceAvatarConfig {
  ice_servers?: VoiceAgentAvatarIceServer[] | null;
}

@doc("The stable realtime session settings accepted in a `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentSessionUpdateConfig {
  @doc("The session type. Always `realtime`.")
  type: "realtime";

  @doc("Instructions applied throughout the session.")
  instructions?: string;

  @doc("The sampling temperature for compatible cascaded pipelines.")
  @minValue(0)
  @maxValue(2)
  temperature?: float32;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches the service's integer-or-inf token limit."
  @doc("The maximum output-token count for one response.")
  max_output_tokens?: VoiceAgentMaxOutputTokens;

  @doc("The output modalities enabled for the session.")
  output_modalities?: VoiceOutputModality[];

  @doc("The input- and output-audio settings for the session.")
  audio?: VoiceAudioConfig;

  @doc("The avatar settings for the session.")
  avatar?: VoiceAgentSessionAvatarConfig;

  @doc("Animation settings for the session.")
  animation?: VoiceAgentAnimationConfig;

  @doc("Tools available to the session.")
  tools?: VoiceAgentTool[];

  @doc("Tool-selection behavior for the session.")
  tool_choice?: VoiceAgentToolChoice;

  @doc("Reasoning settings for compatible realtime models.")
  reasoning?: OpenAI.RealtimeReasoning;

  @doc("Whether the model may call multiple tools in parallel.")
  parallel_tool_calls?: boolean;

  @doc("Additional fields to include in service outputs.")
  include?: VoiceAgentSessionIncludeOption[];

  @doc("Up to 16 string key-value pairs attached to the session.")
  metadata?: Record<string>;

  @doc("Interim-response settings for latency and tool execution.")
  interim_response?: VoiceAgentInterimResponse;

  @doc("A proactive assistant greeting started after session configuration.")
  greeting?: VoiceGreetingConfig;
}

@doc("The effective stable realtime session settings returned by the voice-agent service.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentSessionResponseConfig {
  ...VoiceAgentSessionUpdateConfig;

  @doc("The object type. Always `realtime.session`.")
  object: "realtime.session";

  @doc("The session identifier.")
  id: string;

  @doc("The selected model.")
  `model`: string;

  @doc("The session expiration time as a Unix timestamp in seconds.")
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  expires_at?: utcDateTime | null;
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "The service request item spans OpenAI's disconnected message-role and item-type roots."
@doc("A conversation item accepted as inline response input.")
union VoiceAgentRequestConversationItem {
  OpenAI.RealtimeConversationItemMessageSystem,
  OpenAI.RealtimeConversationItemMessageUser,
  OpenAI.RealtimeConversationItemMessageAssistant,
  OpenAI.RealtimeConversationItemFunctionCall,
  OpenAI.RealtimeConversationItemFunctionCallOutput,
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Conversation item creation additionally accepts an MCP approval response."
@doc("A conversation item accepted by `conversation.item.create`.")
union VoiceAgentCreateConversationItem {
  VoiceAgentRequestConversationItem,
  OpenAI.RealtimeMCPApprovalResponse,
}

@doc("Parameters accepted by a voice-agent `response.create` event.")
model VoiceAgentResponseCreateParams {
  ...OmitProperties<
    OpenAI.RealtimeResponseCreateParams,
    "prompt" | "output_modalities" | "audio"
  >;

  @doc("Modalities that the response may return.")
  output_modalities?: VoiceOutputModality[];

  @doc("Response-specific audio settings.")
  audio?: PickProperties<VoiceAudioConfig, "output">;

  @doc("A pre-generated assistant message used to begin the response.")
  pre_generated_assistant_message?:
    | OpenAI.RealtimeConversationItemMessageAssistant
    | null;

  @doc("Interim-response settings for this response.")
  interim_response?: VoiceAgentInterimResponse | null;
}

@doc("A content part carried by a `response.content_part.*` server event.")
model VoiceAgentResponseEventContentPart {
  ...OpenAI.RealtimeServerEventResponseContentPartDonePart;

  @doc("The audio format, when this is an audio content part.")
  format?: VoiceAudioFormat;
}

#suppress "@azure-tools/typespec-autorest/union-unsupported" "Message items are selected by their `role` property."
@doc("A role-specific message item returned by the voice-agent runtime.")
@oneOf
union VoiceAgentResponseMessageItem {
  system: OpenAI.RealtimeConversationItemMessageSystem,
  user: OpenAI.RealtimeConversationItemMessageUser,
  assistant: OpenAI.RealtimeConversationItemMessageAssistant,
}

#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "The runtime response spans the OpenAI item roots plus Foundry tool output kinds."
@doc("An item returned in a voice-agent response or item event.")
union VoiceAgentResponseItem {
  VoiceAgentResponseMessageItem,
  VoiceFunctionCallItem,
  VoiceFunctionCallOutputItem,
  VoiceMcpListToolsItem,
  VoiceMcpCallItem,
  VoiceMcpApprovalRequestItem,
  VoiceMcpApprovalResponseItem,
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Inheritance preserves the upstream live response contract, including conversation_id, while replacing audio and output."
@doc("A live realtime response returned by the voice-agent service in both `response.created` and `response.done` events.")
model VoiceAgentRealtimeResponse extends OmitProperties<
  OpenAI.RealtimeResponse,
  "audio" | "output"
> {
  @doc("The audio configuration used by the live response, including flat voice provider, locale, and format fields under `output`.")
  audio?: VoiceResponseAudio;

  @doc("The items produced by the live response.")
  output?: VoiceAgentResponseItem[];
}

@doc("A time-stamped word in an input-audio transcription.")
model VoiceAgentTranscriptionWord {
  @doc("The transcribed word text.")
  text: string;

  @doc("The word offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: int32;

  @doc("The word duration in milliseconds.")
  duration_milliseconds: int32;
}

@doc("A transcribed phrase with timing information.")
model VoiceAgentTranscriptionPhrase {
  @doc("The phrase offset from the beginning of the audio, in milliseconds.")
  offset_milliseconds: int32;

  @doc("The phrase duration in milliseconds.")
  duration_milliseconds: int32;

  @doc("The transcribed phrase text.")
  text: string;

  @doc("Word-level timing details, when available.")
  words?: VoiceAgentTranscriptionWord[] | null;

  @doc("The detected locale.")
  locale?: string | null;

  @doc("The transcription confidence score.")
  confidence?: float32 | null;
}

@doc("The `conversation.item.create` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemCreate {
  ...OmitProperties<OpenAI.RealtimeClientEventConversationItemCreate, "item">;

  @doc("The conversation item to create.")
  item: VoiceAgentCreateConversationItem;
}

@doc("The `conversation.item.delete` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemDelete {
  ...OpenAI.RealtimeClientEventConversationItemDelete;
}

@doc("The `conversation.item.retrieve` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemRetrieve {
  ...OpenAI.RealtimeClientEventConversationItemRetrieve;
}

@doc("The `conversation.item.truncate` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventConversationItemTruncate {
  ...OpenAI.RealtimeClientEventConversationItemTruncate;
}

@doc("The `input_audio_buffer.append` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventInputAudioBufferAppend {
  ...OpenAI.RealtimeClientEventInputAudioBufferAppend;
}

@doc("The `input_audio_buffer.clear` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventInputAudioBufferClear {
  ...OpenAI.RealtimeClientEventInputAudioBufferClear;
}

@doc("The `input_audio_buffer.commit` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventInputAudioBufferCommit {
  ...OpenAI.RealtimeClientEventInputAudioBufferCommit;
}

@doc("The `output_audio_buffer.clear` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventOutputAudioBufferClear {
  ...OpenAI.RealtimeClientEventOutputAudioBufferClear;
}

@doc("The `response.cancel` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventResponseCancel {
  ...OpenAI.RealtimeClientEventResponseCancel;
}

@doc("The `response.create` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventResponseCreate {
  ...OmitProperties<OpenAI.RealtimeClientEventResponseCreate, "response">;

  @doc("Parameters for the new response.")
  response?: VoiceAgentResponseCreateParams;
}

@doc("The `session.update` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventSessionUpdate {
  ...OmitProperties<OpenAI.RealtimeClientEventSessionUpdate, "session">;

  @doc("The stable realtime session fields to update.")
  session: VoiceAgentSessionUpdateConfig;
}

@doc("The `conversation.item.added` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemAdded {
  ...OmitProperties<OpenAI.RealtimeServerEventConversationItemAdded, "item">;

  @doc("The item added to the conversation.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.created` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemCreated {
  ...OmitProperties<OpenAI.RealtimeServerEventConversationItemCreated, "item">;

  @doc("The created conversation item.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.deleted` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemDeleted {
  ...OpenAI.RealtimeServerEventConversationItemDeleted;
}

@doc("The `conversation.item.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemDone {
  ...OmitProperties<OpenAI.RealtimeServerEventConversationItemDone, "item">;

  @doc("The completed conversation item.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.input_audio_transcription.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionCompleted {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted;

  @doc("Phrase-level transcription timing and confidence details.")
  phrases?: VoiceAgentTranscriptionPhrase[] | null;
}

@doc("The `conversation.item.input_audio_transcription.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionDelta {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionDelta;
}

@doc("The `conversation.item.input_audio_transcription.failed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionFailed {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionFailed;
}

@doc("The `conversation.item.input_audio_transcription.segment` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemInputAudioTranscriptionSegment {
  ...OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionSegment;
}

@doc("The `conversation.item.retrieved` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemRetrieved {
  ...OmitProperties<
    OpenAI.RealtimeServerEventConversationItemRetrieved,
    "item"
  >;

  @doc("The retrieved conversation item.")
  item: VoiceAgentResponseItem;
}

@doc("The `conversation.item.truncated` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventConversationItemTruncated {
  ...OpenAI.RealtimeServerEventConversationItemTruncated;

  @doc("The assistant message after truncation, when the service returns the updated item.")
  item?: OpenAI.RealtimeConversationItemMessageAssistant;
}

@doc("The `input_audio_buffer.cleared` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferCleared {
  ...OpenAI.RealtimeServerEventInputAudioBufferCleared;
}

@doc("The `input_audio_buffer.committed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferCommitted {
  ...OpenAI.RealtimeServerEventInputAudioBufferCommitted;
}

@doc("The `input_audio_buffer.speech_started` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferSpeechStarted {
  ...OpenAI.RealtimeServerEventInputAudioBufferSpeechStarted;
}

@doc("The `input_audio_buffer.speech_stopped` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferSpeechStopped {
  ...OpenAI.RealtimeServerEventInputAudioBufferSpeechStopped;
}

@doc("The `input_audio_buffer.timeout_triggered` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventInputAudioBufferTimeoutTriggered {
  ...OpenAI.RealtimeServerEventInputAudioBufferTimeoutTriggered;
}

@doc("The `mcp_list_tools.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventMcpListToolsCompleted {
  ...OpenAI.RealtimeServerEventMCPListToolsCompleted;
}

@doc("The `mcp_list_tools.failed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventMcpListToolsFailed {
  ...OpenAI.RealtimeServerEventMCPListToolsFailed;
}

@doc("The `mcp_list_tools.in_progress` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventMcpListToolsInProgress {
  ...OpenAI.RealtimeServerEventMCPListToolsInProgress;
}

@doc("The `output_audio_buffer.cleared` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventOutputAudioBufferCleared {
  ...OpenAI.RealtimeServerEventOutputAudioBufferCleared;
}

@doc("The `rate_limits.updated` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventRateLimitsUpdated {
  ...OpenAI.RealtimeServerEventRateLimitsUpdated;
}

@doc("The `response.output_audio.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioDelta {
  ...OpenAI.RealtimeServerEventResponseAudioDelta;
}

@doc("The `response.output_audio.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioDone {
  ...OpenAI.RealtimeServerEventResponseAudioDone;
}

@doc("The `response.output_audio_transcript.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTranscriptDelta {
  ...OpenAI.RealtimeServerEventResponseAudioTranscriptDelta;
}

@doc("The `response.output_audio_transcript.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTranscriptDone {
  ...OpenAI.RealtimeServerEventResponseAudioTranscriptDone;
}

@doc("The `response.content_part.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseContentPartDone {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseContentPartDone, "part">;

  @doc("The content part that finished streaming.")
  part: VoiceAgentResponseEventContentPart;
}

@doc("The `response.created` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseCreated {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseCreated, "response">;

  @doc("The created voice-agent response.")
  response: VoiceAgentRealtimeResponse;
}

@doc("The `response.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseDone {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseDone, "response">;

  @doc("The completed voice-agent response.")
  response: VoiceAgentRealtimeResponse;
}

@doc("The `response.function_call_arguments.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseFunctionCallArgumentsDelta {
  ...OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDelta;
}

@doc("The `response.function_call_arguments.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseFunctionCallArgumentsDone {
  ...OpenAI.RealtimeServerEventResponseFunctionCallArgumentsDone;
}

@doc("The `response.mcp_call_arguments.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallArgumentsDelta {
  ...OpenAI.RealtimeServerEventResponseMCPCallArgumentsDelta;
}

@doc("The `response.mcp_call_arguments.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallArgumentsDone {
  ...OpenAI.RealtimeServerEventResponseMCPCallArgumentsDone;
}

@doc("The `response.mcp_call.completed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallCompleted {
  ...OpenAI.RealtimeServerEventResponseMCPCallCompleted;
}

@doc("The `response.mcp_call.failed` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallFailed {
  ...OpenAI.RealtimeServerEventResponseMCPCallFailed;
}

@doc("The `response.mcp_call.in_progress` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseMcpCallInProgress {
  ...OpenAI.RealtimeServerEventResponseMCPCallInProgress;
}

@doc("The `response.output_item.added` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseOutputItemAdded {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseOutputItemAdded, "item">;

  @doc("The output item that was added.")
  item: VoiceAgentResponseItem;
}

@doc("The `response.output_item.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseOutputItemDone {
  ...OmitProperties<OpenAI.RealtimeServerEventResponseOutputItemDone, "item">;

  @doc("The output item that finished streaming.")
  item: VoiceAgentResponseItem;
}

@doc("The `response.output_text.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseTextDelta {
  ...OpenAI.RealtimeServerEventResponseTextDelta;
}

@doc("The `response.output_text.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseTextDone {
  ...OpenAI.RealtimeServerEventResponseTextDone;
}

@doc("The `session.created` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionCreated {
  ...OmitProperties<OpenAI.RealtimeServerEventSessionCreated, "session">;

  @doc("The id of the persisted conversation. Only present when conversation persistence is enabled for the session.")
  conversation_id?: string;

  @doc("The initial effective voice-agent session configuration.")
  session: VoiceAgentSessionResponseConfig;
}

@doc("The `session.updated` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionUpdated {
  ...OmitProperties<OpenAI.RealtimeServerEventSessionUpdated, "session">;

  @doc("The effective voice-agent session configuration after the update.")
  session: VoiceAgentSessionResponseConfig;
}

@doc("The `session.avatar.connect` client event.")
@usage(VoiceAgentClientEventUsage)
model VoiceAgentClientEventSessionAvatarConnect {
  @doc("The event type. Always `session.avatar.connect`.")
  type: "session.avatar.connect";

  @doc("An optional client-generated event identifier.")
  event_id?: string;

  @doc("The client's SDP offer for avatar media negotiation.")
  client_sdp: string;
}

@doc("Details of a non-fatal warning.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWarningDetails {
  message: string;
  code?: string;
  param?: string;
}

@doc("The `warning` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventWarning {
  type: "warning";
  event_id: string;
  warning: VoiceAgentServerEventWarningDetails;
}

@doc("The `session.avatar.connecting` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarConnecting {
  type: "session.avatar.connecting";
  event_id: string;

  @doc("The server's SDP answer for avatar media negotiation.")
  server_sdp: string;
}

@doc("The `session.avatar.switch_to_speaking` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToSpeaking {
  type: "session.avatar.switch_to_speaking";
  event_id: string;
  turn_id?: string;
}

@doc("The `session.avatar.switch_to_idle` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventSessionAvatarSwitchToIdle {
  type: "session.avatar.switch_to_idle";
  event_id: string;
  turn_id?: string;
}

@doc("The `response.audio_timestamp.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDelta {
  type: "response.audio_timestamp.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  audio_duration_ms: int32;
  text: string;
  timestamp_type: "word";
}

@doc("The `response.audio_timestamp.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAudioTimestampDone {
  type: "response.audio_timestamp.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("The `response.animation_blendshapes.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationBlendshapesDelta {
  type: "response.animation_blendshapes.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;

  @doc("Animation frames as numeric blendshape weights.")
  frames: float32[][];

  @doc("The index of the first frame in this delta.")
  frame_index: int32;
}

@doc("The `response.animation_blendshapes.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationBlendshapesDone {
  type: "response.animation_blendshapes.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
}

@doc("The `response.animation_viseme.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDelta {
  type: "response.animation_viseme.delta";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
  audio_offset_ms: int32;
  viseme_id: int32;
}

@doc("The `response.animation_viseme.done` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseAnimationVisemeDone {
  type: "response.animation_viseme.done";
  event_id: string;
  response_id: string;
  item_id: string;
  output_index: int32;
  content_index: int32;
}

@doc("The `response.video.delta` server event.")
@usage(VoiceAgentServerEventUsage)
model VoiceAgentServerEventResponseVideoDelta {
  type: "response.video.delta";
  event_id: string;
  output_index: int32;
  codec: string;

  @doc("The base64-encoded video frame data.")
  delta: string;
}

@doc("The response that switches an HTTP connection to the voice-agent WebSocket protocol.")
model VoiceAgentWebSocketUpgradeResponse {
  @statusCode
  status_code: 101;

  @doc("The negotiated WebSocket subprotocol. Present only when the client requests `realtime`.")
  @header("Sec-WebSocket-Protocol")
  subprotocol?: VoiceAgentWebSocketSubprotocol;
}
```

### `routes.tsp`

Canonical path: `specification/ai-foundry/data-plane/Foundry/src/voice-agents/routes.tsp`

```typespec
import "../common/models.tsp";
import "../agents/models.tsp";
import "./models.tsp";
import "./protocol.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

const VoiceAgentConversationRequiredPreviews = #{
  required_previews: #[AgentDefinitionOptInKeys.voice_agents_v1_preview],
};

/**
 * Establishes a service-terminated WebSocket for a voice-agent session. The service applies the persisted
 * agent definition, resolves configured tools, sends the initial session configuration, and then exchanges
 * OpenAI Realtime GA JSON events with the client. Audio bytes are base64-encoded in JSON event fields.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "A WebSocket protocol upgrade does not match a standard resource operation template."
@tag("Voice Agent WebSocket")
interface VoiceAgentWebSocket {
  /**
   * Connects to a voice agent over WebSocket. The client must send an HTTP GET with `Upgrade: websocket`
   * headers. The optional `realtime` subprotocol is the only accepted subprotocol value.
   *
   * If the target agent is disabled, the HTTP WebSocket handshake fails before the `101 Switching Protocols`
   * upgrade. The service returns `409 Conflict` using the shared Foundry `ApiErrorResponse` shape with
   * `error.code = agent_disabled`. This failure is terminal until the caller enables the agent.
   */
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "A successful WebSocket 101 protocol switch has no HTTP entity body; messages begin as WebSocket frames after the upgrade."
  @summary("Connect to a voice agent")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice")
  connectVoiceAgent is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the voice agent. */
      @path agent_name: string;

      /** An optional identifier used to correlate the voice session. */
      @query agent_session_id?: string;

      /**
       * Whether to persist the conversation created by this WebSocket session. If omitted, the service honors the
       * persisted voice agent definition's configured `store` value. If supplied, this value overrides the
       * definition's `store` setting for this session only.
       */
      @query store?: boolean;

      /** Selects a specific version of the voice agent for this session. */
      @query("x-agent-version-override") agent_version_override?: string;

      /** The requested WebSocket subprotocol. Omit this header or request exactly `realtime`. */
      @header("Sec-WebSocket-Protocol")
      websocket_subprotocol?: VoiceAgentWebSocketSubprotocol;

      /** A JSON object that maps structured-input names to their values for this session. */
      @header("x-ms-voice-structured-inputs") structured_inputs?: string;
    },
    VoiceAgentWebSocketUpgradeResponse
  >;
}

/**
 * Read-only, endpoint-scoped retrieval of the conversations, responses, transcript items, per-turn
 * metrics, and audio recorded by a voice agent. For a `voice` agent, the service is the sole writer of
 * responses and items, so only
 * reads plus a cascading conversation delete are exposed — there are no response/item create, update, or
 * delete routes. All persistence is governed by the definition's `store` flag: when `store = false` (the
 * default) nothing is persisted, so these routes return `404`. The merged-recording routes additionally
 * require the session to have ended and return `409` while it is still in progress.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The endpoint-scoped, read-only voice conversation projection and its nested response, item, and audio routes do not match a standard resource operation template."
@tag("Agent Conversations")
interface AgentEndpointConversations {
  /**
   * Returns the conversations persisted for the specified voice agent endpoint.
   * Conversations are present only when the agent definition has `store = true`.
   */
  @summary("List voice agent conversations")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversations is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceConversation>
  >;

  /**
   * Retrieves a single conversation recorded for the specified voice agent endpoint by its id.
   * Returns `404` when the conversation was not persisted (`store = false`) or does not exist.
   */
  @summary("Get a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversation is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to retrieve. */
      @path conversation_id: string;
    },
    VoiceConversation
  >;

  /**
   * Deletes a conversation and all of its stored data — responses, items, and any audio (cascade). This is
   * the customer's explicit data-deletion control for voice conversations.
   */
  @summary("Delete a voice agent conversation")
  @delete
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  deleteAgentConversation is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation to delete. */
      @path conversation_id: string;
    },
    NoContentResponse
  >;

  /**
   * Returns a paged collection of the responses (model inference turns) recorded for the specified
   * conversation. The per-response `output` projection may be omitted here; use the response-items route
   * for the canonical paged output. Returns `404` when the conversation was not persisted (`store = false`).
   */
  @summary("List responses in a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversationResponses is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose responses are listed. */
      @path conversation_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceResponse>
  >;

  /**
   * Retrieves a single response from the specified conversation by its id, including its `output` items,
   * `usage`, and status. Returns `404` when the conversation or response was not persisted (`store = false`).
   */
  @summary("Get a voice agent conversation response")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses/{response_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationResponse is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the response. */
      @path conversation_id: string;

      /** The id of the response to retrieve. */
      @path response_id: string;
    },
    VoiceResponse
  >;

  /**
   * Returns a paged collection of the output items produced by a specific response (the response's output
   * projection). For the complete ordered conversation history — including user input and client-created
   * tool outputs — use the conversation items route instead. Returns `404` when the conversation or
   * response was not persisted (`store = false`).
   */
  @summary("List items produced by a voice agent conversation response")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/responses/{response_id}/items")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversationResponseItems is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the response. */
      @path conversation_id: string;

      /** The id of the response whose output items are listed. */
      @path response_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceConversationItem>
  >;

  /**
   * Returns a paged collection of items — the complete ordered conversation history, including user input,
   * assistant output, and client-created tool outputs (transcripts + tool events). Returns `404` when the
   * conversation was not persisted (`store = false`).
   */
  @summary("List items in a voice agent conversation")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items")
  @list
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  listAgentConversationItems is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose items are listed. */
      @path conversation_id: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<VoiceConversationItem>
  >;

  /**
   * Retrieves a single item from the specified conversation by its id, including its transcript. An
   * `input_audio`/`output_audio` content part indicates that audio is available for the item; the canonical per-item
   * audio metadata is the `/items/{item_id}/audio` resource, and the bytes are streamed by
   * `/items/{item_id}/audio/content`. Returns `404` when the conversation or item was not persisted
   * (`store = false`).
   */
  @summary("Get a voice agent conversation item")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationItem is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item to retrieve. */
      @path item_id: string;
    },
    VoiceConversationItem
  >;

  /**
   * Returns metadata for a single conversation item's audio segment, including the common playback facts
   * (role, format/codec, sample rate, channels, offset, duration) for both Foundry-managed and
   * bring-your-own-storage (BYOS) recordings; for BYOS the response additionally includes `blob_uri`, the URI
   * of the recording in the customer's own storage (no SAS) that the customer downloads with their own credentials.
   * Requires the conversation to have persisted audio (`store = true`); returns `404` when the conversation,
   * item, or its audio was not persisted.
   */
  @summary("Get a voice agent conversation item's audio metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationItemAudio is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item whose audio metadata is retrieved. */
      @path item_id: string;
    },
    VoiceItemAudioResponse
  >;

  /**
   * Streams a single conversation item's audio as a WAV (`audio/wav`) byte stream through the service (no SAS
   * URL). This route serves Foundry-managed storage only. For bring-your-own-storage (BYOS) recordings the
   * bytes are not proxied — the caller must download directly from customer storage using the `blob_uri`
   * returned by the item's `/audio` metadata route — so this route returns `409 Conflict` for BYOS recordings.
   * Returns `404` when the conversation, item, or its audio was not persisted (`store = false`).
   */
  @summary("Stream a voice agent conversation item's audio")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/items/{item_id}/audio/content")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationItemAudioContent is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation that contains the item. */
      @path conversation_id: string;

      /** The id of the conversation item whose audio is streamed. */
      @path item_id: string;
    },
    VoiceAudioStreamResponse
  >;

  /**
   * Returns metadata for the whole-call merged stereo recording (user audio on the left channel, agent audio
   * on the right). The common metadata (format, sample rate, channels, channel layout, duration) is returned
   * for both Foundry-managed and bring-your-own-storage (BYOS) recordings; for BYOS the response additionally
   * includes `blob_uri`, the URI of the recording in the customer's own storage (no SAS) that the customer downloads
   * with their own credentials. The recording is built once from the per-turn segments after persistence
   * finalization succeeds. While the conversation is `in_progress`, this route returns retriable `409 Conflict`
   * with `error.code = recording_not_ready` and a `Retry-After` header when retry guidance is available. When the
   * conversation is `failed`, it returns terminal `409 Conflict` with `error.code = recording_unavailable`.
   * For a `completed` conversation, metadata is available subject to the existing BYOS behavior. Requires the
   * conversation to have persisted audio (`store = true`); otherwise returns `404`.
   */
  @summary("Get a voice agent conversation's merged recording metadata")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationAudio is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose merged recording metadata is retrieved. */
      @path conversation_id: string;
    },
    VoiceRecordingResponse
  >;

  /**
   * Streams the whole-call merged stereo recording as a WAV (`audio/wav`) byte stream through the service
   * (no SAS URL). This route serves Foundry-managed storage only. For bring-your-own-storage (BYOS)
   * recordings the bytes are not proxied — the caller must download directly from customer storage using the
   * `blob_uri` returned by the metadata route — so this route returns `409 Conflict` for BYOS recordings.
   * While the conversation is `in_progress`, this route returns retriable `409 Conflict` with
   * `error.code = recording_not_ready` and a `Retry-After` header when retry guidance is available. When the
   * conversation is `failed`, it returns terminal `409 Conflict` with `error.code = recording_unavailable`.
   * For a `completed` conversation, content is available subject to the existing BYOS behavior. A conversation
   * without persisted audio (`store = false`) returns `404`.
   */
  @summary("Stream a voice agent conversation's merged recording")
  @get
  @route("/agents/{agent_name}/endpoint/protocols/voice/conversations/{conversation_id}/audio/content")
  @extension("x-ms-foundry-meta", VoiceAgentConversationRequiredPreviews)
  getAgentConversationAudioContent is FoundryDataPlaneRequiredPreviewOperation<
    AgentDefinitionOptInKeys.voice_agents_v1_preview,
    {
      /** The name of the agent. */
      @path agent_name: string;

      /** The id of the conversation whose merged recording is streamed. */
      @path conversation_id: string;
    },
    VoiceAudioStreamResponse
  >;
}
```
