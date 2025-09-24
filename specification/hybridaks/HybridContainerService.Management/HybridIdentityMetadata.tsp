import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * Defines the hybridIdentityMetadata.
 */
@singleton("default")
@parentResource(ProvisionedCluster)
model HybridIdentityMetadata
  is ProxyResource<HybridIdentityMetadataProperties> {
  ...ResourceNameParameter<
    HybridIdentityMetadata,
    "hybridIdentityMetadatum",
    "hybridIdentityMetadata"
  >;
}

@armResourceOperations
interface HybridIdentityMetadataOperationGroup {
  /**
   * Get the hybrid identity metadata proxy resource.
   */
  get is ArmResourceRead<
    HybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Creates the hybrid identity metadata proxy resource that facilitates the managed identity provisioning.
   */
  create is ArmResourceCreateOrReplaceSync<
    HybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Deletes the hybrid identity metadata proxy resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    HybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Lists the hybrid identity metadata proxy resource in a provisioned cluster instance.
   */
  listByCluster is ArmResourceListByParent<
    HybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;
}

@@doc(HybridIdentityMetadataOperationGroup.create::parameters.resource,
  "Hybrid Identity Metadata resource definition"
);
