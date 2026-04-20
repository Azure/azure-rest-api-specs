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
      @bodyRoot
      @doc("The text analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextOptions;
    },
    AnalyzeTextResult
  >;

  @added(ContentSafety.Versions.v2024_09_01)
  @summary("Shield Prompt")
  @doc("A synchronous API for shielding prompt from direct and indirect injection attacks.")
  @route("/text:shieldPrompt")
  @post
  shieldPrompt is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected, which may contain direct or indirect injection attacks.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: ShieldPromptOptions;
    },
    ShieldPromptResult
  >;

  @added(ContentSafety.Versions.v2024_09_01)
  @summary("Detect Protected Material for Text")
  @doc("A synchronous API for detecting protected material in the given text.")
  @route("/text:detectProtectedMaterial")
  @post
  detectTextProtectedMaterial is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected, which may contain protected material.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: DetectTextProtectedMaterialOptions;
    },
    DetectTextProtectedMaterialResult
  >;

  @added(ContentSafety.Versions.v2024_09_15_Preview)
  @summary("Detect Protected Material for Code")
  @doc("A synchronous API for detecting protected material in the given code.")
  @route("/text:detectProtectedMaterialForCode")
  @post
  detectCodeProtectedMaterial is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected, which may contain protected material.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: DetectCodeProtectedMaterialOptions;
    },
    DetectCodeProtectedMaterialResult
  >;

  @added(ContentSafety.Versions.v2024_09_15_Preview)
  @summary("Analyze Text with Custom Category")
  @doc("A synchronous API to analyze content with Custom Category defined.")
  @route("/text:analyzeCustomCategory")
  @post
  analyzeTextCustomCategory is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be analyzed.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextCustomCategoryOption;
    },
    AnalyzeTextCustomCategoryResult
  >;

  @added(ContentSafety.Versions.v2024_09_15_Preview)
  @summary("Analyze Text with Auto Reviewer")
  @doc("A synchronous API to analyze text with the Auto Reviewer defined.")
  @route("/text:autoReview")
  @post
  autoReview is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be analyzed.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AutoReviewTextOptions;
    },
    AutoReviewTextResult
  >;

  @added(ContentSafety.Versions.v2024_09_15_Preview)
  @summary("Analyze Text with Text Incidents")
  @doc("A synchronous API to analyze text content with the custom content safety Text Incidents defined.")
  @route("/text:detectIncidents")
  @post
  detectTextIncidents is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextDetectIncidentsOptions;
    },
    DetectIncidentsResult
  >;

  @added(ContentSafety.Versions.v2024_09_15_Preview)
  @summary("Analyze Text Groundedness")
  @doc("A synchronous API to analyze the language model outputs to evaluate alignment with user-provided information or to identify fictional content.")
  @route("/text:detectGroundedness")
  @post
  detectGroundednessOptions is Azure.Core.RpcOperation<
    {
      @body
      @doc("The request body to be detected.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextGroundednessOptions;
    },
    AnalyzeTextGroundednessResult
  >;
}

interface ImageOperations {
  @summary("Analyze Image")
  @doc("A synchronous API for the analysis of potentially harmful image content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/image:analyze")
  @post
  analyzeImage is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The image analysis request.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeImageOptions;
    },
    AnalyzeImageResult
  >;

  @added(ContentSafety.Versions.v2024_09_15_Preview)
  @summary("Analyze Image with Image Incidents")
  @doc("A synchronous API to analyze image content with the custom content safety Image Incidents defined.")
  @route("/image:detectIncidents")
  @post
  detectImageIncidents is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The request body to be detected.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeImageDetectIncidentsOptions;
    },
    DetectIncidentsResult
  >;

  @added(ContentSafety.Versions.v2024_09_30_Preview)
  @summary("Decode the content credentials from assets.")
  @doc("A synchronous API for decoding the content credentials from assets.")
  @route("/image:detectWatermark")
  @post
  detectWatermark is Azure.Core.RpcOperation<
    {
      @bodyRoot
      @doc("The image to be decoded, which is in base64 string format.")
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: DecodeImageCredentialOptions;
    },
    DecodeImageCredentialResult
  >;
}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface ImageWithTextOperations {
  @summary("Analyze Image with Text")
  @doc("A synchronous API to analyze image content with embedded or custom text content.")
  @route("/imageWithText:analyze")
  @post
  analyzeImageWithText is Azure.Core.RpcOperation<
    {
      @doc("The request body of image-with-text analysis.")
      @body
      body: AnalyzeImageWithTextOptions;
    },
    AnalyzeImageWithTextResult
  >;
}

interface BlockOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

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
      @bodyRoot
      @doc("Options for adding or updating blocklist items.")
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
      @bodyRoot
      @doc("Options for removing blocklist items.")
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

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface AutoReviewerOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

alias OperationIdTrait = Azure.Core.Traits.RequestHeadersTrait<{
  @doc("The operation id passed by the user, if not provided, will be automatically generated as a UUID.")
  @header("Operation-Id")
  @pattern("^[0-9A-Za-z._~-]+$")
  @maxLength(64)
  operationId?: string;
}> &
  Azure.Core.Traits.ResponseHeadersTrait<{
    @doc("The operation id passed by the user in the request or a random UUID generated by server side.")
    @header("Operation-Id")
    @pattern("^[0-9A-Za-z._~-]+$")
    operationId: string;
  }>;

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface AutoReviewerOperations {
  @summary("Auto Reviewer - Create")
  @doc("Create a new Auto Reviewer or a new version of an existing Auto Reviewer. This will submit a long running operation.")
  @pollingOperation(AutoReviewerOperations.getLongRunningOperation)
  createOrReplaceAutoReviewer is AutoReviewerOps.LongRunningResourceCreateOrReplace<
    AutoReviewerVersion,
    OperationIdTrait
  >;

  @summary("Auto Reviewer - Get Long Running Operation")
  @doc("Get details of an Auto Reviewer operation.")
  getLongRunningOperation is Azure.Core.ResourceRead<AutoReviewerOperationDetail>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Auto Reviewer - Get")
  @doc("Get the specified or latest version of the given Auto Reviewer.")
  @get
  @route("/text/autoReviewers/{autoReviewerName}")
  getAutoReviewer is Azure.Core.Foundations.Operation<
    {
      @path
      @doc("Name of the Auto Reviewer.")
      @maxLength(64)
      autoReviewerName: string;

      @query
      @doc("If not provided, it will return the latest version.")
      version?: int32;
    },
    AutoReviewerVersionList
  >;

  @summary("Auto Reviewer - List")
  @doc("List Auto Reviewers with their latest versions.")
  listAutoReviewers is AutoReviewerOps.ResourceList<
    AutoReviewerVersion,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Auto Reviewer - Delete")
  @doc("Delete the specified or ALL versions of the given Auto Reviewer.")
  deleteAutoReviewer is AutoReviewerOps.ResourceDelete<
    AutoReviewerVersion,
    QueryParametersTrait<{
      @query
      @doc("If not provided, it will delete ALL versions.")
      version?: int32;
    }>
  >;
}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface TextIncidentOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface TextIncidentOperations {
  @summary("Text Incident - Deploy")
  @doc("Deploy the given text safety incident. After the deployment completed, the incident can be used to detect content. This will submit a long running operation.")
  @pollingOperation(TextIncidentOperations.getLongRunningOperation)
  deploy is TextIncidentOps.LongRunningResourceAction<
    TextIncident,
    IncidentLongRunningOperationParameters,
    IncidentLongRunningOperationStatusResult
  >;

  @summary("Text Incident - Get Long Running Operation")
  @doc("Get details of the given text safety incident operation.")
  getLongRunningOperation is TextIncidentOps.ResourceRead<TextIncidentOperationResult>;

  @summary("Text Incident - Get")
  @doc("Return details of the given text safety incident.")
  getIncidents is TextIncidentOps.ResourceRead<TextIncident>;

  @summary("Text Incident - Upsert")
  @doc("Update the given text safety incident. If the incident does not exist, a new one will be created.")
  createOrUpdateIncident is TextIncidentOps.ResourceCreateOrUpdate<TextIncident>;

  @summary("Text Incident - Delete")
  @doc("Deletes the given text safety incident.")
  deleteIncident is TextIncidentOps.ResourceDelete<TextIncident>;

  @summary("Text Incident - List")
  @doc("List all text safety incidents and their details.")
  listIncidents is TextIncidentOps.ResourceList<
    TextIncident,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Text Incident - Add Samples")
  @doc("Add samples to the given text safety incident.")
  addIncidentSamples is TextIncidentOps.ResourceAction<
    TextIncident,
    AddTextIncidentSamplesOptions,
    AddTextIncidentSamplesResult
  >;

  @summary("Text Incident - Remove Samples")
  @doc("Remove samples from the given text safety incident.")
  removeIncidentSamples is TextIncidentOps.ResourceAction<
    TextIncident,
    RemoveTextIncidentSamplesOptions,
    NoContentResponse
  >;

  @summary("Text Incident - Get Sample")
  @doc("Get details of a sample with the sample id from the given text safety incident.")
  getIncidentSample is TextIncidentOps.ResourceRead<TextIncidentSample>;

  @summary("Text Incident - List Samples")
  @doc("List all samples added into the given text safety incident.")
  listIncidentSamples is TextIncidentOps.ResourceList<
    TextIncidentSample,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface ImageIncidentOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface ImageIncidentOperations {
  @summary("Image Incident - Deploy")
  @doc("Deploy the given image safety incident. After the deployment completed, the incident can be used to detect content. This will submit a long running operation.")
  @pollingOperation(ImageIncidentOperations.getLongRunningOperation)
  deploy is ImageIncidentOps.LongRunningResourceAction<
    ImageIncident,
    IncidentLongRunningOperationParameters,
    IncidentLongRunningOperationStatusResult
  >;

  @summary("Image Incident - Get Long Running Operation")
  @doc("Get details of an image safety incident operation.")
  getLongRunningOperation is ImageIncidentOps.ResourceRead<ImageIncidentOperationResult>;

  @summary("Image Incident - Get")
  @doc("Return details of the given image safety incident.")
  getIncidents is ImageIncidentOps.ResourceRead<ImageIncident>;

  @summary("Image Incident - Upsert")
  @doc("Update the given image safety incident. If the incident does not exist, a new one will be created.")
  createOrUpdateIncident is ImageIncidentOps.ResourceCreateOrUpdate<ImageIncident>;

  @summary("Image Incident - Delete")
  @doc("Deletes the given image safety incident.")
  deleteIncident is ImageIncidentOps.ResourceDelete<ImageIncident>;

  @summary("Image Incident - List")
  @doc("List all image safety incidents and their details.")
  listIncidents is ImageIncidentOps.ResourceList<
    ImageIncident,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Image Incident - Add Samples")
  @doc("Add samples to the given image safety incident.")
  addIncidentSamples is ImageIncidentOps.ResourceAction<
    ImageIncident,
    AddImageIncidentSamplesOptions,
    AddImageIncidentSamplesResult
  >;

  @summary("Image Incident - Remove Samples")
  @doc("Remove samples from the given image safety incident.")
  removeIncidentSamples is ImageIncidentOps.ResourceAction<
    ImageIncident,
    RemoveImageIncidentSamplesOptions,
    NoContentResponse
  >;

  @summary("Image Incident - Get Sample")
  @doc("Get details of a sample with the sample id from the given image safety incident.")
  getIncidentSample is ImageIncidentOps.ResourceRead<ImageIncidentSampleResult>;

  @summary("Image Incident - List Samples")
  @doc("List all samples added into the given image safety incident.")
  listIncidentSamples is ImageIncidentOps.ResourceList<
    ListImageIncidentSampleResult,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface TextCustomizedCategoryOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2024_09_15_Preview)
interface TextCustomizedCategoryOperations {
  @summary("Custom Category - Build")
  @doc("Trigger the build process for the given Custom Category. After the build completed, the category can be used to analyze content. This will submit a long running operation.")
  @pollingOperation(TextCustomizedCategoryOperations.getLongRunningOperation)
  build is TextCustomizedCategoryOps.LongRunningResourceAction<
    TextCustomCategoryVersion,
    CustomCategoryLongRunningOperationParameters,
    CustomCategoryLongRunningOperationStatusResult
  >;

  @summary("Custom Category - Get Long Running Operation")
  @doc("Get details of the given Custom Category operation.")
  getLongRunningOperation is Azure.Core.ResourceRead<CustomCategoryOperationDetail>;

  @summary("Custom Category - Create")
  @doc("Create a new Custom Category or a new version of an existing Custom Category. This will submit a long running operation.")
  createTextCustomCategoryVersion is TextCustomizedCategoryOps.ResourceCreateOrReplace<TextCustomCategoryVersion>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Custom Category - Get")
  @doc("Get the specified or latest version of the given Custom Category.")
  @get
  @route("/text/categories/{categoryName}")
  getCustomizedCategory is Azure.Core.Foundations.Operation<
    {
      @path
      @doc("Name of the Custom Category.")
      categoryName: string;

      @query
      @doc("If not provided, it will return the latest version.")
      version?: int32;
    },
    TextCustomCategoryVersionList
  >;

  @summary("Custom Category - List")
  @doc("List Custom Categories with their latest versions.")
  listCustomizedCategory is TextCustomizedCategoryOps.ResourceList<
    TextCustomCategoryVersion,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  @summary("Custom Category - Delete")
  @doc("Delete the specified or ALL versions of the given Custom Category.")
  deleteCustomizedCategory is TextCustomizedCategoryOps.ResourceDelete<
    TextCustomCategoryVersion,
    QueryParametersTrait<{
      @query
      @doc("If not provided, it will delete ALL versions.")
      version?: int32;
    }>
  >;
}
