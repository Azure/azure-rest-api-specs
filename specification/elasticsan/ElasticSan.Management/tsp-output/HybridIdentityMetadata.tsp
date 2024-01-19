import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedClusters.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
@doc("Defines the hybridIdentityMetadata.")
@singleton("default")
@parentResource(ProvisionedClusters)
model HybridIdentityMetadata
  is ProxyResource<HybridIdentityMetadataProperties> {
  @key("hybridIdentityMetadatum")
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
  delete is ArmResourceDeleteWithoutOkAsync<
    HybridIdentityMetadata,
    BaseParameters<HybridIdentityMetadata>,
    ArmAsyncOperationHeader
  >;

  @doc("Lists the hybrid identity metadata proxy resource in a provisioned cluster instance.")
  listByCluster is ArmResourceListByParent<HybridIdentityMetadata>;
}

@@projectedName(HybridIdentityMetadataOperationGroup.put::parameters.resource,
  "json",
  "body"
);
@@extension(HybridIdentityMetadataOperationGroup.put::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(HybridIdentityMetadataOperationGroup.put::parameters.resource, "");
