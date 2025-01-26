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
@doc("Defines the GuestAgent.")
@singleton("default")
@parentResource(VirtualMachineInstance)
model GuestAgent is ProxyResource<GuestAgentProperties> {
  @doc("guestAgent name")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-._a-zA-Z0-9]{0,62}[a-zA-Z0-9]$")
  @key("guestAgent")
  @segment("guestAgents")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
interface GuestAgents {
  @doc("Implements GuestAgent GET method.")
  get is ArmResourceRead<GuestAgent>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("Create Or Update GuestAgent.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    GuestAgent,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Implements GuestAgent DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;

  @doc("Returns the list of GuestAgent of the given vm.")
  listByVirtualMachineInstance is ArmResourceListByParent<GuestAgent>;
}
