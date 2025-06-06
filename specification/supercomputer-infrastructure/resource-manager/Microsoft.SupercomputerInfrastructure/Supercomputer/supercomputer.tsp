import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

@doc("A supercomputer composed of multiple backing resources.")
model Supercomputer is TrackedResource<SupercomputerProperties> {
  ...ResourceNameParameter<Supercomputer>;
}

@doc("The properties of a supercomputer resource.")
model SupercomputerProperties {
  @doc("The identifier of the physical site where the supercomputer hardware is located.")
  @visibility(Lifecycle.Read)
  siteId: string;

  @doc("The status of the last operation on this resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("The resource provisioning state.")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("The resource operation has been accepted.")
  Accepted: "Accepted",

  @doc("The resource is currently being provisioned.")
  Provisioning: "Provisioning",

  @doc("The resource is currently being validated.")
  Validating: "Validating",

  @doc("The resource is currently being updated.")
  Updating: "Updating",

  @doc("The resource is currently being deleted.")
  Deleting: "Deleting",

  string,
}

@armResourceOperations
interface Supercomputers {
  get is ArmResourceRead<Supercomputer>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Supercomputer>;
  update is ArmResourcePatchAsync<Supercomputer, SupercomputerProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<Supercomputer>;
  listByResourceGroup is ArmResourceListByParent<Supercomputer>;
  listBySubscription is ArmListBySubscription<Supercomputer>;
}
