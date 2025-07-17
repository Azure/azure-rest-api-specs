// Cleaned TypeSpec file aligned with Python model definitions
// Removed models not found in Python code and adjusted field shapes to match Python baseline

import "../common";

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