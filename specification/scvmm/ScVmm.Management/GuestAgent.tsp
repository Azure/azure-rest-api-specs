import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** Defines the GuestAgent. */
@parentResource(VirtualMachineInstance)
@singleton
model GuestAgent is ProxyResource<GuestAgentProperties> {
  /** Name of the guest agent. */
  @key("guestAgentName")
  @segment("guestAgents")
  @visibility("read")
  @path
  name: string;
}

@armResourceOperations
interface GuestAgents {
  /** Implements GuestAgent GET method. */
  get is ArmResourceRead<GuestAgent>;
  /** Create Or Update GuestAgent. */
  create is ArmResourceCreateOrUpdateAsync<GuestAgent>;
  /** Implements GuestAgent DELETE method. */
  delete is ArmResourceDeleteSync<GuestAgent>;
  /** Returns the list of GuestAgent of the given vm. */
  listByVirtualMachineInstance is ArmResourceListByParent<GuestAgent>;
}
