import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./shared_models.tsp";

using Azure.ResourceManager;

namespace Microsoft.NetworkCloud;

/**
 * The more detailed status of the key set.
 */
union BareMetalMachineKeySetDetailedStatus {
  string,

  /**
   * All users in the key set are active.
   */
  AllActive: "AllActive",

  /**
   * Some users in the key set are invalid.
   */
  SomeInvalid: "SomeInvalid",

  /**
   * All users in the key set are invalid.
   */
  AllInvalid: "AllInvalid",

  /**
   * Key set is being validated.
   */
  Validating: "Validating",
}

/**
 * The access level allowed for the users in this key set.
 */
union BareMetalMachineKeySetPrivilegeLevel {
  string,

  /**
   * Standard access level.
   */
  Standard: "Standard",

  /**
   * Superuser access level.
   */
  Superuser: "Superuser",

  /**
   * Other access level.
   */
  Other: "Other",
}

/**
 * The provisioning state of the bare metal machine key set.
 */
union BareMetalMachineKeySetProvisioningState {
  string,

  /**
   * The Succeeded status.
   */
  Succeeded: "Succeeded",

  /**
   * The Failed status.
   */
  Failed: "Failed",

  /**
   * The Canceled status.
   */
  Canceled: "Canceled",

  /**
   * The Accepted status.
   */
  Accepted: "Accepted",

  /**
   * The Provisioning status.
   */
  Provisioning: "Provisioning",
}

/**
 * BareMetalMachineKeySetList represents a list of bare metal machine key sets.
 */
model BareMetalMachineKeySetList is Azure.Core.Page<BareMetalMachineKeySet>;

/**
 * BareMetalMachineKeySetProperties represents the properties of bare metal machine key set.
 */
model BareMetalMachineKeySetProperties {
  ...BareMetalMachineKeySetSpec;
  ...BareMetalMachineKeySetStatus;

  /**
   * The provisioning state of the bare metal machine key set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BareMetalMachineKeySetProvisioningState;
}

/**
 * BareMetalMachineKeySetPropertiesSpec represents the properties that are used as an input to the operator.
 */
model BareMetalMachineKeySetSpec {
  /**
   * The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureGroupId: string;

  /**
   * The date and time after which the users in this key set will be removed from the bare metal machines.
   */
  expiration: utcDateTime;

  /**
   * The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.
   */
  jumpHostsAllowed: string[];

  /**
   * The name of the group that users will be assigned to on the operating system of the machines.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @maxLength(32)
  @pattern("^([A-Za-z]([A-Za-z0-9]*))$")
  osGroupName?: string;

  /**
   * The access level allowed for the users in this key set.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privilegeLevel: BareMetalMachineKeySetPrivilegeLevel;

  /**
   * The name of the access level to apply when the privilege level is set to Other.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privilegeLevelName?: string;

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList: KeySetUser[];
}

/**
 * BareMetalMachineKeySetStatus represents the properties produced by the API implementing logic in the operator.
 */
model BareMetalMachineKeySetStatus {
  /**
   * The more detailed status of the key set.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: BareMetalMachineKeySetDetailedStatus;

  /**
   * The descriptive message about the current detailed status.
   */
  @visibility(Lifecycle.Read)
  detailedStatusMessage?: string;

  /**
   * The last time this key set was validated.
   */
  @visibility(Lifecycle.Read)
  lastValidation?: utcDateTime;

  /**
   * The status evaluation of each user.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["azureUserName"])
  userListStatus?: KeySetUserStatus[];
}

/**
 * BareMetalMachineKeySetPatchParameters represents the body of the request to patch the bare metal machine key set.
 */
model BareMetalMachineKeySetPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: BareMetalMachineKeySetPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * BareMetalMachineKeySetPatchProperties represents the properties of bare metal machine key set that can be patched.
 */
model BareMetalMachineKeySetPatchProperties {
  /**
   * The date and time after which the users in this key set will be removed from the bare metal machines.
   */
  expiration?: utcDateTime;

  /**
   * The list of IP addresses of jump hosts with management network access from which a login will be allowed for the users.
   */
  jumpHostsAllowed?: string[];

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList?: KeySetUser[];
}
