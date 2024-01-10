import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ConnectedVMwarevSphere;
@doc("Defines the GuestAgent.")
@singleton("default")
@parentResource(VirtualMachineInstance)
model GuestAgent is ProxyResource<GuestAgentProperties> {
  @key("guestAgent")
  @segment("guestAgents")
  name: string;
}

@armResourceOperations
@projectedName("client", "VMInstanceGuestAgents")
interface GuestAgents_VMInstanceGuestAgents {
  @doc("Implements GuestAgent GET method.")
  get is ArmResourceRead<GuestAgent>;

  @doc("Create Or Update GuestAgent.")
  create is ArmResourceCreateOrUpdateAsync<GuestAgent>;

  @doc("Implements GuestAgent DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;

  @doc("Returns the list of GuestAgent of the given vm.")
  list is ArmResourceListByParent<GuestAgent>;
}
