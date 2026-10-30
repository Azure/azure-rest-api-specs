import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "./BuilderApp.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.Web;

/** Singleton application authentication configuration. DELETE resets it instead of removing the singleton. */
@added(Versions.v2026_09_01_preview)
@parentResource(BuilderApp)
@singleton("current")
model BuilderAppAuthConfig is ProxyResource<BuilderAppAuthConfigProperties> {
  ...ResourceNameParameter<
    Resource = BuilderAppAuthConfig,
    KeyName = "authConfigName",
    SegmentName = "authConfigs"
  >;
  ...PickProperties<CommonTypes.AzureEntityResource, "etag">;
}

/** Application authentication policy and credential-safe readiness information. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "This synchronous policy singleton exposes revision and propagationPending rather than a provisioning state; no asynchronous resource creation is performed."
@added(Versions.v2026_09_01_preview)
model BuilderAppAuthConfigProperties {
  /** Authentication mode. Omission defaults to disabled. */
  mode?: BuilderAppAuthMode;

  /** GitHub OAuth configuration. */
  github?: BuilderAppGitHubAuth;

  /** Microsoft Entra ID configuration. */
  entraId?: BuilderAppEntraAuth;

  /** Browser redirect provider when multiple providers are enabled. Defaults to github. */
  primaryBrowserProvider?: BuilderAppAuthProvider;

  /** GitHub callback URL. */
  @visibility(Lifecycle.Read)
  githubCallbackUrl?: url;

  /** Microsoft Entra ID callback URL. */
  @visibility(Lifecycle.Read)
  entraCallbackUrl?: url;

  /** Committed identity selection and external registration setup information, not proof of successful sign-in. */
  @visibility(Lifecycle.Read)
  entraSetup?: BuilderAppEntraSetup;

  /** Desired authentication configuration revision. */
  @visibility(Lifecycle.Read)
  revision?: int64;

  /** Revision currently applied by the runtime. */
  @visibility(Lifecycle.Read)
  appliedRevision?: int64;

  /** Configuration warnings. */
  @visibility(Lifecycle.Read)
  warnings?: string[];

  /** Whether the desired configuration is still propagating. */
  @visibility(Lifecycle.Read)
  propagationPending?: boolean;
}

/** Authentication enforcement modes. */
@added(Versions.v2026_09_01_preview)
union BuilderAppAuthMode {
  /** Authentication disabled; provider settings retained. */
  Disabled: "disabled",

  /** Anonymous requests permitted. */
  Optional: "optional",

  /** Authentication required. */
  Required: "required",

  string,
}

/** Browser authentication providers. */
@added(Versions.v2026_09_01_preview)
union BuilderAppAuthProvider {
  /** GitHub OAuth. */
  GitHub: "github",

  /** Microsoft Entra ID. */
  EntraId: "entraId",

  string,
}

/** Ownership of the OAuth application. */
@added(Versions.v2026_09_01_preview)
union BuilderAppAuthApplicationMode {
  /** Platform-managed application. */
  Managed: "managed",

  /** Customer-owned application. */
  Customer: "customer",

  string,
}

/** GitHub OAuth provider settings. */
@added(Versions.v2026_09_01_preview)
model BuilderAppGitHubAuth {
  /** Whether this provider is enabled. */
  enabled?: boolean;

  /** OAuth application ownership. Defaults to managed. */
  applicationMode?: BuilderAppAuthApplicationMode;

  /** Allowed email addresses. */
  emails?: string[];

  /** Allowed email suffixes. */
  emailSuffixes?: string[];

  /** Allowed GitHub usernames. */
  usernames?: string[];

  /** Allowed GitHub username suffixes. */
  usernameSuffixes?: string[];

  /** Allowed GitHub numeric user IDs. */
  userIds?: int64[];

  /** Customer-owned GitHub application configuration. */
  customerApplication?: BuilderAppGitHubCustomerApplication;
}

/** Customer GitHub application input and safe credential metadata. */
@added(Versions.v2026_09_01_preview)
model BuilderAppGitHubCustomerApplication {
  /** OAuth application client ID. */
  clientId: string;

  /** Verified app custom domain used for callbacks; omission or null uses the primary hostname. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The service accepts null to select the primary callback hostname."
  callbackHost?: string | null;

  /** Write-only client secret. Omission retains the secret when clientId is unchanged. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  clientSecret?: string;

  /** Whether a client secret has been configured; no secret value is returned. */
  @visibility(Lifecycle.Read)
  secretConfigured?: boolean;
}

/** Microsoft Entra ID provider policy. Nullable allowlists are treated as empty lists. */
@added(Versions.v2026_09_01_preview)
model BuilderAppEntraAuth {
  /** Whether this provider is enabled. */
  enabled?: boolean;

  /** OAuth application ownership. Defaults to managed. */
  applicationMode?: BuilderAppAuthApplicationMode;

  /** Customer-owned app registration and workload identity. */
  customerApplication?: BuilderAppEntraCustomerApplication;

  /** Allowed email addresses; null clears the allowlist. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The Entra policy explicitly accepts null as an empty allowlist."
  emails?: string[] | null;

  /** Allowed email suffixes; null clears the allowlist. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The Entra policy explicitly accepts null as an empty allowlist."
  emailSuffixes?: string[] | null;

  /** Allowed Entra object IDs; null clears the allowlist. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The Entra policy explicitly accepts null as an empty allowlist."
  objectIds?: string[] | null;

  /** Allowed Entra tenant IDs; null clears the allowlist. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The Entra policy explicitly accepts null as an empty allowlist."
  tenantIds?: string[] | null;
}

/** Customer-owned Entra registration and app-assigned identity selection. */
@added(Versions.v2026_09_01_preview)
model BuilderAppEntraCustomerApplication {
  /** App registration client ID. */
  clientId: string;

  /** Registration home tenant ID. */
  homeTenantId: string;

  /** Supported account population. Defaults to singleTenant. */
  signInMode?: BuilderAppEntraSignInMode;

  /** Assigned user-managed identity used for workload federation. */
  workloadIdentityResourceId: Azure.Core.armResourceIdentifier;

  /** Exact v2 API application-ID audiences; an empty list disables customer bearer authentication. */
  allowedAudiences?: string[];
}

/** Supported account populations for an Entra application. */
@added(Versions.v2026_09_01_preview)
union BuilderAppEntraSignInMode {
  /** Accounts in one tenant. */
  SingleTenant: "singleTenant",

  /** Organizational accounts. */
  Organizations: "organizations",

  /** Organizational and personal accounts. */
  OrganizationsAndPersonal: "organizationsAndPersonal",

  /** Personal accounts. */
  Personal: "personal",

  string,
}

/** Non-secret setup projection. External registration and federation still require actual sign-in verification. */
@added(Versions.v2026_09_01_preview)
model BuilderAppEntraSetup {
  /** Readiness of the committed local identity selection. */
  readiness: string;

  /** Explanation and setup guidance. */
  message: string;

  /** Identity home tenant ID. */
  homeTenantId?: string;

  /** Selected workload identity resource ID. */
  workloadIdentityResourceId?: Azure.Core.armResourceIdentifier;

  /** Generated identity client ID. */
  clientId?: string;

  /** Generated identity principal ID. */
  principalId?: string;

  /** Issuer for the federated credential. */
  federatedCredentialIssuer?: string;

  /** Subject for the federated credential. */
  federatedCredentialSubject?: string;

  /** Audience for the federated credential. */
  federatedCredentialAudience?: string;

  /** Assigned identities with available generated metadata. */
  @identifiers(#["resourceId"])
  userAssignedIdentities?: BuilderAppEntraSetupIdentity[];
}

/** Credential-safe metadata for one assigned identity. */
@added(Versions.v2026_09_01_preview)
model BuilderAppEntraSetupIdentity {
  /** User-assigned identity ARM resource ID. */
  resourceId: Azure.Core.armResourceIdentifier;

  /** Generated client ID, if available. */
  clientId?: string;

  /** Generated principal ID, if available. */
  principalId?: string;
}

/** Conditional headers for replacing an authentication configuration. */
@added(Versions.v2026_09_01_preview)
model BuilderAppAuthConditions {
  /** Update only when the current ETag matches; * requires an existing configuration. */
  @header("If-Match")
  ifMatch?: string;

  /** Update only when the current ETag does not match. */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/** Credential-safe authentication configuration response with cache protection and ETag. */
@added(Versions.v2026_09_01_preview)
model BuilderAppAuthResponse {
  ...ArmResponse<BuilderAppAuthConfig>;

  /** Current entity tag. */
  @header("ETag")
  etag: string;

  /** Authentication responses must not be stored. */
  @header("Cache-Control")
  cacheControl: "private, no-store";
}

/** Singleton authentication configuration operations. */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface BuilderAppAuthConfigs {
  get is ArmResourceRead<
    BuilderAppAuthConfig,
    Response = BuilderAppAuthResponse
  >;

  /** Replace the current policy and return its credential-safe representation. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "This always-present singleton is replaced synchronously and the existing service returns 200, not resource creation."
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BuilderAppAuthConfig,
    Parameters = BuilderAppAuthConditions,
    Response = BuilderAppAuthResponse
  >;

  /** Reset the singleton authentication policy and return the resulting configuration. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "DELETE resets an always-present singleton and returns 200 with the resulting policy; it does not remove a resource or return 204."
  @autoRoute
  @delete
  @armResourceDelete(BuilderAppAuthConfig)
  delete(
    ...ResourceInstanceParameters<BuilderAppAuthConfig>,

    /** Reset only when the current ETag matches. */
    @header("If-Match") ifMatch?: string,
  ): BuilderAppAuthResponse | DefaultErrorResponse;
}
