import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HorizonDb;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "The resource has the fixed literal name passwordMethod, which is more restrictive than a pattern."
@doc("The service-created PostgreSQL username-and-password authentication method for a HorizonDB cluster. This resource configures the authentication mechanism, including its enabled state and administrator login credentials; it is not a password-only resource.")
@singleton("passwordMethod")
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
@doc("The service-created Microsoft Entra authentication method for a HorizonDB cluster.")
@singleton("microsoftEntra")
@parentResource(Cluster)
model MicrosoftEntraAuthentication
  is Azure.ResourceManager.ProxyResource<MicrosoftEntraAuthenticationProperties> {
  @doc("The fixed name of the Microsoft Entra authentication method.")
  @key("authenticationName")
  @path
  @segment("authentications")
  name: "microsoftEntra";
}

@doc("A service-created authentication configuration returned by the authentications collection. The resource name is passwordMethod or microsoftEntra.")
@parentResource(Cluster)
model Authentication
  is Azure.ResourceManager.ProxyResource<AuthenticationProperties> {
  ...ResourceNameParameter<
    Resource = Authentication,
    KeyName = "authenticationName",
    SegmentName = "authentications",
    Type = AuthenticationName
  >;
}

@doc("The name of a service-created authentication configuration.")
union AuthenticationName {
  string,

  @doc("PostgreSQL username-and-password authentication.")
  PasswordMethod: "passwordMethod",

  @doc("Microsoft Entra authentication.")
  MicrosoftEntra: "microsoftEntra",
}

@doc("Common read-only properties of a service-created authentication configuration.")
model AuthenticationProperties {
  @doc("The state of the authentication configuration.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the authentication configuration.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of the service-created PostgreSQL username-and-password authentication method.")
model PasswordAuthenticationProperties {
  @doc("The state of PostgreSQL username-and-password authentication.")
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  state: AuthenticationState;

  @doc("The PostgreSQL administrator login name. After it is set, renaming is not supported. Setting the login requires password authentication state to be Enabled in the same request.")
  @minLength(1)
  @maxLength(63)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  administratorLogin?: string;

  @doc("The PostgreSQL administrator password. Setting the password requires password authentication state to be Enabled in the same request.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Create, Lifecycle.Update)
  administratorLoginPassword?: string;

  @doc("The provisioning state of the PostgreSQL username-and-password authentication method.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties of the service-created Microsoft Entra authentication method.")
model MicrosoftEntraAuthenticationProperties {
  @doc("The state of Microsoft Entra authentication.")
  @visibility(Lifecycle.Read)
  state: AuthenticationState;

  @doc("The provisioning state of the Microsoft Entra authentication method.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Properties for updating PostgreSQL username-and-password authentication. Omitted properties preserve their current values. This API version supports enabling or disabling the authentication method, and resetting its password. Supported changes can be combined.")
model PasswordAuthenticationPropertiesForPatchUpdate {
  @doc("The target password-authentication state. Enabled can be combined with administratorLoginPassword to re-enable password authentication and reset the password for a cluster that already has an administrator. Disabling password authentication does not remove or modify existing database users or roles. Disabled cannot be combined with administratorLoginPassword.")
  @visibility(Lifecycle.Update)
  state?: AuthenticationState;

  @doc("The PostgreSQL administrator password. Supplying this property resets the configured administrator's password. When password authentication is currently disabled for a cluster that already has an administrator, this property can be combined with state Enabled to re-enable password authentication and reset the password.")
  @secret
  @minLength(8)
  @maxLength(128)
  @visibility(Lifecycle.Update)
  administratorLoginPassword?: string;
}

@doc("Properties for updating Microsoft Entra authentication. State Enabled enables the feature and State Disabled disables it. Disabling Microsoft Entra authentication does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions.")
model MicrosoftEntraAuthenticationPropertiesForPatchUpdate {
  @doc("The target Microsoft Entra authentication state. Omission preserves the current state.")
  @visibility(Lifecycle.Update)
  state?: AuthenticationState;
}

@doc("A sparse update request for PostgreSQL username-and-password authentication.")
model PasswordAuthenticationForPatchUpdate {
  @doc("The PostgreSQL username-and-password authentication properties to update.")
  properties?: PasswordAuthenticationPropertiesForPatchUpdate;
}

@doc("A sparse update request for Microsoft Entra authentication.")
model MicrosoftEntraAuthenticationForPatchUpdate {
  @doc("The Microsoft Entra authentication properties to update.")
  properties?: MicrosoftEntraAuthenticationPropertiesForPatchUpdate;
}

@doc("Indicates if authentication state is enabled or not.")
union AuthenticationState {
  string,

  @doc("Is enabled")
  Enabled: "Enabled",

  @doc("Is disabled")
  Disabled: "Disabled",
}

@doc("Operations for the service-created authentication methods of a HorizonDB cluster.")
@armResourceOperations
interface Authentications {
  @doc("Lists the two service-created authentication configurations for the cluster: passwordMethod and microsoftEntra.")
  list is ArmResourceListByParent<Authentication>;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
@doc("Operations for the service-created PostgreSQL username-and-password authentication method of a HorizonDB cluster.")
@armResourceOperations
interface PasswordAuthentications {
  @doc("Gets the service-created PostgreSQL username-and-password authentication method.")
  @autoRoute
  @get
  get is ArmResourceRead<PasswordAuthentication>;

  @doc("Creates or replaces the service-created PostgreSQL username-and-password authentication method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrReplace is ArmResourceCreateOrReplaceAsync<
    PasswordAuthentication,
    LroHeaders = HorizonDbResourceLroHeaders<PasswordAuthentication>,
    Response =
      | HorizonDbResourceUpdatedLroResponse<PasswordAuthentication>
      | ArmResourceCreatedResponse<
          PasswordAuthentication,
          HorizonDbResourceLroHeaders<PasswordAuthentication>
        >
  >;

  @doc("Updates the service-created PostgreSQL username-and-password authentication method. The request is sparse and omitted properties preserve their current values. This API version supports enabling the method, disabling the method, and resetting its password. For a cluster that already has an administrator but currently has password authentication disabled, state Enabled and administratorLoginPassword can be supplied together to re-enable password authentication and reset the password. Disabling cannot include credentials and does not remove or modify existing database users or roles. Administrator rename is not supported in this API version.")
  @autoRoute
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is ArmCustomPatchAsync<
    PasswordAuthentication,
    PasswordAuthenticationForPatchUpdate,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = PasswordAuthentication> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Authentication method instances are service-created with the cluster and cannot be deleted independently."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-put-operation" "Authentication method instances are service-created with the cluster; customers update an existing instance through PATCH and cannot create additional instances."
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-list-operation" "The shared authentications collection list operation is defined by Authentications.list and returns both constrained resource instances."
@doc("Operations for the service-created Microsoft Entra authentication method of a HorizonDB cluster.")
@armResourceOperations
interface MicrosoftEntraAuthentications {
  @doc("Gets the service-created Microsoft Entra authentication method.")
  @autoRoute
  @get
  @armResourceRead(Authentication)
  get is Azure.ResourceManager.Foundations.ArmReadOperation<
    ResourceInstanceParameters<MicrosoftEntraAuthentication>,
    ArmResponse<Authentication>,
    ErrorResponse
  >;

  @doc("Updates the service-created Microsoft Entra authentication method. State Enabled enables the feature and State Disabled disables it; no additional properties are required. Disabling the feature does not remove or modify database roles or users previously created through the MicrosoftEntraAdministrators control-plane API or directly through pgaadauth extension functions.")
  @autoRoute
  @armResourceUpdate(Authentication)
  @patch(#{ implicitOptionality: false })
  @Azure.Core.useFinalStateVia("azure-async-operation")
  update is Azure.ResourceManager.Foundations.ArmUpdateOperation<
    ResourceInstanceParameters<MicrosoftEntraAuthentication>,
    MicrosoftEntraAuthenticationForPatchUpdate,
    Response =
      | ArmResponse<Authentication>
      | ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = Authentication> &
          Azure.Core.Foundations.RetryAfterHeader>,
    ErrorResponse = ErrorResponse
  >;
}
