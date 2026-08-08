import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/openai-typespec/models/realtime";

using Azure.ClientGenerator.Core;

namespace VoiceLive.V1;

/** Model usage for client-to-service JSON messages. */
alias RequestUsage = Usage.input | Usage.json;

/** Model usage for service-to-client JSON messages. */
alias ResponseUsage = Usage.output | Usage.json;

/** The source used as the echo-cancellation reference. */
union EchoReferenceSource {
  string,

  /** The server-generated echo reference. */
  server: "server",

  /** A client-provided second audio channel. */
  client: "client",
}

/** The supported echo-cancellation wire channel counts. */
union EchoChannelCount {
  integer,

  /** Mono input audio. */
  mono: 1,

  /** Stereo interleaved input and echo-reference audio. */
  stereo: 2,
}

/** The supported multichannel input channel counts. */
union InputChannelCount {
  integer,

  /** Two-channel input audio. */
  two: 2,

  /** Three-channel input audio. */
  three: 3,

  /** Four-channel input audio. */
  four: 4,
}

/** Animation data returned with generated audio. */
union AnimationOutput {
  string,

  /** Facial blend-shape frames. */
  blendshapes: "blendshapes",

  /** Speech viseme identifiers. */
  viseme_id: "viseme_id",
}

/** Additional timestamp data returned with generated audio. */
union AudioTimestampType {
  string,

  /** Word-level audio timestamps. */
  word: "word",
}

/** The supported Voice Live voice implementations. */
union VoiceType {
  string,

  /** An OpenAI realtime voice. */
  openai: "openai",

  /** An Azure standard neural voice. */
  azure_standard: "azure-standard",

  /** An Azure custom neural voice. */
  azure_custom: "azure-custom",

  /** An Azure personal voice. */
  azure_personal: "azure-personal",

  /** An Azure realtime-native voice. */
  azure_realtime_native: "azure-realtime-native",

  /** A custom-avatar synchronized personal voice. */
  avatar_voice_sync: "avatar-voice-sync",
}

/** Echo-cancellation settings applied to Voice Live input audio. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage | ResponseUsage)
model EchoCancellation {
  /** The echo-reference source. */
  reference_source?: EchoReferenceSource = EchoReferenceSource.server;

  /** The number of interleaved wire channels. */
  channels?: EchoChannelCount = EchoChannelCount.mono;
}

/** Azure-specific output voice settings added to the OpenAI GA audio output shape. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage | ResponseUsage)
model SessionAudioOutput {
  ...OpenAI.RealtimeSessionCreateRequestGAAudioOutput;

  /** The Voice Live voice implementation. */
  voice_type?: VoiceType = VoiceType.openai;

  /** The Azure voice temperature from 0.0 through 1.0. */
  @minValue(0.0)
  @maxValue(1.0)
  voice_temperature?: float32;

  /** The custom voice endpoint identifier. */
  custom_voice_endpoint_id?: string;

  /** The Azure personal voice model name. */
  personal_voice_model?: string;

  /** The custom pronunciation lexicon URL. */
  custom_lexicon_url?: url;

  /** The custom text-normalization URL. */
  custom_text_normalization_url?: url;

  /** Preferred locales used to resolve multilingual Azure voices. */
  prefer_locales?: string[];

  /** The Azure voice locale. */
  locale?: string;

  /** The Azure voice speaking style. */
  style?: string;

  /** The Azure voice pitch adjustment. */
  pitch?: string;

  /** The Azure voice volume adjustment. */
  volume?: string;

  /** Additional audio timestamp data returned with generated audio. */
  output_audio_timestamp_types?: AudioTimestampType[];
}

/** Voice Live input audio settings added to the OpenAI GA audio input shape. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage | ResponseUsage)
model SessionAudioInput {
  ...OpenAI.RealtimeSessionCreateRequestGAAudioInput;

  /** Echo-cancellation settings. */
  echo_cancellation?: EchoCancellation;

  /** The number of input audio channels for multichannel recognition. */
  channels?: InputChannelCount;

  /** The text template used to identify multichannel speakers. */
  multichannel_audio_context_template?: string;
}

/** Voice Live audio settings for a realtime session. */
@usage(RequestUsage | ResponseUsage)
model SessionAudio {
  /** Input audio settings. */
  input?: SessionAudioInput;

  /** Output audio settings. */
  output?: SessionAudioOutput;
}

/** Avatar rendering settings attached to a normal Voice Live model session. */
@usage(RequestUsage | ResponseUsage)
model AvatarConfig {
  /** The avatar character name. */
  character: string;

  /** The avatar style name. */
  style?: string;

  /** Whether the avatar is a customer-customized avatar. */
  customized?: boolean = false;
}

/** Animation outputs attached to generated audio. */
@usage(RequestUsage | ResponseUsage)
model AnimationConfig {
  /** The animation outputs to return. */
  outputs: AnimationOutput[];
}

/** The tool types supported by the initial Voice Live v1 contract. */
union SessionToolType {
  string,

  /** A caller-defined function. */
  function: "function",

  /** A remote MCP server. */
  mcp: "mcp",
}

/** A tool supported by the initial Voice Live v1 contract. */
@discriminator("type")
@usage(RequestUsage | ResponseUsage)
model SessionTool {
  /** The tool discriminator. */
  type: SessionToolType;
}

/** A caller-defined function tool. */
@usage(RequestUsage | ResponseUsage)
model FunctionTool extends SessionTool {
  ...OmitProperties<OpenAI.RealtimeFunctionTool, "type">;

  /** The function tool discriminator. */
  type: SessionToolType.function;
}

/** A standard MCP tool supported by Voice Live v1. */
@usage(RequestUsage | ResponseUsage)
model McpTool extends SessionTool {
  ...OmitProperties<OpenAI.MCPTool, "type">;

  /** The MCP tool discriminator. */
  type: SessionToolType.mcp;
}

/** The model's automatic tool-selection behavior. */
union ToolChoiceMode {
  string,

  /** Let the model select whether to call a tool. */
  auto: "auto",

  /** Prevent tool calls. */
  none: "none",

  /** Require a tool call. */
  required: "required",
}

/** Forces a specific function tool. */
model FunctionToolChoice {
  /** The selected tool type. */
  type: "function";

  /** The selected function name. */
  name: string;
}

/** Forces a specific tool on an MCP server. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
model McpToolChoice {
  /** The selected tool type. */
  type: "mcp";

  /** The selected MCP server label. */
  server_label: string;

  /** The optional tool name on the selected server. */
  name?: string;
}

/** Tool-selection settings supported by Voice Live v1. */
union ToolChoice {
  ToolChoiceMode,
  FunctionToolChoice,
  McpToolChoice,
}

/** Voice Live v1 session configuration based on the OpenAI Realtime GA session. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage | ResponseUsage)
model Session {
  ...OmitProperties<
    OpenAI.RealtimeSessionCreateRequestGA,
    "audio" | "tool_choice" | "tools"
  >;

  /** Input and output audio settings. */
  audio?: SessionAudio;

  /** Function and standard MCP tools available to the model. */
  tools?: SessionTool[];

  /** How the model chooses tools. */
  tool_choice?: ToolChoice = ToolChoiceMode.auto;

  /** Avatar rendering settings. */
  avatar?: AvatarConfig;

  /** Animation output settings. */
  animation?: AnimationConfig;

  /** A delimiter appended between streamed response segments. */
  response_delimiter?: string;
}

/** Voice Live v1 response creation parameters. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Property names follow the OpenAI realtime wire format."
@usage(RequestUsage)
model ResponseCreateParams {
  ...OmitProperties<
    OpenAI.RealtimeResponseCreateParams,
    "tool_choice" | "tools"
  >;

  /** Additional instructions appended only for this response. */
  additional_instructions?: string;

  /** Function and standard MCP tools available to this response. */
  tools?: SessionTool[];

  /** How the model chooses tools for this response. */
  tool_choice?: ToolChoice = ToolChoiceMode.auto;
}
