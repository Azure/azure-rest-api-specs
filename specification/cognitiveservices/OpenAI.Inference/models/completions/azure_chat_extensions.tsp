import "@typespec/versioning";
import "./chat_completions.tsp";
import "./chat_messages.tsp";
import "./extensions/oyd/azure_search_options.tsp";
import "./extensions/oyd/azure_machinelearning_index_options.tsp";
import "./extensions/oyd/azure_cosmosdb_options.tsp";
import "./extensions/oyd/elasticsearch_options.tsp";
import "./extensions/oyd/mongodb_options.tsp";
import "./extensions/oyd/pinecone_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
    A representation of configuration data for a single Azure OpenAI chat extension. This will be used by a chat
    completions request that should use Azure OpenAI chat extensions to augment the response behavior.
    The use of this configuration is compatible only with Azure OpenAI.
  """)
union AzureChatExtensionType {
  string,

  @doc("Represents the use of Azure AI Search as an Azure OpenAI chat extension.")
  azureSearch: "azure_search",

  @doc("Represents the use of Azure Machine Learning index as an Azure OpenAI chat extension.")
  @removed(ServiceApiVersions.v2024_08_01_Preview)
  azureMachineLearningIndex: "azure_ml_index",

  @doc("Represents the use of Azure Cosmos DB as an Azure OpenAI chat extension.")
  azureCosmosDB: "azure_cosmos_db",

  @doc("Represents the use of Elasticsearch® index as an Azure OpenAI chat extension.")
  elasticsearch: "elasticsearch",

  @doc("Represents the use of Pinecone index as an Azure OpenAI chat extension.")
  pinecone: "pinecone",

  @added(ServiceApiVersions.v2024_08_01_Preview)
  @doc("Represents the use of a MongoDB chat extension.")
  mongoDB: "mongo_db",
}

@discriminator("type")
@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
    A representation of configuration data for a single Azure OpenAI chat extension. This will be used by a chat
    completions request that should use Azure OpenAI chat extensions to augment the response behavior.
    The use of this configuration is compatible only with Azure OpenAI.
  """)
model AzureChatExtensionConfiguration {
  @doc("""
      The label for the type of an Azure chat extension. This typically corresponds to a matching Azure resource.
      Azure chat extensions are only compatible with Azure OpenAI.
    """)
  type: AzureChatExtensionType;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
    A representation of the additional context information available when Azure OpenAI chat extensions are involved
    in the generation of a corresponding chat completions response. This context information is only populated when
    using an Azure OpenAI request configured to use a matching extension.
  """)
model AzureChatExtensionsMessageContext {
  @doc("""
      The contextual information associated with the Azure chat extensions used for a chat completions request.
      These messages describe the data source retrievals, plugin invocations, and other intermediate steps taken in the
      course of generating a chat completions response that was augmented by capabilities from Azure OpenAI chat
      extensions.
    """)
  citations?: AzureChatExtensionDataSourceResponseCitation[];

  @doc("The detected intent from the chat history, used to pass to the next turn to carry over the context.")
  intent?: string;

  /** All the retrieved documents. */
  @added(ServiceApiVersions.v2024_05_01_Preview)
  @encodedName("application/json", "all_retrieved_documents")
  allRetrievedDocuments?: AzureChatExtensionRetrievedDocument[];
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  A single instance of additional context information available when Azure OpenAI chat extensions are involved
  in the generation of a corresponding chat completions response. This context information is only populated when
  using an Azure OpenAI request configured to use a matching extension.
  """)
model AzureChatExtensionDataSourceResponseCitation {
  @doc("The content of the citation.")
  content: string;

  @doc("The title of the citation.")
  title?: string;

  @doc("The URL of the citation.")
  url?: string;

  @doc("The file path of the citation.")
  filepath?: string;

  #suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI uses wire-format snake_casing"
  @doc("The chunk ID of the citation.")
  chunk_id?: string;

  /** The rerank score of the retrieved document. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "OpenAI uses wire-format snake_casing"
  rerank_score?: float64;
}

/** The retrieved document. */
@added(ServiceApiVersions.v2024_05_01_Preview)
model AzureChatExtensionRetrievedDocument {
  ...AzureChatExtensionDataSourceResponseCitation;

  /** The search queries used to retrieve the document. */
  @encodedName("application/json", "search_queries")
  searchQueries: string[];

  /** The index of the data source. */
  @encodedName("application/json", "data_source_index")
  dataSourceIndex: int32;

  /** The original search score of the retrieved document. */
  @encodedName("application/json", "original_search_score")
  originalSearchScore?: float64;

  /**
   * Represents the rationale for filtering the document. If the document does not undergo filtering,
   * this field will remain unset.
   */
  @encodedName("application/json", "filter_reason")
  filterReason?: AzureChatExtensionRetrieveDocumentFilterReason;
}

/** The reason for filtering the retrieved document. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Enforcing closed set of values per service release"
@added(ServiceApiVersions.v2024_05_01_Preview)
union AzureChatExtensionRetrieveDocumentFilterReason {
  /**
   * The document is filtered by original search score threshold defined by `strictness` configure.
   */
  score: "score",

  /**
   * The document is not filtered by original search score threshold, but is filtered by rerank score and `top_n_documents` configure.
   */
  rerank: "rerank",
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A representation of the available options for the Azure OpenAI grounding enhancement.")
model AzureChatGroundingEnhancementConfiguration {
  @doc("Specifies whether the enhancement is enabled.")
  enabled: boolean;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "established industry acronym"
@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A representation of the available options for the Azure OpenAI optical character recognition (OCR) enhancement.")
model AzureChatOCREnhancementConfiguration {
  @doc("Specifies whether the enhancement is enabled.")
  enabled: boolean;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A representation of the available Azure OpenAI enhancement configurations.")
model AzureChatEnhancementConfiguration {
  @doc("A representation of the available options for the Azure OpenAI grounding enhancement.")
  grounding?: AzureChatGroundingEnhancementConfiguration;

  @doc("A representation of the available options for the Azure OpenAI optical character recognition (OCR) enhancement.")
  ocr?: AzureChatOCREnhancementConfiguration;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  Represents the output results of Azure enhancements to chat completions, as configured via the matching input provided
  in the request.
  """)
model AzureChatEnhancements {
  @doc("The grounding enhancement that returns the bounding box of the objects detected in the image.")
  grounding?: AzureGroundingEnhancement;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("The grounding enhancement that returns the bounding box of the objects detected in the image.")
model AzureGroundingEnhancement {
  @doc("The lines of text detected by the grounding enhancement.")
  lines: AzureGroundingEnhancementLine[];
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A content line object consisting of an adjacent sequence of content elements, such as words and selection marks.")
model AzureGroundingEnhancementLine {
  @doc("The text within the line.")
  text: string;

  @doc("An array of spans that represent detected objects and its bounding box information.")
  spans: AzureGroundingEnhancementLineSpan[];
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A span object that represents a detected object and its bounding box information.")
model AzureGroundingEnhancementLineSpan {
  @doc("The text content of the span that represents the detected object.")
  text: string;

  @doc("""
    The character offset within the text where the span begins. This offset is defined as the position of the first
    character of the span, counting from the start of the text as Unicode codepoints.
    """)
  offset: int32;

  @doc("The length of the span in characters, measured in Unicode codepoints.")
  length: int32;

  @doc("An array of objects representing points in the polygon that encloses the detected object.")
  polygon: AzureGroundingEnhancementCoordinatePoint[];
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("A representation of a single polygon point as used by the Azure grounding enhancement.")
model AzureGroundingEnhancementCoordinatePoint {
  @doc("The x-coordinate (horizontal axis) of the point.")
  x: float32;

  @doc("The y-coordinate (vertical axis) of the point.")
  y: float32;
}

/**
 * User security context contains several parameters that describe the AI application itself,
 * and the end user that interacts with the AI application. These fields assist your security
 * operations teams to investigate and mitigate security incidents by providing a comprehensive
 * approach to protecting your AI applications. (Learn more at https://aka.ms/TP4AI/Documentation/EndUserContext)
 * about protecting AI applications using Microsoft Defender for Cloud.
 */
@added(ServiceApiVersions.v2025_01_01_Preview)
model UserSecurityContext {
  /** The name of the application. Sensitive personal information should not be included in this field. */
  @encodedName("application/json", "application_name")
  applicationName?: string;

  /** This identifier is the Microsoft Entra ID (formerly Azure Active Directory) user object ID used to authenticate end-users within the generative AI application. Sensitive personal information should not be included in this field. */
  @encodedName("application/json", "end_user_id")
  endUserId?: Azure.Core.uuid;

  /** The Microsoft 365 tenant ID the end user belongs to. It's required when the generative AI application is multi tenant. */
  @encodedName("application/json", "end_user_tenant_id")
  endUserTenantId?: Azure.Core.uuid;

  /** Captures the original client's IP address, accepting both IPv4 and IPv6 formats. */
  @encodedName("application/json", "source_ip")
  sourceIp?: string;
}
