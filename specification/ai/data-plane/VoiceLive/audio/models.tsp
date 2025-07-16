// Cleaned TypeSpec file aligned with Python model definitions
// Removed models not found in Python code and adjusted field shapes to match Python baseline

import "../common";
import "./custom.tsp";

using TypeSpec.OpenAPI;

namespace VoiceLive;

@doc("""
  The format of the output, in one of these options: `json`, `text`, `srt`, `verbose_json`, or `vtt`. For `gpt-4o-transcribe` and `gpt-4o-mini-transcribe`, the only supported format is `json`.
""")
union AudioResponseFormat {
  "json",
  "text",
  "srt",
  "verbose_json",
  "vtt",
}

model VadConfig {
  @doc("""
    Must be set to `server_vad` to enable manual chunking using server side VAD.
  """)
  type: "server_vad";

  prefix_padding_ms?: int32 = 300;
  silence_duration_ms?: int32 = 200;
  threshold?: float32 = 0.5;
}

@doc("""
  Controls how the audio is cut into chunks. When set to `"auto"`, the
  server first normalizes loudness and then uses voice activity detection (VAD) to
  choose boundaries. `server_vad` object can be provided to tweak VAD detection
  parameters manually. If unset, the audio is transcribed as a single block.
""")
union TranscriptionChunkingStrategy {
  "auto",
  VadConfig,
}

union TranscriptionInclude {
  "logprobs",
}

// Other models removed because they do not correspond to Python models or are redundant
// Please re-add as needed with proper alignment to the source Python definitions

model CreateSpeechRequest {
  @doc("""
    One of the available [TTS models](/docs/models#tts): `tts-1`, `tts-1-hd` or `gpt-4o-mini-tts`.
    """)
  @extension("x-oaiTypeLabel", "string")
  `model`: string | "tts-1" | "tts-1-hd" | "gpt-4o-mini-tts";

  /** The text to generate audio for. The maximum length is 4096 characters. */
  @maxLength(4096)
  input: string;

  @doc("""
    Control the voice of your generated audio with additional instructions. Does not work with `tts-1` or `tts-1-hd`.
    """)
  @maxLength(4096)
  instructions?: string;

  @doc("""
    The voice to use when generating the audio. Supported voices are `alloy`, `ash`, `ballad`, `coral`, `echo`, `fable`, `onyx`, `nova`, `sage`, `shimmer`, and `verse`. Previews of the voices are available in the [Text to speech guide](/docs/guides/text-to-speech#voice-options).
    """)
  voice: VoiceIdsShared;

  @doc("""
    The format to audio in. Supported formats are `mp3`, `opus`, `aac`, `flac`, `wav`, and `pcm`.
    """)
  response_format?: "mp3" | "opus" | "aac" | "flac" | "wav" | "pcm" = "mp3";

  @doc("""
    The speed of the generated audio. Select a value from `0.25` to `4.0`. `1.0` is the default.
    """)
  @minValue(0.25)
  @maxValue(4)
  speed?: float32 = 1;

  @doc("""
    The format to stream the audio in. Supported formats are `sse` and `audio`. `sse` is not supported for `tts-1` or `tts-1-hd`.
    """)
  stream_format?: "sse" | "audio" = "audio";
}

// Tool customization: Convert to discriminated type base
union CreateSpeechResponseStreamEventType {
  speech_audio_delta: "speech.audio.delta",
  speech_audio_done: "speech.audio.done",
}

@discriminator("type")
model CreateSpeechResponseStreamEvent {
  type: CreateSpeechResponseStreamEventType;
}