import "@typespec/openapi";
import "../common/models.tsp";
import "@typespec/http";
using TypeSpec.OpenAPI;
using TypeSpec.Http;
namespace OpenAI;
model CreateSpeechRequest {
  /** One of the available [TTS models](https://platform.openai.com/docs/models#tts): `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`. */
  @extension("x-oaiTypeLabel", "string")
  `model`: string | "tts-1" | "tts-1-hd" | "gpt-4o-mini-tts";

  /** The text to generate audio for. The maximum length is 4096 characters. */
  @maxLength(4096)
  input: string;

  /** Control the voice of your generated audio with additional instructions. Does not work with `tts-1` or `tts-1-hd`. */
  @maxLength(4096)
  instructions?: string;

  /** The voice to use when generating the audio. Supported voices are `alloy`, `ash`, `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and `verse`. Previews of the voices are available in the [Text to speech guide](https://platform.openai.com/docs/guides/text-to-speech#voice-options). */
  voice: VoiceIdsShared;

  /** The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`, `wav`, and `pcm`. */
  response_format?: "mp3" | "opus" | "aac" | "flac" | "wav" | "pcm" = "mp3";

  /** The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is the default. */
  @maxValue(4)
  @minValue(0.25)
  speed?: numeric = 1;

  /** The format to stream the audio in. Supported formats are `sse` and `audio`. `sse` is not supported for `tts-1` or `tts-1-hd`. */
  stream_format?: "sse" | "audio" = "audio";
}

/** Emitted for each chunk of audio data generated during speech synthesis. */
@extension(
  "x-oaiMeta",
  #{
    name: "Stream Event (speech.audio.delta)",
    group: "speech",
    example: "{\n  \"type\": \"speech.audio.delta\",\n  \"audio\": \"base64-encoded-audio-data\"\n}\n",
  }
)
model SpeechAudioDeltaEvent {
  /** The type of the event. Always `speech.audio.delta`. */
  @extension("x-stainless-const", true)
  type: "speech.audio.delta";

  /** A chunk of Base64-encoded audio data. */
  audio: string;
}

/** Emitted when the speech synthesis is complete and all audio has been streamed. */
@extension(
  "x-oaiMeta",
  #{
    name: "Stream Event (speech.audio.done)",
    group: "speech",
    example: "{\n  \"type\": \"speech.audio.done\",\n  \"usage\": {\n    \"input_tokens\": 14,\n    \"output_tokens\": 101,\n    \"total_tokens\": 115\n  }\n}\n",
  }
)
model SpeechAudioDoneEvent {
  /** The type of the event. Always `speech.audio.done`. */
  @extension("x-stainless-const", true)
  type: "speech.audio.done";

  /** Token usage statistics for the request. */
  usage: {
    input_tokens: integer;
    output_tokens: integer;
    total_tokens: integer;
  };
}

model CreateTranscriptionRequest {
  /** The audio file object (not file name) to transcribe, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm. */
  @extension("x-oaiMeta", #{ exampleFilePath: "speech.mp3" })
  @extension("x-oaiTypeLabel", "file")
  file: HttpPart<bytes>;

  /** ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transcribe`, and `whisper-1` (which is powered by our open source Whisper V2 model). */
  @extension("x-oaiTypeLabel", "string")
  `model`: HttpPart<
    | string
    | "whisper-1"
    | "gpt-4o-transcribe"
    | "gpt-4o-mini-transcribe">;

  /** The language of the input audio. Supplying the input language in [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`) format will improve accuracy and latency. */
  language?: HttpPart<string>;

  /** An optional text to guide the model's style or continue a previous audio segment. The [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting) should match the audio language. */
  prompt?: HttpPart<string>;

  response_format?: HttpPart<AudioResponseFormat>;

  /** The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use [log probability](https://en.wikipedia.org/wiki/Log_probability) to automatically increase the temperature until certain thresholds are hit. */
  temperature?: HttpPart<numeric>;

  /**If set to true, the model response data will be streamed to the client
  as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format).
  See the [Streaming section of the Speech-to-Text guide](https://platform.openai.com/docs/guides/speech-to-text?lang=curl#streaming-transcriptions)
  for more information.

  Note: Streaming is not supported for the `whisper-1` model and will be ignored.*/
  stream?: HttpPart<boolean | null>;

  chunking_strategy?: HttpPart<TranscriptionChunkingStrategy>;

  /** The timestamp granularities to populate for this transcription. `response_format` must be set `verbose_json` to use timestamp granularities. Either or both of these options are supported: `word`, or `segment`. Note: There is no additional latency for segment timestamps, but generating word timestamps incurs additional latency. */
  timestamp_granularities?: HttpPart<("word" | "segment")[]>;

  /**Additional information to include in the transcription response.
  `logprobs` will return the log probabilities of the tokens in the
  response to understand the model's confidence in the transcription.
  `logprobs` only works with response_format set to `json` and only with
  the models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`.*/
  include?: HttpPart<TranscriptionInclude[]>;
}

model VadConfig {
  /** Must be set to `server_vad` to enable manual chunking using server side VAD. */
  type: "server_vad";

  /**Amount of audio to include before the VAD detected speech (in
  milliseconds).*/
  prefix_padding_ms?: integer = 300;

  /**Duration of silence to detect speech stop (in milliseconds).
  With shorter values the model will respond more quickly,
  but may jump in on short pauses from the user.*/
  silence_duration_ms?: integer = 200;

  /**Sensitivity threshold (0.0 to 1.0) for voice activity detection. A
  higher threshold will require louder audio to activate the model, and
  thus might perform better in noisy environments.*/
  threshold?: numeric = 0.5;
}

/** Represents a transcription response returned by model, based on the provided input. */
@extension(
  "x-oaiMeta",
  #{
    name: "The transcription object (JSON)",
    group: "audio",
    example: "{\n  \"text\": \"Imagine the wildest idea that you've ever had, and you're curious about how it might scale to something that's a 100, a 1,000 times bigger. This is a place where you can get to do that.\",\n  \"usage\": {\n    \"type\": \"tokens\",\n    \"input_tokens\": 14,\n    \"input_token_details\": {\n      \"text_tokens\": 10,\n      \"audio_tokens\": 4\n    },\n    \"output_tokens\": 101,\n    \"total_tokens\": 115\n  }\n}\n",
  }
)
model CreateTranscriptionResponseJson {
  /** The transcribed text. */
  text: string;

  /** The log probabilities of the tokens in the transcription. Only returned with the models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added to the `include` array. */
  logprobs?: {
    token?: string;
    logprob?: numeric;
    bytes?: numeric[];
  }[];

  /** Token usage statistics for the request. */
  usage?: TranscriptTextUsageTokens | TranscriptTextUsageDuration;
}

/** Usage statistics for models billed by token usage. */
@summary("Token Usage")
model TranscriptTextUsageTokens {
  /** The type of the usage object. Always `tokens` for this variant. */
  @extension("x-stainless-const", true)
  type: "tokens";

  /** Number of input tokens billed for this request. */
  input_tokens: integer;

  /** Details about the input tokens billed for this request. */
  input_token_details?: {
    text_tokens?: integer;
    audio_tokens?: integer;
  };

  /** Number of output tokens generated. */
  output_tokens: integer;

  /** Total number of tokens used (input + output). */
  total_tokens: integer;
}

/** Usage statistics for models billed by audio input duration. */
@summary("Duration Usage")
model TranscriptTextUsageDuration {
  /** The type of the usage object. Always `duration` for this variant. */
  @extension("x-stainless-const", true)
  type: "duration";

  /** Duration of the input audio in seconds. */
  seconds: numeric;
}

/** Emitted when there is an additional text delta. This is also the first event emitted when the transcription starts. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`. */
@extension(
  "x-oaiMeta",
  #{
    name: "Stream Event (transcript.text.delta)",
    group: "transcript",
    example: "{\n  \"type\": \"transcript.text.delta\",\n  \"delta\": \" wonderful\"\n}\n",
  }
)
model TranscriptTextDeltaEvent {
  /** The type of the event. Always `transcript.text.delta`. */
  @extension("x-stainless-const", true)
  type: "transcript.text.delta";

  /** The text delta that was additionally transcribed. */
  delta: string;

  /** The log probabilities of the delta. Only included if you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`. */
  logprobs?: {
    token?: string;
    logprob?: numeric;
    bytes?: integer[];
  }[];
}

/** Emitted when the transcription is complete. Contains the complete transcription text. Only emitted when you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `Stream` parameter set to `true`. */
@extension(
  "x-oaiMeta",
  #{
    name: "Stream Event (transcript.text.done)",
    group: "transcript",
    example: "{\n  \"type\": \"transcript.text.done\",\n  \"text\": \"I see skies of blue and clouds of white, the bright blessed days, the dark sacred nights, and I think to myself, what a wonderful world.\",\n  \"usage\": {\n    \"type\": \"tokens\",\n    \"input_tokens\": 14,\n    \"input_token_details\": {\n      \"text_tokens\": 10,\n      \"audio_tokens\": 4\n    },\n    \"output_tokens\": 31,\n    \"total_tokens\": 45\n  }\n}\n",
  }
)
model TranscriptTextDoneEvent {
  /** The type of the event. Always `transcript.text.done`. */
  @extension("x-stainless-const", true)
  type: "transcript.text.done";

  /** The text that was transcribed. */
  text: string;

  /** The log probabilities of the individual tokens in the transcription. Only included if you [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription) with the `include[]` parameter set to `logprobs`. */
  logprobs?: {
    token?: string;
    logprob?: numeric;
    bytes?: integer[];
  }[];

  usage?: TranscriptTextUsageTokens;
}

/** Represents a verbose json transcription response returned by model, based on the provided input. */
@extension(
  "x-oaiMeta",
  #{
    name: "The transcription object (Verbose JSON)",
    group: "audio",
    example: "{\n  \"task\": \"transcribe\",\n  \"language\": \"english\",\n  \"duration\": 8.470000267028809,\n  \"text\": \"The beach was a popular spot on a hot summer day. People were swimming in the ocean, building sandcastles, and playing beach volleyball.\",\n  \"segments\": [\n    {\n      \"id\": 0,\n      \"seek\": 0,\n      \"start\": 0.0,\n      \"end\": 3.319999933242798,\n      \"text\": \" The beach was a popular spot on a hot summer day.\",\n      \"tokens\": [\n        50364, 440, 7534, 390, 257, 3743, 4008, 322, 257, 2368, 4266, 786, 13, 50530\n      ],\n      \"temperature\": 0.0,\n      \"avg_logprob\": -0.2860786020755768,\n      \"compression_ratio\": 1.2363636493682861,\n      \"no_speech_prob\": 0.00985979475080967\n    },\n    ...\n  ],\n  \"usage\": {\n    \"type\": \"duration\",\n    \"seconds\": 9\n  }\n}\n",
  }
)
model CreateTranscriptionResponseVerboseJson {
  /** The language of the input audio. */
  language: string;

  /** The duration of the input audio. */
  duration: numeric;

  /** The transcribed text. */
  text: string;

  /** Extracted words and their corresponding timestamps. */
  words?: TranscriptionWord[];

  /** Segments of the transcribed text and their corresponding details. */
  segments?: TranscriptionSegment[];

  usage?: TranscriptTextUsageDuration;
}

model TranscriptionWord {
  /** The text content of the word. */
  word: string;

  /** Start time of the word in seconds. */
  start: float32;

  /** End time of the word in seconds. */
  end: float32;
}

model TranscriptionSegment {
  /** Unique identifier of the segment. */
  id: integer;

  /** Seek offset of the segment. */
  seek: integer;

  /** Start time of the segment in seconds. */
  start: float32;

  /** End time of the segment in seconds. */
  end: float32;

  /** Text content of the segment. */
  text: string;

  /** Array of token IDs for the text content. */
  tokens: integer[];

  /** Temperature parameter used for generating the segment. */
  temperature: float32;

  /** Average logprob of the segment. If the value is lower than -1, consider the logprobs failed. */
  avg_logprob: float32;

  /** Compression ratio of the segment. If the value is greater than 2.4, consider the compression failed. */
  compression_ratio: float32;

  /** Probability of no speech in the segment. If the value is higher than 1.0 and the `avg_logprob` is below -1, consider this segment silent. */
  no_speech_prob: float32;
}

model CreateTranslationRequest {
  /** The audio file object (not file name) translate, in one of these formats: flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm. */
  @extension("x-oaiMeta", #{ exampleFilePath: "speech.mp3" })
  @extension("x-oaiTypeLabel", "file")
  file: HttpPart<bytes>;

  /** ID of the model to use. Only `whisper-1` (which is powered by our open source Whisper V2 model) is currently available. */
  @extension("x-oaiTypeLabel", "string")
  `model`: HttpPart<string | "whisper-1">;

  /** An optional text to guide the model's style or continue a previous audio segment. The [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting) should be in English. */
  prompt?: HttpPart<string>;

  /** The format of the output, in one of these options: `json`, `text`, `srt`, `verbose_json`, or `vtt`. */
  response_format?: HttpPart<"json" | "text" | "srt" | "verbose_json" | "vtt">;

  /** The sampling temperature, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. If set to 0, the model will use [log probability](https://en.wikipedia.org/wiki/Log_probability) to automatically increase the temperature until certain thresholds are hit. */
  temperature?: HttpPart<numeric>;
}

model CreateTranslationResponseJson {
  text: string;
}

model CreateTranslationResponseVerboseJson {
  /** The language of the output translation (always `english`). */
  language: string;

  /** The duration of the input audio. */
  duration: numeric;

  /** The translated text. */
  text: string;

  /** Segments of the translated text and their corresponding details. */
  segments?: TranscriptionSegment[];
}

/**Configuration for turn detection, ether Server VAD or Semantic VAD. This can be set to `null` to turn off, in which case the client must manually trigger model response.

Server VAD means that the model will detect the start and end of speech based on audio volume and respond at the end of user speech.

Semantic VAD is more advanced and uses a turn detection model (in conjunction with VAD) to semantically estimate whether the user has finished speaking, then dynamically sets a timeout based on this probability. For example, if user audio trails off with "uhhm", the model will score a low probability of turn end and wait longer for the user to continue speaking. This can be useful for more natural conversations, but may have a higher latency.*/
@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
@summary("Realtime Turn Detection")
union RealtimeTurnDetection {
  server_vad: {
    type: "server_vad" = "server_vad",
    threshold?: numeric,
    prefix_padding_ms?: integer,
    silence_duration_ms?: integer,
    create_response?: boolean = true,
    interrupt_response?: boolean = true,

    @maxValue(30000)
    @minValue(5000)
    idle_timeout_ms?: integer | null,
  },
  semantic_vad: {
    type: "semantic_vad" = "semantic_vad",
    eagerness?: "low" | "medium" | "high" | "auto" = "auto",
    create_response?: boolean = true,
    interrupt_response?: boolean = true,
  },
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union CreateSpeechResponseStreamEvent {
  `speech.audio.delta`: SpeechAudioDeltaEvent,
  `speech.audio.done`: SpeechAudioDoneEvent,
}

@discriminated(#{ envelope: "none", discriminatorPropertyName: "type" })
union CreateTranscriptionResponseStreamEvent {
  `transcript.text.delta`: TranscriptTextDeltaEvent,
  `transcript.text.done`: TranscriptTextDoneEvent,
}

/** Controls how the audio is cut into chunks. When set to `"auto"`, the server first normalizes loudness and then uses voice activity detection (VAD) to choose boundaries. `server_vad` object can be provided to tweak VAD detection parameters manually. If unset, the audio is transcribed as a single block. */
@extension("x-oaiTypeLabel", "string")
union TranscriptionChunkingStrategy {
  "auto",
  VadConfig,
  null,
}

/** The format of the output, in one of these options: `json`, `text`, `srt`, `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`, the only supported format is `json`. */
enum AudioResponseFormat {
  json,
  text,
  srt,
  verbose_json,
  vtt,
}

enum TranscriptionInclude {
  logprobs,
}
