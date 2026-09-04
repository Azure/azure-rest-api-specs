import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The resource has the fixed literal name passwordMethod, which is more restrictive than a pattern."
@added(Versions.v2026_10_01)
@doc("The service-created PostgreSQL username-and-password authentication method for a HorizonDB cluster. This resource configures the authentication mechanism, including its enabled state and administrator login credentials; it is not a password-only resource.")
@parentResource(Cluster)
model PasswordAuthentication
  is Azure.ResourceManager.ProxyResource<PasswordAuthenticationProperties> {
  @doc("The fixed name of the PostgreSQL username-and-password authentication method.")
  @key("authenticationName")
  @path
  @segment("authentications")
  name: "passwordMethod";
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The resource has the fixed literal name microsoftEntra, which is more restrictive than a pattern."
@added(Versions.v2026_10_01)
@doc("The service-created Microsoft Entra authentication method for a HorizonDB cluster.")
@parentResource(Cluster)
model MicrosoftEntraAuthentication
  is Azure.ResourceManager.ProxyResource<MicrosoftEntraAuthenticationProperties> {
  @doc("The fixed name of the Microsoft Entra authentication method.")
  @key("authenticationName")
  @path
  @segment("authentications")
  name: "microsoftEntra";
}

@added(Versions.v2026_10_01)
@doc("A service-created authentication configuration returned by the authentications collection. The resource name is passwordMethod or microsoftEntra.")
model Authentication {
  @doc("The Azure resource ID of the service-created authentication configuration.")
  @visibility(Lifecycle.Read)
  id: armResourceIdentifier;

  @doc("The fixed name of the service-created authentication configuration.")
  @visibility(Lifecycle.Read)
  name: AuthenticationName;

  @doc("The Azure resource type.")
  @visibility(Lifecycle.Read)
  type: "Microsoft.HorizonDb/clusters/authentications";

  @doc("The authentication configuration properties.")
  @visibility(Lifecycle.Read)
  properties: AuthenticationProperties;
}

@added(Versions.v2026_10_01)
@doc("The name of a service-created authentication configuration.")
union AuthenticationName {
  string,

  @doc("PostgreSQL username-and-password authentication.")
  PasswordMethod: "passwordMethod",

  @doc("Microsoft Entra authentication.")
  MicrosoftEntra: "microsoftEntra",
}

@added(Versions.v2026_10_01)
@doc("Common read-only properties of a service-created authentication configuration.")
model AuthenticationProperties {
  @doc("The state of the authentication configuration.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the authentication configuration.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of the service-created PostgreSQL username-and-password authentication method. The control plane stores no administrator identity; PostgreSQL is the source of truth for the sole member of the service-owned administrator role.")
model PasswordAuthenticationProperties {
  @doc("The state of PostgreSQL username-and-password authentication.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the PostgreSQL username-and-password authentication method.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties of the service-created Microsoft Entra authentication method.")
model MicrosoftEntraAuthenticationProperties {
  @doc("The state of Microsoft Entra authentication.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the Microsoft Entra authentication method.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating PostgreSQL username-and-password authentication. Omitted properties preserve their current values. State-only requests enable or disable the authentication mechanism. Credentials are secrets and are never returned or stored by the control plane. Login-only, password-only, and combined credential updates require this authentication method to already be Enabled unless the request also sets state to Enabled.")
model PasswordAuthenticationPropertiesForPatchUpdate {
  @doc("The target password-authentication state. Enabled or Disabled can be supplied without credentials to toggle the feature. Disabled cannot be combined with administratorLogin or administratorLoginPassword. Disabling password authentication does not remove or modify existing database users or roles.")
  @visibility(Lifecycle.Update)
  state?: AuthenticationState;

  @doc("The PostgreSQL administrator role name. A login-only update requires password authentication to already be Enabled unless state is set to Enabled in this request, and requires exactly one member in the AzureSU-owned special group. The current name is an idempotent no-op; a different name renames the current member only when that target role does not already exist. When supplied together with administratorLoginPassword, this value can create the administrator if the special group has no member, reset the matching member's password, or rename a differently named member and reset its password.")
  @secret
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Update)
  administratorLogin?: string;

  @doc("The PostgreSQL administrator password. A password-only update requires password authentication to already be Enabled unless state is set to Enabled in this request, and requires exactly one member in the AzureSU-owned special group. When supplied together with administratorLogin, it can create the administrator if the special group has no member, reset the matching member's password, or rename a differently named member and reset its password.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;
}

@added(Versions.v2026_10_01)
@doc("Properties for updating Microsoft Entra authentication. State Enabled enables the feature and State Disabled disables it. Disabling Microsoft Entra authentication does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions.")
model MicrosoftEntraAuthenticationPropertiesForPatchUpdate {
  @doc("The target Microsoft Entra authentication state. Omission preserves the current state.")
  @visibility(Lifecycle.Update)
  state?: AuthenticationState;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for PostgreSQL username-and-password authentication.")
model PasswordAuthenticationForPatchUpdate {
  @doc("The PostgreSQL username-and-password authentication properties to update.")
  properties?: PasswordAuthenticationPropertiesForPatchUpdate;
}

@added(Versions.v2026_10_01)
@doc("A sparse update request for Microsoft Entra authentication.")
model MicrosoftEntraAuthenticationForPatchUpdate {
  @doc("The Microsoft Entra authentication properties to update.")
  properties?: MicrosoftEntraAuthenticationPropertiesForPatchUpdate;
}

@added(Versions.v2026_05_01_preview)
@doc("Indicates if authentication state is enabled or not.")
union AuthenticationState {
  string,

  @doc("Is enabled")
  Enabled: "Enabled",

  @doc("Is disabled")
  Disabled: "Disabled",
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
@added(Versions.v2026_10_01)
@doc("Operations for the service-created PostgreSQL username-and-password authentication method of a HorizonDB cluster.")
@armResourceOperations
interface PasswordAuthentications {
  @doc("Gets the service-created PostgreSQL username-and-password authentication method.")
  get is ArmResourceRead<PasswordAuthentication>;

  @doc("Updates the service-created PostgreSQL username-and-password authentication method. The request is sparse and omitted properties preserve their current values. A state-only request enables or disables the authentication mechanism; disabling cannot include credentials and does not remove or modify existing database users or roles. Login-only, password-only, and combined credential updates require this method to already be Enabled unless this request also sets state to Enabled. PostgreSQL is the sole source of truth; the control plane stores no administrator identity or credentials. The service bootstraps an AzureSU-owned special group, only AzureSU can grant or revoke its membership, and at most one user role can be a member. Login-only or password-only updates require exactly one current member. A combined administratorLogin and administratorLoginPassword request creates and adds a new user when no member exists, resets the password when the member name matches, or renames the member and resets its password when names differ. A requested name that already exists outside the special group is rejected to prevent privilege elevation. Both authentication methods may be Disabled.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PasswordAuthentication,
    PatchModel = PasswordAuthenticationForPatchUpdate
  >;

  @doc("Lists the two service-created authentication configurations for the cluster: passwordMethod and microsoftEntra.")
  list is ArmResourceListByParent<
    PasswordAuthentication,
    Response = ArmResponse<Azure.ResourceManager.ResourceListCustomResult<Authentication>>
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-list-operation" "The shared authentications collection list operation is defined by PasswordAuthentications.list and returns both constrained resource instances."
@added(Versions.v2026_10_01)
@doc("Operations for the service-created Microsoft Entra authentication method of a HorizonDB cluster.")
@armResourceOperations
interface MicrosoftEntraAuthentications {
  @doc("Gets the service-created Microsoft Entra authentication method.")
  get is ArmResourceRead<MicrosoftEntraAuthentication>;

  @doc("Updates the service-created Microsoft Entra authentication method. State Enabled enables the feature and State Disabled disables it; no additional properties are required. Disabling the feature does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions. The method may be Disabled even when password authentication is also Disabled.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    MicrosoftEntraAuthentication,
    PatchModel = MicrosoftEntraAuthenticationForPatchUpdate
  >;
}
