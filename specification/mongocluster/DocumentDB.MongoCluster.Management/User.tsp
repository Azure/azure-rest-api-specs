using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.DocumentDB;

/** Represents a Mongo cluster user. */
@parentResource(MongoCluster)
@added(Versions.v2025_04_01_preview)
model User is ProxyResource<UserProperties> {
  /** The name of the mongo cluster user. */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9\\-]*")
  @key("userName")
  @segment("users")
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

@armResourceOperations
@added(Versions.v2025_04_01_preview)
interface Users {
  /** Gets the defintion of a Mongo cluster user. */
  get is ArmResourceRead<User>;
  /** Creates a new user or updates an existing user on a mongo cluster. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    User,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Deletes a mongo cluster user. */
  delete is ArmResourceDeleteWithoutOkAsync<User>;
  /** List all the users on a mongo cluster. */
  listByMongoCluster is ArmResourceListByParent<User>;
}

/** Definition of Mongo user resource on a cluster. */
@added(Versions.v2025_04_01_preview)
model UserProperties {
  /** The provisioning state of the user. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  ...IdentityUserProperties;
}

/** Identity provider Mongo user properties. */
@added(Versions.v2025_04_01_preview)
model IdentityUserProperties {
  /** The user's identity provider definition. */
  identityProvider?: IdentityProvider;

  /** Database roles that are assigned to the user. */
  @identifiers(#[])
  roles?: DatabaseRole[];
}

/** Database role definition that is assigned to a user. */
@added(Versions.v2025_04_01_preview)
model DatabaseRole {
  /** Database scope that the role is assigned to. */
  db: string;

  /** The role that is assigned to the user on the database scope. */
  role: UserRole;
}

/** Defines a user's identity provider definition. */
@added(Versions.v2025_04_01_preview)
@discriminator("type")
model IdentityProvider {
  /** The type of identity provider that the user belongs to. */
  type: IdentityProviderType;
}

/** Identity provider types that a a user identity can belong to. */
@added(Versions.v2025_04_01_preview)
union IdentityProviderType {
  string,

  /** Microsoft Entra ID provider. */
  MicrosoftEntraID: "MicrosoftEntraID",
}

/** Defines a Microsot Entra ID Mongo user. */
@added(Versions.v2025_04_01_preview)
model EntraIdentityProvider extends IdentityProvider {
  /** The type of identity provider that the user belongs to. */
  type: IdentityProviderType.MicrosoftEntraID;

  /** The Entra identity properties for the user. */
  properties: EntraIdentityProviderProperties;
}

/** Microsoft Entra ID provider properties. */
@added(Versions.v2025_04_01_preview)
model EntraIdentityProviderProperties {
  /** The principal type of the user. */
  principalType: EntraPrincipalType;
}

/** Microsoft Entra ID principal types available for a Mongo user. */
@added(Versions.v2025_04_01_preview)
union EntraPrincipalType {
  string,

  /** Entra user type. */
  User: "User",

  /** Entra service principal type. */
  ServiePrincipal: "ServicePrincipal",
}

/** Built-in database role that can be assigned to a user. */
@added(Versions.v2025_04_01_preview)
union UserRole {
  string,

  /** Datbase owner role permissions on the target scope. */
  DatabaseOwner: "dbOwner",
}
