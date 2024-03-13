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
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
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
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
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
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
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
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
      body: AnalyzeImageOptions;
    },
    AnalyzeImageResult
  >;
}

interface BlockOps
  extends Azure.Core.ResourceOperations<NoRepeatableRequests &
      NoConditionalRequests &
      NoClientRequestId> {}

@@projectedName(Azure.Core.Foundations.ResourceBody.resource,
  "client",
  "options"
);

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
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
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
      @projectedName("csharp", "options")
      @projectedName("python", "options")
      @projectedName("java", "options")
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
