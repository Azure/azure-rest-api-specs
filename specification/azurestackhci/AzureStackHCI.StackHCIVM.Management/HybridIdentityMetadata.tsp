import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AzureStackHCI;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" "x-ms-azure-resource legacy"
@doc("Defines the HybridIdentityMetadata.")
@extension("x-ms-azure-resource", true)
@singleton("default")
@parentResource(VirtualMachineInstance)
model HybridIdentityMetadata
  is ProxyResource<HybridIdentityMetadataProperties> {
  @doc("Name of the hybrididentitymetadata")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @key("hybridIdentityMetadatum")
  @segment("hybridIdentityMetadata")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
@Azure.ClientGenerator.Core.clientName("HybridIdentityMetadata")
interface HybridIdentityMetadataGroup {
  @doc("Implements HybridIdentityMetadata GET method.")
  get is ArmResourceRead<HybridIdentityMetadata>;

  @doc("Returns the list of HybridIdentityMetadata of the given vm.")
  listByVirtualMachineInstance is ArmResourceListByParent<HybridIdentityMetadata>;
}
