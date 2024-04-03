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
      @clientName("options", "csharp")
      @clientName("options", "python")
      @clientName("options", "java")
      body: AnalyzeTextPromptInjectionOptions;
    },
    AnalyzeTextPromptInjectionResult
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
