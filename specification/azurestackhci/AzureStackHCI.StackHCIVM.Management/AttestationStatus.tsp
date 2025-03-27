import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
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
@doc("The attestation status of the virtual machine")
@singleton("default")
@parentResource(VirtualMachineInstance)
@includeInapplicableMetadataInPayload(false)
model AttestationStatus is ProxyResource<AttestationStatusProperties> {
  @doc("Name of attestation status")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @key("attestationStatus")
  @segment("attestationStatus")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@armResourceOperations
interface AttestationStatuses {
  @doc("Implements AttestationStatus GET method.")
  get is ArmResourceRead<AttestationStatus>;
}
