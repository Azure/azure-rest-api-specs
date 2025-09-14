import "./custom/events.tsp";
import "./custom/items.tsp";
import "./custom/tools.tsp";
import "@typespec/http";
import "@typespec/openapi";

using TypeSpec.OpenAPI;

namespace VoiceLive;

model RequestSession {
  ...SessionBase;
  `model`?: string;
  modalities?: Modality[];
  animation?: Animation;
  voice?: Voice;
  instructions?: string;
  input_audio?: InputAudio;
  input_audio_sampling_rate?: int32 = 24000;
  input_audio_format?: AudioFormat = AudioFormat.pcm16;
  output_audio_format?: AudioFormat = AudioFormat.pcm16;
  turn_detection?: TurnDetection | null;
  input_audio_noise_reduction?: AudioNoiseReduction;
  input_audio_echo_cancellation?: AudioEchoCancellation;
  avatar?: AvatarConfig;
  input_audio_transcription?: AudioInputTranscriptionSettings;
  output_audio_timestamp_types?: AudioTimestampType[];
  tools?: Tool[];
  tool_choice?: ToolChoice;
  temperature?: float32;
  max_response_output_tokens?: int32 | "inf";
  agent?: AgentConfig;
}

model ResponseSession extends RequestSession{
  ...SessionBase;
  id?: string;
}

@doc("Supported OpenAI voice names (string enum).")
union OAIVoice {
  string,
  alloy: "alloy",
  ash: "ash",
  ballad: "ballad",
  coral: "coral",
  echo: "echo",
  sage: "sage",
  shimmer: "shimmer",
  verse: "verse",
}

@doc("""
  OpenAI voice configuration with explicit type field.
  
  This provides a unified interface for OpenAI voices, complementing the
  existing string-based OAIVoice for backward compatibility.
  """)
model OpenAIVoice {
  type: "openai";
  name: OAIVoice;
}

// --- Azure voices ----------------------------------------------------------

@doc("Base for Azure voice configurations.")
@discriminator("type")
model AzureVoice {
  type: string;
}

@doc("Azure custom voice configuration (preferred).")
model AzureCustomVoice extends AzureVoice {
  type: "azure-custom";
  @minLength(1) @doc("Voice name cannot be empty.") name: string;
  @minLength(1) @doc("Endpoint ID cannot be empty.") endpoint_id: string;

  @minValue(0)
  @maxValue(1)
  @doc("Temperature must be between 0.0 and 1.0.")
  temperature?: float32;

  custom_lexicon_url?: string;
  prefer_locales?: string[];
  locale?: string;
  style?: string;
  pitch?: string;
  rate?: string;
  volume?: string;
}

@doc("Azure standard voice configuration.")
model AzureStandardVoice extends AzureVoice {
  type: "azure-standard";
  @minLength(1) @doc("Voice name cannot be empty.") name: string;

  @minValue(0)
  @maxValue(1)
  @doc("Temperature must be between 0.0 and 1.0.")
  temperature?: float32;

  custom_lexicon_url?: string;
  prefer_locales?: string[];
  locale?: string;
  style?: string;
  pitch?: string;
  rate?: string;
  volume?: string;
}

@doc("Azure platform voice configuration (variant of standard).")
model AzurePlatformVoice extends AzureVoice {
  type: "azure-platform";
  @minLength(1) @doc("Voice name cannot be empty.") name: string;

  @minValue(0)
  @maxValue(1)
  @doc("Temperature must be between 0.0 and 1.0.")
  temperature?: float32;

  custom_lexicon_url?: string;
  prefer_locales?: string[];
  locale?: string;
  style?: string;
  pitch?: string;
  rate?: string;
  volume?: string;
}

@doc("Azure personal voice configuration.")
model AzurePersonalVoice extends AzureVoice {
  type: "azure-personal";
  @minLength(1) @doc("Voice name cannot be empty.") name: string;

  @minValue(0)
  @maxValue(1)
  @doc("Temperature must be between 0.0 and 1.0.")
  temperature?: float32;

  @doc("Underlying neural model to use for personal voice.")
  `model`: "DragonLatestNeural" | "PhoenixLatestNeural" | "PhoenixV2Neural";
}

// --- Phi4mm voices ---------------------------------------------------------

@doc("Voice identifier for Phi4mm voices.")
union Phi4mmVoice {
  string,
  "cosyvoice",
}

@doc("""
  Voice configuration for LLM (Large Language Model) voices.
  """)
model LLMVoice {
  type: "llm";
  name: Phi4mmVoice;
}

// --- Top-level Voice union -------------------------------------------------

@doc("Union of all supported voice configurations.")
union Voice {
  OAIVoice,
  OpenAIVoice,
  AzureVoice, // includes AzureCustomVoice, CustomVoice, AzurePersonalVoice
  Phi4mmVoice,
  LLMVoice,
}

union AudioFormat {
  string,
  pcm16: "pcm16",
  g711_ulaw: "g711_ulaw",
  g711_alaw: "g711_alaw",
}

union AudioInputTranscriptionModel {
  string,
  whisper_1: "whisper-1",
}

@doc("Configuration for input audio transcription.")
model AudioInputTranscriptionSettings {
  @doc("""
    The transcription model to use. Supported values:
    'whisper-1', 'gpt-4o-transcribe', 'gpt-4o-mini-transcribe',
    'azure-fast-transcription', 'azure-speech'.
    """)
  `model`:
    | string
    | "whisper-1"
    | "gpt-4o-transcribe"
    | "gpt-4o-mini-transcribe"
    | "azure-fast-transcription"
    | "azure-speech";

  @doc("Optional BCP-47 language code (e.g., 'en-US').")
  language?: string;

  @doc("Optional configuration for custom speech models.")
  custom_speech?: Record<string>;

  @doc("Optional list of phrase hints to bias recognition.")
  phrase_list?: string[];
}

union Modality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

@discriminator("model")
@doc("Top-level union for end-of-utterance (EOU) semantic detection configuration.")
model EOUDetection {
  `model`: "semantic_detection_v1" | "semantic_detection_v1_en" | "semantic_detection_v1_multilingual";
}

@doc("Azure semantic end-of-utterance detection (default).")
model AzureSemanticDetection extends EOUDetection {
  `model`: "semantic_detection_v1";
  threshold?: float32;
  timeout?: float32;
  secondary_threshold?: float32;
  secondary_timeout?: float32;
  disable_rules?: boolean;

  // developer options
  sr_boost?: float32;

  extra_imend_check?: boolean;
}

@doc("Azure semantic end-of-utterance detection (English-optimized).")
model AzureSemanticDetectionEn extends EOUDetection {
  `model`: "semantic_detection_v1_en";
  threshold?: float32;
  timeout?: float32;
  secondary_threshold?: float32;
  secondary_timeout?: float32;
  disable_rules?: boolean;

  // developer options
  sr_boost?: float32;

  extra_imend_check?: boolean;
}

@doc("Azure semantic end-of-utterance detection (multilingual).")
model AzureSemanticDetectionMultilingual extends EOUDetection {
  `model`: "semantic_detection_v1_multilingual";
  threshold?: float32;
  timeout?: float32;
  secondary_threshold?: float32;
  secondary_timeout?: float32;
  disable_rules?: boolean;

  // developer options
  sr_boost?: float32;

  extra_imend_check?: boolean;
}

@discriminator("type")
@doc("Top-level union for turn detection configuration.")
model TurnDetection {
  type:
    | "none"
    | "server_vad"
    | "azure_semantic_vad"
    | "azure_semantic_vad_en"
    | "server_sd"
    | "azure_semantic_vad_multilingual";
}

@doc("Disables turn detection.")
model NoTurnDetection extends TurnDetection {
  type: "none";
}

@doc("Base model for VAD-based turn detection.")
model ServerVad extends TurnDetection {
  type: "server_vad";
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD, default variant).")
model AzureSemanticVad extends TurnDetection {
  type: "azure_semantic_vad";
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  neg_threshold?: float32;
  speech_duration_ms?: int32;
  window_size?: int32;
  distinct_ci_phones?: int32;
  require_vowel?: boolean;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD, English-only).")
model AzureSemanticVadEn extends TurnDetection {
  type: "azure_semantic_vad_en";
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  neg_threshold?: float32;
  speech_duration_ms?: int32;
  window_size?: int32;
  distinct_ci_phones?: int32;
  require_vowel?: boolean;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (legacy `server_sd` alias).")
model AzureSemanticVadServer extends TurnDetection {
  type: "server_sd";
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  neg_threshold?: float32;
  speech_duration_ms?: int32;
  window_size?: int32;
  distinct_ci_phones?: int32;
  require_vowel?: boolean;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD).")
model AzureMultilingualSemanticVad extends TurnDetection {
  type: "azure_semantic_vad_multilingual";
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  neg_threshold?: float32;
  speech_duration_ms?: int32;
  window_size?: int32;
  distinct_ci_phones?: int32;
  require_vowel?: boolean;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
}

@doc("Configuration for input audio noise reduction.")
model AudioNoiseReduction {
  @doc("The type of noise reduction model.")
  type: "azure_deep_noise_suppression";
}

@doc("Configuration for client audio input. Used to specify the audio model and optional phrase list.")
model InputAudio {
  @doc("The name of the model to use for input audio (currently only 'azure-standard' is supported).")
  `model`: "azure-standard";

  @doc("Optional list of phrases to bias the speech recognition engine.")
  phrase_list?: string[];
}

@doc("Echo cancellation configuration for server-side audio processing.")
model AudioEchoCancellation {
  @doc("The type of echo cancellation model to use.")
  type: "server_echo_cancellation";
}

@doc("Output timestamp types supported in audio response content.")
union AudioTimestampType {
  string,

  @doc("Timestamps per word in the output audio.")
  word: "word",
}

@doc("Specifies the types of animation data to output.")
union AnimationOutputType {
  blendshapes: "blendshapes",
  viseme_id: "viseme_id",
  emotion: "emotion",
}

@doc("Configuration for animation outputs including blendshapes, visemes, and emotion metadata.")
model Animation {
  @doc("The name of the animation model to use.")
  model_name?: string = "default";

  @doc("Set of output data types requested from the animation system.")
  outputs?: AnimationOutputType[] = #[AnimationOutputType.blendshapes];

  @doc("Interval for emotion detection in milliseconds. If not set, emotion detection is disabled.")
  emotion_detection_interval_ms?: int32;
}

@doc("Configuration for avatar streaming and behavior during the session.")
model AvatarConfig {
  @doc("Optional list of ICE servers to use for WebRTC connection establishment.")
  ice_servers?: IceServer[];

  @doc("The character name or ID used for the avatar.")
  character: string;

  @doc("Optional avatar style, such as emotional tone or speaking style.")
  style?: string;

  @doc("Indicates whether the avatar is customized or not.")
  customized: boolean;

  @doc("Optional video configuration including resolution, bitrate, and codec.")
  video?: VideoParams;
}

@doc("ICE server configuration for WebRTC connection negotiation.")
model IceServer {
  @doc("List of ICE server URLs (e.g., TURN or STUN endpoints).")
  urls: url[];

  @doc("Optional username used for authentication with the ICE server.")
  username?: string;

  @doc("Optional credential (e.g., password or token) used for authentication.")
  credential?: string;
}

model AgentConfig {
  type: "agent";
  name: string;
  description?: string;
  agent_id: string;
  thread_id: string;
}

@doc("Video streaming parameters for avatar.")
model VideoParams {
  @doc("Bitrate in bits per second (e.g., 2000000 for 2 Mbps).")
  bitrate?: int32 = 2000000;

  @doc("Codec to use for encoding. Currently only 'h264' is supported.")
  codec?: "h264" = "h264";

  @doc("Optional cropping settings for the video stream.")
  crop?: VideoCrop;

  @doc("Optional resolution settings for the video stream.")
  resolution?: VideoResolution;
}

@doc("Defines a video crop rectangle using top-left and bottom-right coordinates.")
model VideoCrop {
  @doc("Top-left corner of the crop region. Array of [x, y], must be non-negative integers.")
  @minItems(2)
  @maxItems(2)
  top_left: int32[];

  @doc("Bottom-right corner of the crop region. Array of [x, y], must be non-negative integers.")
  @minItems(2)
  @maxItems(2)
  bottom_right: int32[];
}

@doc("Resolution of the video feed in pixels.")
model VideoResolution {
  @doc("Width of the video in pixels. Must be greater than 0.")
  width: int32;

  @doc("Height of the video in pixels. Must be greater than 0.")
  height: int32;
}
