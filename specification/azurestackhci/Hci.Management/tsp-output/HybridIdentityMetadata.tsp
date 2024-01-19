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
@doc("Defines the HybridIdentityMetadata.")
@singleton("default")
@parentResource(VirtualMachineInstance)
model HybridIdentityMetadata
  is ProxyResource<HybridIdentityMetadataProperties> {
  @key("hybridIdentityMetadatum")
  @segment("hybridIdentityMetadata")
  name: string;
}

@armResourceOperations
@projectedName("client", "HybridIdentityMetadata")
interface HybridIdentityMetadataOperationGroup {
  @doc("Implements HybridIdentityMetadata GET method.")
  get is ArmResourceRead<HybridIdentityMetadata>;

  @doc("Returns the list of HybridIdentityMetadata of the given vm.")
  list is ArmResourceListByParent<HybridIdentityMetadata>;
}
