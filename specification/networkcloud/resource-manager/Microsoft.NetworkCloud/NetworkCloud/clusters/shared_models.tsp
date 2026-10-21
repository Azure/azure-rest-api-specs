namespace Microsoft.NetworkCloud;

/**
 * The indicator of whether the user is currently deployed for access.
 */
union BareMetalMachineKeySetUserSetupStatus {
  string,

  /**
   * The user is currently active.
   */
  Active: "Active",

  /**
   * The user is not valid and has no access.
   */
  Invalid: "Invalid",
}

/**
 * KeySetUser represents the properties of the user in the key set.
 */
model KeySetUser {
  /**
   * The user name that will be used for access.
   */
  azureUserName: string;

  /**
   * The free-form description for this user.
   */
  @maxLength(256)
  description?: string;

  /**
   * The SSH public key that will be provisioned for user access. The user is expected to have the corresponding SSH private key for logging in.
   */
  sshPublicKey: SshPublicKey;

  /**
   * The user principal name (email format) used to validate this user's group membership.
   */
  userPrincipalName?: string;
}

/**
 * KeySetUserStatus represents the status of the key set user.
 */
model KeySetUserStatus {
  /**
   * The user name that will be used for access.
   */
  @visibility(Lifecycle.Read)
  azureUserName?: string;

  /**
   * The indicator of whether the user is currently deployed for access.
   */
  @visibility(Lifecycle.Read)
  status?: BareMetalMachineKeySetUserSetupStatus;

  /**
   * The additional information describing the current status of this user, if any available.
   */
  @visibility(Lifecycle.Read)
  @maxLength(256)
  statusMessage?: string;
}
