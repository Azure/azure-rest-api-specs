import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
A specific representation of configurable options for Elasticsearch when using it as an Azure OpenAI chat
extension.
""")
model PineconeChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
  The type label to use when configuring Azure OpenAI chat extensions. This should typically not be changed from its
  default value for Pinecone.
  """)
  type: AzureChatExtensionType.pinecone;

  @doc("The parameters to use when configuring Azure OpenAI chat extensions.")
  parameters: PineconeChatExtensionParameters;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("Parameters for configuring Azure OpenAI Pinecone chat extensions.")
model PineconeChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The environment name of Pinecone.")
  @projectedName("csharp", "EnvironmentName")
  environment: string;

  @doc("The name of the Pinecone database index.")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("csharp", "FieldMappingOptions")
  fieldsMapping: PineconeFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  embeddingDependency?: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Pinecone resource.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model PineconeFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @projectedName("csharp", "TitleFieldName")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @projectedName("csharp", "UrlFieldName")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @projectedName("csharp", "FilepathFieldName")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @projectedName("csharp", "ContentFieldNames")
  contentFields?: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("csharp", "ContentFieldSeparator")
  contentFieldsSeparator?: string;

  @doc("The names of fields that represent vector data.")
  @projectedName("csharp", "VectorFieldNames")
  vectorFields?: string[];

  @added(ServiceApiVersions.v2023_12_01_Preview)
  @doc("The names of fields that represent image vector data.")
  @projectedName("csharp", "ImageVectorFieldNames")
  imageVectorFields?: string[];
}
