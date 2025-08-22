import "@typespec/versioning";
import "@azure-tools/typespec-client-generator-core";
import "./../../azure_chat_extensions.tsp";
import "./common_options.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-core/casing-style" "MongoDB is a branded name"
@added(ServiceApiVersions.v2024_08_01_Preview)
@doc("""
  A specific representation of configurable options for a MongoDB chat extension configuration.
  """)
model MongoDBChatExtensionConfiguration
  extends AzureChatExtensionConfiguration {
  @doc("""
    The type label for MongoDB.
    """)
  type: AzureChatExtensionType.mongoDB;

  @doc("The parameters for the MongoDB chat extension.")
  parameters: MongoDBChatExtensionParameters;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" "MongoDB is a branded name"
@added(ServiceApiVersions.v2024_08_01_Preview)
@doc("Parameters for the MongoDB chat extension. The supported authentication types are AccessToken, SystemAssignedManagedIdentity and UserAssignedManagedIdentity.")
model MongoDBChatExtensionParameters {
  ...OnYourDataCommonChatExtensionConfiguration;

  @doc("""
    The authentication method to use when accessing the defined data source.
    Each data source type supports a specific set of available authentication methods; please see the documentation of
    the data source for supported mechanisms.
    If not otherwise provided, On Your Data will attempt to use System Managed Identity (default credential)
    authentication.
    """)
  @clientName("Authentication", "csharp")
  authentication?: OnYourDataUsernameAndPasswordAuthenticationOptions;

  @doc("The endpoint name for MongoDB.")
  endpoint: string;

  @doc("The collection name for MongoDB.")
  collection_name: string;

  @doc("The database name for MongoDB.")
  database_name: string;

  @doc("The app name for MongoDB.")
  app_name: string;

  /** The name of the MongoDB index. */
  index_name: string;

  /**
   * Field mappings to apply to data used by the MongoDB data source.
   * Note that content and vector field mappings are required for MongoDB.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "this represents the case-sensitive wire format"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  fields_mapping: {
    content_fields: string[];
    vector_fields: string[];
    title_field?: string;
    url_field?: string;
    filepath_field?: string;
    content_fields_separator?: string;
  };

  #suppress "@azure-tools/typespec-autorest/union-unsupported" "OpenAPI v2 support deferred"
  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Backwards compatibility with existing clients."
  @doc("""
    The vectorization source to use with the MongoDB chat extension.
    """)
  embedding_dependency: OnYourDataEndpointVectorizationSource | OnYourDataDeploymentNameVectorizationSource;
}
