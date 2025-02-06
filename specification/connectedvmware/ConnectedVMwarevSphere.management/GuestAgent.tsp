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
@parentResource(VirtualMachineInstance)
@singleton("default")
model GuestAgent is ProxyResource<GuestAgentProperties> {
  @key("default")
  @segment("guestAgents")
  name: string;
}

@armResourceOperations
interface GuestAgents {
  @doc("Implements GuestAgent GET method.")
  get is ArmResourceRead<GuestAgent>;
  @doc("Create Or Update GuestAgent.")
  create is ArmResourceCreateOrUpdateAsync<GuestAgent>;
  @doc("Implements GuestAgent DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<GuestAgent>;
  @doc("Returns the list of GuestAgent of the given vm.")
  listByVirtualMachineInstance is ArmResourceListByParent<GuestAgent>;
}
