import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
@added(ServiceApiVersions.v2023_12_01_Preview)
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

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("Parameters for configuring Azure OpenAI Pinecone chat extensions. The supported authentication type is APIKey.")
model PineconeChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("The environment name of Pinecone.")
  @clientName("EnvironmentName", "csharp")
  environment: string;

  @doc("The name of the Pinecone database index.")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @clientName("FieldMappingOptions", "csharp")
  fieldsMapping: PineconeFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  embeddingDependency: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Pinecone resource.")
@added(ServiceApiVersions.v2023_08_01_Preview)
model PineconeFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @clientName("TitleFieldName", "csharp")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @clientName("UrlFieldName", "csharp")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @clientName("FilepathFieldName", "csharp")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @clientName("ContentFieldNames", "csharp")
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @clientName("ContentFieldSeparator", "csharp")
  contentFieldsSeparator?: string;
}
