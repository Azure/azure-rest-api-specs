import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedClustersResponse.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.HybridContainerService;
@doc("Defines the hybridIdentityMetadata.")
@parentResource(ProvisionedClustersResponse)
model HybridIdentityMetadata
  is ProxyResource<HybridIdentityMetadataProperties> {
  @doc("Parameter for the name of the hybrid identity metadata resource.")
  @maxLength(64)
  @minLength(3)
  @key("hybridIdentityMetadataResourceName")
  @segment("hybridIdentityMetadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "HybridIdentityMetadata")
interface HybridIdentityMetadataOperationGroup {
  @doc("Get the hybrid identity metadata proxy resource.")
  get is ArmResourceRead<HybridIdentityMetadata>;

  @doc("Creates the hybrid identity metadata proxy resource that facilitates the managed identity provisioning.")
  put is ArmResourceCreateOrReplaceSync<HybridIdentityMetadata>;

  @doc("Deletes the hybrid identity metadata proxy resource.")
  delete is ArmResourceDeleteSync<HybridIdentityMetadata>;

  @doc("Lists the hybrid identity metadata proxy resource in a cluster.")
  listByCluster is ArmResourceListByParent<HybridIdentityMetadata>;
}
