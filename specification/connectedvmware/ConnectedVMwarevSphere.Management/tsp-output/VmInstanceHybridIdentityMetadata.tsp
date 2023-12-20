import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VMwareVmInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ConnectedVMwarevSphere;
@doc("Defines the HybridIdentityMetadata.")
@parentResource(VMwareVmInstance)
@singleton("default")
model VmInstanceHybridIdentityMetadata
  is ProxyResource<VmInstanceHybridIdentityMetadataProperties> {
  @key("default")
  @segment("hybridIdentityMetadata")
  name: string;
}

@armResourceOperations
interface VmInstanceHybridIdentityMetadata {
  @doc("Implements HybridIdentityMetadata GET method.")
  get is ArmResourceRead<VmInstanceHybridIdentityMetadata>;
  @doc("Returns the list of HybridIdentityMetadata of the given vm.")
  listByVMwareVmInstance is ArmResourceListByParent<VmInstanceHybridIdentityMetadata>;
}
