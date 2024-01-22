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

namespace Microsoft.ConnectedVMwarevSphere;
/**
 * Defines the HybridIdentityMetadata.
 */
@singleton("default")
@parentResource(VirtualMachineInstance)
model VmInstanceHybridIdentityMetadata
  is ProxyResource<VmInstanceHybridIdentityMetadataProperties> {
  @key("hybridIdentityMetadatum")
  @segment("hybridIdentityMetadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "VmInstanceHybridIdentityMetadata")
interface VmInstanceHybridIdentityMetadataOperationGroup {
  /**
   * Implements HybridIdentityMetadata GET method.
   */
  get is ArmResourceRead<VmInstanceHybridIdentityMetadata>;

  /**
   * Returns the list of HybridIdentityMetadata of the given vm.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VmInstanceHybridIdentityMetadata_List")
  list is ArmResourceListByParent<VmInstanceHybridIdentityMetadata>;
}
