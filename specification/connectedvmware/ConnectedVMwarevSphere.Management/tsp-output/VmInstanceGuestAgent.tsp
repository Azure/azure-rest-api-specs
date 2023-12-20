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
@doc("Defines the GuestAgent.")
@parentResource(VMwareVmInstance)
@singleton("default")
model VmInstanceGuestAgent is ProxyResource<GuestAgentProperties> {
  @key("default")
  @segment("guestAgents")
  name: string;
}

@armResourceOperations
interface VmInstanceGuestAgents {
  @doc("Implements GuestAgent GET method.")
  get is ArmResourceRead<VmInstanceGuestAgent>;
  @doc("Create Or Update GuestAgent.")
  create is ArmResourceCreateOrUpdateAsync<VmInstanceGuestAgent>;
  @doc("Implements GuestAgent DELETE method.")
  delete is ArmResourceDeleteWithoutOkAsync<VmInstanceGuestAgent>;
  @doc("Returns the list of GuestAgent of the given vm.")
  listByVMwareVmInstance is ArmResourceListByParent<VmInstanceGuestAgent>;
}
