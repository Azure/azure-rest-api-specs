import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";
import "./vector_search.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

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

  @doc("""
    The authentication method to use when accessing the defined data source.
    Each data source type supports a specific set of available authentication methods; please see the documentation of
    the data source for supported mechanisms.
    If not otherwise provided, On Your Data will attempt to use System Managed Identity (default credential)
    authentication.
    """)
  @clientName("Authentication", "csharp")
  authentication?: OnYourDataAuthenticationOptions;

  @doc("The environment name of Pinecone.")
  @clientName("EnvironmentName", "csharp")
  environment: string;

  @doc("The name of the Pinecone database index.")
  @encodedName("application/json", "index_name")
  indexName: string;

  @doc("Customized field mapping behavior to use when interacting with the search index.")
  @clientName("FieldMappingOptions", "csharp")
  @encodedName("application/json", "fields_mapping")
  fieldsMapping: PineconeFieldMappingOptions;

  @doc("The embedding dependency for vector search.")
  @encodedName("application/json", "embedding_dependency")
  embeddingDependency: OnYourDataVectorizationSource;
}

@doc("Optional settings to control how fields are processed when using a configured Pinecone resource.")
@added(ServiceApiVersions.v2024_02_15_Preview)
model PineconeFieldMappingOptions {
  @doc("The name of the index field to use as a title.")
  @clientName("TitleFieldName", "csharp")
  @encodedName("application/json", "title_field")
  titleField?: string;

  @doc("The name of the index field to use as a URL.")
  @clientName("UrlFieldName", "csharp")
  @encodedName("application/json", "url_field")
  urlField?: string;

  @doc("The name of the index field to use as a filepath.")
  @clientName("FilepathFieldName", "csharp")
  @encodedName("application/json", "filepath_field")
  filepathField?: string;

  @doc("The names of index fields that should be treated as content.")
  @clientName("ContentFieldNames", "csharp")
  @encodedName("application/json", "content_fields")
  contentFields: string[];

  @doc("The separator pattern that content fields should use.")
  @clientName("ContentFieldSeparator", "csharp")
  @encodedName("application/json", "content_fields_separator")
  contentFieldsSeparator?: string;
}
