import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

namespace ContentSafety;

interface TextOperations {
  @summary("Analyze Text")
  @doc("A synchronous API for the analysis of potentially harmful text content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/text:analyze")
  @post
  analyzeText is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextOptions;
    },
    AnalyzeTextResult
  >;

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @summary("Analyze Text Jailbreak")
  @doc("A synchronous API for the analysis of text jailbreak.")
  @route("/text:detectJailbreak")
  @post
  detectTextJailbreak is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text jailbreak analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextJailbreakOptions;
    },
    AnalyzeTextJailbreakResult
  >;

  @added(ContentSafety.Versions.v2023_10_15_Preview)
  @summary("Analyze Protected Material")
  @doc("A synchronous API for the analysis of protected material.")
  @route("/text:detectProtectedMaterial")
  @post
  detectTextProtectedMaterial is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text protected material analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextProtectedMaterialOptions;
    },
    AnalyzeTextProtectedMaterialResult
  >;

  @added(ContentSafety.Versions.v2024_02_15_Preview)
  @summary("Analyze text prompt injection attacks")
  @doc("A synchronous API for the analysis of text prompt injection attacks.")
  @route("/text:shieldPrompt")
  @post
  detectTextPromptInjectionOptions is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text prompt injection attacks analysis request.")
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
      body: AnalyzeTextPromptInjectionOptions;
    },
    AnalyzeTextPromptInjectionResult
  >;

  @added(ContentSafety.Versions.v2024_04_15_Preview)
  @summary("Auto Review Text")
  @doc("A synchronous API for the automatic review of harmful content")
  @route("/text:autoReview")
  @post
  autoReview is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text analysis request.")
      body: AutoReviewTextOptions;
    },
    AutoReviewTextResult
  >;

  @added(ContentSafety.Versions.v2024_04_15_Preview)
  @summary("Analyze Text Detect Incidents")
  @doc("A synchronous API for the analysis of text detect incidents.")
  @route("/text:detectIncidents")
  @post
  detectTextIncidents is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text incidents analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextDetectIncidentsOptions;
    },
    DetectIncidentsResult
  >;
}

interface ImageOperations {
  @summary("Analyze Image")
  @doc("A synchronous API for the analysis of potentially harmful image content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/image:analyze")
  @post
  analyzeImage is Azure.Core.RpcOperation<
    {
      @doc("The image analysis request.")
      @body
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeImageOptions;
    },
    AnalyzeImageResult
  >;

  @added(ContentSafety.Versions.v2024_04_15_Preview)
  @summary("Analyze Image Detect Incidents")
  @doc("A synchronous API for the analysis of image detect incidents.")
  @route("/image:detectIncidents")
  @post
  detectImageIncidents is Azure.Core.RpcOperation<
    {
      @body
      @doc("The image incidents analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeImageDetectIncidentsOptions;
    },
    DetectIncidentsResult
  >;
}

interface BlockOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@@clientName(Azure.Core.Foundations.ResourceBody.resource, "options");

interface TextBlocklists {
  @summary("Get Text Blocklist By blocklistName")
  @doc("Returns text blocklist details.")
  getTextBlocklist is BlockOps.ResourceRead<TextBlocklist>;

  @summary("Create Or Update Text Blocklist")
  @doc("Updates a text blocklist. If the blocklistName does not exist, a new blocklist will be created.")
  createOrUpdateTextBlocklist is BlockOps.ResourceCreateOrUpdate<TextBlocklist>;

  @summary("Delete Text Blocklist By blocklistName")
  @doc("Deletes a text blocklist.")
  deleteTextBlocklist is BlockOps.ResourceDelete<TextBlocklist>;

  @summary("Get All Text Blocklists")
  @doc("Get all text blocklists details.")
  listTextBlocklists is BlockOps.ResourceList<TextBlocklist>;

  @summary("Add or update BlocklistItems To Text Blocklist")
  @doc("Add or update blocklistItems to a text blocklist. You can add or update at most 100 blocklistItems in one request.")
  addOrUpdateBlocklistItems is BlockOps.ResourceAction<
    TextBlocklist,
    {
      @doc("Options for adding or updating blocklist items.")
      @body
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AddOrUpdateTextBlocklistItemsOptions;
    },
    AddOrUpdateTextBlocklistItemsResult
  >;

  @summary("Remove BlocklistItems From Text Blocklist")
  @doc("Remove blocklistItems from a text blocklist. You can remove at most 100 BlocklistItems in one request.")
  removeBlocklistItems is BlockOps.ResourceAction<
    TextBlocklist,
    {
      @doc("Options for removing blocklist items.")
      @body
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: RemoveTextBlocklistItemsOptions;
    },
    NoContentResponse
  >;

  @summary("Get BlocklistItem By blocklistName And blocklistItemId")
  @doc("Get blocklistItem by blocklistName and blocklistItemId from a text blocklist.")
  getTextBlocklistItem is BlockOps.ResourceRead<TextBlocklistItem>;

  @summary("Get All BlocklistItems By blocklistName")
  @doc("Get all blocklistItems in a text blocklist.")
  listTextBlocklistItems is BlockOps.ResourceList<
    TextBlocklistItem,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@added(Versions.v2024_02_15_Preview)
interface TextGroundednessDetectionOperations {
  @summary("Detect Groundedness")
  @doc("A synchronous API for the analysis of language model outputs to determine alignment with user-provided information or identify fictional content.")
  @route("/text:detectGroundedness")
  @post
  detectGroundednessOptions is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text groundedness detection request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextGroundednessOptions;
    },
    AnalyzeTextGroundednessResult
  >;
}

interface AutoReviewerOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_04_15_Preview)
interface AutoReviewerOperations {
  @summary("Create a new version of auto reviewer.")
  @doc("Create new auto reviewer or a new version of existing auto reviewer.")
  createOrReplaceAutoReviewer is AutoReviewerOps.LongRunningResourceCreateOrReplace<AutoReviewerVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a auto reviewer or a specific version of it.")
  @get
  @route("/text/autoReviewers/{autoReviewerName}")
  getAutoReviewer is Azure.Core.Foundations.Operation<
    {
      @path
      @doc("Name of the auto reviewer.")
      autoReviewerName: string;

      @query
      @doc("If not provided, it will return the latest version.")
      version?: int32;
    },
    AutoReviewerVersionList
  >;

  @doc("List latest versions of auto reviewers.")
  listAutoReviewers is AutoReviewerOps.ResourceList<
    AutoReviewerVersion,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @doc("Delete an auto reviewer or a specific version of it.")
  deleteAutoReviewer is AutoReviewerOps.ResourceDelete<
    AutoReviewerVersion,
    QueryParametersTrait<{
      @query
      @doc("If not provided, it will delete all the versions of the auto reviewer.")
      version?: int32;
    }>
  >;

  @summary("Get An Auto Reviewer Operation.")
  @doc("Get an auto reviewer operation.")
  getAutoReviewerOperation is Azure.Core.ResourceRead<AutoReviewerOperationDetail>;
}

interface TextIncidentOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_04_15_Preview)
interface TextIncidents {
  @summary("Get Text Incident By incidentName")
  @doc("Returns text incident details.")
  getIncidents is TextIncidentOps.ResourceRead<TextIncident>;

  @summary("Create Or Update Text Incident")
  @doc("Updates a text incident. If the text incident does not exist, a new text incident will be created.")
  createOrUpdateIncident is TextIncidentOps.ResourceCreateOrUpdate<TextIncident>;

  @summary("Delete Text Incident By incidentName")
  @doc("Deletes a text incident.")
  deleteIncident is TextIncidentOps.ResourceDelete<TextIncident>;

  @summary("Get All Text Incidents")
  @doc("Get all incidents details.")
  listIncidents is TextIncidentOps.ResourceList<
    TextIncident,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Add TextIncidentSamples To Incident")
  @doc("Add textIncidentSamples to an incident. You can add at most 100 textIncidentSamples in one request.")
  addIncidentSamples is TextIncidentOps.ResourceAction<
    TextIncident,
    AddTextIncidentSamplesOptions,
    AddTextIncidentSamplesResult
  >;

  @summary("Remove TextIncidentSamples From Incident")
  @doc("Remove textIncidentSamples from an incident. You can remove at most 100 Text Incident in one request.")
  removeIncidentSamples is TextIncidentOps.ResourceAction<
    TextIncident,
    RemoveTextIncidentSamplesOptions,
    NoContentResponse
  >;

  @summary("Get TextIncidentSample By textIncidentName And textIncidentSampleId")
  @doc("Get textIncidentSample by textIncidentName and textIncidentSampleId from a text incident.")
  getIncidentSample is TextIncidentOps.ResourceRead<TextIncidentSample>;

  @summary("Get All TextIncidentSamples By textIncidentName")
  @doc("Get all TextIncidentSamples in a text incident.")
  listIncidentSamples is TextIncidentOps.ResourceList<
    TextIncidentSample,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

interface ImageIncidentOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_04_15_Preview)
interface ImageIncidents {
  @summary("Get Image Incident By incidentName")
  @doc("Returns image incident details.")
  getIncidents is ImageIncidentOps.ResourceRead<ImageIncident>;

  @summary("Create Or Update Image Incident")
  @doc("Updates a image incident. If the image incident does not exist, a new image incident will be created.")
  createOrUpdateIncident is ImageIncidentOps.ResourceCreateOrUpdate<ImageIncident>;

  @summary("Delete Image Incident By incidentName")
  @doc("Deletes a image incident.")
  deleteIncident is ImageIncidentOps.ResourceDelete<ImageIncident>;

  @summary("Get All Image Incidents")
  @doc("Get all incidents details.")
  listIncidents is ImageIncidentOps.ResourceList<
    ImageIncident,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Add ImageIncidentSamples To Incident")
  @doc("Add imageIncidentSamples to an incident. You can add at most 100 imageIncidentSamples in one request.")
  addIncidentSamples is ImageIncidentOps.ResourceAction<
    ImageIncident,
    AddImageIncidentSamplesOptions,
    AddImageIncidentSamplesResult
  >;

  @summary("Remove ImageIncidentSamples From Incident")
  @doc("Remove imageIncidentSamples from an incident. You can remove at most 100 Image Incident in one request.")
  removeIncidentSamples is ImageIncidentOps.ResourceAction<
    ImageIncident,
    RemoveImageIncidentSamplesOptions,
    NoContentResponse
  >;

  @summary("Get ImageIncidentSample By imageIncidentName And imageIncidentSampleId")
  @doc("Get imageIncidentSample by imageIncidentName and imageIncidentSampleId from a image incident.")
  getIncidentSample is ImageIncidentOps.ResourceRead<ImageIncidentSampleResult>;

  @summary("Get All ImageIncidentSamples By imageIncidentName")
  @doc("Get all ImageIncidentSamples in a image incident.")
  listIncidentSamples is ImageIncidentOps.ResourceList<
    ListImageIncidentSampleResult,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

interface TextIncidentOperationsOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_04_15_Preview)
interface TextIncidentOperation {
  @summary("Deploy Text Incident Operation")
  @doc("Deploy text incident operation.")
  deploy is TextIncidentOperationsOps.LongRunningResourceAction<
    TextIncident,
    IncidentOperationIdOptions,
    {
      @statusCode
      statusCode: 202;

      @doc("The operation id passed by the user, if not provided, will be automatically generated as a UUID.")
      @header("Operation-Id")
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
      operationId?: string;
    }
  >;

  @summary("Get Text Incident Operation By OperationId")
  @doc("Get a text incident operation.")
  getTextIncidentOperation is TextIncidentOperationsOps.ResourceRead<TextIncidentOperationResult>;
}

interface ImageIncidentOperationsOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_04_15_Preview)
interface ImageIncidentOperation {
  @summary("Deploy Image incident Operation")
  @doc("Deploy image incident operation.")
  deploy is ImageIncidentOperationsOps.LongRunningResourceAction<
    ImageIncident,
    IncidentOperationIdOptions,
    {
      @statusCode
      statusCode: 202;

      @doc("The operation id passed by the user, if not provided, will be automatically generated as a UUID.")
      @header("Operation-Id")
      @pattern("^(?=[a-zA-Z0-9])[a-zA-Z0-9-]*[a-zA-Z0-9]$")
      operationId?: string;
    }
  >;

  @summary("Get Image Incident Operation By OperationId")
  @doc("Get a image incident operation.")
  getImageIncidentOperation is ImageIncidentOperationsOps.ResourceRead<ImageIncidentOperationResult>;
}
