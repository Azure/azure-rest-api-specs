import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Audio.createSpeech,
  "x-oaiMeta",
  #{
    name: "Create speech",
    group: "audio",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/speech \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -d '{
                "model": "gpt-4o-mini-tts",
                "input": "The quick brown fox jumped over the lazy dog.",
                "voice": "alloy"
              }' \\
              --output speech.mp3
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            speech = client.audio.speech.create(
                input="input",
                model="tts-1",
                voice="alloy",
            )
            print(speech)
            content = speech.read()
            print(content)
            """,
          javascript: """
            import fs from "fs";
            import path from "path";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const speechFile = path.resolve("./speech.mp3");
            
            async function main() {
              const mp3 = await openai.audio.speech.create({
                model: "gpt-4o-mini-tts",
                voice: "alloy",
                input: "Today is a wonderful day to build something people love!",
              });
              console.log(speechFile);
              const buffer = Buffer.from(await mp3.arrayBuffer());
              await fs.promises.writeFile(speechFile, buffer);
            }
            main();
            
            """,
          csharp: """
            using System;
            using System.IO;
            
            using OpenAI.Audio;
            
            AudioClient client = new(
                model: "gpt-4o-mini-tts",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            BinaryData speech = client.GenerateSpeech(
                text: "The quick brown fox jumped over the lazy dog.",
                voice: GeneratedSpeechVoice.Alloy
            );
            
            using FileStream stream = File.OpenWrite("speech.mp3");
            speech.ToStream().CopyTo(stream);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const speech = await client.audio.speech.create({
              input: 'input',
              model: 'tts-1',
              voice: 'alloy',
            });
            
            console.log(speech);
            
            const content = await speech.blob();
            console.log(content);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	speech, err := client.Audio.Speech.New(context.TODO(), openai.AudioSpeechNewParams{
            		Input: "input",
            		Model: openai.SpeechModelTTS1,
            		Voice: openai.AudioSpeechNewParamsVoiceUnion{
            			OfAudioSpeechNewsVoiceString2: openai.String("alloy"),
            		},
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", speech)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.core.http.HttpResponse;
            import com.openai.models.audio.speech.SpeechCreateParams;
            import com.openai.models.audio.speech.SpeechModel;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    SpeechCreateParams params = SpeechCreateParams.builder()
                        .input("input")
                        .model(SpeechModel.TTS_1)
                        .voice(SpeechCreateParams.Voice.UnionMember1.ALLOY)
                        .build();
                    HttpResponse speech = client.audio().speech().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            speech = openai.audio.speech.create(input: "input", model: :"tts-1", voice: :alloy)
            
            puts(speech)
            """,
        },
      },
      #{
        title: "SSE Stream Format",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/speech \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -d '{
                "model": "gpt-4o-mini-tts",
                "input": "The quick brown fox jumped over the lazy dog.",
                "voice": "alloy",
                "stream_format": "sse"
              }'
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const speech = await client.audio.speech.create({
              input: 'input',
              model: 'tts-1',
              voice: 'alloy',
            });
            
            console.log(speech);
            
            const content = await speech.blob();
            console.log(content);
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            speech = client.audio.speech.create(
                input="input",
                model="tts-1",
                voice="alloy",
            )
            print(speech)
            content = speech.read()
            print(content)
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	speech, err := client.Audio.Speech.New(context.TODO(), openai.AudioSpeechNewParams{
            		Input: "input",
            		Model: openai.SpeechModelTTS1,
            		Voice: openai.AudioSpeechNewParamsVoiceUnion{
            			OfAudioSpeechNewsVoiceString2: openai.String("alloy"),
            		},
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", speech)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.core.http.HttpResponse;
            import com.openai.models.audio.speech.SpeechCreateParams;
            import com.openai.models.audio.speech.SpeechModel;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    SpeechCreateParams params = SpeechCreateParams.builder()
                        .input("input")
                        .model(SpeechModel.TTS_1)
                        .voice(SpeechCreateParams.Voice.UnionMember1.ALLOY)
                        .build();
                    HttpResponse speech = client.audio().speech().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            speech = openai.audio.speech.create(input: "input", model: :"tts-1", voice: :alloy)
            
            puts(speech)
            """,
        },
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Audio.createTranscription,
  "x-oaiMeta",
  #{
    name: "Create transcription",
    group: "audio",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/transcriptions \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: multipart/form-data" \\
              -F file="@/path/to/file/audio.mp3" \\
              -F model="gpt-4o-transcribe"
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for transcription in client.audio.transcriptions.create(
                file=b"Example data",
                model="gpt-4o-transcribe",
            ):
              print(transcription)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const transcription = await openai.audio.transcriptions.create({
                file: fs.createReadStream("audio.mp3"),
                model: "gpt-4o-transcribe",
              });
            
              console.log(transcription.text);
            }
            main();
            
            """,
          csharp: """
            using System;
            
            using OpenAI.Audio;
            string audioFilePath = "audio.mp3";
            
            AudioClient client = new(
                model: "gpt-4o-transcribe",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            AudioTranscription transcription = client.TranscribeAudio(audioFilePath);
            
            Console.WriteLine($"{transcription.Text}");
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const transcription = await client.audio.transcriptions.create({
              file: fs.createReadStream('speech.mp3'),
              model: 'gpt-4o-transcribe',
            });
            
            console.log(transcription);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	transcription, err := client.Audio.Transcriptions.New(context.TODO(), openai.AudioTranscriptionNewParams{
            		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		Model: openai.AudioModelGPT4oTranscribe,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", transcription)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.audio.AudioModel;
            import com.openai.models.audio.transcriptions.TranscriptionCreateParams;
            import com.openai.models.audio.transcriptions.TranscriptionCreateResponse;
            import java.io.ByteArrayInputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    TranscriptionCreateParams params = TranscriptionCreateParams.builder()
                        .file(new ByteArrayInputStream("Example data".getBytes()))
                        .model(AudioModel.GPT_4O_TRANSCRIBE)
                        .build();
                    TranscriptionCreateResponse transcription = client.audio().transcriptions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            transcription = openai.audio.transcriptions.create(file: StringIO.new("Example data"), model: :"gpt-4o-transcribe")
            
            puts(transcription)
            """,
        },
        response: """
          {
            "text": "Imagine the wildest idea that you've ever had, and you're curious about how it might scale to something that's a 100, a 1,000 times bigger. This is a place where you can get to do that.",
            "usage": {
              "type": "tokens",
              "input_tokens": 14,
              "input_token_details": {
                "text_tokens": 0,
                "audio_tokens": 14
              },
              "output_tokens": 45,
              "total_tokens": 59
            }
          }
          
          """,
      },
      #{
        title: "Diarization",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/transcriptions \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: multipart/form-data" \\
              -F file="@/path/to/file/meeting.wav" \\
              -F model="gpt-4o-transcribe-diarize" \\
              -F response_format="diarized_json" \\
              -F chunking_strategy=auto \\
              -F 'known_speaker_names[]=agent' \\
              -F 'known_speaker_references[]=data:audio/wav;base64,AAA...'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for transcription in client.audio.transcriptions.create(
                file=b"Example data",
                model="gpt-4o-transcribe",
            ):
              print(transcription)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const speakerRef = fs.readFileSync("agent.wav").toString("base64");
            
            const transcript = await openai.audio.transcriptions.create({
              file: fs.createReadStream("meeting.wav"),
              model: "gpt-4o-transcribe-diarize",
              response_format: "diarized_json",
              chunking_strategy: "auto",
              extra_body: {
                known_speaker_names: ["agent"],
                known_speaker_references: [`data:audio/wav;base64,\${speakerRef}`],
              },
            });
            
            console.log(transcript.segments);
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const transcription = await client.audio.transcriptions.create({
              file: fs.createReadStream('speech.mp3'),
              model: 'gpt-4o-transcribe',
            });
            
            console.log(transcription);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	transcription, err := client.Audio.Transcriptions.New(context.TODO(), openai.AudioTranscriptionNewParams{
            		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		Model: openai.AudioModelGPT4oTranscribe,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", transcription)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.audio.AudioModel;
            import com.openai.models.audio.transcriptions.TranscriptionCreateParams;
            import com.openai.models.audio.transcriptions.TranscriptionCreateResponse;
            import java.io.ByteArrayInputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    TranscriptionCreateParams params = TranscriptionCreateParams.builder()
                        .file(new ByteArrayInputStream("Example data".getBytes()))
                        .model(AudioModel.GPT_4O_TRANSCRIBE)
                        .build();
                    TranscriptionCreateResponse transcription = client.audio().transcriptions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            transcription = openai.audio.transcriptions.create(file: StringIO.new("Example data"), model: :"gpt-4o-transcribe")
            
            puts(transcription)
            """,
        },
        response: """
          {
            "task": "transcribe",
            "duration": 27.4,
            "text": "Agent: Thanks for calling OpenAI support.
          A: Hi, I'm trying to enable diarization.
          Agent: Happy to walk you through the steps.",
            "segments": [
              {
                "type": "transcript.text.segment",
                "id": "seg_001",
                "start": 0.0,
                "end": 4.7,
                "text": "Thanks for calling OpenAI support.",
                "speaker": "agent"
              },
              {
                "type": "transcript.text.segment",
                "id": "seg_002",
                "start": 4.7,
                "end": 11.8,
                "text": "Hi, I'm trying to enable diarization.",
                "speaker": "A"
              },
              {
                "type": "transcript.text.segment",
                "id": "seg_003",
                "start": 12.1,
                "end": 18.5,
                "text": "Happy to walk you through the steps.",
                "speaker": "agent"
              }
            ],
            "usage": {
              "type": "duration",
              "seconds": 27
            }
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/transcriptions \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: multipart/form-data" \\
              -F file="@/path/to/file/audio.mp3" \\
              -F model="gpt-4o-mini-transcribe" \\
              -F stream=true
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for transcription in client.audio.transcriptions.create(
                file=b"Example data",
                model="gpt-4o-transcribe",
            ):
              print(transcription)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const stream = await openai.audio.transcriptions.create({
              file: fs.createReadStream("audio.mp3"),
              model: "gpt-4o-mini-transcribe",
              stream: true,
            });
            
            for await (const event of stream) {
              console.log(event);
            }
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const transcription = await client.audio.transcriptions.create({
              file: fs.createReadStream('speech.mp3'),
              model: 'gpt-4o-transcribe',
            });
            
            console.log(transcription);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	transcription, err := client.Audio.Transcriptions.New(context.TODO(), openai.AudioTranscriptionNewParams{
            		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		Model: openai.AudioModelGPT4oTranscribe,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", transcription)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.audio.AudioModel;
            import com.openai.models.audio.transcriptions.TranscriptionCreateParams;
            import com.openai.models.audio.transcriptions.TranscriptionCreateResponse;
            import java.io.ByteArrayInputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    TranscriptionCreateParams params = TranscriptionCreateParams.builder()
                        .file(new ByteArrayInputStream("Example data".getBytes()))
                        .model(AudioModel.GPT_4O_TRANSCRIBE)
                        .build();
                    TranscriptionCreateResponse transcription = client.audio().transcriptions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            transcription = openai.audio.transcriptions.create(file: StringIO.new("Example data"), model: :"gpt-4o-transcribe")
            
            puts(transcription)
            """,
        },
        response: """
          data: {"type":"transcript.text.delta","delta":"I","logprobs":[{"token":"I","logprob":-0.00007588794,"bytes":[73]}]}
          
          data: {"type":"transcript.text.delta","delta":" see","logprobs":[{"token":" see","logprob":-3.1281633e-7,"bytes":[32,115,101,101]}]}
          
          data: {"type":"transcript.text.delta","delta":" skies","logprobs":[{"token":" skies","logprob":-2.3392786e-6,"bytes":[32,115,107,105,101,115]}]}
          
          data: {"type":"transcript.text.delta","delta":" of","logprobs":[{"token":" of","logprob":-3.1281633e-7,"bytes":[32,111,102]}]}
          
          data: {"type":"transcript.text.delta","delta":" blue","logprobs":[{"token":" blue","logprob":-1.0280384e-6,"bytes":[32,98,108,117,101]}]}
          
          data: {"type":"transcript.text.delta","delta":" and","logprobs":[{"token":" and","logprob":-0.0005108566,"bytes":[32,97,110,100]}]}
          
          data: {"type":"transcript.text.delta","delta":" clouds","logprobs":[{"token":" clouds","logprob":-1.9361265e-7,"bytes":[32,99,108,111,117,100,115]}]}
          
          data: {"type":"transcript.text.delta","delta":" of","logprobs":[{"token":" of","logprob":-1.9361265e-7,"bytes":[32,111,102]}]}
          
          data: {"type":"transcript.text.delta","delta":" white","logprobs":[{"token":" white","logprob":-7.89631e-7,"bytes":[32,119,104,105,116,101]}]}
          
          data: {"type":"transcript.text.delta","delta":",","logprobs":[{"token":",","logprob":-0.0014890312,"bytes":[44]}]}
          
          data: {"type":"transcript.text.delta","delta":" the","logprobs":[{"token":" the","logprob":-0.0110956915,"bytes":[32,116,104,101]}]}
          
          data: {"type":"transcript.text.delta","delta":" bright","logprobs":[{"token":" bright","logprob":0.0,"bytes":[32,98,114,105,103,104,116]}]}
          
          data: {"type":"transcript.text.delta","delta":" blessed","logprobs":[{"token":" blessed","logprob":-0.000045848617,"bytes":[32,98,108,101,115,115,101,100]}]}
          
          data: {"type":"transcript.text.delta","delta":" days","logprobs":[{"token":" days","logprob":-0.000010802739,"bytes":[32,100,97,121,115]}]}
          
          data: {"type":"transcript.text.delta","delta":",","logprobs":[{"token":",","logprob":-0.00001700133,"bytes":[44]}]}
          
          data: {"type":"transcript.text.delta","delta":" the","logprobs":[{"token":" the","logprob":-0.0000118755715,"bytes":[32,116,104,101]}]}
          
          data: {"type":"transcript.text.delta","delta":" dark","logprobs":[{"token":" dark","logprob":-5.5122365e-7,"bytes":[32,100,97,114,107]}]}
          
          data: {"type":"transcript.text.delta","delta":" sacred","logprobs":[{"token":" sacred","logprob":-5.4385737e-6,"bytes":[32,115,97,99,114,101,100]}]}
          
          data: {"type":"transcript.text.delta","delta":" nights","logprobs":[{"token":" nights","logprob":-4.00813e-6,"bytes":[32,110,105,103,104,116,115]}]}
          
          data: {"type":"transcript.text.delta","delta":",","logprobs":[{"token":",","logprob":-0.0036910512,"bytes":[44]}]}
          
          data: {"type":"transcript.text.delta","delta":" and","logprobs":[{"token":" and","logprob":-0.0031903093,"bytes":[32,97,110,100]}]}
          
          data: {"type":"transcript.text.delta","delta":" I","logprobs":[{"token":" I","logprob":-1.504853e-6,"bytes":[32,73]}]}
          
          data: {"type":"transcript.text.delta","delta":" think","logprobs":[{"token":" think","logprob":-4.3202e-7,"bytes":[32,116,104,105,110,107]}]}
          
          data: {"type":"transcript.text.delta","delta":" to","logprobs":[{"token":" to","logprob":-1.9361265e-7,"bytes":[32,116,111]}]}
          
          data: {"type":"transcript.text.delta","delta":" myself","logprobs":[{"token":" myself","logprob":-1.7432603e-6,"bytes":[32,109,121,115,101,108,102]}]}
          
          data: {"type":"transcript.text.delta","delta":",","logprobs":[{"token":",","logprob":-0.29254505,"bytes":[44]}]}
          
          data: {"type":"transcript.text.delta","delta":" what","logprobs":[{"token":" what","logprob":-0.016815351,"bytes":[32,119,104,97,116]}]}
          
          data: {"type":"transcript.text.delta","delta":" a","logprobs":[{"token":" a","logprob":-3.1281633e-7,"bytes":[32,97]}]}
          
          data: {"type":"transcript.text.delta","delta":" wonderful","logprobs":[{"token":" wonderful","logprob":-2.1008714e-6,"bytes":[32,119,111,110,100,101,114,102,117,108]}]}
          
          data: {"type":"transcript.text.delta","delta":" world","logprobs":[{"token":" world","logprob":-8.180258e-6,"bytes":[32,119,111,114,108,100]}]}
          
          data: {"type":"transcript.text.delta","delta":".","logprobs":[{"token":".","logprob":-0.014231676,"bytes":[46]}]}
          
          data: {"type":"transcript.text.done","text":"I see skies of blue and clouds of white, the bright blessed days, the dark sacred nights, and I think to myself, what a wonderful world.","logprobs":[{"token":"I","logprob":-0.00007588794,"bytes":[73]},{"token":" see","logprob":-3.1281633e-7,"bytes":[32,115,101,101]},{"token":" skies","logprob":-2.3392786e-6,"bytes":[32,115,107,105,101,115]},{"token":" of","logprob":-3.1281633e-7,"bytes":[32,111,102]},{"token":" blue","logprob":-1.0280384e-6,"bytes":[32,98,108,117,101]},{"token":" and","logprob":-0.0005108566,"bytes":[32,97,110,100]},{"token":" clouds","logprob":-1.9361265e-7,"bytes":[32,99,108,111,117,100,115]},{"token":" of","logprob":-1.9361265e-7,"bytes":[32,111,102]},{"token":" white","logprob":-7.89631e-7,"bytes":[32,119,104,105,116,101]},{"token":",","logprob":-0.0014890312,"bytes":[44]},{"token":" the","logprob":-0.0110956915,"bytes":[32,116,104,101]},{"token":" bright","logprob":0.0,"bytes":[32,98,114,105,103,104,116]},{"token":" blessed","logprob":-0.000045848617,"bytes":[32,98,108,101,115,115,101,100]},{"token":" days","logprob":-0.000010802739,"bytes":[32,100,97,121,115]},{"token":",","logprob":-0.00001700133,"bytes":[44]},{"token":" the","logprob":-0.0000118755715,"bytes":[32,116,104,101]},{"token":" dark","logprob":-5.5122365e-7,"bytes":[32,100,97,114,107]},{"token":" sacred","logprob":-5.4385737e-6,"bytes":[32,115,97,99,114,101,100]},{"token":" nights","logprob":-4.00813e-6,"bytes":[32,110,105,103,104,116,115]},{"token":",","logprob":-0.0036910512,"bytes":[44]},{"token":" and","logprob":-0.0031903093,"bytes":[32,97,110,100]},{"token":" I","logprob":-1.504853e-6,"bytes":[32,73]},{"token":" think","logprob":-4.3202e-7,"bytes":[32,116,104,105,110,107]},{"token":" to","logprob":-1.9361265e-7,"bytes":[32,116,111]},{"token":" myself","logprob":-1.7432603e-6,"bytes":[32,109,121,115,101,108,102]},{"token":",","logprob":-0.29254505,"bytes":[44]},{"token":" what","logprob":-0.016815351,"bytes":[32,119,104,97,116]},{"token":" a","logprob":-3.1281633e-7,"bytes":[32,97]},{"token":" wonderful","logprob":-2.1008714e-6,"bytes":[32,119,111,110,100,101,114,102,117,108]},{"token":" world","logprob":-8.180258e-6,"bytes":[32,119,111,114,108,100]},{"token":".","logprob":-0.014231676,"bytes":[46]}],"usage":{"input_tokens":14,"input_token_details":{"text_tokens":0,"audio_tokens":14},"output_tokens":45,"total_tokens":59}}
          
          """,
      },
      #{
        title: "Logprobs",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/transcriptions \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: multipart/form-data" \\
              -F file="@/path/to/file/audio.mp3" \\
              -F "include[]=logprobs" \\
              -F model="gpt-4o-transcribe" \\
              -F response_format="json"
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for transcription in client.audio.transcriptions.create(
                file=b"Example data",
                model="gpt-4o-transcribe",
            ):
              print(transcription)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const transcription = await openai.audio.transcriptions.create({
                file: fs.createReadStream("audio.mp3"),
                model: "gpt-4o-transcribe",
                response_format: "json",
                include: ["logprobs"]
              });
            
              console.log(transcription);
            }
            main();
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const transcription = await client.audio.transcriptions.create({
              file: fs.createReadStream('speech.mp3'),
              model: 'gpt-4o-transcribe',
            });
            
            console.log(transcription);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	transcription, err := client.Audio.Transcriptions.New(context.TODO(), openai.AudioTranscriptionNewParams{
            		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		Model: openai.AudioModelGPT4oTranscribe,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", transcription)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.audio.AudioModel;
            import com.openai.models.audio.transcriptions.TranscriptionCreateParams;
            import com.openai.models.audio.transcriptions.TranscriptionCreateResponse;
            import java.io.ByteArrayInputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    TranscriptionCreateParams params = TranscriptionCreateParams.builder()
                        .file(new ByteArrayInputStream("Example data".getBytes()))
                        .model(AudioModel.GPT_4O_TRANSCRIBE)
                        .build();
                    TranscriptionCreateResponse transcription = client.audio().transcriptions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            transcription = openai.audio.transcriptions.create(file: StringIO.new("Example data"), model: :"gpt-4o-transcribe")
            
            puts(transcription)
            """,
        },
        response: """
          {
            "text": "Hey, my knee is hurting and I want to see the doctor tomorrow ideally.",
            "logprobs": [
              { "token": "Hey", "logprob": -1.0415299, "bytes": [72, 101, 121] },
              { "token": ",", "logprob": -9.805982e-5, "bytes": [44] },
              { "token": " my", "logprob": -0.00229799, "bytes": [32, 109, 121] },
              {
                "token": " knee",
                "logprob": -4.7159858e-5,
                "bytes": [32, 107, 110, 101, 101]
              },
              { "token": " is", "logprob": -0.043909557, "bytes": [32, 105, 115] },
              {
                "token": " hurting",
                "logprob": -1.1041146e-5,
                "bytes": [32, 104, 117, 114, 116, 105, 110, 103]
              },
              { "token": " and", "logprob": -0.011076359, "bytes": [32, 97, 110, 100] },
              { "token": " I", "logprob": -5.3193703e-6, "bytes": [32, 73] },
              {
                "token": " want",
                "logprob": -0.0017156356,
                "bytes": [32, 119, 97, 110, 116]
              },
              { "token": " to", "logprob": -7.89631e-7, "bytes": [32, 116, 111] },
              { "token": " see", "logprob": -5.5122365e-7, "bytes": [32, 115, 101, 101] },
              { "token": " the", "logprob": -0.0040786397, "bytes": [32, 116, 104, 101] },
              {
                "token": " doctor",
                "logprob": -2.3392786e-6,
                "bytes": [32, 100, 111, 99, 116, 111, 114]
              },
              {
                "token": " tomorrow",
                "logprob": -7.89631e-7,
                "bytes": [32, 116, 111, 109, 111, 114, 114, 111, 119]
              },
              {
                "token": " ideally",
                "logprob": -0.5800861,
                "bytes": [32, 105, 100, 101, 97, 108, 108, 121]
              },
              { "token": ".", "logprob": -0.00011093382, "bytes": [46] }
            ],
            "usage": {
              "type": "tokens",
              "input_tokens": 14,
              "input_token_details": {
                "text_tokens": 0,
                "audio_tokens": 14
              },
              "output_tokens": 45,
              "total_tokens": 59
            }
          }
          
          """,
      },
      #{
        title: "Word timestamps",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/transcriptions \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: multipart/form-data" \\
              -F file="@/path/to/file/audio.mp3" \\
              -F "timestamp_granularities[]=word" \\
              -F model="whisper-1" \\
              -F response_format="verbose_json"
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for transcription in client.audio.transcriptions.create(
                file=b"Example data",
                model="gpt-4o-transcribe",
            ):
              print(transcription)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const transcription = await openai.audio.transcriptions.create({
                file: fs.createReadStream("audio.mp3"),
                model: "whisper-1",
                response_format: "verbose_json",
                timestamp_granularities: ["word"]
              });
            
              console.log(transcription.text);
            }
            main();
            
            """,
          csharp: """
            using System;
            
            using OpenAI.Audio;
            
            string audioFilePath = "audio.mp3";
            
            AudioClient client = new(
                model: "whisper-1",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            AudioTranscriptionOptions options = new()
            {
                ResponseFormat = AudioTranscriptionFormat.Verbose,
                TimestampGranularities = AudioTimestampGranularities.Word,
            };
            
            AudioTranscription transcription = client.TranscribeAudio(audioFilePath, options);
            
            Console.WriteLine($"{transcription.Text}");
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const transcription = await client.audio.transcriptions.create({
              file: fs.createReadStream('speech.mp3'),
              model: 'gpt-4o-transcribe',
            });
            
            console.log(transcription);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	transcription, err := client.Audio.Transcriptions.New(context.TODO(), openai.AudioTranscriptionNewParams{
            		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		Model: openai.AudioModelGPT4oTranscribe,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", transcription)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.audio.AudioModel;
            import com.openai.models.audio.transcriptions.TranscriptionCreateParams;
            import com.openai.models.audio.transcriptions.TranscriptionCreateResponse;
            import java.io.ByteArrayInputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    TranscriptionCreateParams params = TranscriptionCreateParams.builder()
                        .file(new ByteArrayInputStream("Example data".getBytes()))
                        .model(AudioModel.GPT_4O_TRANSCRIBE)
                        .build();
                    TranscriptionCreateResponse transcription = client.audio().transcriptions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            transcription = openai.audio.transcriptions.create(file: StringIO.new("Example data"), model: :"gpt-4o-transcribe")
            
            puts(transcription)
            """,
        },
        response: """
          {
            "task": "transcribe",
            "language": "english",
            "duration": 8.470000267028809,
            "text": "The beach was a popular spot on a hot summer day. People were swimming in the ocean, building sandcastles, and playing beach volleyball.",
            "words": [
              {
                "word": "The",
                "start": 0.0,
                "end": 0.23999999463558197
              },
              ...
              {
                "word": "volleyball",
                "start": 7.400000095367432,
                "end": 7.900000095367432
              }
            ],
            "usage": {
              "type": "duration",
              "seconds": 9
            }
          }
          
          """,
      },
      #{
        title: "Segment timestamps",
        request: #{
          curl: """
            curl https://api.openai.com/v1/audio/transcriptions \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: multipart/form-data" \\
              -F file="@/path/to/file/audio.mp3" \\
              -F "timestamp_granularities[]=segment" \\
              -F model="whisper-1" \\
              -F response_format="verbose_json"
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for transcription in client.audio.transcriptions.create(
                file=b"Example data",
                model="gpt-4o-transcribe",
            ):
              print(transcription)
            """,
          javascript: """
            import fs from "fs";
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const transcription = await openai.audio.transcriptions.create({
                file: fs.createReadStream("audio.mp3"),
                model: "whisper-1",
                response_format: "verbose_json",
                timestamp_granularities: ["segment"]
              });
            
              console.log(transcription.text);
            }
            main();
            
            """,
          csharp: """
            using System;
            
            using OpenAI.Audio;
            
            string audioFilePath = "audio.mp3";
            
            AudioClient client = new(
                model: "whisper-1",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            AudioTranscriptionOptions options = new()
            {
                ResponseFormat = AudioTranscriptionFormat.Verbose,
                TimestampGranularities = AudioTimestampGranularities.Segment,
            };
            
            AudioTranscription transcription = client.TranscribeAudio(audioFilePath, options);
            
            Console.WriteLine($"{transcription.Text}");
            
            """,
          `node.js`: """
            import fs from 'fs';
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const transcription = await client.audio.transcriptions.create({
              file: fs.createReadStream('speech.mp3'),
              model: 'gpt-4o-transcribe',
            });
            
            console.log(transcription);
            """,
          go: """
            package main
            
            import (
            	"bytes"
            	"context"
            	"fmt"
            	"io"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	transcription, err := client.Audio.Transcriptions.New(context.TODO(), openai.AudioTranscriptionNewParams{
            		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
            		Model: openai.AudioModelGPT4oTranscribe,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", transcription)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.audio.AudioModel;
            import com.openai.models.audio.transcriptions.TranscriptionCreateParams;
            import com.openai.models.audio.transcriptions.TranscriptionCreateResponse;
            import java.io.ByteArrayInputStream;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    TranscriptionCreateParams params = TranscriptionCreateParams.builder()
                        .file(new ByteArrayInputStream("Example data".getBytes()))
                        .model(AudioModel.GPT_4O_TRANSCRIBE)
                        .build();
                    TranscriptionCreateResponse transcription = client.audio().transcriptions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            transcription = openai.audio.transcriptions.create(file: StringIO.new("Example data"), model: :"gpt-4o-transcribe")
            
            puts(transcription)
            """,
        },
        response: """
          {
            "task": "transcribe",
            "language": "english",
            "duration": 8.470000267028809,
            "text": "The beach was a popular spot on a hot summer day. People were swimming in the ocean, building sandcastles, and playing beach volleyball.",
            "segments": [
              {
                "id": 0,
                "seek": 0,
                "start": 0.0,
                "end": 3.319999933242798,
                "text": " The beach was a popular spot on a hot summer day.",
                "tokens": [
                  50364, 440, 7534, 390, 257, 3743, 4008, 322, 257, 2368, 4266, 786, 13, 50530
                ],
                "temperature": 0.0,
                "avg_logprob": -0.2860786020755768,
                "compression_ratio": 1.2363636493682861,
                "no_speech_prob": 0.00985979475080967
              },
              ...
            ],
            "usage": {
              "type": "duration",
              "seconds": 9
            }
          }
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Audio.createTranslation,
  "x-oaiMeta",
  #{
    name: "Create translation",
    group: "audio",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/audio/translations \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: multipart/form-data" \\
            -F file="@/path/to/file/german.m4a" \\
            -F model="whisper-1"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          translation = client.audio.translations.create(
              file=b"Example data",
              model="whisper-1",
          )
          print(translation)
          """,
        javascript: """
          import fs from "fs";
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
              const translation = await openai.audio.translations.create({
                  file: fs.createReadStream("speech.mp3"),
                  model: "whisper-1",
              });
          
              console.log(translation.text);
          }
          main();
          
          """,
        csharp: """
          using System;
          
          using OpenAI.Audio;
          
          string audioFilePath = "audio.mp3";
          
          AudioClient client = new(
              model: "whisper-1",
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          AudioTranscription transcription = client.TranscribeAudio(audioFilePath);
          
          Console.WriteLine($"{transcription.Text}");
          
          """,
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const translation = await client.audio.translations.create({
            file: fs.createReadStream('speech.mp3'),
            model: 'whisper-1',
          });
          
          console.log(translation);
          """,
        go: """
          package main
          
          import (
          	"bytes"
          	"context"
          	"fmt"
          	"io"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	translation, err := client.Audio.Translations.New(context.TODO(), openai.AudioTranslationNewParams{
          		File:  io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		Model: openai.AudioModelWhisper1,
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", translation)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.audio.AudioModel;
          import com.openai.models.audio.translations.TranslationCreateParams;
          import com.openai.models.audio.translations.TranslationCreateResponse;
          import java.io.ByteArrayInputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  TranslationCreateParams params = TranslationCreateParams.builder()
                      .file(new ByteArrayInputStream("Example data".getBytes()))
                      .model(AudioModel.WHISPER_1)
                      .build();
                  TranslationCreateResponse translation = client.audio().translations().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          translation = openai.audio.translations.create(file: StringIO.new("Example data"), model: :"whisper-1")
          
          puts(translation)
          """,
      },
      response: """
        {
          "text": "Hello, my name is Wolfgang and I come from Germany. Where are you heading today?"
        }
        
        """,
    },
  }
);
