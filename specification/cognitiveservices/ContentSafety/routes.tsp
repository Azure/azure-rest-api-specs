import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/rest";
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
  @doc("A sync API for harmful content analysis for text. Currently, we support four categories: Hate, SelfHarm, Sexual, Violence.")
  @route("/text:analyze")
  @post
  analyzeText is Azure.Core.RpcOperation<
    {
      @body
      @doc("The request of text analysis.")
      body: AnalyzeTextOptions;
    },
    AnalyzeTextResult
  >;
}

interface ImageOperations {
  @summary("Analyze Image")
  @doc("A sync API for harmful content analysis for image. Currently, we support four categories: Hate, SelfHarm, Sexual, Violence.")
  @route("/image:analyze")
  @post
  analyzeImage is Azure.Core.RpcOperation<
    {
      @doc("The analysis request of the image.")
      @body
      body: AnalyzeImageOptions;
    },
    AnalyzeImageResult
  >;
}

interface TextBlocklists {
  @summary("Get Text Blocklist By blocklistName")
  @doc("Returns text blocklist details.")
  getTextBlocklist is Azure.Core.ResourceRead<TextBlocklist>;

  @summary("Create Or Update Text Blocklist")
  @doc("Updates a text blocklist, if blocklistName does not exist, create a new blocklist.")
  createOrUpdateTextBlocklist is Azure.Core.ResourceCreateOrUpdate<TextBlocklist>;

  @summary("Delete Text Blocklist By blocklistName")
  @doc("Deletes a text blocklist.")
  deleteTextBlocklist is Azure.Core.ResourceDelete<TextBlocklist>;

  @summary("Get All Text Blocklists")
  @doc("Get all text blocklists details.")
  listTextBlocklists is Azure.Core.ResourceList<TextBlocklist>;

  @summary("Add BlockItems To Text Blocklist")
  @doc("Add blockItems to a text blocklist. You can add at most 100 BlockItems in one request.")
  addBlockItems is ResourceAction<
    TextBlocklist,
    AddBlockItemsOptions,
    AddBlockItemsResult
  >;

  @summary("Remove BlockItems From Text Blocklist")
  @doc("Remove blockItems from a text blocklist. You can remove at most 100 BlockItems in one request.")
  removeBlockItems is ResourceAction<
    TextBlocklist,
    RemoveBlockItemsOptions,
    NoContentResponse
  >;

  @summary("Get BlockItem By blocklistName And blockItemId")
  @doc("Get blockItem By blockItemId from a text blocklist.")
  getTextBlocklistItem is Azure.Core.ResourceRead<TextBlockItem>;

  @summary("Get All BlockItems By blocklistName")
  @doc("Get all blockItems in a text blocklist")
  listTextBlocklistItems is Azure.Core.ResourceList<
    TextBlockItem,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;
}
