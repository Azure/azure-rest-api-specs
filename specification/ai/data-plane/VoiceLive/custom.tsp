import "./custom/events.tsp";
import "./custom/items.tsp";
import "./custom/tools.tsp";

using TypeSpec.OpenAPI;

namespace OpenAI;

model VoiceLiveRequestSession {
  ...VoiceLiveSessionBase;
  model?: string;
  modalities?: VoiceLiveModality[];
  animation?: VoiceLiveAnimation;
  voice?: VoiceIdsShared;
  instructions?: string;
  input_audio?: VoiceLiveInputAudio;
  input_audio_sampling_rate?: int32 = 24000;
  input_audio_format?: VoiceLiveAudioFormat = VoiceLiveAudioFormat.pcm16;
  output_audio_format?: VoiceLiveAudioFormat = VoiceLiveAudioFormat.pcm16;
  turn_detection?: VoiceLiveTurnDetection | null;
  input_audio_noise_reduction?: VoiceLiveAudioNoiseReduction;
  input_audio_echo_cancellation?: VoiceLiveAudioEchoCancellation;
  avatar?: VoiceLiveAvatarConfig;
  input_audio_transcription?: VoiceLiveAudioInputTranscriptionSettings;
  output_audio_timestamp_types?: VoiceLiveAudioTimestampType[];
  tools?: VoiceLiveTool[];
  tool_choice?: VoiceLiveToolChoice;
  temperature?: float32;
  max_response_output_tokens?: int32 | "inf";
}

model VoiceLiveResponseSession {
  ...VoiceLiveSessionBase;
  id: string;
  model: string;
  modalities: VoiceLiveModality[];
  instructions: string;
  animation?: VoiceLiveAnimation;
  voice: VoiceIdsShared;
  input_audio?: VoiceLiveInputAudio;
  input_audio_format: VoiceLiveAudioFormat;
  output_audio_format: VoiceLiveAudioFormat;
  input_audio_sampling_rate?: int32;
  turn_detection: VoiceLiveTurnDetection;
  input_audio_noise_reduction: VoiceLiveAudioNoiseReduction;
  input_audio_echo_cancellation?: VoiceLiveAudioEchoCancellation;
  avatar?: VoiceLiveAvatarConfig;
  input_audio_transcription: VoiceLiveAudioInputTranscriptionSettings | null;
  tools: list<VoiceLiveTool>;
  tool_choice: VoiceLiveToolChoice;
  temperature: float32;
  max_response_output_tokens: int32 | "inf" | null;
  agent?: AgentConfig;
}

union VoiceLiveAudioFormat {
  string,
  pcm16: "pcm16",
  g711_ulaw: "g711_ulaw",
  g711_alaw: "g711_alaw",
}

union VoiceLiveAudioInputTranscriptionModel {
  string,
  whisper_1: "whisper-1",
}

@doc("Configuration for input audio transcription.")
model VoiceLiveAudioInputTranscriptionSettings {
  @doc("The model used for transcription. E.g., 'whisper-1', 'azure-fast-transcription', 's2s-ingraph'.")
  model: "whisper-1" | "azure-fast-transcription" | "s2s-ingraph";

  @doc("The language code to use for transcription, if specified.")
  language?: string;

  @doc("Whether transcription is enabled.")
  enabled: boolean;

  @doc("Whether a custom model is being used.")
  custom_model: boolean;
}

union VoiceLiveModality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

@discriminator("type")
@doc("Top-level union for turn detection configuration.")
model VoiceLiveTurnDetection {
  type: "none" | "server_vad" | "azure_semantic_vad";
}

@doc("Disables turn detection.")
model VoiceLiveNoTurnDetection extends VoiceLiveTurnDetection {
  type: "none";
}

@doc("Base model for VAD-based turn detection.")
model VoiceLiveServerVad extends VoiceLiveTurnDetection {
  type: "server_vad";
  threshold?: float32;
  prefix_padding_ms?: int32;
  silence_duration_ms?: int32;
  end_of_utterance_detection?: unknown;
}

@doc("Semantic VAD settings based on Azure SDK features.")
model VoiceLiveAzureSemanticVad extends VoiceLiveServerVad {
  type: "azure_semantic_vad";
  neg_threshold?: float32;
  window_size?: int32;
  distinct_ci_phones?: int32;
  require_vowel?: boolean;
  remove_filler_words?: boolean;
}

@doc("Configuration for input audio noise reduction.")
model VoiceLiveAudioNoiseReduction {
  @doc("The type of noise reduction model.")
  type: "azure_deep_noise_suppression";
}

@doc("Configuration for client audio input. Used to specify the audio model and optional phrase list.")
model VoiceLiveInputAudio {
  @doc("The name of the model to use for input audio (currently only 'azure-standard' is supported).")
  model: "azure-standard";

  @doc("Optional list of phrases to bias the speech recognition engine.")
  phrase_list?: string[];
}

@doc("Echo cancellation configuration for server-side audio processing.")
model VoiceLiveAudioEchoCancellation {
  @doc("The type of echo cancellation model to use.")
  type: "server_echo_cancellation";
}

@doc("Output timestamp types supported in audio response content.")
union VoiceLiveAudioTimestampType {
  string,
  @doc("Timestamps per word in the output audio.")
  word: "word",
}

@doc("Specifies the types of animation data to output.")
union VoiceLiveAnimationOutputType {
  blendshapes: "blendshapes",
  viseme_id: "viseme_id",
  emotion: "emotion",
}

@doc("Configuration for animation outputs including blendshapes, visemes, and emotion metadata.")
model VoiceLiveAnimation {
  @doc("The name of the animation model to use.")
  model_name?: string = "default";

  @doc("Set of output data types requested from the animation system.")
  outputs?: VoiceLiveAnimationOutputType[] = [VoiceLiveAnimationOutputType.blendshapes];

  @doc("Interval for emotion detection in milliseconds. If not set, emotion detection is disabled.")
  emotion_detection_interval_ms?: int32;
}

@doc("Configuration for avatar streaming and behavior during the session.")
model VoiceLiveAvatarConfig {
  @doc("Optional list of ICE servers to use for WebRTC connection establishment.")
  ice_servers?: list<IceServer>;

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
  urls: list<string>;

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