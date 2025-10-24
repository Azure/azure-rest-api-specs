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
}

interface ImageOperations {
  @summary("Analyze Image")
  @doc("A synchronous API for the analysis of potentially harmful image content. Currently, it supports four categories: Hate, SelfHarm, Sexual, and Violence.")
  @route("/image:analyze")
  @post
  analyzeImage is Azure.Core.RpcOperation<
    {
      @doc("The image analysis request.")
      @bodyRoot
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
      @bodyRoot
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
      @bodyRoot
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
