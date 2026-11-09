# Voice-agent event schema export

The client and server unions in `src/voice-agents/protocol.tsp` are the source of
truth for the voice-agent WebSocket reference. Their
`x-foundry-event-direction` annotations identify the two event sets.

`tsp compile .` runs `emitters/voice-event-reference.mjs` after the existing REST
OpenAPI emitter. The event emitter uses the same OpenAPI projection and options
except that it sets `omit-unreachable-types` to `false`, then retains only the
two annotated unions and their transitive schema dependencies. This preserves
wire encodings such as Unix timestamps, integer-millisecond durations, and
base64 audio.

The generated artifact is `event-schemas/voice-agent-events.json`. Commit it
alongside its TypeSpec changes. Do not edit the artifact by hand. It contains
OpenAPI component schemas and no HTTP operations; the existing REST OpenAPI
output and unreachable-type setting remain unchanged.

Run the emitter's focused extraction checks from the repository root:

```sh
node --test specification/ai-foundry/data-plane/Foundry/emitters/voice-event-reference.test.mjs
```

The Foundry reference site's refresh automation consumes this artifact and the
REST OpenAPI from the same Git commit. OpenAI's client/server organization is a
presentation precedent, not a second source of event definitions.
