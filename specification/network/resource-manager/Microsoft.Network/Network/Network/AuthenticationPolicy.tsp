import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;

namespace Microsoft.Network;

/**
 * Authentication policy resource for identity integration.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for includeInapplicableMetadataInPayload which suppresses systemData in the response payload, consistent with other Network RP resources"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the local Network RP Resource is the established pattern for tracked resources in this RP"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP resource definitions"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "AuthenticationPolicy uses the local Network RP Resource base type consistent with other Network RP tracked resources (e.g. IpGroup)"
@added(Versions.v2025_09_01)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
model AuthenticationPolicy extends Common.Resource {
  /** Properties of the authentication policy. */
  properties?: AuthenticationPolicyPropertiesFormat;

  /** The name of the authentication policy. */
  @visibility(Lifecycle.Read)
  @path
  @key("authenticationPolicyName")
  @segment("authenticationPolicies")
  @maxLength(80)
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is an established read-only envelope property across Network RP resources"
  @visibility(Lifecycle.Read)
  etag?: string;
}

/**
 * Properties of the authentication policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP property models"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
model AuthenticationPolicyPropertiesFormat {
  /** The type of the user trust provider. */
  userTrustProviderType?: UserTrustProviderType;

  /** The action to take when a request is unauthenticated. */
  onUnauthenticatedRequest?: OnUnauthenticatedRequest;

  /** The authentication provider configuration for the policy. */
  authenticationProperties: AuthenticationProviderProperties;

  /** A collection of resource IDs that reference this authentication policy. */
  @visibility(Lifecycle.Read)
  associatedResources?: string[];

  /** The provisioning state of the authentication policy resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** The resource GUID property of the authentication policy resource. */
  @visibility(Lifecycle.Read)
  resourceGuid?: string;
}

/**
 * Properties for authentication provider configuration.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP property models"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
model AuthenticationProviderProperties {
  /** The URL of the Secure Token Service. Include a trailing slash at the end of the value. Example: https://login.microsoftonline.com/{Microsoft Entra Tenant ID}/ */
  issuer: string;

  /** The OIDC Authorization Endpoint. Example: https://login.microsoftonline.com/{Microsoft Entra Tenant ID}/oauth2/v2.0/authorize */
  authEndpoint?: string;

  /** The OIDC Token Endpoint. Example: https://login.microsoftonline.com/{Microsoft Entra Tenant ID}/oauth2/v2.0/token */
  tokenEndpoint?: string;

  /** The OIDC User Info Endpoint. Example: https://graph.microsoft.com/oidc/userinfo */
  userInfoEndpoint?: string;

  /** The JSON Web Key Set (JWKS) URI used to retrieve the public keys for JWT validation. Example: https://login.microsoftonline.com/{Microsoft Entra Tenant ID}/discovery/v2.0/keys */
  jwksUri?: string;

  /** The intended audience for the JWT. Only a single audience value is supported in this API version. Example: https://audience.com/{application-id} */
  audience?: string;

  /** The Application (client) ID for the related application registered in Microsoft Entra ID. */
  clientId: string;

  /** The Key Vault secret URL containing the client secret for authentication. Example: https://myvault.vault.azure.net/secrets/mysecret */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "This property holds a Key Vault secret URL reference (not the secret value itself), so it is not sensitive data."
  clientSecret?: string;

  /** The scopes used by an application during authentication to authorize access to a user's details. */
  scope?: string[];

  /** The timeout of the session cookie used for user authentication, in seconds. Applicable to the Application Gateway post-OIDC workflow. */
  sessionTimeout?: string;

  /** The name of the session cookie used for user authentication. Applicable to the Application Gateway post-OIDC workflow. */
  sessionCookieName?: string;
}

/**
 * Type of the user trust provider.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP enums"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
union UserTrustProviderType {
  string,

  /** OpenID Connect (OIDC) trust provider type. */
  Oidc: "oidc",

  /** Microsoft Entra trust provider type. */
  Entra: "entra",
}

/**
 * Action to take when a request is unauthenticated.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP enums"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
union OnUnauthenticatedRequest {
  string,

  /** Allow the request to pass through without authentication. */
  Allow: "allow",

  /** Redirect the request to the authentication provider. Only valid for the user authentication capability. */
  Authenticate: "authenticate",

  /** Deny the request when no credential is presented. */
  Deny: "deny",
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP operation interfaces"
@added(Versions.v2025_09_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
@armResourceOperations(#{ omitTags: true })
interface AuthenticationPolicies {
  /**
   * Retrieve the authentication policy with specified name within a resource group.
   */
  @tag("AuthenticationPolicies")
  get is ArmResourceRead<AuthenticationPolicy, Error = CloudError>;

  /**
   * Creates or updates an authentication policy with the specified name within a resource group.
   */
  @tag("AuthenticationPolicies")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    AuthenticationPolicy,
    Error = CloudError
  >;

  /**
   * Deletes the specified authentication policy.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Network RP delete operations use the 200+202+204 pattern, matching existing Network RP resource delete conventions"
  @tag("AuthenticationPolicies")
  delete is ArmResourceDeleteWithoutOkAsync<
    AuthenticationPolicy,
    Response =
      | ArmDeletedResponse
      | ArmDeleteAcceptedLroResponse
      | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all of the authentication policies within a resource group.
   */
  @tag("AuthenticationPolicies")
  list is ArmResourceListByParent<AuthenticationPolicy, Error = CloudError>;

  /**
   * Gets all the authentication policies in a subscription.
   */
  @tag("AuthenticationPolicies")
  listAll is ArmListBySubscription<AuthenticationPolicy, Error = CloudError>;
}

@@doc(AuthenticationPolicy.name, "The name of the authentication policy.");
@@doc(
  AuthenticationPolicy.properties,
  "Properties of the authentication policy."
);
@@doc(
  AuthenticationPolicies.createOrUpdate::parameters.resource,
  "Authentication policy to be created or updated."
);
