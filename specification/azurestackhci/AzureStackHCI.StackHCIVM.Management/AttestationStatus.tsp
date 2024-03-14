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
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("The attestation status of the virtual machine")
@singleton("default")
@parentResource(VirtualMachineInstance)
@includeInapplicableMetadataInPayload(false)
model AttestationStatus is ProxyResource<AttestationStatusProperties> {
  @doc("Name of attestation status")
  @key("attestationStatus")
  @segment("attestationStatus")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
interface AttestationStatuses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Implements AttestationStatus GET method.")
  @operationId("AttestationStatus_Get")
  get is ArmResourceRead<AttestationStatus>;
}
