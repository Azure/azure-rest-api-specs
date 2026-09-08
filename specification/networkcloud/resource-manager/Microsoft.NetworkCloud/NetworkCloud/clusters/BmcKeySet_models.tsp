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
union BmcKeySetDetailedStatus {
  string,

  /**
   * The AllActive status.
   */
  AllActive: "AllActive",

  /**
   * The SomeInvalid status.
   */
  SomeInvalid: "SomeInvalid",

  /**
   * The AllInvalid status.
   */
  AllInvalid: "AllInvalid",

  /**
   * The Validating status.
   */
  Validating: "Validating",
}

/**
 * The access level allowed for the users in this key set.
 */
union BmcKeySetPrivilegeLevel {
  string,

  /**
   * ReadOnly privilege level
   */
  ReadOnly: "ReadOnly",

  /**
   * Administrator privilege level
   */
  Administrator: "Administrator",
}

/**
 * The provisioning state of the baseboard management controller key set.
 */
union BmcKeySetProvisioningState {
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
 * BmcKeySetList represents a list of baseboard management controller key sets.
 */
model BmcKeySetList is Azure.Core.Page<BmcKeySet>;

/**
 * BmcKeySetProperties represents the properties of baseboard management controller key set.
 */
model BmcKeySetProperties {
  ...BmcKeySetSpec;
  ...BmcKeySetStatus;

  /**
   * The provisioning state of the baseboard management controller key set.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BmcKeySetProvisioningState;
}

/**
 * BmcKeySetSpec represents the properties that are used as an input to the operator.
 */
model BmcKeySetSpec {
  /**
   * The object ID of Azure Active Directory group that all users in the list must be in for access to be granted. Users that are not in the group will not have access.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  azureGroupId: string;

  /**
   * The date and time after which the users in this key set will be removed from the baseboard management controllers.
   */
  expiration: utcDateTime;

  /**
   * The access level allowed for the users in this key set.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  privilegeLevel: BmcKeySetPrivilegeLevel;

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList: KeySetUser[];
}

/**
 * BmcKeySetStatus represents the properties produced by the API implementing logic in the operator.
 */
model BmcKeySetStatus {
  /**
   * The more detailed status of the key set.
   */
  @visibility(Lifecycle.Read)
  detailedStatus?: BmcKeySetDetailedStatus;

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
 * BmcKeySetPatchParameters represents the body of the request to patch the baseboard management controller key set.
 */
model BmcKeySetPatchParameters {
  /**
   * The list of the resource properties.
   */
  properties?: BmcKeySetPatchProperties;

  /**
   * The Azure resource tags that will replace the existing ones.
   */
  ...Foundations.ArmTagsProperty;
}

/**
 * BmcKeySetPatchProperties represents the properties of baseboard management controller key set that are patchable.
 */
model BmcKeySetPatchProperties {
  /**
   * The date and time after which the users in this key set will be removed from the baseboard management controllers.
   */
  expiration?: utcDateTime;

  /**
   * The unique list of permitted users.
   */
  @identifiers(#["azureUserName"])
  userList?: KeySetUser[];
}
