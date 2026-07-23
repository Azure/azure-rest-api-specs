import "./events.tsp";
import "./items.tsp";
import "./tools.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;
using Azure.Core.Experimental;

namespace VoiceLive;

// --- GA Realtime nested audio configuration ---------------------------------
// VoiceLive adopts OpenAI's GA Realtime `audio.input` / `audio.output` nesting
// (replacing the flat beta-style `input_audio_*` fields), using VoiceLive's
// Azure-specific audio types and adding Azure-only fields.

/** GA Realtime nested audio configuration (`audio.input` / `audio.output`) for a VoiceLive session. */
@usage(DualUsage)
model AudioConfig {
  /** Input audio configuration. */
  input?: AudioInputConfig;

  /** Output audio configuration. */
  output?: AudioOutputConfig;
}

/** Audio format MIME types supported by VoiceLive v1. */
union AudioFormatType {
  string,
  pcm: "audio/pcm",
  pcmu: "audio/pcmu",
  pcma: "audio/pcma",
}

/** Voice implementations available through VoiceLive. */
union VoiceType {
  string,
  openai: "openai",
  azure_standard: "azure-standard",
  azure_custom: "azure-custom",
  azure_personal: "azure-personal",
  avatar_voice_sync: "avatar-voice-sync",
  azure_realtime_native: "azure-realtime-native",
}

/** Base audio format object used by VoiceLive v1. */
@discriminator("type")
@usage(DualUsage)
model AudioFormat {
  type: AudioFormatType;
}

/** PCM audio with an explicit sample rate. */
@usage(DualUsage)
model PcmAudioFormat extends AudioFormat {
  type: AudioFormatType.pcm;

  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "VoiceLive supports these runtime PCM sample rates."
  rate?: 8000 | 16000 | 24000 = 24000;
}

/** G.711 μ-law audio at 8 kHz. */
@usage(DualUsage)
model PcmuAudioFormat extends AudioFormat {
  type: AudioFormatType.pcmu;
}

/** G.711 A-law audio at 8 kHz. */
@usage(DualUsage)
model PcmaAudioFormat extends AudioFormat {
  type: AudioFormatType.pcma;
}

/** Input audio configuration (OpenAI GA Realtime `audio.input` shape, with Azure extensions). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AudioInputConfig {
  /** Input audio format. Defaults to 24 kHz PCM. */
  format?: AudioFormat;

  /** Configuration for input audio transcription. */
  transcription?: AudioInputTranscriptionOptions;

  /** Configuration for input audio noise reduction. */
  noise_reduction?: AudioNoiseReduction;

  /** Type of turn detection to use. */
  turn_detection?: OpenAI.RealtimeTurnDetection;

  /** Configuration for echo cancellation during server-side audio processing (Azure extension). */
  echo_cancellation?: AudioEchoCancellation;
}

// Multichannel session fields, per-event channel context, and input_audio_buffer.all_idle are
// private runtime features and are intentionally excluded from the public TypeSpec surface.

/** Output audio configuration (OpenAI GA Realtime `audio.output` shape, with Azure extensions). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AudioOutputConfig {
  /** Output audio format. Defaults to 24 kHz PCM. */
  format?: AudioFormat;

  /** Voice name. */
  voice?: string = "alloy";

  /** Voice implementation selected for synthesis. */
  voice_type?: VoiceType = VoiceType.openai;

  /** Numeric voice speed. */
  speed?: float32;

  /** Voice variation temperature. */
  @minValue(0)
  @maxValue(1)
  voice_temperature?: float32;

  /** URL of a custom pronunciation lexicon. */
  custom_lexicon_url?: string;

  /** URL of a custom text normalization configuration. */
  custom_text_normalization_url?: string;

  /** Preferred locales for multilingual synthesis. */
  prefer_locales?: string[];

  /** Enforced output locale. */
  locale?: string;

  /** Voice speaking style. */
  style?: string;

  /** Voice pitch adjustment. */
  pitch?: string;

  /** Voice volume adjustment. */
  volume?: string;

  /** Azure custom voice endpoint identifier. */
  custom_voice_endpoint_id?: string;

  /** Azure personal/avatar voice model. */
  personal_voice_model?: string;

  /** Types of timestamps to include in audio response content. */
  output_audio_timestamp_types?: AudioTimestampType[];
}

// The GA response `output` list is retyped to VoiceLive's `ResponseItem` union so
// Azure-specific response items (message, MCP, web/file search) are preserved.
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Foundry-approved: retype the inherited GA response `output` to VoiceLive's ResponseItem union without mutating the imported OpenAI source."
@@changePropertyType(OpenAI.RealtimeResponse.output, ResponseItem[]);

// --- Client events: consume OpenAI GA client events, inject Azure payloads -----
// VoiceLive consumes OpenAI's GA Realtime client events directly. Events whose
// payload is Azure-extended have that payload retyped onto the OpenAI event
// (session -> RequestSession, item -> ConversationRequestItem, response ->
// ResponseCreateParams); Azure-only extra fields are added via @@copyProperties.
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA client-event payloads to VoiceLive's Azure-extended types."
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Mirrors OpenAI's inline `@oneOf` session union, swapping the realtime session for VoiceLive's RequestSession."
@@changePropertyType(
  OpenAI.RealtimeClientEventSessionUpdate.session,
  SessionUpdateConfig
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA client-event payloads to VoiceLive's Azure-extended types."
@@changePropertyType(
  OpenAI.RealtimeClientEventConversationItemCreate.item,
  ConversationRequestItem
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA client-event payloads to VoiceLive's Azure-extended types."
@@changePropertyType(
  OpenAI.RealtimeClientEventResponseCreate.response,
  ResponseCreateParams
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Add the Azure-only `additional_instructions` field to the GA response.create event."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Service message format is snake_case to remain close to OpenAI style."
@@copyProperties(
  OpenAI.RealtimeClientEventResponseCreate,
  {
    /** Additional instructions (system prompt) appended to the default session instructions. Affects this response only. (Azure extension) */
    @removed(Versions.v1)
    additional_instructions?: string,
  }
);

// --- Server events: consume OpenAI GA server events, inject Azure payloads -----
// VoiceLive consumes OpenAI's GA Realtime server events directly. Events whose
// payload is Azure-extended have that payload retyped onto the OpenAI event
// (`response` -> `Response`, `item` -> `ResponseItem`).
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `response` payload to VoiceLive's Azure-extended `Response`."
@@changePropertyType(
  OpenAI.RealtimeServerEventResponseCreated.response,
  Response
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `response` payload to VoiceLive's Azure-extended `Response`."
@@changePropertyType(OpenAI.RealtimeServerEventResponseDone.response, Response);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `item` payload to VoiceLive's Azure-extended `ResponseItem` union."
@@changePropertyType(
  OpenAI.RealtimeServerEventConversationItemCreated.item,
  ResponseItem
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `item` payload to VoiceLive's Azure-extended `ResponseItem` union."
@@changePropertyType(
  OpenAI.RealtimeServerEventConversationItemRetrieved.item,
  ResponseItem
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `item` payload to VoiceLive's Azure-extended `ResponseItem` union."
@@changePropertyType(
  OpenAI.RealtimeServerEventResponseOutputItemAdded.item,
  ResponseItem
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `item` payload to VoiceLive's Azure-extended `ResponseItem` union."
@@changePropertyType(
  OpenAI.RealtimeServerEventResponseOutputItemDone.item,
  ResponseItem
);

// Fence imported OpenAI events that are not exposed by the VoiceLive v1
// WebSocket contract.
@@removed(OpenAI.RealtimeServerEventOutputAudioBufferStarted, Versions.v1);
@@removed(OpenAI.RealtimeServerEventOutputAudioBufferStopped, Versions.v1);
@@removed(OpenAI.RealtimeServerEventConversationCreated, Versions.v1);
@@removed(OpenAI.RealtimeServerEventInputAudioBufferDtmfEventReceived, Versions.v1);
@@removed(OpenAI.RealtimeServerEventRateLimitsUpdated, Versions.v1);

// VoiceLive reuses the OpenAI event names for avatar media-buffer clearing but
// has different semantics: clearing buffered avatar output does not stop TTS,
// and the acknowledgement does not include a response_id.
@@doc(
  OpenAI.RealtimeClientEventOutputAudioBufferClear,
  "Clears buffered VoiceLive avatar media output without stopping TTS synthesis."
);
@@doc(
  OpenAI.RealtimeServerEventOutputAudioBufferCleared,
  "Confirms that buffered VoiceLive avatar media output was cleared. response_id is empty when no model response is active."
);

// `session.created` / `session.updated` server events: retype the GA `session`
// payload (an `@oneOf` union) to VoiceLive's Azure-extended `ResponseSession`.
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `session` payload to VoiceLive's Azure-extended `ResponseSession`."
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Mirrors OpenAI's inline `@oneOf` session union, swapping the realtime session for VoiceLive's ResponseSession."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionCreated.session,
  SessionResponseConfig
);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Retype the GA server-event `session` payload to VoiceLive's Azure-extended `ResponseSession`."
#suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Mirrors OpenAI's inline `@oneOf` session union, swapping the realtime session for VoiceLive's ResponseSession."
@@changePropertyType(
  OpenAI.RealtimeServerEventSessionUpdated.session,
  SessionResponseConfig
);

// `response.content_part.added` / `.done` server events are consumed from OpenAI
// GA directly; their native `part` payload
// (`RealtimeServerEventResponseContentPart{Added,Done}Part`) is used as-is.

// `conversation.item.input_audio_transcription.completed` server event: add the
// Azure-only `phrases` field (with timing information) to the GA event.
#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Add the Azure-only `phrases` field to the GA transcription-completed server event."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Service message format is snake_case to remain close to OpenAI style."
@@copyProperties(
  OpenAI.RealtimeServerEventConversationItemInputAudioTranscriptionCompleted,
  {
    /** The transcription phrases with timing information. (Azure extension) */
    phrases?: TranscriptionPhrase[],
  }
);

/** Output modalities supported by VoiceLive sessions. */
union SessionModality {
  string,
  text: "text",
  audio: "audio",
  animation: "animation",
  avatar: "avatar",
}

/** Voice-optimized instruction adaptation. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model VoiceAdaptation {
  /** Adaptation strategy. */
  type: "auto";

  /** Server-generated voice-optimized instructions. */
  additional_instructions?: string;
}

/** VoiceLive v1 realtime session configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model RequestSession {
  /** The session type. VoiceLive v1 supports realtime sessions only. */
  type: "realtime";

  /** Modalities the service may return. */
  output_modalities?: SessionModality[];

  /** Session instructions. */
  instructions?: string;

  /** Nested input and output audio configuration. */
  audio?: AudioConfig;

  /** Additional fields to include in server outputs. */
  include?: string[];

  /** Tools available to the model. */
  tools?: VoiceLiveTool[];

  /** Tool selection behavior. */
  tool_choice?: VoiceLiveToolChoice;

  /** Whether multiple tool calls may run in parallel. */
  parallel_tool_calls?: boolean;

  /** Reasoning configuration for compatible realtime models. */
  reasoning?: OpenAI.RealtimeReasoning;

  /** Maximum output tokens for one response. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Matches the OpenAI Realtime max-token wire shape."
  max_output_tokens?: integer | "inf";

  /** The animation configuration for the session. */
  animation?: Animation;

  /** Configuration for avatar streaming and behavior during the session. */
  avatar?: AvatarConfig;

  /**
   * Controls randomness for compatible cascaded pipelines. Native realtime
   * pipelines reject this property because the upstream realtime API does not
   * support session temperature.
   */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  /** Configuration for interim response generation during latency or tool calls. */
  interim_response?: InterimResponseConfig;

  /** Voice-optimized instruction adaptation. */
  voice_adaptation?: VoiceAdaptation;

  /** Delimiter appended to generated responses. */
  response_delimiter?: string;

  /**
   * Set of up to 16 key-value pairs that can be attached to the session. This is
   * useful for storing additional information about the session in a structured format, such as
   * tracking IDs, user context, or application-specific labels. These key-value pairs are also
   * included in Foundry resource logs for tracing and diagnostics. Keys can be a maximum of 64
   * characters long and values can be a maximum of 512 characters long.
   */
  metadata?: Record<string>;
}

/** Session update payloads supported by VoiceLive. */
union SessionUpdateConfig {
  RequestSession,
}

/** Base for session configuration in the response. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(ResponseUsage)
model ResponseSession is RequestSession {
  ...SessionBase;

  /** The agent configuration for the session, if applicable. */
  @removed(Versions.v1)
  agent?: AgentConfig;

  /** The unique identifier for the session. */
  id: string;

  /** The response object type. */
  object: "realtime.session";

  /** The selected model. */
  `model`: string;

  /** Expiration time for the session. This value is set by the server and cannot be changed with `session.update`. */
  #suppress "@microsoft/azure-openapi-validator/IntegerTypeMustHaveFormat" "The unixtime format is present, but the legacy rule only allows int32 or int64."
  @encode(DateTimeKnownEncoding.unixTimestamp, int64)
  expires_at?: utcDateTime;
}

/** Session response payloads supported by VoiceLive. */
union SessionResponseConfig {
  ResponseSession,
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

  /** Azure avatar voice sync. */
  avatar_voice_sync: "avatar-voice-sync",
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

  /** URL of a custom lexicon file for pronunciation customization. */
  custom_lexicon_url?: string;

  /** URL of a custom text normalization endpoint. */
  custom_text_normalization_url?: string;

  /**
   * Preferred locales in BCP-47 format that change the accents of languages.
   * If not set, TTS uses the default accent for each language (e.g., American English for English,
   * Mexican Spanish for Spanish). Setting this to `["en-GB", "es-ES"]` changes the English accent
   * to British English and the Spanish accent to European Spanish, while TTS can still speak other
   * languages like French or Chinese with their default accents.
   */
  prefer_locales?: string[];

  /**
   * Enforced locale in BCP-47 format for TTS output. If set, TTS will always use the specified
   * locale to speak. For example, setting locale to `en-US` forces American English accent for all
   * text content, even if the text is in another language, and TTS will output silence for
   * unsupported languages (e.g., Chinese text with `en-US` locale). If not set, TTS automatically
   * detects the language from the text content.
   */
  locale?: string;

  /** Speaking style for the voice (e.g., 'cheerful', 'sad'). */
  style?: string;

  /**
   * Pitch adjustment for the voice output. Follows the same rules as the `pitch` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-low`, `low`, `medium`, `high`, `x-high`, `default`),
   * a relative change (e.g., `+10%`, `-5%`, `+50Hz`, `-2st`), or an absolute frequency (e.g., `200Hz`).
   */
  pitch?: string;

  /**
   * Speaking rate adjustment for the voice output. Follows the same rules as the `rate` attribute of
   * the SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-slow`, `slow`, `medium`, `fast`, `x-fast`, `default`),
   * a relative percentage (e.g., `+20%`, `-10%`), or a non-negative multiplier (e.g., `0.5`, `1.5`).
   */
  rate?: string;

  /**
   * Volume adjustment for the voice output. Follows the same rules as the `volume` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`silent`, `x-soft`, `soft`, `medium`, `loud`, `x-loud`, `default`),
   * an absolute number from 0.0 to 100.0, or a relative change (e.g., `+10`, `-6dB`).
   */
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

  /** URL of a custom lexicon file for pronunciation customization. */
  custom_lexicon_url?: string;

  /** URL of a custom text normalization endpoint. */
  custom_text_normalization_url?: string;

  /**
   * Preferred locales in BCP-47 format that change the accents of languages.
   * If not set, TTS uses the default accent for each language (e.g., American English for English,
   * Mexican Spanish for Spanish). Setting this to `["en-GB", "es-ES"]` changes the English accent
   * to British English and the Spanish accent to European Spanish, while TTS can still speak other
   * languages like French or Chinese with their default accents.
   */
  prefer_locales?: string[];

  /**
   * Enforced locale in BCP-47 format for TTS output. If set, TTS will always use the specified
   * locale to speak. For example, setting locale to `en-US` forces American English accent for all
   * text content, even if the text is in another language, and TTS will output silence for
   * unsupported languages (e.g., Chinese text with `en-US` locale). If not set, TTS automatically
   * detects the language from the text content.
   */
  locale?: string;

  /** Speaking style for the voice (e.g., 'cheerful', 'sad'). */
  style?: string;

  /**
   * Pitch adjustment for the voice output. Follows the same rules as the `pitch` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-low`, `low`, `medium`, `high`, `x-high`, `default`),
   * a relative change (e.g., `+10%`, `-5%`, `+50Hz`, `-2st`), or an absolute frequency (e.g., `200Hz`).
   */
  pitch?: string;

  /**
   * Speaking rate adjustment for the voice output. Follows the same rules as the `rate` attribute of
   * the SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-slow`, `slow`, `medium`, `fast`, `x-fast`, `default`),
   * a relative percentage (e.g., `+20%`, `-10%`), or a non-negative multiplier (e.g., `0.5`, `1.5`).
   */
  rate?: string;

  /**
   * Volume adjustment for the voice output. Follows the same rules as the `volume` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`silent`, `x-soft`, `soft`, `medium`, `loud`, `x-loud`, `default`),
   * an absolute number from 0.0 to 100.0, or a relative change (e.g., `+10`, `-6dB`).
   */
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

  /** URL of a custom lexicon file for pronunciation customization. */
  custom_lexicon_url?: string;

  /** URL of a custom text normalization endpoint. */
  custom_text_normalization_url?: string;

  /**
   * Preferred locales in BCP-47 format that change the accents of languages.
   * If not set, TTS uses the default accent for each language (e.g., American English for English,
   * Mexican Spanish for Spanish). Setting this to `["en-GB", "es-ES"]` changes the English accent
   * to British English and the Spanish accent to European Spanish, while TTS can still speak other
   * languages like French or Chinese with their default accents.
   */
  prefer_locales?: string[];

  /**
   * Enforced locale in BCP-47 format for TTS output. If set, TTS will always use the specified
   * locale to speak. For example, setting locale to `en-US` forces American English accent for all
   * text content, even if the text is in another language, and TTS will output silence for
   * unsupported languages (e.g., Chinese text with `en-US` locale). If not set, TTS automatically
   * detects the language from the text content.
   */
  locale?: string;

  /** Speaking style for the voice (e.g., 'cheerful', 'sad'). */
  style?: string;

  /**
   * Pitch adjustment for the voice output. Follows the same rules as the `pitch` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-low`, `low`, `medium`, `high`, `x-high`, `default`),
   * a relative change (e.g., `+10%`, `-5%`, `+50Hz`, `-2st`), or an absolute frequency (e.g., `200Hz`).
   */
  pitch?: string;

  /**
   * Speaking rate adjustment for the voice output. Follows the same rules as the `rate` attribute of
   * the SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-slow`, `slow`, `medium`, `fast`, `x-fast`, `default`),
   * a relative percentage (e.g., `+20%`, `-10%`), or a non-negative multiplier (e.g., `0.5`, `1.5`).
   */
  rate?: string;

  /**
   * Volume adjustment for the voice output. Follows the same rules as the `volume` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`silent`, `x-soft`, `soft`, `medium`, `loud`, `x-loud`, `default`),
   * an absolute number from 0.0 to 100.0, or a relative change (e.g., `+10`, `-6dB`).
   */
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

  /** Use the latest Dragon HD Omni model. */
  "DragonHDOmniLatestNeural",

  /** Use the MAI-Voice-1 model. */
  `MAI-Voice-1`: "MAI-Voice-1",
}

/** Azure avatar voice sync configuration. Uses personal voice synthesis with avatar character. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzureAvatarVoiceSyncVoice extends AzureVoice {
  type: AzureVoiceType.avatar_voice_sync;

  /** Underlying neural model to use. */
  `model`: PersonalVoiceModels;

  /** Temperature must be between 0.0 and 1.0. */
  @minValue(0)
  @maxValue(1)
  temperature?: float32;

  /** URL of a custom lexicon file for pronunciation customization. */
  custom_lexicon_url?: string;

  /** URL of a custom text normalization endpoint. */
  custom_text_normalization_url?: string;

  /**
   * Preferred locales in BCP-47 format that change the accents of languages.
   * If not set, TTS uses the default accent for each language (e.g., American English for English,
   * Mexican Spanish for Spanish). Setting this to `["en-GB", "es-ES"]` changes the English accent
   * to British English and the Spanish accent to European Spanish, while TTS can still speak other
   * languages like French or Chinese with their default accents.
   */
  prefer_locales?: string[];

  /**
   * Enforced locale in BCP-47 format for TTS output. If set, TTS will always use the specified
   * locale to speak. For example, setting locale to `en-US` forces American English accent for all
   * text content, even if the text is in another language, and TTS will output silence for
   * unsupported languages (e.g., Chinese text with `en-US` locale). If not set, TTS automatically
   * detects the language from the text content.
   */
  locale?: string;

  /** Speaking style for the voice (e.g., 'cheerful', 'sad'). */
  style?: string;

  /**
   * Pitch adjustment for the voice output. Follows the same rules as the `pitch` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-low`, `low`, `medium`, `high`, `x-high`, `default`),
   * a relative change (e.g., `+10%`, `-5%`, `+50Hz`, `-2st`), or an absolute frequency (e.g., `200Hz`).
   */
  pitch?: string;

  /**
   * Speaking rate adjustment for the voice output. Follows the same rules as the `rate` attribute of
   * the SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`x-slow`, `slow`, `medium`, `fast`, `x-fast`, `default`),
   * a relative percentage (e.g., `+20%`, `-10%`), or a non-negative multiplier (e.g., `0.5`, `1.5`).
   */
  rate?: string;

  /**
   * Volume adjustment for the voice output. Follows the same rules as the `volume` attribute of the
   * SSML `prosody` element (see
   * https://learn.microsoft.com/azure/ai-services/speech-service/speech-synthesis-markup-voice#adjust-prosody).
   * Typical values: a named level (`silent`, `x-soft`, `soft`, `medium`, `loud`, `x-loud`, `default`),
   * an absolute number from 0.0 to 100.0, or a relative change (e.g., `+10`, `-6dB`).
   */
  volume?: string;
}

/**
 * Currently known voice names for the Azure realtime native voice type.
 * This is an extensible enum; additional voice names may be accepted by the
 * service in the future.
 */
union AzureRealtimeNativeVoiceName {
  string,

  /** Aarti voice. */
  aarti: "aarti",

  /** Andrew voice. */
  andrew: "andrew",

  /** Ava voice. */
  ava: "ava",

  /** Denise voice. */
  denise: "denise",

  /** Diya voice. */
  diya: "diya",

  /** Elsa voice. */
  elsa: "elsa",

  /** Florian voice. */
  florian: "florian",

  /** Francisca voice. */
  francisca: "francisca",

  /** Meera voice. */
  meera: "meera",

  /** Xiaoxiao voice. */
  xiaoxiao: "xiaoxiao",

  /** Yunxi voice. */
  yunxi: "yunxi",

  /** Ximena voice. */
  ximena: "ximena",
}

/**
 * Azure realtime native voice configuration. These voices are natively
 * supported by the `azure-realtime` model and offer higher quality speech
 * synthesis than standard Azure voices. Only valid when using the
 * `azure-realtime` model.
 */
@usage(DualUsage)
model AzureRealtimeNativeVoice {
  /** The type of the voice. */
  type: "azure-realtime-native";

  /** The name of the Azure realtime native voice. */
  name: AzureRealtimeNativeVoiceName;
}

// --- Top-level Voice union -------------------------------------------------

/** Union of all supported voice configurations. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" // This is how the service implemented the model...
union Voice {
  OAIVoice,
  OpenAIVoice,
  AzureVoice, // includes AzureCustomVoice, AzureStandardVoice, AzurePersonalVoice, AzureAvatarVoiceSyncVoice
  AzureRealtimeNativeVoice,
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
  pcm16_8000hz: "pcm16_8000hz",

  /** 16-bit PCM audio format at 16kHz sampling rate */
  pcm16_16000hz: "pcm16_16000hz",

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
   * 'gpt-4o-transcribe-diarize', 'azure-speech', 'azure-mrs',
   * 'mai-transcribe-1', 'mai-transcribe-1.5', and 'mai-transcribe'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  `model`:
    | string
    | "whisper-1"
    | "gpt-4o-transcribe"
    | "gpt-4o-mini-transcribe"
    | "gpt-4o-transcribe-diarize"
    | "azure-speech"
    | "azure-mrs"
    | "mai-transcribe-1"
    | "mai-transcribe-1.5"
    | "mai-transcribe";

  /** Optional language code in BCP-47 (e.g., 'en-US'), or ISO-639-1 (e.g., 'en'), or multi languages with auto detection, (e.g., 'en,zh'). */
  language?: string;

  /** Optional configuration for custom speech models. */
  custom_speech?: Record<string>;

  /** Optional list of phrase hints to bias recognition. */
  phrase_list?: string[];
}

/** Top-level union for end-of-utterance (EOU) semantic detection configuration. */
@discriminator("model")
@usage(RequestUsage)
model EouDetection {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Keeping inline union to avoid breaking changes."
  @typeChangedFrom(
    Versions.v1,

      | "semantic_detection_v1"
      | "semantic_detection_v1_en"
      | "semantic_detection_v1_multilingual"
      | "smart_end_of_turn_detection"
      | string
  )
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

/**
 * Audio-based end-of-turn detection. Operates directly on the input audio
 * stream rather than text. Use `threshold_level` and `timeout_ms` to tune
 * detection.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@removed(Versions.v1)
@usage(RequestUsage)
model SmartEndOfTurnDetection extends EouDetection {
  `model`: "smart_end_of_turn_detection";

  /** Threshold level setting. One of `low`, `medium`, `high`, or `default`. */
  threshold_level?: EouThresholdLevel;

  /** Timeout in milliseconds. */
  @minValue(0)
  timeout_ms?: int32;
}

// --- Turn detection: OpenAI GA Realtime base + Azure extensions --------------
// VoiceLive consumes OpenAI's discriminated turn-detection base
// `RealtimeTurnDetection` (variants `server_vad`, `semantic_vad`), augments the
// server-VAD variant with Azure fields via `@@copyProperties`, and adds Azure
// semantic-VAD variants that `extends OpenAI.RealtimeTurnDetection`.
@@usage(OpenAI.RealtimeTurnDetection, DualUsage);
@@usage(OpenAI.RealtimeTurnDetectionServerVad, DualUsage);
@@usage(OpenAI.RealtimeTurnDetectionSemanticVad, DualUsage);

#suppress "@azure-tools/typespec-azure-core/experimental-feature" "Foundry-approved read-only-base augmentation: add Azure fields to OpenAI's model without mutating the imported source."
#suppress "@azure-tools/typespec-azure-core/casing-style" "Service message format is snake_case to remain close to OpenAI style."
@@copyProperties(
  OpenAI.RealtimeTurnDetectionServerVad,
  {
    /** Configuration for end-of-utterance detection (Azure extension). */
    end_of_utterance_detection?: EouDetection,

    /** Whether to automatically truncate the audio buffer when speech stops (Azure extension). */
    auto_truncate?: boolean,
  }
);

/** Server Speech Detection (Azure semantic VAD, default variant). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzureSemanticVad extends OpenAI.RealtimeTurnDetection {
  type: "azure_semantic_vad";

  /** Activation threshold for VAD detection. Range: 0.0 to 1.0. */
  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  /** Amount of audio to include before speech is detected, in milliseconds. */
  prefix_padding_ms?: int32;

  /** Duration of silence required to end speech detection, in milliseconds. */
  silence_duration_ms?: int32;

  /** Configuration for end-of-utterance detection. */
  end_of_utterance_detection?: EouDetection;

  /** Minimum speech duration in milliseconds to trigger detection. */
  speech_duration_ms?: int32;

  /** Whether to remove filler words (e.g., 'um', 'uh') from transcription. */
  remove_filler_words?: boolean = false;

  /** List of BCP-47 language codes for speech detection. */
  languages?: string[];

  /** Whether to automatically truncate the audio buffer when speech stops. */
  auto_truncate?: boolean = false;

  /** Whether to automatically create a response when speech stops. */
  create_response?: boolean = false;

  /** Whether to allow the user's speech to interrupt the assistant's response. */
  interrupt_response?: boolean = false;
}

/** Server Speech Detection (Azure semantic VAD, English-only). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzureSemanticVadEn extends OpenAI.RealtimeTurnDetection {
  type: "azure_semantic_vad_en";

  /** Activation threshold for VAD detection. Range: 0.0 to 1.0. */
  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  /** Amount of audio to include before speech is detected, in milliseconds. */
  prefix_padding_ms?: int32;

  /** Duration of silence required to end speech detection, in milliseconds. */
  silence_duration_ms?: int32;

  /** Configuration for end-of-utterance detection. */
  end_of_utterance_detection?: EouDetection;

  /** Minimum speech duration in milliseconds to trigger detection. */
  speech_duration_ms?: int32;

  /** Whether to remove filler words (e.g., 'um', 'uh') from transcription. */
  remove_filler_words?: boolean = false;

  /** Whether to automatically truncate the audio buffer when speech stops. */
  auto_truncate?: boolean = false;

  /** Whether to automatically create a response when speech stops. */
  create_response?: boolean = false;

  /** Whether to allow the user's speech to interrupt the assistant's response. */
  interrupt_response?: boolean = false;
}

/** Server Speech Detection (Azure semantic VAD). */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(DualUsage)
model AzureSemanticVadMultilingual extends OpenAI.RealtimeTurnDetection {
  type: "azure_semantic_vad_multilingual";

  /** Activation threshold for VAD detection. Range: 0.0 to 1.0. */
  @minValue(0)
  @maxValue(1)
  threshold?: float32;

  /** Amount of audio to include before speech is detected, in milliseconds. */
  prefix_padding_ms?: int32;

  /** Duration of silence required to end speech detection, in milliseconds. */
  silence_duration_ms?: int32;

  /** Configuration for end-of-utterance detection. */
  end_of_utterance_detection?: EouDetection;

  /** Minimum speech duration in milliseconds to trigger detection. */
  speech_duration_ms?: int32;

  /** Whether to remove filler words (e.g., 'um', 'uh') from transcription. */
  remove_filler_words?: boolean = false;

  /** List of BCP-47 language codes for speech detection. */
  languages?: string[];

  /** Whether to automatically truncate the audio buffer when speech stops. */
  auto_truncate?: boolean = false;

  /** Whether to automatically create a response when speech stops. */
  create_response?: boolean = false;

  /** Whether to allow the user's speech to interrupt the assistant's response. */
  interrupt_response?: boolean = false;
}

/**
 * Configuration for input audio noise reduction. Consumes the OpenAI GA Realtime
 * noise-reduction types (`near_field`, `far_field`) and extends them with Azure's
 * `azure_deep_noise_suppression`.
 */
@usage(RequestUsage)
model AudioNoiseReduction {
  /** The type of noise reduction model. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Azure extension over the OpenAI GA Realtime NoiseReductionType."
  type: OpenAI.NoiseReductionType | "azure_deep_noise_suppression" | string;
}

/** Echo cancellation configuration for server-side audio processing. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case.
@usage(RequestUsage)
model AudioEchoCancellation {
  /** The type of echo cancellation model to use. */
  type: "server_echo_cancellation";

  /**
   * The source of the echo cancellation reference signal.
   * - `server`: EC uses the internal TTS loopback as the reference signal (default, existing behavior).
   * - `client`: EC uses the client-supplied reference channel (ch1 of stereo input). Internal TTS loopback is skipped.
   */
  reference_source?: EchoCancellationReferenceSource = EchoCancellationReferenceSource.server;

  /**
   * Number of input audio channels.
   * - `1`: Mono input (default).
   * - `2`: Interleaved stereo input where channel 0 is the microphone signal and channel 1 is the echo reference signal.
   * When set to 2, `reference_source` must be `client` and `input_audio_format` must be `pcm16`.
   */
  @minValue(1)
  @maxValue(2)
  channels?: int32 = 1;
}

/** The source of the echo cancellation reference signal. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case.
union EchoCancellationReferenceSource {
  string,

  /** EC uses the internal TTS loopback as the reference signal. */
  server: "server",

  /** EC uses the client-supplied reference channel from the stereo input stream. */
  client: "client",
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

/** Configuration for avatar's zoom level, position, rotation and movement amplitude in the video frame. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model Scene {
  /** Zoom level of the avatar. Range is (0, +∞). Values less than 1 zoom out, values greater than 1 zoom in. */
  zoom?: float32 = 0.0;

  /** Horizontal position of the avatar. Range is [-1, 1], as a proportion of frame width. Negative values move left, positive values move right. */
  position_x?: float32 = 0.0;

  /** Vertical position of the avatar. Range is [-1, 1], as a proportion of frame height. Negative values move up, positive values move down. */
  position_y?: float32 = 0.0;

  /** Rotation around the X-axis (pitch). Range is [-π, π] in radians. Negative values rotate up, positive values rotate down. */
  rotation_x?: float32 = 0.0;

  /** Rotation around the Y-axis (yaw). Range is [-π, π] in radians. Negative values rotate left, positive values rotate right. */
  rotation_y?: float32 = 0.0;

  /** Rotation around the Z-axis (roll). Range is [-π, π] in radians. Negative values rotate anticlockwise, positive values rotate clockwise. */
  rotation_z?: float32 = 0.0;

  /** Amplitude of the avatar movement. Range is (0, 1]. Values in (0, 1) mean reduced amplitude, 1 means full amplitude. */
  amplitude?: float32 = 0.0;
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

  /** Configuration for the avatar's zoom level, position, rotation and movement amplitude in the video frame. */
  scene?: Scene;

  /** Output protocol for avatar streaming. Default is 'webrtc'. */
  output_protocol?: AvatarOutputProtocol = AvatarOutputProtocol.webrtc;

  /** When enabled, forwards audit audio via WebSocket for review/debugging purposes, even when avatar output is delivered via WebRTC. */
  output_audit_audio?: boolean = false;
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

// --- Interim Response Configuration ----------------------------------------

/** Triggers that can activate interim response generation. */
union InterimResponseTrigger {
  string,

  /** Trigger interim response when response latency exceeds threshold. */
  latency: "latency",

  /** Trigger interim response when a tool call is being executed. */
  tool: "tool",
}

/** Union of interim response configuration types. */
#suppress "@azure-tools/typespec-autorest/union-unsupported" // Discriminated union for interim response config types.
union InterimResponseConfig {
  StaticInterimResponseConfig,
  LlmInterimResponseConfig,
}

/** Base model for interim response configuration. */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@discriminator("type")
@usage(RequestUsage)
model InterimResponseConfigBase {
  /** The type of interim response configuration. */
  type: InterimResponseConfigType;

  /**
   * List of triggers that can fire the interim response. Any trigger can activate it (OR logic).
   * Supported: 'latency', 'tool'.
   */
  triggers?: InterimResponseTrigger[] = #[InterimResponseTrigger.latency];

  /** Latency threshold in milliseconds before triggering interim response. Default is 2000ms. */
  @minValue(0)
  latency_threshold_ms?: int32;
}

/** Interim response configuration types. */
union InterimResponseConfigType {
  string,

  /** Static interim response configuration type. */
  static_interim_response: "static_interim_response",

  /** LLM-based interim response configuration type. */
  llm_interim_response: "llm_interim_response",
}

/**
 * Configuration for static interim response generation.
 * Randomly selects from configured texts when any trigger condition is met.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model StaticInterimResponseConfig extends InterimResponseConfigBase {
  type: InterimResponseConfigType.static_interim_response;

  /** List of interim response text options to randomly select from. */
  texts?: string[];
}

/**
 * Configuration for LLM-based interim response generation.
 * Uses LLM to generate context-aware interim responses when any trigger condition is met.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" // Service message format is snake_case to remain close to OpenAI style.
@usage(RequestUsage)
model LlmInterimResponseConfig extends InterimResponseConfigBase {
  type: InterimResponseConfigType.llm_interim_response;

  /** The model to use for LLM-based interim response generation. Default is gpt-4.1-mini. */
  `model`?: string;

  /** Custom instructions for generating interim responses. If not provided, a default prompt is used. */
  instructions?: string;

  /** Maximum number of tokens to generate for the interim response. */
  @minValue(1)
  max_completion_tokens?: int32 = 50;
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

// -----------------------------------------------------------------------
// Session include options
// -----------------------------------------------------------------------

/** Options for what additional data to include in session responses. */
union SessionIncludeOption {
  string,

  /** Include log probabilities for input audio transcription. */
  item_input_audio_transcription_logprobs: "item.input_audio_transcription.logprobs",

  /** Include phrase-level details for input audio transcription. */
  item_input_audio_transcription_phrases: "item.input_audio_transcription.phrases",

  /** Include file search call results. */
  file_search_call_results: "file_search_call.results",
}
