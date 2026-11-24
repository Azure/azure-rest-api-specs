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

/** Fixed default application authentication configuration. Use PUT with mode disabled to turn off authentication; DELETE is not supported. */
@added(Versions.v2026_11_15)
@parentResource(BuilderApp)
@singleton("default")
model BuilderAppAuthConfig is ProxyResource<BuilderAppAuthConfigProperties> {
  ...ResourceNameParameter<
    Resource = BuilderAppAuthConfig,
    KeyName = "authConfigName",
    SegmentName = "authConfigs"
  >;
  ...PickProperties<CommonTypes.AzureEntityResource, "etag">;
}

/** Application authentication policy and credential-safe readiness information. */
@added(Versions.v2026_11_15)
model BuilderAppAuthConfigProperties {
  /** State of the configuration resource operation, independent of runtime propagation. */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderAppProvisioningState;

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
@added(Versions.v2026_11_15)
union BuilderAppAuthMode {
  /** Authentication disabled; provider settings supplied in the replacement remain configured. */
  Disabled: "disabled",

  /** Anonymous requests permitted. */
  Optional: "optional",

  /** Authentication required. */
  Required: "required",

  string,
}

/** Browser authentication providers. */
@added(Versions.v2026_11_15)
union BuilderAppAuthProvider {
  /** GitHub OAuth. */
  GitHub: "github",

  /** Microsoft Entra ID. */
  EntraId: "entraId",

  string,
}

/** Ownership of the OAuth application. */
@added(Versions.v2026_11_15)
union BuilderAppAuthApplicationMode {
  /** Platform-managed application. */
  Managed: "managed",

  /** Customer-owned application. */
  Customer: "customer",

  string,
}

/** Provider participation in the application access policy, independent of the global authentication mode. */
@added(Versions.v2026_11_15)
union BuilderAppAuthProviderState {
  /** The provider participates in authentication and authorization. */
  Enabled: "Enabled",

  /** The provider is not used; settings supplied in the replacement can remain configured. */
  Disabled: "Disabled",

  string,
}

/** An authentication allowlist entry, limited to 512 characters. */
@added(Versions.v2026_11_15)
@maxLength(512)
scalar BuilderAppAuthAllowlistEntry extends string;

/** An exact email domain without a leading `@`. Subdomains do not match. */
@added(Versions.v2026_11_15)
@maxLength(511)
scalar BuilderAppAuthEmailDomain extends string;

/** A GitHub username matched exactly, ignoring case. */
@added(Versions.v2026_11_15)
@maxLength(39)
scalar BuilderAppAuthGitHubUsername extends string;

/** An Enterprise Managed User short code without a leading underscore. */
@added(Versions.v2026_11_15)
@maxLength(511)
scalar BuilderAppAuthEnterpriseShortcode extends string;

/** A positive GitHub user ID representable exactly by JSON clients. */
@added(Versions.v2026_11_15)
@minValue(1)
@maxValue(9007199254740991)
scalar BuilderAppAuthGitHubUserId extends int64;

/** GitHub OAuth provider settings. A user may match any populated allowlist; with all lists empty, any authenticated GitHub user is allowed. At most 100 combined entries are allowed across all lists. Invalid policies are rejected atomically, without truncation. */
@added(Versions.v2026_11_15)
model BuilderAppGitHubAuth {
  /** Whether this provider participates in authentication. Required whenever the GitHub configuration is supplied. */
  state: BuilderAppAuthProviderState;

  /** OAuth application ownership. Defaults to managed. */
  applicationMode?: BuilderAppAuthApplicationMode;

  /** Complete verified email addresses, matched exactly ignoring case. Omission on PUT resets this list; [] clears it. */
  @maxItems(100)
  allowedEmails?: BuilderAppAuthAllowlistEntry[];

  /** Verified email domains without a leading `@`, matched exactly ignoring case. Subdomains do not match. Combined with the other GitHub selectors using OR. */
  @maxItems(100)
  allowedEmailDomains?: BuilderAppAuthEmailDomain[];

  /** Exact GitHub usernames, matched ignoring case. Combined with the other GitHub selectors using OR. */
  @maxItems(100)
  allowedUsernames?: BuilderAppAuthGitHubUsername[];

  /** Enterprise Managed User short codes without a leading underscore. A value microsoft matches the enterprise-controlled _microsoft username suffix, ignoring case. This is not a GitHub organization or team membership check. */
  @maxItems(100)
  allowedEnterpriseShortcodes?: BuilderAppAuthEnterpriseShortcode[];

  /** Stable numeric GitHub user IDs, independent of username changes. Combined with the other GitHub selectors using OR. */
  @maxItems(100)
  allowedUserIds?: BuilderAppAuthGitHubUserId[];

  /** Customer-owned GitHub application configuration. */
  customerApplication?: BuilderAppGitHubCustomerApplication;
}

/** Customer GitHub application input and safe credential metadata. */
@added(Versions.v2026_11_15)
model BuilderAppGitHubCustomerApplication {
  /** OAuth application client ID. */
  clientId: string;

  /** Verified app custom domain used for callbacks; omission uses the primary hostname. */
  callbackHost?: string;

  /** Write-only OAuth client secret, encrypted at rest and never returned. Supply a replacement to rotate it. Omission retains the existing secret only when clientId is unchanged; changing clientId requires its matching secret. Empty or null secrets are rejected. Omit the GitHub provider on PUT to remove its saved configuration. Mode disabled does not itself clear provider configuration supplied in the same replacement. */
  @secret
  @visibility(Lifecycle.Create, Lifecycle.Update)
  clientSecret?: string;

  /** Whether a client secret has been configured; no secret value is returned. */
  @visibility(Lifecycle.Read)
  secretConfigured?: boolean;
}

/** Microsoft Entra ID app sign-in policy, separate from authorization to deploy the Azure resource. Omitted allowlists default to empty lists on replacement. At most 100 combined entries are allowed across all lists, including customer application audiences. Invalid policies are rejected atomically, without truncation. */
@added(Versions.v2026_11_15)
model BuilderAppEntraAuth {
  /** Whether this provider participates in authentication. Required whenever the Entra configuration is supplied. */
  state: BuilderAppAuthProviderState;

  /** OAuth application ownership. Defaults to managed. */
  applicationMode?: BuilderAppAuthApplicationMode;

  /** Customer-owned app registration and workload identity. */
  customerApplication?: BuilderAppEntraCustomerApplication;

  /** Complete email addresses, matched exactly ignoring case. After the tenant check, matching an email, email domain, or object ID grants access. Email selectors apply only to users, not application principals. Multitenant customer applications require a domain-owner-verified email claim (xms_edov), unless the token tenant is explicitly trusted by allowedTenantIds or a single-tenant registration. */
  @maxItems(100)
  allowedEmails?: BuilderAppAuthAllowlistEntry[];

  /** Exact email domains without a leading `@`; subdomains do not match. Uses the same claim trust and OR semantics as allowedEmails. [] clears the list. */
  @maxItems(100)
  allowedEmailDomains?: BuilderAppAuthEmailDomain[];

  /** User or service-principal object IDs from the validated token's oid claim. Requires allowedTenantIds or a single-tenant customer registration to establish tenant context. Guest users match their object ID in the issuing resource tenant, not their home-tenant object ID. After the tenant check, object IDs are ORed with email and domain selectors. */
  @maxItems(100)
  allowedObjectIds?: BuilderAppAuthAllowlistEntry[];

  /** Directory IDs allowed to sign in to the hosted application, not the tenant of the Azure deployment. When populated, the validated token's tid must match before object/email rules are evaluated. If this is the only populated list, a matching tenant grants access. Empty means no additional tenant restriction beyond signInMode and issuer validation. */
  @maxItems(100)
  allowedTenantIds?: BuilderAppAuthAllowlistEntry[];
}

/** Customer-owned Entra registration and app-assigned identity selection. */
@added(Versions.v2026_11_15)
model BuilderAppEntraCustomerApplication {
  /** App registration client ID. */
  clientId: string;

  /** App registration home tenant ID. The selected workload identity must belong to this tenant; allowedTenantIds controls the separate sign-in population. */
  homeTenantId: string;

  /** Supported sign-in population and issuer authority. Defaults to singleTenant. Guest users sign in as users of the token-issuing tenant. */
  signInMode?: BuilderAppEntraSignInMode;

  /** Assigned user-managed identity used for workload federation. */
  workloadIdentityResourceId: Azure.Core.armResourceIdentifier;

  /** Exact v2 API application-ID audiences; an empty list disables customer bearer authentication. */
  @maxItems(100)
  allowedAudiences?: BuilderAppAuthAllowlistEntry[];
}

/** Supported account populations for an Entra application. */
@added(Versions.v2026_11_15)
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
@added(Versions.v2026_11_15)
model BuilderAppEntraSetup {
  /** Machine-readable local identity readiness; does not prove that the registration, callback, or federation works or that sign-in succeeds. */
  readiness: BuilderAppEntraSetupReadiness;

  /** Explanation and setup guidance. */
  setupMessage: string;

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

/** Local readiness of a customer Entra application's selected managed identity. */
@added(Versions.v2026_11_15)
union BuilderAppEntraSetupReadiness {
  /** No customer Entra application is configured. */
  NotConfigured: "notConfigured",

  /** The selected identity is not attached, is still provisioning, or belongs to a different tenant than the registration. */
  Unavailable: "unavailable",

  /** The selected identity is attached, provisioned, and in the registration's home tenant. External sign-in has not been verified. */
  Ready: "ready",

  string,
}

/** Credential-safe metadata for one assigned identity. */
@added(Versions.v2026_11_15)
model BuilderAppEntraSetupIdentity {
  /** User-assigned identity ARM resource ID. */
  resourceId: Azure.Core.armResourceIdentifier;

  /** Generated client ID, if available. */
  clientId?: string;

  /** Generated principal ID, if available. */
  principalId?: string;
}

/** Conditional headers for replacing an authentication configuration. */
@added(Versions.v2026_11_15)
model BuilderAppAuthConditions {
  /** Update only when the current ETag matches; * requires an existing configuration. */
  @header("If-Match")
  ifMatch?: string;

  /** Update only when the current ETag does not match. */
  @header("If-None-Match")
  ifNoneMatch?: string;
}

/** Credential-safe authentication configuration response with cache protection and ETag. */
@added(Versions.v2026_11_15)
model BuilderAppAuthResponse {
  ...ArmResponse<BuilderAppAuthConfig>;

  /** Current entity tag. */
  @header("ETag")
  etag: string;

  /** Authentication responses must not be stored. */
  @header("Cache-Control")
  cacheControl: "private, no-store";
}

/** Newly persisted authentication configuration with cache protection and ETag. */
@added(Versions.v2026_11_15)
model BuilderAppAuthCreatedResult {
  ...ArmResourceCreatedSyncResponse<BuilderAppAuthConfig>;
  ...PickProperties<BuilderAppAuthResponse, "etag" | "cacheControl">;
}

/** Credential-safe singleton collection with cache protection. */
@added(Versions.v2026_11_15)
model BuilderAppAuthListResult {
  ...ArmResponse<ResourceListResult<BuilderAppAuthConfig>>;

  /** Authentication responses must not be stored. */
  @header("Cache-Control")
  cacheControl: "private, no-store";
}

/** Singleton authentication configuration operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The default authentication configuration always exists; it is disabled through PUT with mode disabled rather than deleted."
@added(Versions.v2026_11_15)
@armResourceOperations
interface BuilderAppAuthConfigs {
  /** List the always-present default configuration, including when authentication is disabled. */
  listByBuilderApp is ArmResourceListByParent<
    BuilderAppAuthConfig,
    Response = BuilderAppAuthListResult
  >;

  get is ArmResourceRead<
    BuilderAppAuthConfig,
    Response = BuilderAppAuthResponse
  >;

  /** Create or replace the default policy and return its credential-safe representation. Use mode disabled to turn off authentication without deleting the resource. */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    BuilderAppAuthConfig,
    Parameters = BuilderAppAuthConditions,
    Response = BuilderAppAuthResponse | BuilderAppAuthCreatedResult
  >;
}
