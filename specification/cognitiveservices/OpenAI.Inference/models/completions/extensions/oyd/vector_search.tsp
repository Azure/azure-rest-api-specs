import "@typespec/versioning";
import "./authentication.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
Represents the available sources Azure OpenAI On Your Data can use to configure vectorization of data for use with
vector search.
""")
enum OnYourDataVectorizationSourceType {
  @doc("""
  Represents vectorization performed by public service calls to an Azure OpenAI embedding model.
  """)
  endpoint: "Endpoint",

  @doc("""
  Represents an Ada model deployment name to use. This model deployment must be in the same Azure OpenAI resource, but
  On Your Data will use this model deployment via an internal call rather than a public one, which enables vector
  search even in private networks.
  """)
  deploymentName: "DeploymentName",

  @doc("""
  Represents a specific embedding model ID as defined in the search service.
  Currently only supported by Elasticsearch®.
  """)
  modelId: "ModelId",
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@discriminator("type")
@doc("An abstract representation of a vectorization source for Azure OpenAI On Your Data with vector search.")
model OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use.")
  type: OnYourDataVectorizationSourceType;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
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

  @doc("Specifies the authentication options to use when retrieving embeddings from the specified endpoint.")
  authentication: OnYourDataAuthenticationOptions;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
The details of a a vectorization source, used by Azure OpenAI On Your Data when applying vector search, that is based
on an internal embeddings model deployment name in the same Azure OpenAI resource.
""")
model OnYourDataDeploymentNameVectorizationSource
  extends OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use. Always 'DeploymentName' for this type.")
  type: OnYourDataVectorizationSourceType.deploymentName;

  @doc("The embedding model deployment name within the same Azure OpenAI resource. This enables you to use vector search without Azure OpenAI api-key and without Azure OpenAI public network access.")
  deploymentName: string;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("""
The details of a a vectorization source, used by Azure OpenAI On Your Data when applying vector search, that is based
on a search service model ID. Currently only supported by Elasticsearch®.
""")
model OnYourDataModelIdVectorizationSource
  extends OnYourDataVectorizationSource {
  @doc("The type of vectorization source to use. Always 'ModelId' for this type.")
  type: OnYourDataVectorizationSourceType.modelId;

  @doc("The embedding model ID build inside the search service. Currently only supported by Elasticsearch®.")
  modelId: string;
}
