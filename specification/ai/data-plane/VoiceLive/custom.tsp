import "./events.tsp";
import "./items.tsp";
import "./tools.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Base for session configuration shared between request and response.")
model RequestSession {
  ...SessionBase;
  @doc("The model for the session.")
  `model`?: string;
  @doc("The modalities to be used in the session.")
  modalities?: Modality[];
  @doc("The animation configuration for the session.")
  animation?: Animation;
  @doc("The voice configuration for the session.")
  voice?: Voice;
  @doc("Optional instructions to guide the model's behavior throughout the session.")
  instructions?: string;

  @doc("""
    Input audio sampling rate in Hz. Available values:
    - For pcm16: 8000, 16000, 24000
    - For g711_alaw/g711_ulaw: 8000
    """)
  input_audio_sampling_rate?: int32 = 24000;

  @doc("Input audio format. Default is 'pcm16'.")
  input_audio_format?: InputAudioFormat = InputAudioFormat.pcm16;
  @doc("Output audio format. Default is 'pcm16'.")
  output_audio_format?: OutputAudioFormat = OutputAudioFormat.pcm16;
  @doc("Type of turn detection to use.")  
  turn_detection?: TurnDetection;
  @doc("Configuration for input audio noise reduction.")
  input_audio_noise_reduction?: AudioNoiseReduction;
  @doc("Configuration for echo cancellation during server-side audio processing.")
  input_audio_echo_cancellation?: AudioEchoCancellation;
  @doc("Configuration for avatar streaming and behavior during the session.")
  avatar?: AvatarConfig;
  @doc("Configuration for input audio transcription.")
  input_audio_transcription?: AudioInputTranscriptionOptions;
  @doc("Types of timestamps to include in audio response content.")
  output_audio_timestamp_types?: AudioTimestampType[];
  @doc("Configuration for tools to be used during the session, if applicable.")
  tools?: Tool[];
  @doc("Specifies which tools the model is allowed to call during the session.")
  tool_choice?: ToolChoice;
  @doc("Controls the randomness of the model's output. Range: 0.0 to 1.0. Default is 0.7.")
  temperature?: float32;
  @doc("Maximum number of tokens to generate in the response. Default is unlimited.")
  max_response_output_tokens?: int32 | "inf";
}

@usage(ResponseUsage)
@doc("Base for session configuration in the response.")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" // Being able to use the returned options as input is useful
model ResponseSession extends RequestSession {
  ...SessionBase;
  @doc("The agent configuration for the session, if applicable.")
  agent?: AgentConfig;
  @doc("The unique identifier for the session.")
  id?: string;
}

@doc("Supported OpenAI voice names (string enum).")
union OAIVoice {
  string,
  @doc("Alloy voice.")
  alloy: "alloy",
  @doc("Ash voice.")
  ash: "ash",
  @doc("Ballard voice.")
  ballad: "ballad",
  @doc("Coral voice.")
  coral: "coral",
  @doc("Echo voice.")
  echo: "echo",
  @doc("Sage voice.")
  sage: "sage",
  @doc("Shimmer voice.")
  shimmer: "shimmer",
  @doc("Verse voice.")
  verse: "verse",
}

@doc("""
  OpenAI voice configuration with explicit type field.
  
  This provides a unified interface for OpenAI voices, complementing the
  existing string-based OAIVoice for backward compatibility.
  """)
@usage(RequestUsage)
model OpenAIVoice {
  @doc("The type of the voice.")
  type: "openai";
  @doc("The name of the OpenAI voice.")
  name: OAIVoice;
}

// --- Azure voices ----------------------------------------------------------

@doc("Base for Azure voice configurations.")
@discriminator("type")
@usage(DualUsage)
model AzureVoice {
  @doc("The type of the Azure voice.")
  type: AzureVoiceType;
}

@doc("Union of all supported Azure voice types.")
union AzureVoiceType {
  string,
  @doc("Azure custom voice.")
  azure_custom: "azure-custom",
  @doc("Azure standard voice.")
  azure_standard: "azure-standard",
  @doc("Azure personal voice.")
  azure_personal: "azure-personal",
}
@usage(DualUsage)
@doc("Azure custom voice configuration.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureCustomVoice extends AzureVoice {
  type: AzureVoiceType.azure_custom;

  @minLength(1)
  @doc("Voice name cannot be empty.")
  name: string;

  @minLength(1)
  @doc("Endpoint ID cannot be empty.")
  endpoint_id: string;

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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureStandardVoice extends AzureVoice {
  type: AzureVoiceType.azure_standard;

  @minLength(1)
  @doc("Voice name cannot be empty.")
  name: string;

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
  type: AzureVoiceType.azure_personal;
  @minLength(1) @doc("Voice name cannot be empty.") name: string;

  @minValue(0)
  @maxValue(1)
  @doc("Temperature must be between 0.0 and 1.0.")
  temperature?: float32;

  @doc("Underlying neural model to use for personal voice.")
  `model`: PersonalVoiceModels;
}

@doc("PersonalVoice models")
union PersonalVoiceModels {
  string,
  @doc("Use the latest Dragon model.")
  "DragonLatestNeural",
  @doc("Use the latest Phoenix model.")
  "PhoenixLatestNeural",
  @doc("Use the Phoenix V2 model.")
  "PhoenixV2Neural",
}

// --- Top-level Voice union -------------------------------------------------

@doc("Union of all supported voice configurations.")
union Voice {
  OAIVoice,
  OpenAIVoice,
  AzureVoice, // includes AzureCustomVoice, CustomVoice, AzurePersonalVoice
}

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Input audio format types supported.")
union InputAudioFormat {
  string,
  @doc("16-bit PCM audio format at default sampling rate (24kHz)")
  pcm16: "pcm16",
  @doc("G.711 μ-law (mu-law) audio format at 8kHz sampling rate")
  g711_ulaw: "g711_ulaw",
  @doc("G.711 A-law audio format at 8kHz sampling rate")
  g711_alaw: "g711_alaw",
}

@doc("Output audio format types supported.")
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

#suppress "@azure-tools/typespec-azure-core/casing-style"
@doc("Supported audio input transcription models.")
union AudioInputTranscriptionModel {
  string,
  @doc("OpenAI Whisper model.")
  whisper_1: "whisper-1",
}

@doc("Configuration for input audio transcription.")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AudioInputTranscriptionOptions {
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

@doc("Supported modalities for the session.")
union Modality {
  string,
  @doc("Text modality.")
  text: "text",
  @doc("Audio modality.")
  audio: "audio",
  @doc("Animation modality.")
  animation: "animation",
  @doc("Avatar modality.")
  avatar: "avatar",
}

@discriminator("model")
@doc("Top-level union for end-of-utterance (EOU) semantic detection configuration.")
@usage(RequestUsage)
model EouDetection {
  `model`: "semantic_detection_v1" | "semantic_detection_v1_en" | "semantic_detection_v1_multilingual" | string;
}

@doc("Threshold level settings for Azure semantic end-of-utterance detection.")
union EouThresholdLevel
{
  string,
  @doc("Low sensitivity threshold level.")
  "low",
  @doc("Medium sensitivity threshold level.")
  "medium",
  @doc("High sensitivity threshold level.")
  "high",
  @doc("Default sensitivity threshold level.")
  "default"
}
@doc("Azure semantic end-of-utterance detection (default).")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureSemanticDetection extends EouDetection {
  `model`: "semantic_detection_v1";

  @doc("Threshold level setting. Recommended instead of `threshold`. One of `low`, `medium`, `high`, or `default`.")
  threshold_level?: EouThresholdLevel; 

  @doc("Timeout in milliseconds. Recommended instead of `timeout`.")
  @minValue(0)
  timeout_ms?: int32;
}

@doc("Azure semantic end-of-utterance detection (English-optimized).")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureSemanticDetectionEn extends EouDetection {
  `model`: "semantic_detection_v1_en";

  @doc("Threshold level setting. Recommended instead of `threshold`. One of `low`, `medium`, `high`, or `default`.")
  threshold_level?: EouThresholdLevel;

  @doc("Timeout in milliseconds. Recommended instead of `timeout`.")
  @minValue(0)
  timeout_ms?: int32;
}

@doc("Azure semantic end-of-utterance detection (multilingual).")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureSemanticDetectionMultilingual extends EouDetection {
  `model`: "semantic_detection_v1_multilingual";

  @doc("Threshold level setting. Recommended instead of `threshold`. One of `low`, `medium`, `high`, or `default`.")
  threshold_level?: EouThresholdLevel;

  @doc("Timeout in milliseconds. Recommended instead of `timeout`.")
  @minValue(0)
  timeout_ms?: int32;
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
model ServerVad extends TurnDetection {
  type: TurnDetectionType.server_vad;

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EouDetection;
  auto_truncate?: boolean = false;
  create_response?: boolean = false;
  interrupt_response?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD, default variant).")
@usage(DualUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureSemanticVad extends TurnDetection {
  type: TurnDetectionType.azure_semantic_vad;

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EouDetection;
  speech_duration_ms?: int32;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
  create_response?: boolean = false;
  interrupt_response?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD, English-only).")
@usage(DualUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureSemanticVadEn extends TurnDetection {
  type: TurnDetectionType.azure_semantic_vad_en;

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EouDetection;
  speech_duration_ms?: int32;
  remove_filler_words?: boolean = false;
  auto_truncate?: boolean = false;
  create_response?: boolean = false;
  interrupt_response?: boolean = false;
}

@doc("Server Speech Detection (Azure semantic VAD).")
@usage(DualUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AzureSemanticVadMultilingual extends TurnDetection {
  type: TurnDetectionType.azure_semantic_vad_multilingual;

  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: EouDetection;
  speech_duration_ms?: int32;
  remove_filler_words?: boolean = false;
  languages?: string[];
  auto_truncate?: boolean = false;
  create_response?: boolean = false;
  interrupt_response?: boolean = false;
}

@doc("Configuration for input audio noise reduction.")
@usage(RequestUsage)
model AudioNoiseReduction {
  @doc("The type of noise reduction model.")
  type: "azure_deep_noise_suppression" | "near_field" | "far_field" | string;
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
#suppress "@azure-tools/typespec-azure-core/casing-style"
union AnimationOutputType {
  string,
  @doc("Blendshapes output type.")
  blendshapes: "blendshapes",
  @doc("Viseme ID output type.")
  viseme_id: "viseme_id",
}

@doc("Configuration for animation outputs including blendshapes and visemes metadata.")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model Animation {
  @doc("The name of the animation model to use.")
  model_name?: string = "default";

  @doc("Set of output data types requested from the animation system.")
  outputs?: AnimationOutputType[] = #[AnimationOutputType.blendshapes];
}

@doc("Configuration for avatar streaming and behavior during the session.")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
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
@doc("Configuration for the agent.")
#suppress "@azure-tools/typespec-azure-core/casing-style"
model AgentConfig {
  @doc("The type of agent to use.")
  type: "agent";
  @doc("The name of the agent.")
  name: string;
  @doc("Optional description of the agent.")
  description?: string;
  @doc("The ID of the agent.")
  agent_id: string;
  @doc("The ID of the conversation thread.")
  thread_id: string;
}

@doc("Video streaming parameters for avatar.")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model VideoParams {
  @doc("Bitrate in bits per second (e.g., 2000000 for 2 Mbps).")
  bitrate?: int32 = 2000000;

  @doc("Codec to use for encoding. Currently only 'h264' is supported.")
  codec?: "h264" = "h264";

  @doc("Optional cropping settings for the video stream.")
  crop?: VideoCrop;

  @doc("Optional resolution settings for the video stream.")
  resolution?: VideoResolution;

  @doc("Optional background settings for the video. Allows specifying either a solid color or an image URL.")
  background?: Background;

  @doc("Group of Pictures (GOP) size for video encoding. Controls the interval between keyframes, affecting compression efficiency and seeking performance.")
  @minValue(1)
  @maxValue(2000)
  gop_size?: int32 = 10;
}

@doc("Defines a video crop rectangle using top-left and bottom-right coordinates.")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
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

@doc("Defines a video background, either a solid color or an image URL (mutually exclusive).")
@usage(RequestUsage)
#suppress "@azure-tools/typespec-azure-core/casing-style"
model Background {
  @doc("Background color in hex format (e.g., `#00FF00FF`). Cannot be set if `image_url` is provided.")
  color?: string;

  @doc("Background image URL. Cannot be set if `color` is provided.")
  image_url?: string;
}
