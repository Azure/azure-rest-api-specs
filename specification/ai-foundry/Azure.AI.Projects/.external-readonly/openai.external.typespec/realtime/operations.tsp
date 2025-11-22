import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/**Create a new Realtime API call over WebRTC and receive the SDP answer needed
to complete the peer connection.*/
#suppress "@azure-tools/typespec-azure-core/byos" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create call")
@post
@route("/realtime/calls")
@extension(
  "x-oaiMeta",
  #{
    name: "Create call",
    group: "realtime",
    returns: "Returns `201 Created` with the SDP answer in the response body. The\n`Location` response header includes the call ID for follow-up requests,\ne.g., establishing a monitoring WebSocket or hanging up the call.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/calls \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -F \"sdp=<offer.sdp;type=application/sdp\" \\\n  -F 'session={\"type\":\"realtime\",\"model\":\"gpt-realtime\"};type=application/json'",
      },
      response: "v=0\no=- 4227147428 1719357865 IN IP4 127.0.0.1\ns=-\nc=IN IP4 0.0.0.0\nt=0 0\na=group:BUNDLE 0 1\na=msid-semantic:WMS *\na=fingerprint:sha-256 CA:92:52:51:B4:91:3B:34:DD:9C:0B:FB:76:19:7E:3B:F1:21:0F:32:2C:38:01:72:5D:3F:78:C7:5F:8B:C7:36\nm=audio 9 UDP/TLS/RTP/SAVPF 111 0 8\na=mid:0\na=ice-ufrag:kZ2qkHXX/u11\na=ice-pwd:uoD16Di5OGx3VbqgA3ymjEQV2kwiOjw6\na=setup:active\na=rtcp-mux\na=rtpmap:111 opus/48000/2\na=candidate:993865896 1 udp 2130706431 4.155.146.196 3478 typ host ufrag kZ2qkHXX/u11\na=candidate:1432411780 1 tcp 1671430143 4.155.146.196 443 typ host tcptype passive ufrag kZ2qkHXX/u11\nm=application 9 UDP/DTLS/SCTP webrtc-datachannel\na=mid:1\na=sctp-port:5000",
    },
  }
)
@tag("Realtime")
op `create-realtime-call`(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @header
  contentType: "multipart/form-data",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @multipartBody
  body: RealtimeCallCreateRequest,
): CreateRealtimeCallResponse;

/**Accept an incoming SIP call and configure the realtime session that will
handle it.*/
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Accept call")
@post
@route("/realtime/calls/{call_id}/accept")
@extension(
  "x-oaiMeta",
  #{
    name: "Accept call",
    group: "realtime-calls",
    returns: "Returns `200 OK` once OpenAI starts ringing the SIP leg with the supplied\nsession configuration.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/accept \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n        \"type\": \"realtime\",\n        \"model\": \"gpt-realtime\",\n        \"instructions\": \"You are Alex, a friendly concierge for Example Corp.\",\n      }'",
      },
    },
  }
)
@tag("Realtime")
op `accept-realtime-call`(
  /**The identifier for the call provided in the
[`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook_events/realtime/call/incoming)
webhook.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  call_id: string,

  /** Session configuration to apply before the caller is bridged to the model. */
  @body
  body: RealtimeSessionCreateRequestGA,
): OkResponse;

/**End an active Realtime API call, whether it was initiated over SIP or
WebRTC.*/
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Hang up call")
@post
@route("/realtime/calls/{call_id}/hangup")
@extension(
  "x-oaiMeta",
  #{
    name: "Hang up call",
    group: "realtime-calls",
    returns: "Returns `200 OK` when OpenAI begins terminating the realtime call.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/hangup \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"",
      },
    },
  }
)
@tag("Realtime")
op `hangup-realtime-call`(
  /**The identifier for the call. For SIP calls, use the value provided in the
[`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook_events/realtime/call/incoming)
webhook. For WebRTC sessions, reuse the call ID returned in the `Location`
header when creating the call with
[`POST /v1/realtime/calls`](https://platform.openai.com/docs/api-reference/realtime/create-call).*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  call_id: string,
): OkResponse;

/** Transfer an active SIP call to a new destination using the SIP REFER verb. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Refer call")
@post
@route("/realtime/calls/{call_id}/refer")
@extension(
  "x-oaiMeta",
  #{
    name: "Refer call",
    group: "realtime-calls",
    returns: "Returns `200 OK` once the REFER is handed off to your SIP provider.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/refer \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\"target_uri\": \"tel:+14155550123\"}'",
      },
    },
  }
)
@tag("Realtime")
op `refer-realtime-call`(
  /**The identifier for the call provided in the
[`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook_events/realtime/call/incoming)
webhook.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  call_id: string,

  /** Destination URI for the REFER request. */
  @body
  body: RealtimeCallReferRequest,
): OkResponse;

/** Decline an incoming SIP call by returning a SIP status code to the caller. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Reject call")
@post
@route("/realtime/calls/{call_id}/reject")
@extension(
  "x-oaiMeta",
  #{
    name: "Reject call",
    group: "realtime-calls",
    returns: "Returns `200 OK` after OpenAI sends the SIP status code to the caller.",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/reject \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\"status_code\": 486}'",
      },
    },
  }
)
@tag("Realtime")
op `reject-realtime-call`(
  /**The identifier for the call provided in the
[`realtime.call.incoming`](https://platform.openai.com/docs/api-reference/webhook_events/realtime/call/incoming)
webhook.*/
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  call_id: string,

  /**Provide an optional SIP status code. When omitted the API responds with
`603 Decline`.*/
  @body
  body: RealtimeCallRejectRequest,
): OkResponse;

/** Create a Realtime client secret with an associated session configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create client secret")
@post
@route("/realtime/client_secrets")
@extension(
  "x-oaiMeta",
  #{
    name: "Create client secret",
    group: "realtime",
    returns: "The created client secret and the effective session object. The client secret is a string that looks like `ek_1234`.",
    examples: #{
      response: "{\n  \"value\": \"ek_68af296e8e408191a1120ab6383263c2\",\n  \"expires_at\": 1756310470,\n  \"session\": {\n    \"type\": \"realtime\",\n    \"object\": \"realtime.session\",\n    \"id\": \"sess_C9CiUVUzUzYIssh3ELY1d\",\n    \"model\": \"gpt-realtime\",\n    \"output_modalities\": [\n      \"audio\"\n    ],\n    \"instructions\": \"You are a friendly assistant.\",\n    \"tools\": [],\n    \"tool_choice\": \"auto\",\n    \"max_output_tokens\": \"inf\",\n    \"tracing\": null,\n    \"truncation\": \"auto\",\n    \"prompt\": null,\n    \"expires_at\": 0,\n    \"audio\": {\n      \"input\": {\n        \"format\": {\n          \"type\": \"audio/pcm\",\n          \"rate\": 24000\n        },\n        \"transcription\": null,\n        \"noise_reduction\": null,\n        \"turn_detection\": {\n          \"type\": \"server_vad\",\n        }\n      },\n      \"output\": {\n        \"format\": {\n          \"type\": \"audio/pcm\",\n          \"rate\": 24000\n        },\n        \"voice\": \"alloy\",\n        \"speed\": 1.0\n      }\n    },\n    \"include\": null\n  }\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/client_secrets \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n    \"expires_after\": {\n      \"anchor\": \"created_at\",\n      \"seconds\": 600\n    },\n    \"session\": {\n      \"type\": \"realtime\",\n      \"model\": \"gpt-realtime\",\n      \"instructions\": \"You are a friendly assistant.\"\n    }\n  }'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst clientSecret = await client.realtime.clientSecrets.create();\n\nconsole.log(clientSecret.expires_at);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nclient_secret = client.realtime.client_secrets.create()\nprint(client_secret.expires_at)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/realtime\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  clientSecret, err := client.Realtime.ClientSecrets.New(context.TODO(), realtime.ClientSecretNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", clientSecret.ExpiresAt)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.realtime.clientsecrets.ClientSecretCreateParams;\nimport com.openai.models.realtime.clientsecrets.ClientSecretCreateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ClientSecretCreateResponse clientSecret = client.realtime().clientSecrets().create();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nclient_secret = openai.realtime.client_secrets.create\n\nputs(client_secret)",
      },
    },
  }
)
@tag("Realtime")
op `create-realtime-client-secret`(
  /** Create a client secret with the given session configuration. */
  @body
  body: RealtimeCreateClientSecretRequest,
): RealtimeCreateClientSecretResponse;

/**Create an ephemeral API token for use in client-side applications with the
Realtime API. Can be configured with the same session parameters as the
`session.update` client event.

It responds with a session object, plus a `client_secret` key which contains
a usable ephemeral API token that can be used to authenticate browser clients
for the Realtime API.*/
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create session")
@post
@route("/realtime/sessions")
@extension(
  "x-oaiMeta",
  #{
    name: "Create session",
    group: "realtime",
    returns: "The created Realtime session object, plus an ephemeral key",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/sessions \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n    \"model\": \"gpt-realtime\",\n    \"modalities\": [\"audio\", \"text\"],\n    \"instructions\": \"You are a friendly assistant.\"\n  }'\n",
      },
      response: "{\n  \"id\": \"sess_001\",\n  \"object\": \"realtime.session\",\n  \"model\": \"gpt-realtime-2025-08-25\",\n  \"modalities\": [\"audio\", \"text\"],\n  \"instructions\": \"You are a friendly assistant.\",\n  \"voice\": \"alloy\",\n  \"input_audio_format\": \"pcm16\",\n  \"output_audio_format\": \"pcm16\",\n  \"input_audio_transcription\": {\n      \"model\": \"whisper-1\"\n  },\n  \"turn_detection\": null,\n  \"tools\": [],\n  \"tool_choice\": \"none\",\n  \"temperature\": 0.7,\n  \"max_response_output_tokens\": 200,\n  \"speed\": 1.1,\n  \"tracing\": \"auto\",\n  \"client_secret\": {\n    \"value\": \"ek_abc123\", \n    \"expires_at\": 1234567890\n  }\n}\n",
    },
  }
)
@tag("Realtime")
op `create-realtime-session`(
  /** Create an ephemeral API key with the given session configuration. */
  @body
  body: RealtimeSessionCreateRequest,
): RealtimeSessionCreateResponse;

/**Create an ephemeral API token for use in client-side applications with the
Realtime API specifically for realtime transcriptions.
Can be configured with the same session parameters as the `transcription_session.update` client event.

It responds with a session object, plus a `client_secret` key which contains
a usable ephemeral API token that can be used to authenticate browser clients
for the Realtime API.*/
#suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create transcription session")
@post
@route("/realtime/transcription_sessions")
@extension(
  "x-oaiMeta",
  #{
    name: "Create transcription session",
    group: "realtime",
    returns: "The created [Realtime transcription session object](https://platform.openai.com/docs/api-reference/realtime-sessions/transcription_session_object), plus an ephemeral key",
    examples: #{
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/realtime/transcription_sessions \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{}'\n",
      },
      response: "{\n  \"id\": \"sess_BBwZc7cFV3XizEyKGDCGL\",\n  \"object\": \"realtime.transcription_session\",\n  \"modalities\": [\"audio\", \"text\"],\n  \"turn_detection\": {\n    \"type\": \"server_vad\",\n    \"threshold\": 0.5,\n    \"prefix_padding_ms\": 300,\n    \"silence_duration_ms\": 200\n  },\n  \"input_audio_format\": \"pcm16\",\n  \"input_audio_transcription\": {\n    \"model\": \"gpt-4o-transcribe\",\n    \"language\": null,\n    \"prompt\": \"\"\n  },\n  \"client_secret\": null\n}\n",
    },
  }
)
@tag("Realtime")
op `create-realtime-transcription-session`(
  /** Create an ephemeral API key with the given session configuration. */
  @body
  body: RealtimeTranscriptionSessionCreateRequest,
): RealtimeTranscriptionSessionCreateResponse;
