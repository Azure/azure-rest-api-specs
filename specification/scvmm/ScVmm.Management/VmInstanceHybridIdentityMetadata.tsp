import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** Defines the HybridIdentityMetadata. */
@parentResource(VirtualMachineInstance)
@singleton
model VmInstanceHybridIdentityMetadata
  is ProxyResource<VmInstanceHybridIdentityMetadataProperties> {
  // TODO/NOTE: key name is used as a workaround for name collision with singleton
  /** Name of the VM Instance Hybrid Identity Metadata */
  @key("vmInstanceHybridIdentityMetadataName")
  @segment("hybridIdentityMetadata")
  @path
  @visibility("read")
  name: string;
}

@armResourceOperations
interface VmInstanceHybridIdentityMetadatas {
  /** Implements HybridIdentityMetadata GET method. */
  get is ArmResourceRead<VmInstanceHybridIdentityMetadata>;
  /** Returns the list of HybridIdentityMetadata of the given VM. */
  listByVirtualMachineInstance is ArmResourceListByParent<VmInstanceHybridIdentityMetadata>;
}
