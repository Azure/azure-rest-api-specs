import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.SupercomputerInfrastructure;

/** A supercomputer composed of topological entities. */
model Supercomputer is TrackedResource<SupercomputerProperties> {
  ...ResourceNameParameter<Supercomputer>;
}

/** The properties of a supercomputer. */
model SupercomputerProperties {
  /** The identifier of the physical site where the supercomputer hardware is located. */
  @visibility(Lifecycle.Read)
  siteId?: string;

  /** The SKU of the supercomputer. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tier: SupercomputerTier;

  /** The status of the last operation on the supercomputer. */
  @visibility(Lifecycle.Read)
  provisioningState?: SupercomputerProvisioningState;
}

/** The available tiers of supercomputers. */
union SupercomputerTier {
  /** A supercomputer in a Fairwater site. */
  Fairwater: "Fairwater",

  /** A Nebius MIV50 Canary supercomputer. */
  Offnet_Nebius_MIV50_Canary: "Offnet_Nebius_MIV50_Canary",

  /** A Nebius MIV50 GB200 supercomputer. */
  Offnet_Nebius_MIV50_GB200: "Offnet_Nebius_MIV50_GB200",

  /** A Nebius MIV50 GB300 supercomputer. */
  Offnet_Nebius_MIV50_GB300: "Offnet_Nebius_MIV50_GB300",

  string,
}

/** The resource provisioning state. */
@lroStatus
union SupercomputerProvisioningState {
  ResourceProvisioningState,

  /** The resource operation has been accepted. */
  Accepted: "Accepted",

  /** The resource is currently being provisioned. */
  Provisioning: "Provisioning",

  /** The resource is currently being validated. */
  Validating: "Validating",

  /** The resource is currently being updated. */
  Updating: "Updating",

  /** The resource is currently being deleted. */
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
