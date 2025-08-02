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
}

model ResponseSession {
  ...SessionBase;
  id?: string;
  `model`?: string;
  modalities?: Modality[];
  instructions?: string;
  animation?: Animation;
  voice?: Voice;
  input_audio?: InputAudio;
  input_audio_format?: AudioFormat;
  output_audio_format?: AudioFormat;
  input_audio_sampling_rate?: int32;
  turn_detection?: TurnDetection;
  input_audio_noise_reduction?: AudioNoiseReduction;
  input_audio_echo_cancellation?: AudioEchoCancellation;
  avatar?: AvatarConfig;
  input_audio_transcription?: AudioInputTranscriptionSettings | null;
  output_audio_timestamp_types?: AudioTimestampType[];
  tools?: Tool[];
  tool_choice?: ToolChoice;
  temperature?: float32;
  max_response_output_tokens?: int32 | "inf" | null;
  agent?: AgentConfig;
}

@doc("Voice configuration for Azure standard or platform voices.")
model AzureStandardVoice {
  @doc("Name of the voice.")
  name: string;

  @doc("Voice type identifier.")
  type: "azure-standard" | "azure-platform";

  @doc("Optional temperature for generation.")
  temperature?: float32;
}

@doc("Voice configuration for Azure custom voice.")
model AzureCustomVoice {
  @doc("Name of the voice.")
  name: string;

  @doc("Custom endpoint ID.")
  endpoint_id: string;

  @doc("Voice type identifier.")
  type: "azure-custom" | "custom";

  @doc("Optional temperature for generation.")
  temperature?: float32;

  @doc("Optional custom lexicon URL.")
  custom_lexicon_url?: string;

  @doc("Preferred locale list for voice rendering.")
  prefer_locales?: string[];
}

@doc("Voice configuration for Azure personal voice.")
model AzurePersonalVoice {
  @doc("Name of the voice.")
  name: string;

  @doc("Voice type identifier.")
  type: "azure-personal" | "personal";

  @doc("Personal voice model identifier.")
  `model`: "DragonLatestNeural" | "PhoenixLatestNeural" | "PhoenixV2Neural";
}

@doc("Voice identifier for OpenAI-provided voices.")
union OAIVoice {
  "alloy",
  "ash",
  "ballad",
  "coral",
  "echo",
  "sage",
  "shimmer",
  "verse"
}

@doc("Voice identifier for Phi4mm voices.")
union Phi4mmVoice {
  "cosyvoice"
}

@doc("Union of supported voice identifiers and configurations.")
union Voice {
  OAIVoice,
  AzureStandardVoice,
  AzureCustomVoice,
  AzurePersonalVoice,
  Phi4mmVoice
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
  @doc("The model used for transcription. E.g., 'whisper-1', 'azure-fast-transcription', 's2s-ingraph'.")
  `model`: "whisper-1" | "azure-fast-transcription" | "s2s-ingraph";

  @doc("The language code to use for transcription, if specified.")
  language?: string;

  @doc("Whether transcription is enabled.")
  enabled: boolean;

  @doc("Whether a custom model is being used.")
  custom_model: boolean;
}

union Modality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

@discriminator("type")
@doc("Top-level union for turn detection configuration.")
model TurnDetection {
  type: "none" | "server_vad" | "azure_semantic_vad";
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
  end_of_utterance_detection?: unknown;
}

@doc("Semantic VAD settings based on Azure SDK features.")
model AzureSemanticVad extends TurnDetection {
  type: "azure_semantic_vad";
  neg_threshold?: float32;
  window_size?: int32;
  distinct_ci_phones?: int32;
  require_vowel?: boolean;
  remove_filler_words?: boolean;
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
  urls: string[];

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

@doc("A 2D point with x and y coordinates.")
model Point2D {
  x: int32;
  y: int32;
}

@doc("Defines a video crop rectangle.")
model VideoCrop {
  @doc("Top-left corner of the crop region.")
  top_left: Point2D;

  @doc("Bottom-right corner of the crop region.")
  bottom_right: Point2D;
}

@doc("Resolution of the video feed in pixels.")
model VideoResolution {
  @doc("Width of the video in pixels. Must be greater than 0.")
  width: int32;

  @doc("Height of the video in pixels. Must be greater than 0.")
  height: int32;
}