import "./custom/events.tsp";
import "./custom/items.tsp";
import "./custom/tools.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace VoiceLive;

@usage(RequestUsage)
model RequestSession {
  ...SessionBase;
  `model`?: string;
  modalities?: Modality[];
  animation?: Animation;
  voice?: Voice;
  instructions?: string;

  @doc("""
    Input audio sampling rate in Hz. Available values:
    - For pcm16: 8000, 16000, 24000
    - For g711_alaw/g711_ulaw: 8000
    """)
  input_audio_sampling_rate?: int32 = 24000;

  input_audio_format?: InputAudioFormat = InputAudioFormat.pcm16;
  output_audio_format?: OutputAudioFormat = OutputAudioFormat.pcm16;
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
}

@usage(ResponseUsage)
model ResponseSession extends RequestSession {
  ...SessionBase;
  agent?: AgentConfig;
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
@usage(RequestUsage)
model OpenAIVoice {
  type: "openai";
  name: OAIVoice;
}

// --- Azure voices ----------------------------------------------------------

@doc("Base for Azure voice configurations.")
@discriminator("type")
@usage(DualUsage)
model AzureVoice {
  type: string;
}

@usage(DualUsage)
@doc("Azure custom voice configuration.")
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
@usage(DualUsage)
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

@doc("Azure personal voice configuration.")
@usage(DualUsage)
model AzurePersonalVoice extends AzureVoice {
  type: "azure-personal";
  @minLength(1) @doc("Voice name cannot be empty.") name: string;

  @minValue(0)
  @maxValue(1)
  @doc("Temperature must be between 0.0 and 1.0.")
  temperature?: float32;

  @doc("Underlying neural model to use for personal voice.")
  `model`: PersonalVoiceModels
}

@doc("PersonalVoice models")
union PersonalVoiceModels {
  string,
  "DragonLatestNeural",
  "PhoenixLatestNeural",
  "PhoenixV2Neural"
}

// --- Top-level Voice union -------------------------------------------------

@doc("Union of all supported voice configurations.")
union Voice {
  OAIVoice,
  OpenAIVoice,
  AzureVoice, // includes AzureCustomVoice, CustomVoice, AzurePersonalVoice
}

union InputAudioFormat {
  string,
  pcm16: "pcm16",
  g711_ulaw: "g711_ulaw",
  g711_alaw: "g711_alaw",
}

union OutputAudioFormat {
  string,

  @doc("16-bit PCM audio format at default sampling rate (24kHz)")
  pcm16: "pcm16",

  @doc("16-bit PCM audio format at 8kHz sampling rate")
  pcm16_8000hz: "pcm16-8000hz",

  @doc("16-bit PCM audio format at 16kHz sampling rate")
  pcm16_16000hz: "pcm16-16000hz",

  @doc("G.711 μ-law (mu-law) audio format at 8kHz sampling rate")
  g711_ulaw: "g711_ulaw",

  @doc("G.711 A-law audio format at 8kHz sampling rate")
  g711_alaw: "g711_alaw",
}

union AudioInputTranscriptionModel {
  string,
  whisper_1: "whisper-1",
}

@doc("Configuration for input audio transcription.")
@usage(RequestUsage)
model AudioInputTranscriptionSettings {
  @doc("""
    The transcription model to use. Supported values:
    'whisper-1', 'gpt-4o-transcribe', 'gpt-4o-mini-transcribe',
    'azure-speech'.
    """)
  `model`:
    | string
    | "whisper-1"
    | "gpt-4o-transcribe"
    | "gpt-4o-mini-transcribe"
    | "azure-speech";

  @doc("Optional language code in BCP-47 (e.g., 'en-US'), or ISO-639-1 (e.g., 'en'), or multi languages with auto detection, (e.g., 'en,zh').")
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
@usage(RequestUsage)
model EOUDetection {
  `model`: "semantic_detection_v1" | "semantic_detection_v1_en" | "semantic_detection_v1_multilingual";
}

@doc("Azure semantic end-of-utterance detection (default).")
@usage(RequestUsage)
model AzureSemanticDetection extends EOUDetection {
  `model`: "semantic_detection_v1";

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  timeout?: float32;
}

@doc("Azure semantic end-of-utterance detection (English-optimized).")
@usage(RequestUsage)
model AzureSemanticDetectionEn extends EOUDetection {
  `model`: "semantic_detection_v1_en";

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  timeout?: float32;
}

@doc("Azure semantic end-of-utterance detection (multilingual).")
@usage(RequestUsage)
model AzureSemanticDetectionMultilingual extends EOUDetection {
  `model`: "semantic_detection_v1_multilingual";
  threshold?: float32;
  timeout?: float32;
}

@discriminator("type")
@doc("Top-level union for turn detection configuration.")
@usage(RequestUsage)
model TurnDetection {
  type: TurnDetectionType;
}

union TurnDetectionType {
  string,
  server_vad: "server_vad",
  azure_semantic_vad: "azure_semantic_vad",
  azure_semantic_vad_en: "azure_semantic_vad_en",
  azure_semantic_vad_multilingual: "azure_semantic_vad_multilingual",
}

@doc("Base model for VAD-based turn detection.")
@usage(DualUsage)
model ServerVad extends TurnDetection {
  type: "server_vad";

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD, default variant).")
@usage(DualUsage)
model AzureSemanticVad extends TurnDetection {
  type: "azure_semantic_vad";

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  speech_duration_ms?: int32;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD, English-only).")
@usage(DualUsage)
model AzureSemanticVadEn extends TurnDetection {
  type: "azure_semantic_vad_en";

  @minValue(0)
  @maxValue(1)
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  speech_duration_ms?: int32;
  remove_filler_words?: boolean = false;
  auto_truncate?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD).")
@usage(DualUsage)
model AzureSemanticVadMultilingual extends TurnDetection {
  type: "azure_semantic_vad_multilingual";

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EOUDetection;
  speech_duration_ms?: int32;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
}

@doc("Configuration for input audio noise reduction.")
@usage(RequestUsage)
model AudioNoiseReduction {
  @doc("The type of noise reduction model.")
  type: "azure_deep_noise_suppression" | "near_field" | "far_field";
}

@doc("Echo cancellation configuration for server-side audio processing.")
@usage(RequestUsage)
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
}

@doc("Configuration for animation outputs including blendshapes and visemes metadata.")
@usage(RequestUsage)
model Animation {
  @doc("The name of the animation model to use.")
  model_name?: string = "default";

  @doc("Set of output data types requested from the animation system.")
  outputs?: AnimationOutputType[] = #[AnimationOutputType.blendshapes];
}

@doc("Configuration for avatar streaming and behavior during the session.")
@usage(RequestUsage)
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
@usage(RequestUsage)
model IceServer {
  @doc("List of ICE server URLs (e.g., TURN or STUN endpoints).")
  urls: url[];

  @doc("Optional username used for authentication with the ICE server.")
  username?: string;

  @doc("Optional credential (e.g., password or token) used for authentication.")
  credential?: string;
}

@usage(RequestUsage)
model AgentConfig {
  type: "agent";
  name: string;
  description?: string;
  agent_id: string;
  thread_id: string;
}

@doc("Video streaming parameters for avatar.")
@usage(RequestUsage)
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
@usage(RequestUsage)
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
@usage(RequestUsage)
model VideoResolution {
  @doc("Width of the video in pixels. Must be greater than 0.")
  width: int32;

  @doc("Height of the video in pixels. Must be greater than 0.")
  height: int32;
}
