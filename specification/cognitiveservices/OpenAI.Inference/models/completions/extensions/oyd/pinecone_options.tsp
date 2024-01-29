import "@typespec/versioning";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
A specific representation of configurable options for Pinecone when using it as an Azure OpenAI chat
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

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("Parameters for configuring Azure OpenAI Pinecone chat extensions. The supported authentication type is APIKey.")
model PineconeChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The environment name of Pinecone.")
  @projectedName("csharp", "EnvironmentName")
  environment: string;

  @doc("The name of the Pinecone database index.")
  @projectedName("json", "index_name")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @projectedName("csharp", "FieldMappingOptions")
  @projectedName("json", "fields_mapping")
  fieldsMapping: PineconeFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  @projectedName("json", "embedding_dependency")
  embeddingDependency: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Pinecone resource.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model PineconeFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @projectedName("csharp", "TitleFieldName")
  @projectedName("json", "title_field")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @projectedName("csharp", "UrlFieldName")
  @projectedName("json", "url_field")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @projectedName("csharp", "FilepathFieldName")
  @projectedName("json", "filepath_field")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @projectedName("csharp", "ContentFieldNames")
  @projectedName("json", "content_fields")
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @projectedName("csharp", "ContentFieldSeparator")
  @projectedName("json", "content_fields_separator")
  contentFieldsSeparator?: string;
}
