import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service({
  title: "Microsoft.NexusIdentity management service",
  version: "2023-06-15",
})
/** Microsoft.NexusIdentity Resource Provider management API. */
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.NexusIdentity;

/** The available API versions. */
enum Versions {
  /** 2021-10-01-preview version */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  v2021_10_01_preview: "2021-10-01-preview",
}

interface Operations extends Azure.ResourceManager.Operations {}

@lroStatus
@doc("The provisioning state of Identity Set resource.")
enum ProvisioningState {
  ...ResourceProvisioningState,
  @doc("The operation is accepted and in progress.")
  Updating,
  @doc("The resource is being deleted.")
  Deleting,
  @doc("The operation is accepted.")
  Accepted,
}

@doc("Identity Set Properties defines the properties of the Idenity Set.")
model IdentitySetResourceProperties {
  @doc("Tenant id in which scope is created.")
  tenant: string;
  @doc("List of scopes to be watched")
  scopes: Array<ScopeProperties>;
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Tracked Scope Properties defines the properties needed to ")
model ScopeProperties {
  @doc("Scope on which roles are to be watched.")
  scope: string;
  @doc("Roles to be watched.")
  roles: Array<NexusIdentityRoles>;
}

@doc("Role defined for Nexus Identity Service")
enum NexusIdentityRoles {
  @doc("Full access to all NNF resources and read-write access to network devices")
  NexusFabricServiceAdministrator,
  @doc("No access to ARM resources. Full RW access to network devices")
  NexusFabricDeviceAdministrator,
  @doc("Read-only access to all NNF resources and network devices (RW)​")
  NexusFabricServiceReader,
  @doc("No access to ARM resources. Read-only access to network devices​")
  NexusFabricDeviceReader
}

@doc("Identity Set resource definition")
model IdentitySetResource is TrackedResource<IdentitySetResourceProperties> {
  @key
  @segment("identitySets")
  @doc("The name of the Identity Set resource.")
  @path
  name: string;
}

@armResourceOperations
interface IdentitySet {
  get is ArmResourceRead<IdentitySetResource>;
  create is ArmResourceCreateOrUpdateAsync<IdentitySetResource>;
  update is ArmResourcePatchAsync<IdentitySetResource, IdentitySetResourceProperties>;
  delete is ArmResourceDeleteAsync<IdentitySetResource>;
  listByResourceGroup is ArmResourceListByParent<IdentitySetResource>;
  listBySubscription is ArmListBySubscription<IdentitySetResource>;
}