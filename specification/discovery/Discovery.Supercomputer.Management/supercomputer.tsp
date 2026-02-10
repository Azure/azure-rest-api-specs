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

@armProviderNamespace
@versioned(Microsoft.Discovery.Versions)
namespace Microsoft.Discovery;

@doc("Supercomputer tracked resource")
model Supercomputer is TrackedResource<SupercomputerProperties> {
  ...ResourceNameParameter<Supercomputer>;
}

@added(Versions.v2025_12_01_preview)
@doc("Supported System SKU Sizes.")
union SystemSku {
  @doc("Standard_D4s_v6 SKU")
  Standard_D4s_v6: "Standard_D4s_v6 basic compute VM (default)",

  @doc("Standard_D4s_v5 SKU")
  Standard_D4s_v5: "Standard_D4s_v5",

  @doc("Standard_D4s_v4 SKU")
  Standard_D4s_v4: "Standard_D4s_v4",

  string,
}

@doc("Supercomputer properties")
model SupercomputerProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
    System Subnet ID associated with managed NodePool for system resources.
    It should have connectivity to the child NodePool subnets.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  subnetId: Microsoft.Discovery.Shared.SubnetId;

  @doc("The SKU to use for the system nodepool.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_12_01_preview)
  systemSku?: SystemSku;

  /**
    Dictionary of identity properties for the Supercomputer.
   */
  @doc("Dictionary of identity properties.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  identities: SupercomputerIdentities;

  ...MoboConfigurationWithMrg;
}

/**
    Model representing the dictionary of identity properties.
   */
@doc("Dictionary of identity properties for the Supercomputer.")
model SupercomputerIdentities {
  /**
      Cluster identity ID used by the supercomputer.
      This identity is used by the supercomputer at cluster level to access Azure resources.
      This identity must have NetworkContributor role on the system subnet.
    */
  @doc("Cluster identity ID.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  clusterIdentity: Microsoft.Discovery.Identity;

  /**
      Kubelet identity ID used by the supercomputer.
      This identity is used by the supercomputer at node level to access Azure resources.
      This identity must have ManagedIdentityOperator role on the clusterIdentity.
    */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kubeletIdentity: Microsoft.Discovery.Identity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  @doc("User assigned identity IDs to be used by workloads as federated credentials running on supercomputer.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  workloadIdentities?: Record<Azure.ResourceManager.CommonTypes.UserAssignedIdentity | null>;
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
