import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";

using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

#suppress "@azure-tools/typespec-azure-core/no-openapi" "Keeping this in the spec for now"
@doc("Video translation API to translate video from source locale to target locale.")
@versioned(VideoTranslation.ApiVersions)
@service({
  title: "Video Translation",
})
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
@info({
  contact: {
    name: "Azure AI - Speech Services",
    url: "https://learn.microsoft.com/azure/ai-services/speech-service/",
  },
  license: {
    name: "Copyright (c) Microsoft. All rights reserved.",
  },
})
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

@doc("Translation webvtt file.")
model WebvttFile {
  @doc("Translation webvtt file url.")
  url: url;

  @doc("Translation webvtt file kind.")
  kind: WebvttFileKind;
}

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

@doc("Translation input.")
model TranslationInput {
  @doc("The source locale of the video file. Locale code follows BCP-47. You can find the text to speech locale list here https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.")
  sourceLocale: localeName;

  @doc("The target locale of the translation. Locale code follows BCP-47. You can find the text to speech locale list here https://learn.microsoft.com/azure/ai-services/speech-service/language-support?tabs=tts.")
  targetLocale: localeName;

  @doc("Translation voice kind.")
  voiceKind: VoiceKind;

  @doc("Translation video file url.")
  videoFileUrl: url;

  @doc("Number of speakers in the video.")
  speakerCount?: int32;

  @doc("Subtitle max display character count per segment.")
  subtitleMaxCharCountPerSegment?: int32;

  @doc("Export subtitle in video.")
  exportSubtitleInVideo?: boolean;
}

@doc("Iteration result.")
model IterationResult {
  @doc("Translated video file URL.")
  translatedVideoFileUrl?: url;

  @doc("Source locale subtitle file URL.")
  sourceLocaleSubtitleWebvttFileUrl?: url;

  @doc("Target locale subtitle file URL.")
  targetLocaleSubtitleWebvttFileUrl?: url;

  @doc("Metadata json webvtt file URL.")
  metadataJsonWebvttFileUrl?: url;

  @doc("Report file URL.")
  reportFileUrl?: url;
}

@doc("Iteration input.")
model IterationInput {
  @doc("Webvtt file for content editing, this parameter is required from the second iteration creation request of the translation.")
  webvttFile?: WebvttFile;

  @doc("Number of speakers in the video.")
  speakerCount?: int32;

  @doc("Subtitle max display character count per segment.")
  subtitleMaxCharCountPerSegment?: int32;

  @doc("Export subtitle in video.")
  exportSubtitleInVideo?: boolean;
}

@doc("Operation ID header.")
model OperationIdHeader {
  @doc("Operation ID.")
  @header("Operation-Id")
  @visibility("create")
  operationId: resourceId;
}

@doc("Create translation resource for hosting iterations of translating one video file from source locale to target locale.")
@TypeSpec.Rest.resource("translations")
model Translation {
  @doc("Translation resource ID.")
  @key("translationId")
  @visibility("read")
  id: resourceId;

  @doc("Translation input.")
  input: TranslationInput;

  @doc("Translation display name.")
  displayName?: string;

  @doc("Translation description.")
  description?: string;

  @doc("The timestamp when the object was created. The timestamp is encoded as ISO 8601 date and time format (\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  @visibility("read")
  createdDateTime?: utcDateTime;

  @doc("Latest iteration of the translation.")
  @visibility("read")
  latestIteration?: Iteration;

  @doc("Latest completed iteration of the translation.")
  @visibility("read")
  latestSucceededIteration?: Iteration;

  @doc("Translation failure reason")
  @visibility("read")
  failureReason?: string;
}

@doc("Do one iteration to translate one video file from source locale to target locale, webvtt for content editing is optional for requesting parameter.")
@TypeSpec.Rest.resource("iterations")
@TypeSpec.Rest.parentResource(Translation)
model Iteration {
  @doc("Iteration ID")
  @key("iterationId")
  @visibility("read")
  id: resourceId;

  @doc("Iteration input.")
  input: IterationInput;

  @doc("Iteration description")
  description?: string;

  @doc("Iteration status")
  @visibility("read")
  status?: Status;

  @doc("Iteration failure reason")
  @visibility("read")
  failureReason?: string;

  @doc("The timestamp when the object was created. The timestamp is encoded as ISO 8601 date and time format (\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  @visibility("read")
  createdDateTime?: utcDateTime;

  @doc("The timestamp when the current status was entered. The timestamp is encoded as ISO 8601 date and time format (\"YYYY-MM-DDThh:mm:ssZ\", see https://en.wikipedia.org/wiki/ISO_8601#Combined_date_and_time_representations).")
  @visibility("read")
  lastActionDateTime?: utcDateTime;

  @doc("Iteration result.")
  @visibility("read")
  result?: IterationResult;
}

@doc("Operation.")
@TypeSpec.Rest.resource("operations")
model Operation {
  @doc("Operation ID")
  @key("operationId")
  @visibility("read")
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
