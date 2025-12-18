import "./events.tsp";
import "./items.tsp";
import "./tools.tsp";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace VoiceLive;

/** Base for session configuration shared between request and response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style. // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model RequestSession {
  ...SessionBase;

  /** The model for the session. */
  `model`?: string;

  /** The modalities to be used in the session. */
  modalities?: Modality[];

  /** The animation configuration for the session. */
  animation?: Animation;

  /** The voice configuration for the session. */
  voice?: Voice;

  /** Optional instructions to guide the model's behavior throughout the session. */
  instructions?: string;

  /**

   * Input audio sampling rate in Hz. Available values:

   * - For pcm16: 8000, 16000, 24000

   * - For g711_alaw/g711_ulaw: 8000

   */
  input_audio_sampling_rate?: int32 = 24000;

  /** Input audio format. Default is 'pcm16'. */
  input_audio_format?: InputAudioFormat = InputAudioFormat.pcm16;

  /** Output audio format. Default is 'pcm16'. */
  output_audio_format?: OutputAudioFormat = OutputAudioFormat.pcm16;

  /** Type of turn detection to use. */
  turn_detection?: TurnDetection;

  /** Configuration for input audio noise reduction. */
  input_audio_noise_reduction?: AudioNoiseReduction;

  /** Configuration for echo cancellation during server-side audio processing. */
  input_audio_echo_cancellation?: AudioEchoCancellation;

  /** Configuration for avatar streaming and behavior during the session. */
  avatar?: AvatarConfig;

  /** Configuration for input audio transcription. */
  input_audio_transcription?: AudioInputTranscriptionOptions;

  /** Types of timestamps to include in audio response content. */
  output_audio_timestamp_types?: AudioTimestampType[];

  /** Configuration for tools to be used during the session, if applicable. */
  tools?: Tool[];

  /** Specifies which tools the model is allowed to call during the session. */
  tool_choice?: ToolChoice;

  /** Controls the randomness of the model's output. Range: 0.0 to 1.0. Default is 0.7. */
  temperature?: float32;

  /** Maximum number of tokens to generate in the response. Default is unlimited. */
  #suppress "@azure-tools/typespec-autorest/union-unsupported" // This is how it's represented OpeAI Style.
  max_response_output_tokens?: int32 | "inf";
}

/** Base for session configuration in the response. */
@usage(ResponseUsage)
model ResponseSession is RequestSession {
  ...SessionBase;

  /** The agent configuration for the session, if applicable. */
  agent?: AgentConfig;

  /** The unique identifier for the session. */
  id?: string;
}

/** Supported OpenAI voice names (string enum). */
union OAIVoice {
  string,

  /** Alloy voice. */
  alloy: "alloy",

  /** Ash voice. */
  ash: "ash",

  /** Ballard voice. */
  ballad: "ballad",

  /** Coral voice. */
  coral: "coral",

  /** Echo voice. */
  echo: "echo",

  /** Sage voice. */
  sage: "sage",

  /** Shimmer voice. */
  shimmer: "shimmer",

  /** Verse voice. */
  verse: "verse",

  /** Marin voice. */
  marin: "marin",

  /** Cedar voice. */
  cedar: "cedar",
}

/**

 * OpenAI voice configuration with explicit type field.

 * This provides a unified interface for OpenAI voices, complementing the
 * existing string-based OAIVoice for backward compatibility.
 */
@usage(RequestUsage)
model OpenAIVoice {
  /** The type of the voice. */
  type: "openai";

  /** The name of the OpenAI voice. */
  name: OAIVoice;
}

// --- Azure voices ----------------------------------------------------------

/** Base for Azure voice configurations. */
@discriminator("type")
@usage(DualUsage)
model AzureVoice {
  /** The type of the Azure voice. */
  type: AzureVoiceType;
}

/** Union of all supported Azure voice types. */
union AzureVoiceType {
  string,

  /** Azure custom voice. */
  azure_custom: "azure-custom",

  /** Azure standard voice. */
  azure_standard: "azure-standard",

  /** Azure personal voice. */
  azure_personal: "azure-personal",
}
/** Azure custom voice configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzureCustomVoice extends AzureVoice {
  type: AzureVoiceType.azure_custom;

  /** Voice name cannot be empty. */
  @minLength(1)
  name: string;

  /** Endpoint ID cannot be empty. */
  @minLength(1)
  endpoint_id: string;

  /** Temperature must be between 0.0 and 1.0. */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  custom_lexicon_url?: string;
  prefer_locales?: string[];
  locale?: string;
  style?: string;
  pitch?: string;
  rate?: string;
  volume?: string;
}

/** Azure standard voice configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzureStandardVoice extends AzureVoice {
  type: AzureVoiceType.azure_standard;

  /** Voice name cannot be empty. */
  @minLength(1)
  name: string;

  /** Temperature must be between 0.0 and 1.0. */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  custom_lexicon_url?: string;
  prefer_locales?: string[];
  locale?: string;
  style?: string;
  pitch?: string;
  rate?: string;
  volume?: string;
}

/** Azure personal voice configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzurePersonalVoice extends AzureVoice {
  type: AzureVoiceType.azure_personal;

  /** Voice name cannot be empty. */
  @minLength(1) name: string;

  /** Temperature must be between 0.0 and 1.0. */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  /** Underlying neural model to use for personal voice. */
  `model`: PersonalVoiceModels;

  custom_lexicon_url?: string;
  prefer_locales?: string[];
  locale?: string;
  style?: string;
  pitch?: string;
  rate?: string;
  volume?: string;
}

/** PersonalVoice models */
union PersonalVoiceModels {
  string,

  /** Use the latest Dragon model. */
  "DragonLatestNeural",

  /** Use the latest Phoenix model. */
  "PhoenixLatestNeural",

  /** Use the Phoenix V2 model. */
  "PhoenixV2Neural",
}

// --- Top-level Voice union -------------------------------------------------

/** Union of all supported voice configurations. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" // This is how the service implemented the model...
union Voice {
  OAIVoice,
  OpenAIVoice,
  AzureVoice, // includes AzureCustomVoice, CustomVoice, AzurePersonalVoice
}

/** Input audio format types supported. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
union InputAudioFormat {
  string,

  /** 16-bit PCM audio format at default sampling rate (24kHz) */
  pcm16: "pcm16",

  /** G.711 μ-law (mu-law) audio format at 8kHz sampling rate */
  g711_ulaw: "g711_ulaw",

  /** G.711 A-law audio format at 8kHz sampling rate */
  g711_alaw: "g711_alaw",
}

/** Output audio format types supported. */
union OutputAudioFormat {
  string,

  /** 16-bit PCM audio format at default sampling rate (24kHz) */
  pcm16: "pcm16",

  /** 16-bit PCM audio format at 8kHz sampling rate */
  pcm16_8000hz: "pcm16-8000hz",

  /** 16-bit PCM audio format at 16kHz sampling rate */
  pcm16_16000hz: "pcm16-16000hz",

  /** G.711 μ-law (mu-law) audio format at 8kHz sampling rate */
  g711_ulaw: "g711_ulaw",

  /** G.711 A-law audio format at 8kHz sampling rate */
  g711_alaw: "g711_alaw",
}

/** Supported audio input transcription models. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
union AudioInputTranscriptionModel {
  string,

  /** OpenAI Whisper model. */
  whisper_1: "whisper-1",
}

/** Configuration for input audio transcription. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model AudioInputTranscriptionOptions {
  /**
   * The transcription model to use. Supported values:
   * 'whisper-1', 'gpt-4o-transcribe', 'gpt-4o-mini-transcribe',
   * 'azure-speech'.
   */
  `model`:
    | string
    | "whisper-1"
    | "gpt-4o-transcribe"
    | "gpt-4o-mini-transcribe"
    | "azure-speech";

  /** Optional language code in BCP-47 (e.g., 'en-US'), or ISO-639-1 (e.g., 'en'), or multi languages with auto detection, (e.g., 'en,zh'). */
  language?: string;

  /** Optional configuration for custom speech models. */
  custom_speech?: Record<string>;

  /** Optional list of phrase hints to bias recognition. */
  phrase_list?: string[];
}

/** Supported modalities for the session. */
union Modality {
  string,

  /** Text modality. */
  text: "text",

  /** Audio modality. */
  audio: "audio",

  /** Animation modality. */
  animation: "animation",

  /** Avatar modality. */
  avatar: "avatar",
}

/** Top-level union for end-of-utterance (EOU) semantic detection configuration. */
@discriminator("model")
@usage(RequestUsage)
model EouDetection {
  `model`:
    | "semantic_detection_v1"
    | "semantic_detection_v1_en"
    | "semantic_detection_v1_multilingual"
    | string;
}

/** Threshold level settings for Azure semantic end-of-utterance detection. */
union EouThresholdLevel {
  string,

  /** Low sensitivity threshold level. */
  "low",

  /** Medium sensitivity threshold level. */
  "medium",

  /** High sensitivity threshold level. */
  "high",

  /** Default sensitivity threshold level. */
  "default",
}
/** Azure semantic end-of-utterance detection (default). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model AzureSemanticDetection extends EouDetection {
  `model`: "semantic_detection_v1";

  /** Threshold level setting. Recommended instead of `threshold`. One of `low`, `medium`, `high`, or `default`. */
  threshold_level?: EouThresholdLevel;

  /** Timeout in milliseconds. Recommended instead of `timeout`. */
  @minValue(0)
  timeout_ms?: int32;
}

/** Azure semantic end-of-utterance detection (English-optimized). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model AzureSemanticDetectionEn extends EouDetection {
  `model`: "semantic_detection_v1_en";

  /** Threshold level setting. Recommended instead of `threshold`. One of `low`, `medium`, `high`, or `default`. */
  threshold_level?: EouThresholdLevel;

  /** Timeout in milliseconds. Recommended instead of `timeout`. */
  @minValue(0)
  timeout_ms?: int32;
}

/** Azure semantic end-of-utterance detection (multilingual). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model AzureSemanticDetectionMultilingual extends EouDetection {
  `model`: "semantic_detection_v1_multilingual";

  /** Threshold level setting. Recommended instead of `threshold`. One of `low`, `medium`, `high`, or `default`. */
  threshold_level?: EouThresholdLevel;

  /** Timeout in milliseconds. Recommended instead of `timeout`. */
  @minValue(0)
  timeout_ms?: int32;
}

/** Top-level union for turn detection configuration. */
@discriminator("type")
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

/** Base model for VAD-based turn detection. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
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

/** Server Speech Detection (Azure semantic VAD, default variant). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
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

/** Server Speech Detection (Azure semantic VAD, English-only). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
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

/** Server Speech Detection (Azure semantic VAD). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
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

/** Configuration for input audio noise reduction. */
@usage(RequestUsage)
model AudioNoiseReduction {
  /** The type of noise reduction model. */
  type: "azure_deep_noise_suppression" | "near_field" | "far_field" | string;
}

/** Echo cancellation configuration for server-side audio processing. */
@usage(RequestUsage)
model AudioEchoCancellation {
  /** The type of echo cancellation model to use. */
  type: "server_echo_cancellation";
}

/** Output timestamp types supported in audio response content. */
union AudioTimestampType {
  string,

  /** Timestamps per word in the output audio. */
  word: "word",
}

/** Specifies the types of animation data to output. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
union AnimationOutputType {
  string,

  /** Blendshapes output type. */
  blendshapes: "blendshapes",

  /** Viseme ID output type. */
  viseme_id: "viseme_id",
}

/** Configuration for animation outputs including blendshapes and visemes metadata. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model Animation {
  /** The name of the animation model to use. */
  model_name?: string = "default";

  /** Set of output data types requested from the animation system. */
  outputs?: AnimationOutputType[] = #[AnimationOutputType.blendshapes];
}

/** Configuration for avatar streaming and behavior during the session. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model AvatarConfig {
  /** Type of avatar to use. */
  type?: AvatarConfigTypes;

  /** Optional list of ICE servers to use for WebRTC connection establishment. */
  ice_servers?: IceServer[];

  /** The character name or ID used for the avatar. */
  character: string;

  /** Optional avatar style, such as emotional tone or speaking style. */
  style?: string;

  /** Base model to use for the avatar. Required for photo avatar. */
  `model`?: PhotoAvatarBaseModes;

  /** Indicates whether the avatar is customized or not. */
  customized: boolean;

  /** Optional video configuration including resolution, bitrate, and codec. */
  video?: VideoParams;

  /** Output protocol for avatar streaming. Default is 'webrtc'. */
  output_protocol?: AvatarOutputProtocol = AvatarOutputProtocol.webrtc;
}

/** Avatar config types */
union AvatarConfigTypes {
  string,

  /** Video avatar */
  "video-avatar",

  /** Photo avatar */
  "photo-avatar",
}

/** Photo avatar base modes */
union PhotoAvatarBaseModes {
  string,

  /** VASA-1 model */
  `vasa-1`: "vasa-1",
}

/** Avatar config output protocols */
union AvatarOutputProtocol {
  string,

  /** WebRTC protocol, output the audio/video streams via WebRTC */
  webrtc: "webrtc",

  /** WebSocket protocol, output the video frames over WebSocket */
  websocket: "websocket",
}

/** ICE server configuration for WebRTC connection negotiation. */
@usage(RequestUsage)
model IceServer {
  /** List of ICE server URLs (e.g., TURN or STUN endpoints). */
  urls: url[];

  /** Optional username used for authentication with the ICE server. */
  username?: string;

  /** Optional credential (e.g., password or token) used for authentication. */
  credential?: string;
}

/** Configuration for the agent. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model AgentConfig {
  /** The type of agent to use. */
  type: "agent";

  /** The name of the agent. */
  name: string;

  /** Optional description of the agent. */
  description?: string;

  /** The ID of the agent. */
  agent_id: string;

  /** The ID of the conversation thread. */
  thread_id: string;
}

/** Video streaming parameters for avatar. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model VideoParams {
  /** Bitrate in bits per second (e.g., 2000000 for 2 Mbps). */
  bitrate?: int32 = 2000000;

  /** Codec to use for encoding. Currently only 'h264' is supported. */
  codec?: "h264" = "h264";

  /** Optional cropping settings for the video stream. */
  crop?: VideoCrop;

  /** Optional resolution settings for the video stream. */
  resolution?: VideoResolution;

  /** Optional background settings for the video. Allows specifying either a solid color or an image URL. */
  background?: Background;

  /** Group of Pictures (GOP) size for video encoding. Controls the interval between keyframes, affecting compression efficiency and seeking performance. */
  @minValue(1)
  @maxValue(2000)
  gop_size?: int32 = 10;
}

/** Defines a video crop rectangle using top-left and bottom-right coordinates. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model VideoCrop {
  /** Top-left corner of the crop region. Array of [x, y], must be non-negative integers. */
  @minItems(2)
  @maxItems(2)
  top_left: int32[];

  /** Bottom-right corner of the crop region. Array of [x, y], must be non-negative integers. */
  @minItems(2)
  @maxItems(2)
  bottom_right: int32[];
}

/** Resolution of the video feed in pixels. */
@usage(RequestUsage)
model VideoResolution {
  /** Width of the video in pixels. Must be greater than 0. */
  width: int32;

  /** Height of the video in pixels. Must be greater than 0. */
  height: int32;
}

/** Defines a video background, either a solid color or an image URL (mutually exclusive). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model Background {
  /** Background color in hex format (e.g., `#00FF00FF`). Cannot be set if `image_url` is provided. */
  color?: string;

  /** Background image URL. Cannot be set if `color` is provided. */
  image_url?: string;
}
