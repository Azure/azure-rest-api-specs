using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DocumentDB;

/** Represents a Mongo cluster user. */
@parentResource(MongoCluster)
model User is ProxyResource<UserProperties> {
  /** The name of the mongo cluster user. */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\-]*")
  @key("userName")
  @segment("users")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@added(Versions.v2025_04_01_preview)
model UserProperties {
  /** The provisioning state of the user. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  identityProvider: IdentityProviderProperties,

  roles: RoleProperties[];
}

@added(Versions.v2025_04_01_preview)
model RoleProperties {
  db: string;

  role: UserRole;
}

@added(Versions.v2025_04_01_preview)
model IdentityProviderProperties {
  type: IdentityProviderType;

  properties: EntraProviderProperties;
}

@added(Versions.v2025_04_01_preview)
union IdentityProviderType {
  string,

  "MicrosoftEntraID",
}

@added(Versions.v2025_04_01_preview)
model EntraProviderProperties {
  principalType: EntraPrincipalType;
}

@added(Versions.v2025_04_01_preview)
union EntraPrincipalType {
  string,

  "User",

  "ServicePrincipal",
}

@added(Versions.v2025_04_01_preview)
union UserRole {
  string
}