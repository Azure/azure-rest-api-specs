import "@typespec/versioning";
import "./authentication.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  Represents the available sources Azure OpenAI On Your Data can use to configure vectorization of data for use with
  vector search.
  """)
union OnYourDataVectorizationSourceType {
  string,

  @doc("""
    Represents vectorization performed by public service calls to an Azure OpenAI embedding model.
    """)
  endpoint: "endpoint",

  @doc("""
    Represents an Ada model deployment name to use. This model deployment must be in the same Azure OpenAI resource, but
    On Your Data will use this model deployment via an internal call rather than a public one, which enables vector
    search even in private networks.
    """)
  deploymentName: "deployment_name",

  @doc("""
    Represents a specific embedding model ID as defined in the search service.
    Currently only supported by Elasticsearch®.
    """)
  modelId: "model_id",

  @added(ServiceApiVersions.v2024_08_01_Preview)
  @doc("""
    Represents the integrated vectorizer defined within the search resource.
    """)
  integrated: "integrated",
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@discriminator("type")
@doc("An abstract representation of a vectorization source for Azure OpenAI On Your Data with vector search.")
model OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use.")
  type: OnYourDataVectorizationSourceType;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  The details of a a vectorization source, used by Azure OpenAI On Your Data when applying vector search, that is based
  on a public Azure OpenAI endpoint call for embeddings.
  """)
model OnYourDataEndpointVectorizationSource
  extends OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use. Always 'Endpoint' for this type.")
  type: OnYourDataVectorizationSourceType.endpoint;

  @doc("Specifies the resource endpoint URL from which embeddings should be retrieved. It should be in the format of https://YOUR_RESOURCE_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/embeddings. The api-version query parameter is not allowed.")
  endpoint: url;

  // `authentication` according to the 05-01-preview spec, only supports api-key and data access token auth.
  @doc("Specifies the authentication options to use when retrieving embeddings from the specified endpoint.")
  @added(ServiceApiVersions.v2024_05_01_Preview)
  authentication: OnYourDataVectorSearchAuthenticationOptions;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  The details of a a vectorization source, used by Azure OpenAI On Your Data when applying vector search, that is based
  on an internal embeddings model deployment name in the same Azure OpenAI resource.
  """)
model OnYourDataDeploymentNameVectorizationSource
  extends OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use. Always 'DeploymentName' for this type.")
  type: OnYourDataVectorizationSourceType.deploymentName;

  @doc("The embedding model deployment name within the same Azure OpenAI resource. This enables you to use vector search without Azure OpenAI api-key and without Azure OpenAI public network access.")
  @encodedName("application/json", "deployment_name")
  deploymentName: string;

  /** The number of dimensions the embeddings should have. Only supported in `text-embedding-3` and later models. */
  @added(ServiceApiVersions.v2024_05_01_Preview)
  dimensions?: int32;
}

@added(ServiceApiVersions.v2024_02_15_Preview)
@doc("""
  The details of a a vectorization source, used by Azure OpenAI On Your Data when applying vector search, that is based
  on a search service model ID. Currently only supported by Elasticsearch®.
  """)
model OnYourDataModelIdVectorizationSource
  extends OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use. Always 'ModelId' for this type.")
  type: OnYourDataVectorizationSourceType.modelId;

  @doc("The embedding model ID build inside the search service. Currently only supported by Elasticsearch®.")
  @encodedName("application/json", "model_id")
  modelId: string;
}

@added(ServiceApiVersions.v2024_08_01_Preview)
@doc("""
  Represents the integrated vectorizer defined within the search resource.
  """)
model OnYourDataIntegratedVectorizationSource
  extends OnYourDataVectorizationSource {
  /** The type discriminator. ALways 'integrated'. */
  type: OnYourDataVectorizationSourceType.integrated;
}

/** The authentication types supported with Azure OpenAI On Your Data vector search. */
@added(ServiceApiVersions.v2024_05_01_Preview)
union OnYourDataVectorSearchAuthenticationType {
  string,

  /** Authentication via API key. */
  apiKey: "api_key",

  /** Authentication via access token. */
  accessToken: "access_token",
}

/**
 * The authentication options for Azure OpenAI On Your Data vector search.
 */
@discriminator("type")
@added(ServiceApiVersions.v2024_05_01_Preview)
model OnYourDataVectorSearchAuthenticationOptions {
  /** The type of authentication to use. */
  type: OnYourDataVectorSearchAuthenticationType;
}

/**
 * The authentication options for Azure OpenAI On Your Data when using an API key.
 */
@added(ServiceApiVersions.v2024_05_01_Preview)
model OnYourDataVectorSearchApiKeyAuthenticationOptions
  extends OnYourDataVectorSearchAuthenticationOptions {
  /** The authentication type of API key. */
  type: OnYourDataVectorSearchAuthenticationType.apiKey;

  /** The API key to use for authentication. */
  key: string;
}

/**
 * The authentication options for Azure OpenAI On Your Data vector search when using access token.
 */
@added(ServiceApiVersions.v2024_05_01_Preview)
model OnYourDataVectorSearchAccessTokenAuthenticationOptions
  extends OnYourDataVectorSearchAuthenticationOptions {
  /** The authentication type of access token. */
  type: OnYourDataVectorSearchAuthenticationType.accessToken;

  /** The access token to use for authentication. */
  @encodedName("application/json", "access_token")
  accessToken: string;
}
