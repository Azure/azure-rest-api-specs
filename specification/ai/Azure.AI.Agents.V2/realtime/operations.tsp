import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Create a Realtime client secret with an associated session configuration. */
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
