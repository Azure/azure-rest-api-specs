import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./authentication.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

alias OnYourDataCommonChatExtensionConfiguration = {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  @doc("The configured top number of documents to feature for the configured query.")
  @clientName("DocumentCount", "csharp")
  @encodedName("application/json", "top_n_documents")
  topNDocuments?: int32;

  @doc("Whether queries should be restricted to use of indexed data.")
  @clientName("ShouldRestrictResultScope", "csharp")
  @encodedName("application/json", "in_scope")
  inScope?: boolean;

  @doc("The configured strictness of the search relevance filtering. The higher of strictness, the higher of the precision but lower recall of the answer.")
  @minValue(1)
  @maxValue(5)
  strictness?: int32;

  @doc("Give the model instructions about how it should behave and any context it should reference when generating a response. You can describe the assistant's personality and tell it how to format responses. There's a 100 token limit for it, and it counts against the overall token limit.")
  @encodedName("application/json", "role_information")
  @removed(ServiceApiVersions.v2024_08_01_Preview)
  roleInformation?: string;

  /**
   * The max number of rewritten queries should be send to search provider for one user message. If not specified,
   * the system will decide the number of queries to send.
   */
  @encodedName("application/json", "max_search_queries")
  @added(ServiceApiVersions.v2024_05_01_Preview)
  maxSearchQueries?: int32;

  /**
   * If specified as true, the system will allow partial search results to be used and the request fails if all the queries fail.
   * If not specified, or specified as false, the request will fail if any search query fails.
   */
  @encodedName("application/json", "allow_partial_result")
  @added(ServiceApiVersions.v2024_05_01_Preview)
  allowPartialResult?: boolean = false;

  /** The included properties of the output context. If not specified, the default value is `citations` and `intent`. */
  @encodedName("application/json", "include_contexts")
  @added(ServiceApiVersions.v2024_05_01_Preview)
  includeContexts?: OnYourDataContextProperty[];
};

/** The context property. */
@added(ServiceApiVersions.v2024_05_01_Preview)
union OnYourDataContextProperty {
  string,

  /** The `citations` property. */
  citations: "citations",

  /** The `intent` property. */
  intent: "intent",

  /** The `all_retrieved_documents` property. */
  allRetrievedDocuments: "all_retrieved_documents",
}
