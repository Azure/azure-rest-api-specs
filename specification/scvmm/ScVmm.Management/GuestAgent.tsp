import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./VirtualMachineInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ScVmm;
/** Defines the GuestAgent. */
@parentResource(VirtualMachineInstance)
@singleton
model GuestAgent is ProxyResource<GuestAgentProperties> {
  /** Name of the guest agent. */
  @key("guestAgentName")
  @segment("guestAgents")
  @visibility(Lifecycle.Read)
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  name: string;
}

@armResourceOperations
interface GuestAgents {
  /** Implements GuestAgent GET method. */
  @summary("Gets GuestAgent.")
  get is ArmResourceRead<GuestAgent>;
  /** Create Or Update GuestAgent. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @summary("Implements GuestAgent PUT method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    GuestAgent,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Implements GuestAgent DELETE method. */
  @summary("Deletes a GuestAgent resource.")
  delete is ArmResourceDeleteSync<GuestAgent>;
  /** Returns the list of GuestAgent of the given vm. */
  @summary("Implements GET GuestAgent in a vm.")
  listByVirtualMachineInstance is ArmResourceListByParent<GuestAgent>;
}
