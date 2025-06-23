import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Keeping this in the spec for now"
@doc("Video translation API to translate video from source locale to target locale.")
@versioned(ApiVersions)
@service(#{ title: "Video Translation" })
@server(
  "{endpoint}/videotranslation",
  "Translate video from source locale to target locale.",
  {
    @doc("Supported Cognitive Services endpoints (protocol and hostname, for example: https://eastus.api.cognitive.microsoft.com).")
    endpoint: string,
  }
)
@useAuth(KeyAuth | AADToken)
@tag("VideoTranslation")
@info(#{
  contact: #{
    name: "Azure AI - Speech Services",
    url: "https://learn.microsoft.com/azure/ai-services/speech-service/",
  },
  license: #{ name: "Copyright (c) Microsoft. All rights reserved." },
})
@versioned(ApiVersions)
namespace Microsoft.Speech.VideoTranslation;

@doc("Provide your Speech resource key here.")
model KeyAuth is ApiKeyAuth<ApiKeyLocation.header, "Ocp-Apim-Subscription-Key">;

#suppress "@azure-tools/typespec-azure-core/casing-style" "Supress casing style for AAD"
@doc("These are the [Microsoft identity platform](entra/identity-platform/v2-overview) flows.")
model AADToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize";
      scopes: ["https://cognitiveservices.azure.com/.default"];
    }
  ]>;

alias VideoTranslationServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias ops = Azure.Core.ResourceOperations<VideoTranslationServiceTraits>;

enum ApiVersions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2024-05-20-preview version of the VideoTranslation service.")
  v2024_05_20_preview: "2024-05-20-preview",

  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-05-20 GA version of the VideoTranslation service.")
  v2025_05_20: "2025-05-20",
}

@doc("Task status.")
union Status {
  string,

  /** Not started status */
  NotStarted: "NotStarted",

  /** Running status */
  Running: "Running",

  /** Run succeeded status */
  Succeeded: "Succeeded",

  /** Run failed status */
  Failed: "Failed",

  /** Cancelled status */
  Canceled: "Canceled",
}

@doc("TTS voice kind.")
union VoiceKind {
  string,

  /** TTS platform voice */
  PlatformVoice: "PlatformVoice",

  /** TTS personal voice */
  PersonalVoice: "PersonalVoice",
}

@doc("Webvtt file kind.")
union WebvttFileKind {
  string,

  /** Source locale plain text subtitle webvtt file */
  SourceLocaleSubtitle: "SourceLocaleSubtitle",

  /** Target locale plain text subtitle webvtt file */
  TargetLocaleSubtitle: "TargetLocaleSubtitle",

  /** Target locale metadata JSON webvtt file */
  MetadataJson: "MetadataJson",
}

@added(ApiVersions.v2025_05_20)
@doc("EventHub event kind.")
union EventHubVideoTranslationEventKind {
  string,

  /** Send event to EventHub when ping API is requested. */
  Ping: "Ping",

  /** Send event to EventHub when translation completed or failed. */
  TranslationCompletion: "TranslationCompletion",

  /** Send event to EventHub when iteration completed or failed. */
  IterationCompletion: "IterationCompletion",
}

@added(ApiVersions.v2025_05_20)
@doc("Enable emotional platform voice kind.")
union EnableEmotionalPlatformVoice {
  string,

  /** Let API to decide whether to enable emotional voice for the target locale. */
  Auto: "Auto",

  /** Force to enable emotional voice if there is voice supported emotion for the target locale. */
  Enable: "Enable",

  /** Disable platform voice emotion for the target locale. */
  Disable: "Disable",
}

@doc("Translation webvtt file.")
model WebvttFile {
  @doc("Translation webvtt file url.")
  url: url;

  @doc("Translation webvtt file kind.")
  kind: WebvttFileKind;
}

@doc("Guid, for example: 8e2da02e-f9b3-4a1c-941f-8da60f16c2e5")
@pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
scalar Guid extends string;

@doc("Locale name, for example: en-US")
@pattern("^[A-Za-z]{2,4}([_-][A-Za-z]{4})?([_-]([A-Za-z]{2}|[0-9]{3}))?$")
@minLength(5)
@maxLength(16)
scalar localeName extends string;

@doc("Resource ID")
@pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{1,62}[a-zA-Z0-9]$")
@minLength(3)
@maxLength(64)
scalar resourceId extends string;

@doc("The value should be provided in the format <rr><gg><bb>, #<rr><gg><bb>, <rr><gg><bb><aa> or #<rr><gg><bb><aa>, where <rr> represents the red component of the color, <gg> represents the green component, <bb> represents the blue component, <aa> represents the alpha component. For example, EBA205 or #EBA205  would set the subtitle color to a specific shade of yellow.")
@pattern("^#?(?:[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$")
@minLength(6)
@maxLength(9)
scalar rgbaColor extends string;

@doc("Translation input.")
model TranslationInput {
  @doc("The source locale of the video file. Locale code follows BCP-47. You can find the text to speech locale list here https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts , if not specified, the source locale will be auto-detected from the video file, the auto detect is only supported after version 2025-05-20.")
  @madeOptional(ApiVersions.v2025_05_20)
  sourceLocale?: localeName;

  @doc("The target locale of the translation. Locale code follows BCP-47. You can find the text to speech locale list here https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.")
  targetLocale: localeName;

  @doc("Translation voice kind.")
  voiceKind: VoiceKind;

  @doc("Translation video file Azure blob url, .mp4 file format, maxmum 5GB file size and 4 hours video duration. Provide the input media file using either videoFileUrl or audioFileUrl, these parameters are mutually exclusive—only one of them is required. If both are provided, the request will be considered invalid.")
  @madeOptional(ApiVersions.v2025_05_20)
  videoFileUrl?: url;

  @added(ApiVersions.v2025_05_20)
  @doc("Translation audio file Azure blob url, .mp3 or .wav file format, maxmum 5GB file size and 4 hours video duration. Provide the input media file using either videoFileUrl or audioFileUrl, these parameters are mutually exclusive—only one of them is required. If both are provided, the request will be considered invalid.")
  audioFileUrl?: url;

  @doc("Number of speakers in the video, if not provided, it will be auto-detected from the video file.")
  speakerCount?: int32;

  @doc("Indicate whether to enable lip sync, if not provided, the default value is false to disable the lip sync.")
  @added(ApiVersions.v2025_05_20)
  enableLipSync?: boolean;

  @doc("Subtitle max display character count per segment, if not provided, it will use the language dependent default value.")
  subtitleMaxCharCountPerSegment?: int32;

  @doc("Export subtitle in video, if not specified, the default value is false, it will not burn subtitle to the translated video file.")
  exportSubtitleInVideo?: boolean;
}

@doc("Iteration result.")
model IterationResult {
  @doc("Translated video file URL.")
  translatedVideoFileUrl?: url;

  @added(ApiVersions.v2025_05_20)
  @doc("Translated audio file URL.")
  translatedAudioFileUrl?: url;

  @doc("Source locale subtitle file URL.")
  sourceLocaleSubtitleWebvttFileUrl?: url;

  @doc("Target locale subtitle file URL.")
  targetLocaleSubtitleWebvttFileUrl?: url;

  @added(ApiVersions.v2025_05_20)
  @doc("This property provides the URL of the target locale Advanced SubStation Alpha (ASS) subtitle file. It is populated only when exportTargetLocaleAdvancedSubtitleFile is set to true during iteration creation; otherwise, this property will not be included in the response.")
  targetLocaleAdvancedSubtitleFileUrl?: url;

  @doc("Metadata json webvtt file URL.")
  metadataJsonWebvttFileUrl?: url;

  @doc("Report file URL.")
  reportFileUrl?: url;
}

@doc("Iteration input.")
model IterationInput {
  @doc("Webvtt file for content editing, this parameter is required from the second iteration creation request of the translation.")
  webvttFile?: WebvttFile;

  @doc("Number of speakers in the video, if not specified, it will inherit the value defined in the input of translation creation.")
  speakerCount?: int32;

  @doc("Subtitle max display character count per segment, if not specified, it will inherit the value defined in the input of translation creation.")
  subtitleMaxCharCountPerSegment?: int32;

  @doc("Export subtitle in video, if not specified, it will inherit the value defined in the input of translation creation.")
  exportSubtitleInVideo?: boolean;

  @added(ApiVersions.v2025_05_20)
  @doc("Translate with TTS custom lexicon for speech synthesis. Provide the custom lexicon file using either ttsCustomLexiconFileUrl or ttsCustomLexiconFileIdInAudioContentCreation. These parameters are mutually exclusive—only one of them is required. If both are provided, the request will be considered invalid.")
  ttsCustomLexiconFileUrl?: url;

  @added(ApiVersions.v2025_05_20)
  @doc("Translate with TTS custom lexicon for speech synthesis. Provide the custom lexicon file using either ttsCustomLexiconFileUrl or ttsCustomLexiconFileIdInAudioContentCreation. These parameters are mutually exclusive—only one of them is required. If both are provided, the request will be considered invalid.")
  ttsCustomLexiconFileIdInAudioContentCreation?: Guid;

  @added(ApiVersions.v2025_05_20)
  @doc("This parameter allows for the adjustment of video playback speed to ensure better alignment with translated audio. When enabled, the API can slow down or speed up the video to match the timing of the translated audio, providing a more synchronized and seamless viewing experience, if not specified, video speed will not be adjusted.")
  enableVideoSpeedAdjustment?: boolean;

  @added(ApiVersions.v2025_05_20)
  @doc("Indicate whether to allow the API to correct the speech recognition (SR) results using the subtitles from the original video file. By leveraging the existing subtitles, the API can enhance the accuracy of the transcribed text, ensuring that the final output is more precise and reliable, if not specified, translation will not do correction from OCR subtitle.")
  enableOcrCorrectionFromSubtitle?: boolean;

  @added(ApiVersions.v2025_05_20)
  @doc("This parameter, when enabled, allows the API to export subtitles in the Advanced SubStation Alpha format. The subtitle file can specify font styles and colors, which helps in addressing character display issues in certain target locales such as Arabic (Ar), Japanese (Ja), Korean (Ko), and Chinese (Ch). By using this parameter, you can ensure that the subtitles are visually appealing and correctly rendered across different languages and regions, if not specified, iteration response will not include advanced subtitle.")
  exportTargetLocaleAdvancedSubtitleFile?: boolean;

  @added(ApiVersions.v2025_05_20)
  @doc("This parameter specifies the primary color of the subtitles in the video translation output. The value should be provided in the format <rr><gg><bb>, #<rr><gg><bb>, <rr><gg><bb><aa> or #<rr><gg><bb><aa>, where <rr> represents the red component of the color, <gg> represents the green component, <bb> represents the blue component, <aa> represents the alpha component. For example, EBA205 or #EBA205  would set the subtitle color to a specific shade of yellow. This parameter allows for customization of subtitle appearance to enhance readability and visual appeal, if not specified, it will use default white color.")
  subtitlePrimaryColor?: rgbaColor;

  @added(ApiVersions.v2025_05_20)
  @doc("This parameter specifies the outline color of the subtitles in the video translation output. The value should be provided in the format <rr><gg><bb>, #<rr><gg><bb>, <rr><gg><bb><aa> or #<rr><gg><bb><aa>, where <rr> represents the red component of the color, <gg> represents the green component, <bb> represents the blue component, <aa> represents the alpha component. For example, EBA205 or #EBA205  would set the subtitle color to a specific shade of yellow. This parameter allows for customization of subtitle appearance to enhance readability and visual appeal, if not specified, it will use default black color.")
  subtitleOutlineColor?: rgbaColor;

  @added(ApiVersions.v2025_05_20)
  @doc("This parameter specifies the font size of subtitles in the video translation output between 5 and 30, if not specified, it will use the language dependent default value.")
  subtitleFontSize?: int32;

  @added(ApiVersions.v2025_05_20)
  @doc("This parameter specifies whether to enable emotion for platform voice. By default, the server determines whether to apply emotion based on the target locale to optimize quality. If not specified, the API will automatically decide whether to enable emotional expression on the server side.")
  enableEmotionalPlatformVoice?: EnableEmotionalPlatformVoice;
}

@added(ApiVersions.v2025_05_20)
@doc("EventHub configuration.")
model EventHubConfiguration {
  @doc("Indicate whether to enable sending event to EventHub.")
  isEnabled: boolean;

  @doc("EventHub namespace host name, for example: [YourNamespace].servicebus.windows.net")
  eventHubNamespaceHostName: string;

  @doc("EventHub name.")
  eventHubName: string;

  @doc("Managed identity client ID for user-assigned managed identity, if not specified, API will use system-assigned managed identity.")
  managedIdentityClientId?: Guid;

  @doc("Enabled event kinds for notification.")
  enabledEvents: EventHubVideoTranslationEventKind[];
}

@doc("Operation ID header.")
model OperationIdHeader {
  @doc("Operation ID.")
  @header("Operation-Id")
  @visibility(Lifecycle.Create)
  operationId: resourceId;
}

@doc("Create translation resource for hosting iterations of translating one video file from source locale to target locale.")
@TypeSpec.Rest.resource("translations")
model Translation {
  @doc("Translation resource ID.")
  @key("translationId")
  @visibility(Lifecycle.Read)
  id: resourceId;

  @doc("Translation input.")
  input: TranslationInput;

  @doc("Translation display name.")
  displayName?: string;

  @doc("Translation description.")
  description?: string;

  @doc("The timestamp when the object was created. The timestamp is encoded as ISO 8601 date and time format (\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  @doc("Latest iteration of the translation.")
  @visibility(Lifecycle.Read)
  latestIteration?: Iteration;

  @doc("Latest completed iteration of the translation.")
  @visibility(Lifecycle.Read)
  latestSucceededIteration?: Iteration;

  @doc("Translation failure reason")
  @visibility(Lifecycle.Read)
  failureReason?: string;
}

@doc("Do one iteration to translate one video file from source locale to target locale, webvtt for content editing is optional for requesting parameter.")
@TypeSpec.Rest.resource("iterations")
@TypeSpec.Rest.parentResource(Translation)
model Iteration {
  @doc("Iteration ID")
  @key("iterationId")
  @visibility(Lifecycle.Read)
  id: resourceId;

  @doc("Iteration input.")
  input: IterationInput;

  @doc("Iteration description")
  description?: string;

  @doc("Iteration status")
  @visibility(Lifecycle.Read)
  status?: Status;

  @doc("Iteration failure reason")
  @visibility(Lifecycle.Read)
  failureReason?: string;

  @doc("The timestamp when the object was created. The timestamp is encoded as ISO 8601 date and time format (\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  @visibility(Lifecycle.Read)
  createdDateTime?: utcDateTime;

  @doc("The timestamp when the current status was entered. The timestamp is encoded as ISO 8601 date and time format (\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  @visibility(Lifecycle.Read)
  lastActionDateTime?: utcDateTime;

  @doc("Iteration result.")
  @visibility(Lifecycle.Read)
  result?: IterationResult;
}

@doc("Operation.")
@TypeSpec.Rest.resource("operations")
model Operation {
  @doc("Operation ID")
  @key("operationId")
  @visibility(Lifecycle.Read)
  id: resourceId;

  @doc("Operation status")
  status?: Status;
}

interface TranslationOperations {
  // LongRunningResourceCreateOrReplace will generate PUT, to align with CNV other creation operation.
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Because auto generated operation ID contains OrReplace(TranslationOperations_CreateOrReplaceTranslation), which will cause the operation title of the API doc's to be [Translation Operations - Create Or Replace Translation], because we don't support replace, specify the operation ID explicitly to avoid the misunderstanding API description."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The same as @azure-tools/typespec-azure-core/no-operation-id, no-operation-id is warning by tsp compile while no-openapi is validation by PR TypeSpec Validation pipeline."
  @TypeSpec.OpenAPI.operationId("TranslationOperations_CreateTranslation")
  @doc("Creates a translation.")
  @pollingOperation(OperationOperations.getOperation)
  createOrReplaceTranslation is ops.LongRunningResourceCreateOrReplace<
    Translation,
    RequestHeadersTrait<OperationIdHeader>
  >;

  @doc("Fetch a translation by ID.")
  getTranslation is ops.ResourceRead<Translation>;

  @doc("Delete a translation.")
  deleteTranslation is ops.ResourceDelete<Translation>;

  @doc("List translation resources.")
  listTranslation is ops.ResourceList<
    Translation,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

interface IterationOperations {
  // LongRunningResourceCreateOrReplace will generate PUT, to align with CNV other creation operation.
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Because auto generated operation ID contains OrReplace(IterationOperations_CreateOrReplaceIteration), which will cause the operation title of the API doc's to be [Iteration Operations - Create Or Replace Iteration], because we don't support replace, specify the operation ID explicitly to avoid the misunderstanding API description."
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The same as @azure-tools/typespec-azure-core/no-operation-id, no-operation-id is warning by tsp compile while no-openapi is validation by PR TypeSpec Validation pipeline."
  @TypeSpec.OpenAPI.operationId("IterationOperations_CreateIteration")
  @doc("Creates an iteration.")
  @pollingOperation(OperationOperations.getOperation)
  createOrReplaceIteration is ops.LongRunningResourceCreateOrReplace<
    Iteration,
    RequestHeadersTrait<OperationIdHeader>
  >;

  @doc("Fetch a iteration by ID.")
  getIteration is ops.ResourceRead<Iteration>;

  @doc("List Iteration resources.")
  listIteration is ops.ResourceList<
    Iteration,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

interface OperationOperations {
  @doc("Fetch a operation by ID.")
  getOperation is ops.ResourceRead<Operation>;
}

@added(ApiVersions.v2025_05_20)
interface EventHubConfigurationOperations {
  @doc("Create or replace EventHub configuration.")
  @route("/configurations/event-hub")
  @put
  createOrReplaceEventHubConfiguration is RpcOperation<
    EventHubConfiguration,
    EventHubConfiguration
  >;

  @doc("Get EventHub configuration.")
  @route("/configurations/event-hub")
  @get
  getEventHubConfiguration is RpcOperation<{}, EventHubConfiguration>;

  @doc("Delete EventHub configuration.")
  @delete
  @route("/configurations/event-hub")
  deleteEventHubConfiguration is RpcOperation<{}, NoContentResponse>;

  @doc("Send ping to EventHub to verify configuration.")
  @route("/configurations/event-hub:ping")
  @post
  pingEventHub is RpcOperation<{}, OkResponse>;
}
