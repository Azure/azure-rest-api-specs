import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Realtime.`create-realtime-call`,
  "x-oaiMeta",
  #{
    name: "Create call",
    group: "realtime",
    returns: """
      Returns `201 Created` with the SDP answer in the response body. The
      `Location` response header includes the call ID for follow-up requests,
      e.g., establishing a monitoring WebSocket or hanging up the call.
      """,
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/calls \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -F "sdp=<offer.sdp;type=application/sdp" \\
            -F 'session={"type":"realtime","model":"gpt-realtime"};type=application/json'
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          call = client.realtime.calls.create(
              sdp="sdp",
          )
          print(call)
          content = call.read()
          print(content)
          """,
      },
      response: """
        v=0
        o=- 4227147428 1719357865 IN IP4 127.0.0.1
        s=-
        c=IN IP4 0.0.0.0
        t=0 0
        a=group:BUNDLE 0 1
        a=msid-semantic:WMS *
        a=fingerprint:sha-256 CA:92:52:51:B4:91:3B:34:DD:9C:0B:FB:76:19:7E:3B:F1:21:0F:32:2C:38:01:72:5D:3F:78:C7:5F:8B:C7:36
        m=audio 9 UDP/TLS/RTP/SAVPF 111 0 8
        a=mid:0
        a=ice-ufrag:kZ2qkHXX/u11
        a=ice-pwd:uoD16Di5OGx3VbqgA3ymjEQV2kwiOjw6
        a=setup:active
        a=rtcp-mux
        a=rtpmap:111 opus/48000/2
        a=candidate:993865896 1 udp 2130706431 4.155.146.196 3478 typ host ufrag kZ2qkHXX/u11
        a=candidate:1432411780 1 tcp 1671430143 4.155.146.196 443 typ host tcptype passive ufrag kZ2qkHXX/u11
        m=application 9 UDP/DTLS/SCTP webrtc-datachannel
        a=mid:1
        a=sctp-port:5000
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`accept-realtime-call`,
  "x-oaiMeta",
  #{
    name: "Accept call",
    group: "realtime-calls",
    returns: """
      Returns `200 OK` once OpenAI starts ringing the SIP leg with the supplied
      session configuration.
      """,
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/accept \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
                  "type": "realtime",
                  "model": "gpt-realtime",
                  "instructions": "You are Alex, a friendly concierge for Example Corp.",
                }'
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.realtime.calls.accept('call_id', { type: 'realtime' });
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.realtime.calls.accept(
              call_id="call_id",
              type="realtime",
          )
          """,
        go: """
          package main
          
          import (
          	"context"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/realtime"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	err := client.Realtime.Calls.Accept(
          		context.TODO(),
          		"call_id",
          		realtime.CallAcceptParams{
          			RealtimeSessionCreateRequest: realtime.RealtimeSessionCreateRequestParam{},
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.realtime.RealtimeSessionCreateRequest;
          import com.openai.models.realtime.calls.CallAcceptParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  CallAcceptParams params = CallAcceptParams.builder()
                      .callId("call_id")
                      .realtimeSessionCreateRequest(RealtimeSessionCreateRequest.builder().build())
                      .build();
                  client.realtime().calls().accept(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.realtime.calls.accept("call_id", type: :realtime)
          
          puts(result)
          """,
      },
      response: "",
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`hangup-realtime-call`,
  "x-oaiMeta",
  #{
    name: "Hang up call",
    group: "realtime-calls",
    returns: "Returns `200 OK` when OpenAI begins terminating the realtime call.",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/hangup \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.realtime.calls.hangup('call_id');
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.realtime.calls.hangup(
              "call_id",
          )
          """,
        go: """
          package main
          
          import (
          	"context"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	err := client.Realtime.Calls.Hangup(context.TODO(), "call_id")
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.realtime.calls.CallHangupParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  client.realtime().calls().hangup("call_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.realtime.calls.hangup("call_id")
          
          puts(result)
          """,
      },
      response: "",
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`refer-realtime-call`,
  "x-oaiMeta",
  #{
    name: "Refer call",
    group: "realtime-calls",
    returns: "Returns `200 OK` once the REFER is handed off to your SIP provider.",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/refer \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{"target_uri": "tel:+14155550123"}'
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.realtime.calls.refer('call_id', { target_uri: 'tel:+14155550123' });
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.realtime.calls.refer(
              call_id="call_id",
              target_uri="tel:+14155550123",
          )
          """,
        go: """
          package main
          
          import (
          	"context"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/realtime"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	err := client.Realtime.Calls.Refer(
          		context.TODO(),
          		"call_id",
          		realtime.CallReferParams{
          			TargetUri: "tel:+14155550123",
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.realtime.calls.CallReferParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  CallReferParams params = CallReferParams.builder()
                      .callId("call_id")
                      .targetUri("tel:+14155550123")
                      .build();
                  client.realtime().calls().refer(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.realtime.calls.refer("call_id", target_uri: "tel:+14155550123")
          
          puts(result)
          """,
      },
      response: "",
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`reject-realtime-call`,
  "x-oaiMeta",
  #{
    name: "Reject call",
    group: "realtime-calls",
    returns: "Returns `200 OK` after OpenAI sends the SIP status code to the caller.",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/calls/$CALL_ID/reject \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{"status_code": 486}'
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.realtime.calls.reject('call_id');
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.realtime.calls.reject(
              call_id="call_id",
          )
          """,
        go: """
          package main
          
          import (
          	"context"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/realtime"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	err := client.Realtime.Calls.Reject(
          		context.TODO(),
          		"call_id",
          		realtime.CallRejectParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.realtime.calls.CallRejectParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  client.realtime().calls().reject("call_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.realtime.calls.reject("call_id")
          
          puts(result)
          """,
      },
      response: "",
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`create-realtime-client-secret`,
  "x-oaiMeta",
  #{
    name: "Create client secret",
    group: "realtime",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/client_secrets \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "expires_after": {
                "anchor": "created_at",
                "seconds": 600
              },
              "session": {
                "type": "realtime",
                "model": "gpt-realtime",
                "instructions": "You are a friendly assistant."
              }
            }'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const clientSecret = await client.realtime.clientSecrets.create();
          
          console.log(clientSecret.expires_at);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client_secret = client.realtime.client_secrets.create()
          print(client_secret.expires_at)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/realtime"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	clientSecret, err := client.Realtime.ClientSecrets.New(context.TODO(), realtime.ClientSecretNewParams{})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", clientSecret.ExpiresAt)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.realtime.clientsecrets.ClientSecretCreateParams;
          import com.openai.models.realtime.clientsecrets.ClientSecretCreateResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ClientSecretCreateResponse clientSecret = client.realtime().clientSecrets().create();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          client_secret = openai.realtime.client_secrets.create
          
          puts(client_secret)
          """,
      },
      response: """
        {
          "value": "ek_68af296e8e408191a1120ab6383263c2",
          "expires_at": 1756310470,
          "session": {
            "type": "realtime",
            "object": "realtime.session",
            "id": "sess_C9CiUVUzUzYIssh3ELY1d",
            "model": "gpt-realtime",
            "output_modalities": [
              "audio"
            ],
            "instructions": "You are a friendly assistant.",
            "tools": [],
            "tool_choice": "auto",
            "max_output_tokens": "inf",
            "tracing": null,
            "truncation": "auto",
            "prompt": null,
            "expires_at": 0,
            "audio": {
              "input": {
                "format": {
                  "type": "audio/pcm",
                  "rate": 24000
                },
                "transcription": null,
                "noise_reduction": null,
                "turn_detection": {
                  "type": "server_vad",
                }
              },
              "output": {
                "format": {
                  "type": "audio/pcm",
                  "rate": 24000
                },
                "voice": "alloy",
                "speed": 1.0
              }
            },
            "include": null
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`create-realtime-session`,
  "x-oaiMeta",
  #{
    name: "Create session",
    group: "realtime",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/sessions \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "model": "gpt-realtime",
              "modalities": ["audio", "text"],
              "instructions": "You are a friendly assistant."
            }'
          
          """,
      },
      response: """
        {
          "id": "sess_001",
          "object": "realtime.session",
          "model": "gpt-realtime-2025-08-25",
          "modalities": ["audio", "text"],
          "instructions": "You are a friendly assistant.",
          "voice": "alloy",
          "input_audio_format": "pcm16",
          "output_audio_format": "pcm16",
          "input_audio_transcription": {
              "model": "whisper-1"
          },
          "turn_detection": null,
          "tools": [],
          "tool_choice": "none",
          "temperature": 0.7,
          "max_response_output_tokens": 200,
          "speed": 1.1,
          "tracing": "auto",
          "client_secret": {
            "value": "ek_abc123",
            "expires_at": 1234567890
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`create-realtime-transcription-session`,
  "x-oaiMeta",
  #{
    name: "Create transcription session",
    group: "realtime",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/transcription_sessions \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{}'
          
          """,
      },
      response: """
        {
          "id": "sess_BBwZc7cFV3XizEyKGDCGL",
          "object": "realtime.transcription_session",
          "modalities": ["audio", "text"],
          "turn_detection": {
            "type": "server_vad",
            "threshold": 0.5,
            "prefix_padding_ms": 300,
            "silence_duration_ms": 200
          },
          "input_audio_format": "pcm16",
          "input_audio_transcription": {
            "model": "gpt-4o-transcribe",
            "language": null,
            "prompt": ""
          },
          "client_secret": null
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Realtime.`create-realtime-translation-client-secret`,
  "x-oaiMeta",
  #{
    name: "Create translation client secret",
    group: "realtime",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/realtime/translations/client_secrets \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "expires_after": {
                "anchor": "created_at",
                "seconds": 600
              },
              "session": {
                "model": "gpt-realtime-translate",
                "audio": {
                  "input": {
                    "transcription": {
                      "model": "gpt-realtime-whisper"
                    },
                    "noise_reduction": null
                  },
                  "output": {
                    "language": "es"
                  }
                }
              }
            }'
          
          """,
      },
      response: """
        {
          "value": "ek_68af296e8e408191a1120ab6383263c2",
          "expires_at": 1756310470,
          "session": {
            "id": "sess_C9CiUVUzUzYIssh3ELY1d",
            "type": "translation",
            "expires_at": 1756310470,
            "model": "gpt-realtime-translate",
            "audio": {
              "input": {
                "transcription": {
                  "model": "gpt-realtime-whisper"
                },
                "noise_reduction": null
              },
              "output": {
                "language": "es"
              }
            }
          }
        }
        
        """,
    },
  }
);
