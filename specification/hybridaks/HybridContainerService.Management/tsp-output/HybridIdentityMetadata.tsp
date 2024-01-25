import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProvisionedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridContainerService;
/**
 * Defines the hybridIdentityMetadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(ProvisionedCluster)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  HybridIdentityMetadataProperties
)
model HybridIdentityMetadata extends ProxyResourceBase {
  @key("hybridIdentityMetadatum")
  @segment("hybridIdentityMetadata")
  @visibility("read")
  name: string;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: HybridIdentityMetadataProperties;
}

@armResourceOperations
@projectedName("client", "HybridIdentityMetadata")
interface HybridIdentityMetadataOperationGroup {
  /**
   * Get the hybrid identity metadata proxy resource.
   */
  get is ArmResourceRead<HybridIdentityMetadata>;

  /**
   * Creates the hybrid identity metadata proxy resource that facilitates the managed identity provisioning.
   */
  put is ArmResourceCreateOrReplaceSync<HybridIdentityMetadata>;

  /**
   * Deletes the hybrid identity metadata proxy resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    HybridIdentityMetadata,
    BaseParameters<HybridIdentityMetadata>,
    ArmAsyncOperationHeader
  >;

  /**
   * Lists the hybrid identity metadata proxy resource in a provisioned cluster instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridIdentityMetadata_ListByCluster")
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
@@doc(HybridIdentityMetadataOperationGroup.put::parameters.resource,
  "Hybrid Identity Metadata resource definition"
);
