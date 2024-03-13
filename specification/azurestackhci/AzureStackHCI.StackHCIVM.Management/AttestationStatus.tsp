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
@doc("The attestation status of the virtual machine")
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("default")
@parentResource(VirtualMachineInstance)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AttestationStatusProperties)
model AttestationStatus extends ProxyResourceBase {
  @doc("Name of attestation status")
  @key("attestationStatus")
  @segment("attestationStatus")
  @visibility("read")
  name: string;

  @doc("Attestation status properties.")
  @extension("x-ms-client-flatten", true)
  properties: AttestationStatusProperties;
}

@armResourceOperations
interface AttestationStatuses {
  @doc("Implements AttestationStatus GET method.")
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AttestationStatus_Get")
  get is ArmResourceRead<AttestationStatus>;
}
