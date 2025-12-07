/**
 * Authentication config used if 'path != /' or certain authentication is required.
 */
@doc("Authentication settings for secure access to storage.")
model AuthConfig {
  @doc("Auth method to use.")
  authType: AuthType; // this is required
}

/**
 * AuthType enumerates possible authentication methods.
 */
@doc("Possible authentication methods.")
union AuthType {
  @doc("Workload Identity for authentication.")
  WORKLOAD_IDENTITY: "WORKLOAD_IDENTITY",

  @doc("Managed Identity for authentication.")
  MANAGED_IDENTITY: "MANAGED_IDENTITY",

  string,
}

/**
 * UID/GID ownership for the subvolume.
 */
@doc("Unix-like ownership of the subvolume via UID/GID.")
model AuthSysConfig {
  @doc("User ID owning the subvolume (default 4294967294).")
  @minValue(1) // Minimum value constraint
  @maxValue(4294967294) // Maximum value constraint
  uid: int64; // Required

  @doc("Group ID owning the subvolume (default 4294967294).")
  @minValue(1) // Minimum value constraint
  @maxValue(4294967294) // Maximum value constraint
  gid: int64; // Required
}
