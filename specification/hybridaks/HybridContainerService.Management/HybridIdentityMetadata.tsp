import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.HybridContainerService;
/**
 * Defines the hybridIdentityMetadata.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Initial suppression to prevent breaking change"
#suppress "@azure-tools/typespec-azure-resource-manager/resource-name" "Initial suppression to prevent breaking change"
@singleton("default")
@parentResource(provisionedCluster)
model hybridIdentityMetadata
  is Azure.ResourceManager.ProxyResource<
    HybridIdentityMetadataProperties
  > {
  ...ResourceNameParameter<
    Resource = hybridIdentityMetadata,
    KeyName = "hybridIdentityMetadatum",
    SegmentName = "hybridIdentityMetadata"
  >;
}

@armResourceOperations
interface HybridIdentityMetadataOperationGroup {
  /**
   * Get the hybrid identity metadata proxy resource.
   */
  get is ArmResourceRead<
    hybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Creates the hybrid identity metadata proxy resource that facilitates the managed identity provisioning.
   */
  put is ArmResourceCreateOrReplaceSync<
    hybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters
  >;

  /**
   * Deletes the hybrid identity metadata proxy resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "for backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    hybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters,
    LroHeaders = ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Lists the hybrid identity metadata proxy resource in a provisioned cluster instance.
   */
  listByCluster is ArmResourceListByParent<
    hybridIdentityMetadata,
    BaseParameters = ConnectedClusterResourceUriParameters,
    Response = ArmResponse<hybridIdentityMetadataList>
  >;
}

@@doc(hybridIdentityMetadata.name, "");
@@doc(hybridIdentityMetadata.properties, "Resource properties.");
@@doc(HybridIdentityMetadataOperationGroup.put::parameters.resource,
  "Hybrid Identity Metadata resource definition"
);
