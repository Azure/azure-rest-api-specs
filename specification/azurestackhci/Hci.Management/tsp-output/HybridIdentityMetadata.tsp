import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;
/**
 * Defines the HybridIdentityMetadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(VirtualMachineInstance)
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
   * Implements HybridIdentityMetadata GET method.
   */
  get is ArmResourceRead<HybridIdentityMetadata>;

  /**
   * Returns the list of HybridIdentityMetadata of the given vm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("HybridIdentityMetadata_List")
  list is ArmResourceListByParent<HybridIdentityMetadata>;
}
