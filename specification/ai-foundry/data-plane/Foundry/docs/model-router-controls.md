# Model Router controls (V1Preview)

<!-- cspell:ignore xhigh chatcmpl -->

This reference describes the public request and response shape for the Model Router preview on `POST /openai/v1/responses` and `POST /openai/v1/chat/completions`. Send `Foundry-Features: ModelRouterControls=V1Preview` on create requests using these controls. The preview header is an opt-in, not a new API version; without it, existing endpoint behavior applies and the new controls are not guaranteed to be enforced. These examples use raw HTTP. Public SDK support and the qualified model/revision, region, route, tool, and execution-mode matrix must be verified separately before advertising a particular combination.

## Requests

Both APIs accept the same optional `routing_config` object. Supply any subset of:

| Field              | Meaning                                                                                                                                                                                                                                                                                                                                   |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `mode`             | Routing mode: `balanced`, `cost`, or `quality`. Omission inherits the configured mode. Matching is case-insensitive; an unsupported value is invalid.                                                                                                                                                                                     |
| `models`           | Nonempty, unordered allowed set of serving model names _inside_ the Model Router deployment, not deployment URLs. Names are trimmed and matched case-insensitively; duplicates are removed. Every member must be eligible. Omission inherits the configured pool.                                                                         |
| `reasoning_effort` | Nonempty, unordered allowed set of exact labels `none`, `low`, `medium`, `high`, `xhigh`. Duplicates are removed; order is not priority. `none` means a qualified non-reasoning model, not an unspecified or disabled reasoning effort. Omission retains existing model/effort defaulting.                                                |
| `session_affinity` | Existing optional `mode: sticky` or `none` and optional opaque `session_id`. A valid body ID takes precedence over the existing `x-ms-session-id` header; otherwise existing validation and fallback apply. `none` disables lookup and updates without creating a new identity. Existing allowlisted affinity behavior remains unchanged. |

`{}` does not add a hard requirement. New controls, the routing object, and affinity mode cannot be null. Unsupported routing-owned property names do not enable a new control. The schema uses extensible string unions so future results can be read; that openness does **not** make unknown request labels supported. Model-name validity, allowed values, pool membership, original-request tool capabilities, and cross-field conflicts require service validation, not only JSON Schema validation.

Native scalar effort stays in `reasoning.effort` for Responses and `reasoning_effort` for Chat. Native `minimal` and `max` are not routing-set choices. An explicitly present routing allowed set conflicts with an **effective authored** native effort property, including an explicit null or a surviving saved/prompt-authored effort; identical values still conflict. A native default injected by an adapter is not authored intent. Responses `reasoning: null`, `{}`, or a summary without `effort` does not conflict. Native-only effort retains its existing non-filtering behavior.

Every effective native tool is a hard capability requirement for preview-enabled Model Router routing, even without new routing fields, when tools came from the caller or an existing saved configuration and even with `tool_choice: "none"`. A candidate must support _all_ original-API tools and the permitted effort together; native tool payloads, permissions, and unrelated native settings retain their original shapes and behavior. A requested subset with an unavailable member is rejected as a whole, not silently narrowed.

### Responses request: native effort and tool

```http
POST /openai/v1/responses HTTP/1.1
Host: example.services.ai.azure.com
Authorization: Bearer <token>
Content-Type: application/json
Foundry-Features: ModelRouterControls=V1Preview

{
  "model": "router-deployment",
  "input": "What is the weather in Paris?",
  "reasoning": {"effort": "high"},
  "tools": [{
    "type": "function",
    "name": "get_weather",
    "description": "Get weather for a city.",
    "parameters": {
      "type": "object",
      "properties": {"city": {"type": "string"}},
      "required": ["city"],
      "additionalProperties": false
    },
    "strict": true
  }],
  "routing_config": {"mode": "balanced", "models": ["gpt-5"]}
}
```

### Chat Completions request: native effort and tool

```http
POST /openai/v1/chat/completions HTTP/1.1
Host: example.services.ai.azure.com
Authorization: Bearer <token>
Content-Type: application/json
Foundry-Features: ModelRouterControls=V1Preview

{
  "model": "router-deployment",
  "messages": [{"role": "user", "content": "What is the weather in Paris?"}],
  "reasoning_effort": "high",
  "tools": [{
    "type": "function",
    "function": {
      "name": "get_weather",
      "description": "Get weather for a city.",
      "parameters": {
        "type": "object",
        "properties": {"city": {"type": "string"}},
        "required": ["city"],
        "additionalProperties": false
      },
      "strict": true
    }
  }],
  "routing_config": {"mode": "balanced", "models": ["gpt-5"]}
}
```

For **routing effort** on either API, remove the native effort property and use `"routing_config": {"reasoning_effort": ["medium", "high"]}`. A singleton `["medium"]` requires medium; `["none"]` requires an eligible non-reasoning route. These examples illustrate the wire shape; they do not certify that the named model and tool are qualified in a given deployment.

### Routing-effort requests: no native effort

```http
POST /openai/v1/responses HTTP/1.1
Host: example.services.ai.azure.com
Authorization: Bearer <token>
Content-Type: application/json
Foundry-Features: ModelRouterControls=V1Preview

{"model":"router-deployment","input":"Hello.","routing_config":{"reasoning_effort":["medium","high"]}}
```

```http
POST /openai/v1/chat/completions HTTP/1.1
Host: example.services.ai.azure.com
Authorization: Bearer <token>
Content-Type: application/json
Foundry-Features: ModelRouterControls=V1Preview

{"model":"router-deployment","messages":[{"role":"user","content":"Hello."}],"routing_config":{"reasoning_effort":["medium","high"]}}
```

## Errors and execution boundaries

Both endpoints use the existing `{ "error": { "code", "message", "type"?, "param"? } }` envelope. For new preview validation errors, the service should return a safe, non-null code and a `param` naming the **effective caller-API request** property: `routing_config.mode`, `routing_config.models`, `routing_config.reasoning_effort` (or its zero-based invalid element), `routing_config` for a joint conflict, and `tools` for a collective tool requirement. That effective field may originate from a saved configuration rather than the literal request body. The proposed code/status/type and exact per-endpoint parameter mapping require endpoint-owner confirmation before publication as a finalized error-code reference; do not program against a proposed new code. Existing native and authentication/authorization errors retain their own status semantics.

For example, sending both Responses `reasoning.effort` and `routing_config.reasoning_effort`, or both Chat `reasoning_effort` and `routing_config.reasoning_effort`, is invalid. An illustrative, **not yet endpoint-confirmed**, Responses error is:

```http
HTTP/1.1 400 Bad Request
Content-Type: application/json

{"error":{"type":"invalid_request_error","code":"conflicting_reasoning_effort","param":"routing_config.reasoning_effort","message":"Do not supply reasoning.effort together with routing_config.reasoning_effort."}}
```

For Chat the equivalent conflicting input is `"reasoning_effort": "medium"` together with `"routing_config": {"reasoning_effort": ["medium"]}`; equality does not remove the conflict. `error.param` remains the routing effort path, while the safe message names Chat's native `reasoning_effort` path.

Only qualified foreground routes can promise pre-acceptance validation and a final result. Preview-enabled Model Router requests with an explicitly present new control **or** nonempty effective tools need execution-mode admission; a header alone, empty config, affinity alone, or native effort alone does not add this new restriction. Unsupported background, continuation, or concurrent combinations must not accept and ignore hard requirements. No qualification or deployed runtime enforcement is implied by these schemas.

## Results and streams

Successful routed results retain their native Chat/Responses output, usage, tools, status, and error fields. When truthful final routing information is available, `model` is the **actual serving model** and `model_selection_details.model_router_details` contains the existing required applied `mode` and ordered `routing_trace`. Optional `reasoning_effort` is only a known selected value from an explicit routing allowed set, never a native or injected default; optional nonempty `decision_id` names the selected logical routing decision including fallback attempts. Existing optional `session_affinity` reports the actual mode, source, and model-based initialize/retain/switch outcome; a change of effort on the same associated model is retain. These scalars describe the last client-output-producing inference in established execution order, not a later internal call. Do not infer a default from an omitted field.

An illustrative fragment in either native JSON result is:

```json
{
  "model": "gpt-5",
  "model_selection_details": {
    "model_router_details": {
      "mode": "balanced",
      "reasoning_effort": "medium",
      "decision_id": "decision-42",
      "session_affinity": {
        "mode": "sticky",
        "source": "session_id_payload",
        "decision": "retain"
      },
      "routing_trace": [
        {
          "latency_ms": 12,
          "attempts": [{ "model": "gpt-5", "result": { "status": 200 } }]
        }
      ]
    }
  }
}
```

For Chat SSE, `stream: true` retains native chunks, all choices (`n > 1` included), deltas, finish reasons and `[DONE]`. Without `stream_options.include_usage`, final metadata is on the existing chunk that completes **all** requested choices. With usage requested, earlier chunks may carry `"usage": null`; the existing final usage chunk has `choices: []`, the usage object, and final metadata. No new chunk or event is introduced:

```text
data: {"id":"chatcmpl_42","object":"chat.completion.chunk","created":1792497600,"model":"gpt-5","choices":[{"index":0,"delta":{},"finish_reason":"stop"}],"usage":null}

data: {"id":"chatcmpl_42","object":"chat.completion.chunk","created":1792497600,"model":"gpt-5","choices":[{"index":1,"delta":{},"finish_reason":"length"}],"usage":null}

data: {"id":"chatcmpl_42","object":"chat.completion.chunk","created":1792497600,"model":"gpt-5","choices":[],"usage":{"prompt_tokens":10,"completion_tokens":8,"total_tokens":18},"model_selection_details":{"model_router_details":{"mode":"balanced","reasoning_effort":"medium","decision_id":"decision-42","routing_trace":[{"latency_ms":12,"attempts":[{"model":"gpt-5","result":{"status":200}}]}]}}}

data: [DONE]
```

Without usage, the last **all-choice** finishing chunk itself contains the wrapper, without an extra usage frame:

```text
data: {"id":"chatcmpl_43","object":"chat.completion.chunk","created":1792497600,"model":"gpt-5","choices":[{"index":0,"delta":{},"finish_reason":"stop"}]}

data: {"id":"chatcmpl_43","object":"chat.completion.chunk","created":1792497600,"model":"gpt-5","choices":[{"index":1,"delta":{},"finish_reason":"stop"}],"model_selection_details":{"model_router_details":{"mode":"balanced","reasoning_effort":"medium","decision_id":"decision-43","routing_trace":[{"latency_ms":12,"attempts":[{"model":"gpt-5","result":{"status":200}}]}]}}}

data: [DONE]
```

For Responses SSE, existing `response.created` and `response.in_progress` snapshots may omit final routing information; the native `response.completed` event's `response` carries the final wrapper when available. Interim item/content/tool events remain unchanged. An interrupted stream may lack terminal metadata; after SSE commitment an HTTP 400 cannot be sent retroactively. Native stream failures still apply.

```text
event: response.completed
data: {"type":"response.completed","sequence_number":8,"response":{"id":"resp_42","object":"response","created_at":1792497600,"status":"completed","model":"gpt-5","error":null,"incomplete_details":null,"output":[{"id":"msg_42","type":"message","role":"assistant","status":"completed","content":[{"type":"output_text","text":"Hello.","annotations":[]}]}],"instructions":null,"parallel_tool_calls":true,"agent_reference":null,"model_selection_details":{"model_router_details":{"mode":"balanced","reasoning_effort":"medium","decision_id":"decision-42","routing_trace":[{"output_id":"msg_42","latency_ms":12,"attempts":[{"model":"gpt-5","result":{"status":200}}]}]}}}}
```

GET/list, GET-stream, old records, and `store: false` share response schemas but **do not guarantee persistence or replay of the new effort/decision fields**. They may omit these ephemeral create/final-stream additions even when an earlier final event included them. Existing stored fields are not removed. Queued background acceptance is not a final routed result and does not promise a later delivery channel.

```http
GET /openai/v1/responses/resp_42 HTTP/1.1
Host: example.services.ai.azure.com
Authorization: Bearer <token>

GET /openai/v1/responses HTTP/1.1
Host: example.services.ai.azure.com
Authorization: Bearer <token>
```
