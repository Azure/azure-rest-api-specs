import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Discovery.Management.Shared/all.tsp";
import "../Discovery.Shared/shared.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using Microsoft.Discovery.Shared;

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Supercomputer tracked resource")
model Supercomputer is TrackedResource<SupercomputerProperties> {
  ...ResourceNameParameter<Supercomputer>;

  /** Updatable managed service identity */
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@doc("Supercomputer properties")
model SupercomputerProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  // read
  @doc("The ID of the workspace.")
  @visibility(Lifecycle.Read)
  workspaceId?: WorkspaceId;

  /**
    System Subnet ID associated with managed NodePool for system resources.
    It should have connectivity to the child NodePool subnets.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: Microsoft.Discovery.Shared.SubnetId;

  ...MoboConfigurationWithMrg;
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
