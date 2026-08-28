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
using Azure.ClientGenerator.Core;

namespace Microsoft.Network;

/**
 * Authentication policy resource for identity integration.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Required for includeInapplicableMetadataInPayload which suppresses systemData in the response payload, consistent with other Network RP resources"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Extending the local Network RP Resource is the established pattern for tracked resources in this RP"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP resource definitions"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "AuthenticationPolicy uses the local Network RP Resource base type consistent with other Network RP tracked resources (e.g. IpGroup)"
@added(Versions.v2026_01_01)
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
  @pattern("^[A-Za-z0-9_-]{1,80}$")
  @maxLength(80)
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "etag is an established read-only envelope property across Network RP resources"
  @visibility(Lifecycle.Read)
  etag?: string;

  /** The user-assigned identity used by a user sign-in policy to access its Key Vault client secret. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "AuthenticationPolicy uses the established Network RP identity envelope property pattern."
  identity?: Common.ManagedServiceIdentity;
}

/**
 * Properties of the authentication policy.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP property models"
@added(Versions.v2026_01_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
model AuthenticationPolicyPropertiesFormat {
  /** The type of the user trust provider. Only Microsoft Entra is supported, using the serialized value `entra`. */
  userTrustProviderType: UserTrustProviderType;

  /** The action to take when a request is unauthenticated. When omitted, user sign-in policies default to `authenticate` and JWT validation policies default to `deny`. */
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
 * Properties for authentication provider configuration. A policy must configure either JWT validation fields or user sign-in fields; the two configurations are mutually exclusive and cannot be combined.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP property models"
@added(Versions.v2026_01_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
model AuthenticationProviderProperties {
  /** The URL of the Secure Token Service. Include a trailing slash at the end of the value. Example: https://login.microsoftonline.com/{Microsoft Entra Tenant ID}/ */
  @maxLength(2048)
  issuer: string;

  /** The JSON Web Key Set (JWKS) URI used to retrieve the public keys for JWT validation. Example: https://login.microsoftonline.com/{Microsoft Entra Tenant ID}/discovery/v2.0/keys */
  @maxLength(2048)
  @pattern("^[Hh][Tt][Tt][Pp][Ss]://")
  jwksUri?: url;

  /** The intended audience for the JWT. Only a single audience value is supported in this API version. Example: https://audience.com/{application-id} */
  @maxLength(2048)
  audience?: string;

  /** The Application (client) ID for the related application registered in Microsoft Entra ID, formatted as a GUID. */
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  clientId: string;

  /** The absolute HTTPS Key Vault secret URL containing the client secret for authentication. This property is required for user sign-in policies. The secret value retrieved from Key Vault can contain up to 4096 characters. Example: https://myvault.vault.azure.net/secrets/mysecret */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "This property holds a Key Vault secret URL reference (not the secret value itself), so it is not sensitive data."
  @pattern("^[Hh][Tt][Tt][Pp][Ss]://")
  clientSecret?: url;

  /** The scopes used by an application during authentication to authorize access to a user's details. A maximum of 10 scopes is supported, each scope can contain up to 128 characters, and all scopes can contain up to 256 characters combined. */
  @maxItems(10)
  scope?: AuthenticationScope[];

  /** The timeout of the session cookie used for user authentication, in seconds. The supported range is 1 to 604800 seconds, and the default is 86400 seconds. Applicable to the Application Gateway post-OIDC workflow. */
  sessionTimeout?: string;

  /** The name of the session cookie used for user authentication. Applicable to the Application Gateway post-OIDC workflow. */
  @maxLength(256)
  @pattern("^[A-Za-z0-9_-]+$")
  sessionCookieName?: string;
}

/** An authentication scope value. */
@maxLength(128)
@minLength(1)
@pattern("^[A-Za-z0-9_.:/-]+$")
scalar AuthenticationScope extends string;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP enums"
@doc("Type of the user trust provider.")
@added(Versions.v2026_01_01)
@Azure.ResourceManager.Legacy.feature(Features.authenticationPolicy)
union UserTrustProviderType {
  string,

  /** Microsoft Entra trust provider type. */
  Entra: "entra",
}

/**
 * Action to take when a request is unauthenticated.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy feature decorator required for Network RP feature gating, consistent with other Network RP enums"
@added(Versions.v2026_01_01)
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
@added(Versions.v2026_01_01)
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    AuthenticationPolicy,
    Error = CloudError
  >;

  /**
   * Updates an authentication policy's tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "AuthenticationPolicy supports a tags-only PATCH through the generic Network RP controller."
  @tag("AuthenticationPolicies")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    AuthenticationPolicy,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified authentication policy.
   */
  @tag("AuthenticationPolicies")
  delete is ArmResourceDeleteSync<
    AuthenticationPolicy,
    Response = ArmDeletedNoContentResponse,
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
@@doc(
  AuthenticationPolicies.updateTags::parameters.properties,
  "Parameters supplied to update authentication policy tags."
);
@@clientName(
  AuthenticationPolicies.updateTags::parameters.properties,
  "parameters"
);
