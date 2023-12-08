import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Hci;
@doc("Defines the HybridIdentityMetadata.")
@parentResource(VirtualMachineInstance)
@singleton("default")
model HybridIdentityMetadata
  is ProxyResource<HybridIdentityMetadataProperties> {
  @key("default")
  @segment("hybridIdentityMetadata")
  name: string;
}

@armResourceOperations
interface HybridIdentityMetadata {
  @doc("Implements HybridIdentityMetadata GET method.")
  get is ArmResourceRead<HybridIdentityMetadata>;
  @doc("Returns the list of HybridIdentityMetadata of the given vm.")
  listByVirtualMachineInstance is ArmResourceListByParent<HybridIdentityMetadata>;
}
