import "@azure-tools/typespec-azure-core";
import "@typespec/http";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

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
      @doc("The text analysis request.")
      body: AnalyzeTextProtectedMaterialOptions;
    },
    AnalyzeTextProtectedMaterialResult
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
      body: AnalyzeImageOptions;
    },
    AnalyzeImageResult
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
    AddOrUpdateTextBlocklistItemsOptions,
    AddOrUpdateTextBlocklistItemsResult
  >;

  @summary("Remove BlocklistItems From Text Blocklist")
  @doc("Remove blocklistItems from a text blocklist. You can remove at most 100 BlocklistItems in one request.")
  removeBlocklistItems is BlockOps.ResourceAction<
    TextBlocklist,
    RemoveTextBlocklistItemsOptions,
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

interface TextIncidentOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

@added(ContentSafety.Versions.v2023_10_30_Preview)
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

@added(Versions.v2023_10_30_Preview)
interface PromptTextOperations {
  @summary("Annotate Text by Prompt")
  @route("/text:adaptiveAnnotate")
  @post
  annotateText is Azure.Core.RpcOperation<
    {
      @body
      @doc("The text analysis request.")
      body: AnnotateTextOptions;
    },
    AnnotateTextResult
  >;
}

interface CategoryOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@added(Versions.v2023_10_30_Preview)
interface TextCategoryCustomization {
  createOrReplaceTextCustomizedCategory is CategoryOps.ResourceCreateOrReplace<TextCustomizedCategory>;

  getTextCustomizedCategory is CategoryOps.ResourceRead<TextCustomizedCategory>;

  deleteTextCustomizedCategory is CategoryOps.ResourceDelete<TextCustomizedCategory>;

  listTextCustomizedCategory is CategoryOps.ResourceList<
    TextCustomizedCategory,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}

@added(Versions.v2023_10_30_Preview)
interface ImageWithTextOperations {
  @summary("Analyze Image With Text")
  @doc("A synchronous API for the analysis of potentially harmful image with text content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/imageWithText:analyze")
  @post
  analyzeImageWithText is Azure.Core.RpcOperation<
    {
      @doc("The image with text analysis request.")
      @body
      body: AnalyzeImageWithTextOptions;
    },
    AnalyzeImageWithTextResult
  >;
}
