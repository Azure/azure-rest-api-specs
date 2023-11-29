import "@typespec/versioning";
import "./authentication.tsp";

namespace Azure.OpenAI;

using TypeSpec.Versioning;

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("Embedding dependency types for vector search.")
enum OnYourDataEmbeddingDependencyType {
  @doc("Azure OpenAI Embedding endpoint URL.")
  endpoint: "Endpoint",

  @doc("Azure OpenAI Embedding deployment name.")
  deploymentName: "DeploymentName",

  @doc("The embedding model ID defined in the search service. Currently only supported by Elasticsearch.")
  modelId: "ModelId",
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@discriminator("type")
@doc("Embedding dependency for vector search.")
model OnYourDataEmbeddingDependency {
  @doc("Embedding dependency types for vector search.")
  type: OnYourDataEmbeddingDependencyType;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("The embedding dependency based on endpoint URL")
model OnYourDataEmbeddingEndpointDependency
  extends OnYourDataEmbeddingDependency {
  @doc("The embedding dependency based on endpoint URL")
  type: OnYourDataEmbeddingDependencyType.endpoint;

  @doc("Specifies the resource endpoint URL from which embeddings should be retrieved. It should be in the format of https://YOUR_RESOURCE_NAME.openai.azure.com/openai/deployments/YOUR_DEPLOYMENT_NAME/embeddings. The api-version query parameter is not allowed.")
  endpoint: url;

  @doc("Specifies the authentication options to use when retrieving embeddings from the specified endpoint.")
  authentication: OnYourDataAuthenticationOptions;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("The embedding dependency based on deployment name")
model OnYourDataEmbeddingDeploymentNameDependency
  extends OnYourDataEmbeddingDependency {
  @doc("The embedding dependency based on deployment name")
  type: OnYourDataEmbeddingDependencyType.deploymentName;

  @doc("The embedding model deployment name within the same Azure OpenAI resource. This enables you to use vector search without Azure OpenAI api-key and without Azure OpenAI public network access.")
  deploymentName: string;
}

@added(ServiceApiVersions.v2023_12_01_Preview)
@doc("The embedding dependency based on model id")
model OnYourDataEmbeddingModelIdDependency
  extends OnYourDataEmbeddingDependency {
  @doc("The embedding dependency based on model id")
  type: OnYourDataEmbeddingDependencyType.modelId;

  @doc("The embedding model ID build inside the search service. Currently only supported by Elasticsearch.")
  modelId: string;
}
