import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.App;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * indicates whether the profile is default for the location.
 */
enum Applicability {
  LocationDefault,
  Custom,
}

/**
 * The type of extendedLocation.
 */
enum ExtendedLocationTypes {
  CustomLocation,
}

/**
 * Provisioning state of the Kubernetes Environment.
 */
enum ConnectedEnvironmentProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Waiting,
  InitializationInProgress,
  InfrastructureSetupInProgress,
  InfrastructureSetupComplete,
  ScheduledForDelete,
}

/**
 * Provisioning state of the certificate.
 */
enum CertificateProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  DeleteFailed,
  Pending,
}

/**
 * Access mode for storage
 */
enum AccessMode {
  ReadOnly,
  ReadWrite,
}

/**
 * Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).
 */
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

/**
 * Provisioning state of the Container App.
 */
enum ContainerAppProvisioningState {
  InProgress,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
}

/**
 * ActiveRevisionsMode controls how active revisions are handled for the Container app:
 * <list><item>Multiple: multiple revisions can be active.</item><item>Single: Only one revision can be active at a time. Revision weights can not be used in this mode. If no value if provided, this is the default.</item></list>
 */
enum ActiveRevisionsMode {
  Multiple,
  Single,
}

/**
 * Ingress transport protocol
 */
enum IngressTransportMethod {
  auto,
  http,
  http2,
  tcp,
}

/**
 * Custom Domain binding type.
 */
enum BindingType {
  Disabled,
  SniEnabled,
}

/**
 * Allow or Deny rules to determine for incoming IP. Note: Rules can only consist of ALL Allow or ALL Deny
 */
enum Action {
  Allow,
  Deny,
}

/**
 * Sticky Session Affinity
 */
enum Affinity {
  sticky,
  none,
}

/**
 * Client certificate mode for mTLS authentication. Ignore indicates server drops client certificate on forwarding. Accept indicates server forwards client certificate but does not require a client certificate. Require indicates server requires a client certificate.
 */
enum IngressClientCertificateMode {
  ignore,
  accept,
  require,
}

/**
 * Tells Dapr which protocol your application is using. Valid options are http and grpc. Default is http
 */
enum AppProtocol {
  http,
  grpc,
}

/**
 * Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.
 */
enum LogLevel {
  info,
  debug,
  warn,
  error,
}

/**
 * Scheme to use for connecting to the host. Defaults to HTTP.
 */
enum Scheme {
  HTTP,
  HTTPS,
}

/**
 * The type of probe.
 */
enum Type {
  Liveness,
  Readiness,
  Startup,
}

/**
 * Storage type for the volume. If not provided, use EmptyDir.
 */
enum StorageType {
  AzureFile,
  EmptyDir,
  Secret,
}

/**
 * Current health State of the revision
 */
enum RevisionHealthState {
  Healthy,
  Unhealthy,
  None,
}

/**
 * Current provisioning State of the revision
 */
enum RevisionProvisioningState {
  Provisioning,
  Provisioned,
  Failed,
  Deprovisioning,
  Deprovisioned,
}

/**
 * Current running state of the revision
 */
enum RevisionRunningState {
  Running,
  Processing,
  Stopped,
  Degraded,
  Failed,
  Unknown,
}

/**
 * Current running state of the replica
 */
enum ContainerAppReplicaRunningState {
  Running,
  NotRunning,
  Unknown,
}

/**
 * Current running state of the container
 */
enum ContainerAppContainerRunningState {
  Running,
  Terminated,
  Waiting,
}

/**
 * Provisioning state of the Environment.
 */
enum EnvironmentProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Waiting,
  InitializationInProgress,
  InfrastructureSetupInProgress,
  InfrastructureSetupComplete,
  ScheduledForDelete,
  UpgradeRequested,
  UpgradeFailed,
}

/**
 * Provisioning state of the Container Apps Job.
 */
enum JobProvisioningState {
  InProgress,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
}

/**
 * Trigger type of the job
 */
enum TriggerType {
  Schedule,
  Event,
  Manual,
}

/**
 * Current running State of the job
 */
enum JobExecutionRunningState {
  Running,
  Processing,
  Stopped,
  Degraded,
  Failed,
  Unknown,
  Succeeded,
}

/**
 * Selected type of domain control validation for managed certificates.
 */
enum ManagedCertificateDomainControlValidation {
  CNAME,
  HTTP,
  TXT,
}

/**
 * Current provisioning State of the operation
 */
enum SourceControlOperationState {
  InProgress,
  Succeeded,
  Failed,
  Canceled,
}

/**
 * The action to take when an unauthenticated client attempts to access the app.
 */
@fixed
enum UnauthenticatedClientActionV2 {
  RedirectToLoginPage,
  AllowAnonymous,
  Return401,
  Return403,
}

/**
 * The convention used when determining the session cookie's expiration.
 */
@fixed
enum CookieExpirationConvention {
  FixedTime,
  IdentityProviderDerived,
}

/**
 * The convention used to determine the url of the request made.
 */
@fixed
enum ForwardProxyConvention {
  NoProxy,
  Standard,
  Custom,
}

/**
 * DNS verification test result.
 */
@fixed
enum DnsVerificationTestResult {
  Passed,
  Failed,
  Skipped,
}

/**
 * AuthConfig resource specific properties
 */
model AuthConfigProperties {
  /**
   * The configuration settings of the platform of ContainerApp Service Authentication/Authorization.
   */
  platform?: AuthPlatform;

  /**
   * The configuration settings that determines the validation flow of users using  Service Authentication/Authorization.
   */
  globalValidation?: GlobalValidation;

  /**
   * The configuration settings of each of the identity providers used to configure ContainerApp Service Authentication/Authorization.
   */
  identityProviders?: IdentityProviders;

  /**
   * The configuration settings of the login flow of users using ContainerApp Service Authentication/Authorization.
   */
  login?: Login;

  /**
   * The configuration settings of the HTTP requests for authentication and authorization requests made against ContainerApp Service Authentication/Authorization.
   */
  httpSettings?: HttpSettings;
}

/**
 * The configuration settings of the platform of ContainerApp Service Authentication/Authorization.
 */
model AuthPlatform {
  /**
   * <code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The RuntimeVersion of the Authentication / Authorization feature in use for the current app.
   * The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
   */
  runtimeVersion?: string;
}

/**
 * The configuration settings that determines the validation flow of users using ContainerApp Service Authentication/Authorization.
 */
model GlobalValidation {
  /**
   * The action to take when an unauthenticated client attempts to access the app.
   */
  unauthenticatedClientAction?: UnauthenticatedClientActionV2;

  /**
   * The default authentication provider to use when multiple providers are configured.
   * This setting is only needed if multiple providers are configured and the unauthenticated client
   * action is set to "RedirectToLoginPage".
   */
  redirectToProvider?: string;

  /**
   * The paths for which unauthenticated flow would not be redirected to the login page.
   */
  excludedPaths?: string[];
}

/**
 * The configuration settings of each of the identity providers used to configure ContainerApp Service Authentication/Authorization.
 */
model IdentityProviders {
  /**
   * The configuration settings of the Azure Active directory provider.
   */
  azureActiveDirectory?: AzureActiveDirectory;

  /**
   * The configuration settings of the Facebook provider.
   */
  facebook?: Facebook;

  /**
   * The configuration settings of the GitHub provider.
   */
  gitHub?: GitHub;

  /**
   * The configuration settings of the Google provider.
   */
  google?: Google;

  /**
   * The configuration settings of the Twitter provider.
   */
  twitter?: Twitter;

  /**
   * The configuration settings of the Apple provider.
   */
  apple?: Apple;

  /**
   * The configuration settings of the Azure Static Web Apps provider.
   */
  azureStaticWebApps?: AzureStaticWebApps;

  /**
   * The map of the name of the alias of each custom Open ID Connect provider to the
   * configuration settings of the custom Open ID Connect provider.
   */
  customOpenIdConnectProviders?: Record<CustomOpenIdConnectProvider>;
}

/**
 * The configuration settings of the Azure Active directory provider.
 */
model AzureActiveDirectory {
  /**
   * <code>false</code> if the Azure Active Directory provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the Azure Active Directory app registration.
   */
  registration?: AzureActiveDirectoryRegistration;

  /**
   * The configuration settings of the Azure Active Directory login flow.
   */
  login?: AzureActiveDirectoryLogin;

  /**
   * The configuration settings of the Azure Active Directory token validation flow.
   */
  validation?: AzureActiveDirectoryValidation;

  /**
   * Gets a value indicating whether the Azure AD configuration was auto-provisioned using 1st party tooling.
   * This is an internal flag primarily intended to support the Azure Management Portal. Users should not
   * read or write to this property.
   */
  isAutoProvisioned?: boolean;
}

/**
 * The configuration settings of the Azure Active Directory app registration.
 */
model AzureActiveDirectoryRegistration {
  /**
   * The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
   * When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/.
   * This URI is a case-sensitive identifier for the token issuer.
   * More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
   */
  openIdIssuer?: string;

  /**
   * The Client ID of this relying party application, known as the client_id.
   * This setting is required for enabling OpenID Connection authentication with Azure Active Directory or
   * other 3rd party OpenID Connect providers.
   * More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
   */
  clientId?: string;

  /**
   * The app setting name that contains the client secret of the relying party application.
   */
  clientSecretSettingName?: string;

  /**
   * An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret. It is also optional.
   */
  clientSecretCertificateThumbprint?: string;

  /**
   * An alternative to the client secret thumbprint, that is the subject alternative name of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret Certificate Thumbprint. It is also optional.
   */
  clientSecretCertificateSubjectAlternativeName?: string;

  /**
   * An alternative to the client secret thumbprint, that is the issuer of a certificate used for signing purposes. This property acts as
   * a replacement for the Client Secret Certificate Thumbprint. It is also optional.
   */
  clientSecretCertificateIssuer?: string;
}

/**
 * The configuration settings of the Azure Active Directory login flow.
 */
model AzureActiveDirectoryLogin {
  /**
   * Login parameters to send to the OpenID Connect authorization endpoint when
   * a user logs in. Each parameter must be in the form "key=value".
   */
  loginParameters?: string[];

  /**
   * <code>true</code> if the www-authenticate provider should be omitted from the request; otherwise, <code>false</code>.
   */
  disableWWWAuthenticate?: boolean;
}

/**
 * The configuration settings of the Azure Active Directory token validation flow.
 */
model AzureActiveDirectoryValidation {
  /**
   * The configuration settings of the checks that should be made while validating the JWT Claims.
   */
  jwtClaimChecks?: JwtClaimChecks;

  /**
   * The list of audiences that can make successful authentication/authorization requests.
   */
  allowedAudiences?: string[];

  /**
   * The configuration settings of the default authorization policy.
   */
  defaultAuthorizationPolicy?: DefaultAuthorizationPolicy;
}

/**
 * The configuration settings of the checks that should be made while validating the JWT Claims.
 */
model JwtClaimChecks {
  /**
   * The list of the allowed groups.
   */
  allowedGroups?: string[];

  /**
   * The list of the allowed client applications.
   */
  allowedClientApplications?: string[];
}

/**
 * The configuration settings of the Azure Active Directory default authorization policy.
 */
model DefaultAuthorizationPolicy {
  /**
   * The configuration settings of the Azure Active Directory allowed principals.
   */
  allowedPrincipals?: AllowedPrincipals;

  /**
   * The configuration settings of the Azure Active Directory allowed applications.
   */
  allowedApplications?: string[];
}

/**
 * The configuration settings of the Azure Active Directory allowed principals.
 */
model AllowedPrincipals {
  /**
   * The list of the allowed groups.
   */
  groups?: string[];

  /**
   * The list of the allowed identities.
   */
  identities?: string[];
}

/**
 * The configuration settings of the Facebook provider.
 */
model Facebook {
  /**
   * <code>false</code> if the Facebook provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the app registration for the Facebook provider.
   */
  registration?: AppRegistration;

  /**
   * The version of the Facebook api to be used while logging in.
   */
  graphApiVersion?: string;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;
}

/**
 * The configuration settings of the app registration for providers that have app ids and app secrets
 */
model AppRegistration {
  /**
   * The App ID of the app used for login.
   */
  appId?: string;

  /**
   * The app setting name that contains the app secret.
   */
  appSecretSettingName?: string;
}

/**
 * The configuration settings of the login flow, including the scopes that should be requested.
 */
model LoginScopes {
  /**
   * A list of the scopes that should be requested while authenticating.
   */
  scopes?: string[];
}

/**
 * The configuration settings of the GitHub provider.
 */
model GitHub {
  /**
   * <code>false</code> if the GitHub provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the app registration for the GitHub provider.
   */
  registration?: ClientRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;
}

/**
 * The configuration settings of the app registration for providers that have client ids and client secrets
 */
model ClientRegistration {
  /**
   * The Client ID of the app used for login.
   */
  clientId?: string;

  /**
   * The app setting name that contains the client secret.
   */
  clientSecretSettingName?: string;
}

/**
 * The configuration settings of the Google provider.
 */
model Google {
  /**
   * <code>false</code> if the Google provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the app registration for the Google provider.
   */
  registration?: ClientRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;

  /**
   * The configuration settings of the Azure Active Directory token validation flow.
   */
  validation?: AllowedAudiencesValidation;
}

/**
 * The configuration settings of the Allowed Audiences validation flow.
 */
model AllowedAudiencesValidation {
  /**
   * The configuration settings of the allowed list of audiences from which to validate the JWT token.
   */
  allowedAudiences?: string[];
}

/**
 * The configuration settings of the Twitter provider.
 */
model Twitter {
  /**
   * <code>false</code> if the Twitter provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the app registration for the Twitter provider.
   */
  registration?: TwitterRegistration;
}

/**
 * The configuration settings of the app registration for the Twitter provider.
 */
model TwitterRegistration {
  /**
   * The OAuth 1.0a consumer key of the Twitter application used for sign-in.
   * This setting is required for enabling Twitter Sign-In.
   * Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
   */
  consumerKey?: string;

  /**
   * The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
   * application used for sign-in.
   */
  consumerSecretSettingName?: string;
}

/**
 * The configuration settings of the Apple provider.
 */
model Apple {
  /**
   * <code>false</code> if the Apple provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the Apple registration.
   */
  registration?: AppleRegistration;

  /**
   * The configuration settings of the login flow.
   */
  login?: LoginScopes;
}

/**
 * The configuration settings of the registration for the Apple provider
 */
model AppleRegistration {
  /**
   * The Client ID of the app used for login.
   */
  clientId?: string;

  /**
   * The app setting name that contains the client secret.
   */
  clientSecretSettingName?: string;
}

/**
 * The configuration settings of the Azure Static Web Apps provider.
 */
model AzureStaticWebApps {
  /**
   * <code>false</code> if the Azure Static Web Apps provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the Azure Static Web Apps registration.
   */
  registration?: AzureStaticWebAppsRegistration;
}

/**
 * The configuration settings of the registration for the Azure Static Web Apps provider
 */
model AzureStaticWebAppsRegistration {
  /**
   * The Client ID of the app used for login.
   */
  clientId?: string;
}

/**
 * The configuration settings of the custom Open ID Connect provider.
 */
model CustomOpenIdConnectProvider {
  /**
   * <code>false</code> if the custom Open ID provider provider should not be enabled; otherwise, <code>true</code>.
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * The configuration settings of the app registration for the custom Open ID Connect provider.
   */
  registration?: OpenIdConnectRegistration;

  /**
   * The configuration settings of the login flow of the custom Open ID Connect provider.
   */
  login?: OpenIdConnectLogin;
}

/**
 * The configuration settings of the app registration for the custom Open ID Connect provider.
 */
model OpenIdConnectRegistration {
  /**
   * The client id of the custom Open ID Connect provider.
   */
  clientId?: string;

  /**
   * The authentication credentials of the custom Open ID Connect provider.
   */
  clientCredential?: OpenIdConnectClientCredential;

  /**
   * The configuration settings of the endpoints used for the custom Open ID Connect provider.
   */
  openIdConnectConfiguration?: OpenIdConnectConfig;
}

/**
 * The authentication client credentials of the custom Open ID Connect provider.
 */
model OpenIdConnectClientCredential {
  /**
   * The method that should be used to authenticate the user.
   */
  method?: "ClientSecretPost";

  /**
   * The app setting that contains the client secret for the custom Open ID Connect provider.
   */
  clientSecretSettingName?: string;
}

/**
 * The configuration settings of the endpoints used for the custom Open ID Connect provider.
 */
model OpenIdConnectConfig {
  /**
   * The endpoint to be used to make an authorization request.
   */
  authorizationEndpoint?: string;

  /**
   * The endpoint to be used to request a token.
   */
  tokenEndpoint?: string;

  /**
   * The endpoint that issues the token.
   */
  issuer?: string;

  /**
   * The endpoint that provides the keys necessary to validate the token.
   */
  certificationUri?: string;

  /**
   * The endpoint that contains all the configuration endpoints for the provider.
   */
  wellKnownOpenIdConfiguration?: string;
}

/**
 * The configuration settings of the login flow of the custom Open ID Connect provider.
 */
model OpenIdConnectLogin {
  /**
   * The name of the claim that contains the users name.
   */
  nameClaimType?: string;

  /**
   * A list of the scopes that should be requested while authenticating.
   */
  scopes?: string[];
}

/**
 * The configuration settings of the login flow of users using ContainerApp Service Authentication/Authorization.
 */
model Login {
  /**
   * The routes that specify the endpoints used for login and logout requests.
   */
  routes?: LoginRoutes;

  /**
   * <code>true</code> if the fragments from the request are preserved after the login request is made; otherwise, <code>false</code>.
   */
  preserveUrlFragmentsForLogins?: boolean;

  /**
   * External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
   * This is an advanced setting typically only needed by Windows Store application backends.
   * Note that URLs within the current domain are always implicitly allowed.
   */
  allowedExternalRedirectUrls?: string[];

  /**
   * The configuration settings of the session cookie's expiration.
   */
  cookieExpiration?: CookieExpiration;

  /**
   * The configuration settings of the nonce used in the login flow.
   */
  nonce?: Nonce;
}

/**
 * The routes that specify the endpoints used for login and logout requests.
 */
model LoginRoutes {
  /**
   * The endpoint at which a logout request should be made.
   */
  logoutEndpoint?: string;
}

/**
 * The configuration settings of the session cookie's expiration.
 */
model CookieExpiration {
  /**
   * The convention used when determining the session cookie's expiration.
   */
  convention?: CookieExpirationConvention;

  /**
   * The time after the request is made when the session cookie should expire.
   */
  timeToExpiration?: string;
}

/**
 * The configuration settings of the nonce used in the login flow.
 */
model Nonce {
  /**
   * <code>false</code> if the nonce should not be validated while completing the login flow; otherwise, <code>true</code>.
   */
  validateNonce?: boolean;

  /**
   * The time after the request is made when the nonce should expire.
   */
  nonceExpirationInterval?: string;
}

/**
 * The configuration settings of the HTTP requests for authentication and authorization requests made against ContainerApp Service Authentication/Authorization.
 */
model HttpSettings {
  /**
   * <code>false</code> if the authentication/authorization responses not having the HTTPS scheme are permissible; otherwise, <code>true</code>.
   */
  requireHttps?: boolean;

  /**
   * The configuration settings of the paths HTTP requests.
   */
  routes?: HttpSettingsRoutes;

  /**
   * The configuration settings of a forward proxy used to make the requests.
   */
  forwardProxy?: ForwardProxy;
}

/**
 * The configuration settings of the paths HTTP requests.
 */
model HttpSettingsRoutes {
  /**
   * The prefix that should precede all the authentication/authorization paths.
   */
  apiPrefix?: string;
}

/**
 * The configuration settings of a forward proxy used to make the requests.
 */
model ForwardProxy {
  /**
   * The convention used to determine the url of the request made.
   */
  convention?: ForwardProxyConvention;

  /**
   * The name of the header containing the host of the request.
   */
  customHostHeaderName?: string;

  /**
   * The name of the header containing the scheme of the request.
   */
  customProtoHeaderName?: string;
}

/**
 * Common fields that are returned in the response for all Azure Resource Manager resources
 */
model Resource {
  /**
   * Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource. E.g. "Microsoft.Compute/virtualMachines" or "Microsoft.Storage/storageAccounts"
   */
  @visibility("read")
  type?: string;

  /**
   * Azure Resource Manager metadata containing createdBy and modifiedBy information.
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * App Service error response.
 */
@error
model DefaultErrorResponse {
  /**
   * Error model.
   */
  @visibility("read")
  error?: DefaultErrorResponseError;
}

/**
 * Error model.
 */
model DefaultErrorResponseError {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  target?: string;

  /**
   * Details or the error
   */
  details?: DefaultErrorResponseErrorDetailsItem[];

  /**
   * More information to debug error.
   */
  @visibility("read")
  innererror?: string;
}

/**
 * Detailed errors.
 */
model DefaultErrorResponseErrorDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  target?: string;
}

/**
 * Collection of available workload profiles in the location.
 */
model AvailableWorkloadProfilesCollection
  is Azure.Core.Page<AvailableWorkloadProfile>;

/**
 * A workload profile with specific hardware configure to run container apps.
 */
model AvailableWorkloadProfile extends ProxyResource<{}> {
  /**
   * Region of the workload profile.
   */
  location?: string;

  /**
   * Revision resource specific properties
   */
  properties?: AvailableWorkloadProfileProperties;
}

/**
 * Revision resource specific properties
 */
model AvailableWorkloadProfileProperties {
  /**
   * Used to categorize workload profiles.
   */
  category?: string;

  /**
   * indicates whether the profile is default for the location.
   */
  applicability?: Applicability;

  /**
   * Number of cores in CPU.
   */
  cores?: int32;

  /**
   * Memory in GiB.
   */
  memoryGiB?: int32;

  /**
   * The everyday name of the workload profile.
   */
  displayName?: string;
}

/**
 * Collection of billing meters.
 */
model BillingMeterCollection {
  /**
   * Collection of billing meters.
   */
  value: BillingMeter[];
}

/**
 * Billing meter.
 */
model BillingMeter extends ProxyResource<{}> {
  /**
   * Region for the billing meter.
   */
  location?: string;

  /**
   * Revision resource specific properties
   */
  properties?: BillingMeterProperties;
}

/**
 * Revision resource specific properties
 */
model BillingMeterProperties {
  /**
   * Used to categorize billing meters.
   */
  category?: string;

  /**
   * Billing meter type.
   */
  meterType?: string;

  /**
   * The everyday name of the billing meter.
   */
  displayName?: string;
}

/**
 * The complex type of the extended location.
 */
model ExtendedLocation {
  /**
   * The name of the extended location.
   */
  name?: string;

  /**
   * The type of the extended location.
   */
  type?: ExtendedLocationTypes;
}

/**
 * ConnectedEnvironment resource specific properties
 */
model ConnectedEnvironmentProperties {
  /**
   * Provisioning state of the Kubernetes Environment.
   */
  @visibility("read")
  provisioningState?: ConnectedEnvironmentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility("read")
  deploymentErrors?: string;

  /**
   * Default Domain Name for the cluster
   */
  @visibility("read")
  defaultDomain?: string;

  /**
   * Static IP of the connectedEnvironment
   */
  staticIp?: string;

  /**
   * Application Insights connection string used by Dapr to export Service to Service communication telemetry
   */
  daprAIConnectionString?: string;

  /**
   * Custom domain configuration for the environment
   */
  customDomainConfiguration?: CustomDomainConfiguration;
}

/**
 * Configuration properties for apps environment custom domain
 */
model CustomDomainConfiguration {
  /**
   * Id used to verify domain name ownership
   */
  @visibility("read")
  customDomainVerificationId?: string;

  /**
   * Dns suffix for the environment domain
   */
  @visibility("read", "create")
  dnsSuffix?: string;

  /**
   * PFX or PEM blob
   */
  certificateValue?: bytes;

  /**
   * Certificate password
   */
  certificatePassword?: string;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility("read")
  subjectName?: string;
}

/**
 * The check availability request body.
 */
model CheckNameAvailabilityRequest {
  /**
   * The name of the resource for which availability needs to be checked.
   */
  name?: string;

  /**
   * The resource type.
   */
  type?: string;
}

/**
 * The check availability result.
 */
model CheckNameAvailabilityResponse {
  /**
   * Indicates if the resource name is available.
   */
  nameAvailable?: boolean;

  /**
   * The reason why the given name is not available.
   */
  reason?: CheckNameAvailabilityReason;

  /**
   * Detailed reason why the given name is available.
   */
  message?: string;
}

/**
 * Certificate resource specific properties
 */
model CertificateProperties {
  /**
   * Provisioning state of the certificate.
   */
  @visibility("read")
  provisioningState?: CertificateProvisioningState;

  /**
   * Certificate password.
   */
  @visibility("create")
  password?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility("read")
  subjectName?: string;

  /**
   * Subject alternative names the certificate applies to.
   */
  @visibility("read")
  subjectAlternativeNames?: string[];

  /**
   * PFX or PEM blob
   */
  @visibility("create")
  value?: bytes;

  /**
   * Certificate issuer.
   */
  @visibility("read")
  issuer?: string;

  /**
   * Certificate issue Date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  /**
   * Certificate expiration date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility("read")
  thumbprint?: string;

  /**
   * Is the certificate valid?.
   */
  @visibility("read")
  valid?: boolean;

  /**
   * Public key hash.
   */
  @visibility("read")
  publicKeyHash?: string;
}

/**
 * A certificate to update
 */
model CertificatePatch {
  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * Dapr Component resource specific properties
 */
model DaprComponentProperties {
  /**
   * Component type
   */
  componentType?: string;

  /**
   * Component version
   */
  version?: string;

  /**
   * Boolean describing if the component errors are ignores
   */
  ignoreErrors?: boolean;

  /**
   * Initialization timeout
   */
  initTimeout?: string;

  /**
   * Collection of secrets used by a Dapr component
   */
  secrets?: Secret[];

  /**
   * Name of a Dapr component to retrieve component secrets from
   */
  secretStoreComponent?: string;

  /**
   * Component metadata
   */
  metadata?: DaprMetadata[];

  /**
   * Names of container apps that can use this Dapr component
   */
  scopes?: string[];
}

/**
 * Secret definition.
 */
model Secret {
  /**
   * Secret Name.
   */
  name?: string;

  /**
   * Secret Value.
   */
  @visibility("create", "update")
  value?: string;

  /**
   * Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
   */
  identity?: string;

  /**
   * Azure Key Vault URL pointing to the secret referenced by the container app.
   */
  keyVaultUrl?: string;
}

/**
 * Dapr component metadata.
 */
model DaprMetadata {
  /**
   * Metadata property name.
   */
  name?: string;

  /**
   * Metadata property value.
   */
  value?: string;

  /**
   * Name of the Dapr Component secret from which to pull the metadata property value.
   */
  secretRef?: string;
}

/**
 * Dapr component Secrets Collection for ListSecrets Action.
 */
model DaprSecretsCollection {
  /**
   * Collection of secrets used by a Dapr component
   */
  value: DaprSecret[];
}

/**
 * Dapr component Secret for ListSecrets Action
 */
model DaprSecret {
  /**
   * Secret Name.
   */
  @visibility("read")
  name?: string;

  /**
   * Secret Value.
   */
  @visibility("read")
  value?: string;
}

/**
 * Storage properties
 */
model ConnectedEnvironmentStorageProperties {
  /**
   * Azure file properties
   */
  azureFile?: AzureFileProperties;
}

/**
 * Azure File Properties.
 */
model AzureFileProperties {
  /**
   * Storage account name for azure file.
   */
  accountName?: string;

  /**
   * Storage account key for azure file.
   */
  accountKey?: string;

  /**
   * Access mode for storage
   */
  accessMode?: AccessMode;

  /**
   * Azure file share name.
   */
  shareName?: string;
}

/**
 * ContainerApp resource specific properties
 */
model ContainerAppProperties {
  /**
   * Provisioning state of the Container App.
   */
  @visibility("read")
  provisioningState?: ContainerAppProvisioningState;

  /**
   * Deprecated. Resource ID of the Container App's environment.
   */
  @visibility("read", "create")
  managedEnvironmentId?: string;

  /**
   * Resource ID of environment.
   */
  @visibility("read", "create")
  environmentId?: string;

  /**
   * Workload profile name to pin for container app execution.
   */
  workloadProfileName?: string;

  /**
   * Name of the latest revision of the Container App.
   */
  @visibility("read")
  latestRevisionName?: string;

  /**
   * Name of the latest ready revision of the Container App.
   */
  @visibility("read")
  latestReadyRevisionName?: string;

  /**
   * Fully Qualified Domain Name of the latest revision of the Container App.
   */
  @visibility("read")
  latestRevisionFqdn?: string;

  /**
   * Id used to verify domain name ownership
   */
  @visibility("read")
  customDomainVerificationId?: string;

  /**
   * Non versioned Container App configuration properties.
   */
  configuration?: Configuration;

  /**
   * Container App versioned application definition.
   */
  template?: Template;

  /**
   * Outbound IP Addresses for container app.
   */
  @visibility("read")
  outboundIpAddresses?: string[];

  /**
   * The endpoint of the eventstream of the container app.
   */
  @visibility("read")
  eventStreamEndpoint?: string;
}

/**
 * Non versioned Container App configuration properties that define the mutable settings of a Container app
 */
model Configuration {
  /**
   * Collection of secrets used by a Container app
   */
  secrets?: Secret[];

  /**
   * ActiveRevisionsMode controls how active revisions are handled for the Container app:
   * <list><item>Multiple: multiple revisions can be active.</item><item>Single: Only one revision can be active at a time. Revision weights can not be used in this mode. If no value if provided, this is the default.</item></list>
   */
  activeRevisionsMode?: ActiveRevisionsMode = ActiveRevisionsMode.Single;

  /**
   * Ingress configurations.
   */
  ingress?: Ingress;

  /**
   * Collection of private container registry credentials for containers used by the Container app
   */
  registries?: RegistryCredentials[];

  /**
   * Dapr configuration for the Container App.
   */
  dapr?: Dapr;

  /**
   * Optional. Max inactive revisions a Container App can have.
   */
  maxInactiveRevisions?: int32;

  /**
   * Container App to be a dev Container App Service
   */
  service?: Service;
}

/**
 * Container App Ingress configuration.
 */
model Ingress {
  /**
   * Hostname.
   */
  @visibility("read")
  fqdn?: string;

  /**
   * Bool indicating if app exposes an external http endpoint
   */
  external?: boolean;

  /**
   * Target Port in containers for traffic from ingress
   */
  targetPort?: int32;

  /**
   * Exposed Port in containers for TCP traffic from ingress
   */
  exposedPort?: int32;

  /**
   * Ingress transport protocol
   */
  transport?: IngressTransportMethod = IngressTransportMethod.auto;

  /**
   * Traffic weights for app's revisions
   */
  traffic?: TrafficWeight[];

  /**
   * custom domain bindings for Container Apps' hostnames.
   */
  customDomains?: CustomDomain[];

  /**
   * Bool indicating if HTTP connections to is allowed. If set to false HTTP connections are automatically redirected to HTTPS connections
   */
  allowInsecure?: boolean;

  /**
   * Rules to restrict incoming IP address.
   */
  ipSecurityRestrictions?: IpSecurityRestrictionRule[];

  /**
   * Sticky Sessions for Single Revision Mode
   */
  stickySessions?: IngressStickySessions;

  /**
   * Client certificate mode for mTLS authentication. Ignore indicates server drops client certificate on forwarding. Accept indicates server forwards client certificate but does not require a client certificate. Require indicates server requires a client certificate.
   */
  clientCertificateMode?: IngressClientCertificateMode;

  /**
   * CORS policy for container app
   */
  corsPolicy?: CorsPolicy;
}

/**
 * Traffic weight assigned to a revision
 */
model TrafficWeight {
  /**
   * Name of a revision
   */
  revisionName?: string;

  /**
   * Traffic weight assigned to a revision
   */
  weight?: int32;

  /**
   * Indicates that the traffic weight belongs to a latest stable revision
   */
  latestRevision?: boolean;

  /**
   * Associates a traffic label with a revision
   */
  label?: string;
}

/**
 * Custom Domain of a Container App
 */
model CustomDomain {
  /**
   * Hostname.
   */
  name: string;

  /**
   * Custom Domain binding type.
   */
  bindingType?: BindingType;

  /**
   * Resource Id of the Certificate to be bound to this hostname. Must exist in the Managed Environment.
   */
  certificateId?: string;
}

/**
 * Rule to restrict incoming IP address.
 */
model IpSecurityRestrictionRule {
  /**
   * Name for the IP restriction rule.
   */
  name: string;

  /**
   * Describe the IP restriction rule that is being sent to the container-app. This is an optional field.
   */
  description?: string;

  /**
   * CIDR notation to match incoming IP address
   */
  ipAddressRange: string;

  /**
   * Allow or Deny rules to determine for incoming IP. Note: Rules can only consist of ALL Allow or ALL Deny
   */
  action: Action;
}

/**
 * Sticky Sessions for Single Revision Mode
 */
model IngressStickySessions {
  /**
   * Sticky Session Affinity
   */
  affinity?: Affinity;
}

/**
 * Cross-Origin-Resource-Sharing policy
 */
model CorsPolicy {
  /**
   * Specifies the content for the access-control-allow-origins header
   */
  allowedOrigins: string[];

  /**
   * Specifies the content for the access-control-allow-methods header
   */
  allowedMethods?: string[];

  /**
   * Specifies the content for the access-control-allow-headers header
   */
  allowedHeaders?: string[];

  /**
   * Specifies the content for the access-control-expose-headers header
   */
  exposeHeaders?: string[];

  /**
   * Specifies the content for the access-control-max-age header
   */
  maxAge?: int32;

  /**
   * Specifies whether the resource allows credentials
   */
  allowCredentials?: boolean;
}

/**
 * Container App Private Registry
 */
model RegistryCredentials {
  /**
   * Container Registry Server
   */
  server?: string;

  /**
   * Container Registry Username
   */
  username?: string;

  /**
   * The name of the Secret that contains the registry login password
   */
  passwordSecretRef?: string;

  /**
   * A Managed Identity to use to authenticate with Azure Container Registry. For user-assigned identities, use the full user-assigned identity Resource ID. For system-assigned identities, use 'system'
   */
  identity?: string;
}

/**
 * Container App Dapr configuration.
 */
model Dapr {
  /**
   * Boolean indicating if the Dapr side car is enabled
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  /**
   * Dapr application identifier
   */
  appId?: string;

  /**
   * Tells Dapr which protocol your application is using. Valid options are http and grpc. Default is http
   */
  appProtocol?: AppProtocol = AppProtocol.http;

  /**
   * Tells Dapr which port your application is listening on
   */
  appPort?: int32;

  /**
   * Dapr max size of http header read buffer in KB to handle when sending multi-KB headers. Default is 65KB.
   */
  httpReadBufferSize?: int32;

  /**
   * Increasing max size of request body http and grpc servers parameter in MB to handle uploading of big files. Default is 4 MB.
   */
  httpMaxRequestSize?: int32;

  /**
   * Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.
   */
  logLevel?: LogLevel;

  /**
   * Enables API logging for the Dapr sidecar
   */
  enableApiLogging?: boolean;
}

/**
 * Container App to be a dev service
 */
model Service {
  /**
   * Dev ContainerApp service type
   */
  type: string;
}

/**
 * Container App versioned application definition.
 * Defines the desired state of an immutable revision.
 * Any changes to this section Will result in a new revision being created
 */
model Template {
  /**
   * User friendly suffix that is appended to the revision name
   */
  revisionSuffix?: string;

  /**
   * Optional duration in seconds the Container App Instance needs to terminate gracefully. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.
   */
  terminationGracePeriodSeconds?: int64;

  /**
   * List of specialized containers that run before app containers.
   */
  initContainers?: InitContainer[];

  /**
   * List of container definitions for the Container App.
   */
  containers?: Container[];

  /**
   * Scaling properties for the Container App.
   */
  scale?: Scale;

  /**
   * List of volume definitions for the Container App.
   */
  volumes?: Volume[];

  /**
   * List of container app services bound to the app
   */
  serviceBinds?: ServiceBind[];
}

/**
 * Container App init container definition
 */
model InitContainer extends BaseContainer {}

/**
 * Container App base container definition.
 */
model BaseContainer {
  /**
   * Container image tag.
   */
  image?: string;

  /**
   * Custom container name.
   */
  name?: string;

  /**
   * Container start command.
   */
  command?: string[];

  /**
   * Container start command arguments.
   */
  args?: string[];

  /**
   * Container environment variables.
   */
  env?: EnvironmentVar[];

  /**
   * Container resource requirements.
   */
  resources?: ContainerResources;

  /**
   * Container volume mounts.
   */
  volumeMounts?: VolumeMount[];
}

/**
 * Container App container environment variable.
 */
model EnvironmentVar {
  /**
   * Environment variable name.
   */
  name?: string;

  /**
   * Non-secret environment variable value.
   */
  value?: string;

  /**
   * Name of the Container App secret from which to pull the environment variable value.
   */
  secretRef?: string;
}

/**
 * Container App container resource requirements.
 */
model ContainerResources {
  /**
   * Required CPU in cores, e.g. 0.5
   */
  cpu?: float64;

  /**
   * Required memory, e.g. "250Mb"
   */
  memory?: string;

  /**
   * Ephemeral Storage, e.g. "1Gi"
   */
  @visibility("read")
  ephemeralStorage?: string;
}

/**
 * Volume mount for the Container App.
 */
model VolumeMount {
  /**
   * This must match the Name of a Volume.
   */
  volumeName?: string;

  /**
   * Path within the container at which the volume should be mounted.Must not contain ':'.
   */
  mountPath?: string;

  /**
   * Path within the volume from which the container's volume should be mounted. Defaults to "" (volume's root).
   */
  subPath?: string;
}

/**
 * Container App container definition
 */
model Container extends BaseContainer {
  /**
   * List of probes for the container.
   */
  probes?: ContainerAppProbe[];
}

/**
 * Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic.
 */
model ContainerAppProbe {
  /**
   * Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. Maximum value is 10.
   */
  failureThreshold?: int32;

  /**
   * HTTPGet specifies the http request to perform.
   */
  httpGet?: ContainerAppProbeHttpGet;

  /**
   * Number of seconds after the container has started before liveness probes are initiated. Minimum value is 1. Maximum value is 60.
   */
  initialDelaySeconds?: int32;

  /**
   * How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1. Maximum value is 240.
   */
  periodSeconds?: int32;

  /**
   * Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1. Maximum value is 10.
   */
  successThreshold?: int32;

  /**
   * TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported.
   */
  tcpSocket?: ContainerAppProbeTcpSocket;

  /**
   * Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is an alpha field and requires enabling ProbeTerminationGracePeriod feature gate. Maximum value is 3600 seconds (1 hour)
   */
  terminationGracePeriodSeconds?: int64;

  /**
   * Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. Maximum value is 240.
   */
  timeoutSeconds?: int32;

  /**
   * The type of probe.
   */
  type?: Type;
}

/**
 * HTTPGet specifies the http request to perform.
 */
model ContainerAppProbeHttpGet {
  /**
   * Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
   */
  host?: string;

  /**
   * Custom headers to set in the request. HTTP allows repeated headers.
   */
  httpHeaders?: ContainerAppProbeHttpGetHttpHeadersItem[];

  /**
   * Path to access on the HTTP server.
   */
  path?: string;

  /**
   * Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
   */
  port: int32;

  /**
   * Scheme to use for connecting to the host. Defaults to HTTP.
   */
  scheme?: Scheme;
}

/**
 * HTTPHeader describes a custom header to be used in HTTP probes
 */
model ContainerAppProbeHttpGetHttpHeadersItem {
  /**
   * The header field name
   */
  name: string;

  /**
   * The header field value
   */
  value: string;
}

/**
 * TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported.
 */
model ContainerAppProbeTcpSocket {
  /**
   * Optional: Host name to connect to, defaults to the pod IP.
   */
  host?: string;

  /**
   * Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.
   */
  port: int32;
}

/**
 * Container App scaling configurations.
 */
model Scale {
  /**
   * Optional. Minimum number of container replicas.
   */
  minReplicas?: int32;

  /**
   * Optional. Maximum number of container replicas. Defaults to 10 if not set.
   */
  maxReplicas?: int32 = 10;

  /**
   * Scaling rules.
   */
  rules?: ScaleRule[];
}

/**
 * Container App container scaling rule.
 */
model ScaleRule {
  /**
   * Scale Rule Name
   */
  name?: string;

  /**
   * Azure Queue based scaling.
   */
  azureQueue?: QueueScaleRule;

  /**
   * Custom scale rule.
   */
  custom?: CustomScaleRule;

  /**
   * HTTP requests based scaling.
   */
  http?: HttpScaleRule;

  /**
   * Tcp requests based scaling.
   */
  tcp?: TcpScaleRule;
}

/**
 * Container App container Azure Queue based scaling rule.
 */
model QueueScaleRule {
  /**
   * Queue name.
   */
  queueName?: string;

  /**
   * Queue length.
   */
  queueLength?: int32;

  /**
   * Authentication secrets for the queue scale rule.
   */
  auth?: ScaleRuleAuth[];
}

/**
 * Auth Secrets for Scale Rule
 */
model ScaleRuleAuth {
  /**
   * Name of the secret from which to pull the auth params.
   */
  secretRef?: string;

  /**
   * Trigger Parameter that uses the secret
   */
  triggerParameter?: string;
}

/**
 * Container App container Custom scaling rule.
 */
model CustomScaleRule {
  /**
   * Type of the custom scale rule
   * eg: azure-servicebus, redis etc.
   */
  type?: string;

  /**
   * Metadata properties to describe custom scale rule.
   */
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  auth?: ScaleRuleAuth[];
}

/**
 * Container App container Http scaling rule.
 */
model HttpScaleRule {
  /**
   * Metadata properties to describe http scale rule.
   */
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  auth?: ScaleRuleAuth[];
}

/**
 * Container App container Tcp scaling rule.
 */
model TcpScaleRule {
  /**
   * Metadata properties to describe tcp scale rule.
   */
  metadata?: Record<string>;

  /**
   * Authentication secrets for the tcp scale rule.
   */
  auth?: ScaleRuleAuth[];
}

/**
 * Volume definitions for the Container App.
 */
model Volume {
  /**
   * Volume name.
   */
  name?: string;

  /**
   * Storage type for the volume. If not provided, use EmptyDir.
   */
  storageType?: StorageType;

  /**
   * Name of storage resource. No need to provide for EmptyDir and Secret.
   */
  storageName?: string;

  /**
   * List of secrets to be added in volume. If no secrets are provided, all secrets in collection will be added to volume.
   */
  secrets?: SecretVolumeItem[];

  /**
   * Mount options used while mounting the AzureFile. Must be a comma-separated string.
   */
  mountOptions?: string;
}

/**
 * Secret to be added to volume.
 */
model SecretVolumeItem {
  /**
   * Name of the Container App secret from which to pull the secret value.
   */
  secretRef?: string;

  /**
   * Path to project secret to. If no path is provided, path defaults to name of secret listed in secretRef.
   */
  path?: string;
}

/**
 * Configuration to bind a ContainerApp to a dev ContainerApp Service
 */
model ServiceBind {
  /**
   * Resource id of the target service
   */
  serviceId?: string;

  /**
   * Name of the service bind
   */
  name?: string;
}

/**
 * Custom domain analysis.
 */
model CustomHostnameAnalysisResult {
  /**
   * Host name that was analyzed
   */
  @visibility("read")
  hostName?: string;

  /**
   * <code>true</code> if hostname is already verified; otherwise, <code>false</code>.
   */
  @visibility("read")
  isHostnameAlreadyVerified?: boolean;

  /**
   * DNS verification test result.
   */
  @visibility("read")
  customDomainVerificationTest?: DnsVerificationTestResult;

  /**
   * Raw failure information if DNS verification fails.
   */
  @visibility("read")
  customDomainVerificationFailureInfo?: CustomHostnameAnalysisResultCustomDomainVerificationFailureInfo;

  /**
   * <code>true</code> if there is a conflict on the Container App's managed environment; otherwise, <code>false</code>.
   */
  @visibility("read")
  hasConflictOnManagedEnvironment?: boolean;

  /**
   * <code>true</code> if there is a conflict on the Container App's managed environment level custom domain; otherwise, <code>false</code>.
   */
  @visibility("read")
  conflictWithEnvironmentCustomDomain?: boolean;

  /**
   * Name of the conflicting Container App on the Managed Environment if it's within the same subscription.
   */
  @visibility("read")
  conflictingContainerAppResourceId?: string;

  /**
   * CName records visible for this hostname.
   */
  cNameRecords?: string[];

  /**
   * TXT records visible for this hostname.
   */
  txtRecords?: string[];

  /**
   * A records visible for this hostname.
   */
  aRecords?: string[];

  /**
   * Alternate CName records visible for this hostname.
   */
  alternateCNameRecords?: string[];

  /**
   * Alternate TXT records visible for this hostname.
   */
  alternateTxtRecords?: string[];
}

/**
 * Raw failure information if DNS verification fails.
 */
model CustomHostnameAnalysisResultCustomDomainVerificationFailureInfo {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  target?: string;

  /**
   * Details or the error
   */
  details?: CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem[];
}

/**
 * Detailed errors.
 */
model CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility("read")
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility("read")
  target?: string;
}

/**
 * Container App Secrets Collection ARM resource.
 */
model SecretsCollection {
  /**
   * Collection of resources.
   */
  value: ContainerAppSecret[];
}

/**
 * Container App Secret.
 */
model ContainerAppSecret {
  /**
   * Secret Name.
   */
  @visibility("read")
  name?: string;

  /**
   * Secret Value.
   */
  @visibility("read")
  value?: string;

  /**
   * Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
   */
  @visibility("read")
  identity?: string;

  /**
   * Azure Key Vault URL pointing to the secret referenced by the container app.
   */
  @visibility("read")
  keyVaultUrl?: string;
}

/**
 * Container App Auth Token.
 */
model ContainerAppAuthToken extends TrackedResource<{}> {
  /**
   * Container App auth token resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ContainerAppAuthTokenProperties;
}

/**
 * Container App auth token resource specific properties
 */
model ContainerAppAuthTokenProperties {
  /**
   * Auth token value.
   */
  @visibility("read")
  token?: string;

  /**
   * Token expiration date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

/**
 * Revision resource specific properties
 */
model RevisionProperties {
  /**
   * Timestamp describing when the revision was created
   * by controller
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Timestamp describing when the revision was last active. Only meaningful when revision is inactive
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActiveTime?: utcDateTime;

  /**
   * Fully qualified domain name of the revision
   */
  @visibility("read")
  fqdn?: string;

  /**
   * Container App Revision Template with all possible settings and the
   * defaults if user did not provide them. The defaults are populated
   * as they were at the creation time
   */
  @visibility("read")
  template?: Template;

  /**
   * Boolean describing if the Revision is Active
   */
  @visibility("read")
  active?: boolean;

  /**
   * Number of pods currently running for this revision
   */
  @visibility("read")
  replicas?: int32;

  /**
   * Traffic weight assigned to this revision
   */
  @visibility("read")
  trafficWeight?: int32;

  /**
   * Optional Field - Platform Error Message
   */
  @visibility("read")
  provisioningError?: string;

  /**
   * Current health State of the revision
   */
  @visibility("read")
  healthState?: RevisionHealthState;

  /**
   * Current provisioning State of the revision
   */
  @visibility("read")
  provisioningState?: RevisionProvisioningState;

  /**
   * Current running state of the revision
   */
  @visibility("read")
  runningState?: RevisionRunningState;
}

/**
 * Replica resource specific properties
 */
model ReplicaProperties {
  /**
   * Timestamp describing when the pod was created by controller
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Current running state of the replica
   */
  @visibility("read")
  runningState?: ContainerAppReplicaRunningState;

  /**
   * The details of replica current running state
   */
  @visibility("read")
  runningStateDetails?: string;

  /**
   * The containers collection under a replica.
   */
  containers?: ReplicaContainer[];

  /**
   * The init containers collection under a replica.
   */
  initContainers?: ReplicaContainer[];
}

/**
 * Container object under Container App Revision Replica.
 */
model ReplicaContainer {
  /**
   * The Name of the Container
   */
  name?: string;

  /**
   * The Id of the Container
   */
  containerId?: string;

  /**
   * The container ready status
   */
  ready?: boolean;

  /**
   * The container start status
   */
  started?: boolean;

  /**
   * The container restart count
   */
  restartCount?: int32;

  /**
   * Current running state of the container
   */
  @visibility("read")
  runningState?: ContainerAppContainerRunningState;

  /**
   * The details of container current running state
   */
  @visibility("read")
  runningStateDetails?: string;

  /**
   * Log Stream endpoint
   */
  @visibility("read")
  logStreamEndpoint?: string;

  /**
   * Container exec endpoint
   */
  @visibility("read")
  execEndpoint?: string;
}

/**
 * Diagnostics resource specific properties
 */
model DiagnosticsProperties {
  /**
   * Metadata of the diagnostics response.
   */
  metadata?: DiagnosticsDefinition;

  /**
   * Set of data collections associated with the response.
   */
  dataset?: DiagnosticsDataApiResponse[];

  /**
   * Status of the diagnostics response.
   */
  status?: DiagnosticsStatus;

  /**
   * List of data providers' metadata.
   */
  dataProviderMetadata?: DiagnosticDataProviderMetadata;
}

/**
 * Metadata of the diagnostics response
 */
model DiagnosticsDefinition {
  /**
   * Unique detector name
   */
  @visibility("read")
  id?: string;

  /**
   * Display Name of the detector
   */
  @visibility("read")
  name?: string;

  /**
   * Details of the diagnostics info
   */
  @visibility("read")
  description?: string;

  /**
   * Authors' names of the detector
   */
  @visibility("read")
  author?: string;

  /**
   * Category of the detector
   */
  @visibility("read")
  category?: string;

  /**
   * List of support topics
   */
  supportTopicList?: DiagnosticSupportTopic[];

  /**
   * List of analysis types
   */
  analysisTypes?: string[];

  /**
   * Authors' names of the detector
   */
  @visibility("read")
  type?: string;

  /**
   * Authors' names of the detector
   */
  @visibility("read")
  score?: float32;
}

/**
 * Support topic information
 */
model DiagnosticSupportTopic {
  /**
   * Unique topic identifier
   */
  @visibility("read")
  id?: string;

  /**
   * PES identifier
   */
  @visibility("read")
  pesId?: string;
}

/**
 * Diagnostics data returned from a detector
 */
model DiagnosticsDataApiResponse {
  /**
   * Table response
   */
  table?: DiagnosticDataTableResponseObject;

  /**
   * Details of the table response
   */
  renderingProperties?: DiagnosticRendering;
}

/**
 * Diagnostics data table
 */
model DiagnosticDataTableResponseObject {
  /**
   * Table name
   */
  tableName?: string;

  /**
   * Columns in the table
   */
  columns?: DiagnosticDataTableResponseColumn[];

  /**
   * Rows in the table
   */
  rows?: Record<unknown>[];
}

/**
 * Diagnostics data column
 */
model DiagnosticDataTableResponseColumn {
  /**
   * Column name
   */
  columnName?: string;

  /**
   * Data type of the column
   */
  dataType?: string;

  /**
   * Column type
   */
  columnType?: string;
}

/**
 * Rendering details of a diagnostics table
 */
model DiagnosticRendering {
  /**
   * Rendering type
   */
  type?: int32;

  /**
   * Title of the table
   */
  title?: string;

  /**
   * Description of the table
   */
  description?: string;

  /**
   * Flag if the table should be rendered
   */
  isVisible?: boolean;
}

/**
 * Rendering details of a diagnostics table
 */
model DiagnosticsStatus {
  /**
   * Diagnostic message
   */
  message?: string;

  /**
   * Status
   */
  statusId?: int32;
}

/**
 * Details of a diagnostics data provider
 */
model DiagnosticDataProviderMetadata {
  /**
   * Name of data provider
   */
  providerName?: string;

  /**
   * Collection of properties
   */
  propertyBag?: DiagnosticDataProviderMetadataPropertyBagItem[];
}

/**
 * Property details
 */
model DiagnosticDataProviderMetadataPropertyBagItem {
  /**
   * Property name
   */
  name?: string;

  /**
   * Property value
   */
  value?: string;
}

/**
 * Managed environment resource specific properties
 */
model ManagedEnvironmentProperties {
  /**
   * Provisioning state of the Environment.
   */
  @visibility("read")
  provisioningState?: EnvironmentProvisioningState;

  /**
   * Azure Monitor instrumentation key used by Dapr to export Service to Service communication telemetry
   */
  daprAIInstrumentationKey?: string;

  /**
   * Application Insights connection string used by Dapr to export Service to Service communication telemetry
   */
  daprAIConnectionString?: string;

  /**
   * Vnet configuration for the environment
   */
  vnetConfiguration?: VnetConfiguration;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility("read")
  deploymentErrors?: string;

  /**
   * Default Domain Name for the cluster
   */
  @visibility("read")
  defaultDomain?: string;

  /**
   * Static IP of the Environment
   */
  @visibility("read")
  staticIp?: string;

  /**
   * Cluster configuration which enables the log daemon to export
   * app logs to a destination. Currently only "log-analytics" is
   * supported
   */
  appLogsConfiguration?: AppLogsConfiguration;

  /**
   * Whether or not this Managed Environment is zone-redundant.
   */
  @visibility("read", "create")
  zoneRedundant?: boolean;

  /**
   * Custom domain configuration for the environment
   */
  customDomainConfiguration?: CustomDomainConfiguration;

  /**
   * The endpoint of the eventstream of the Environment.
   */
  @visibility("read")
  eventStreamEndpoint?: string;

  /**
   * Workload profiles configured for the Managed Environment.
   */
  workloadProfiles?: WorkloadProfile[];

  /**
   * The configuration of Keda component.
   */
  kedaConfiguration?: KedaConfiguration;

  /**
   * The configuration of Dapr component.
   */
  daprConfiguration?: DaprConfiguration;

  /**
   * Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. If a subnet ID is provided, this resource group will be created in the same subscription as the subnet.
   */
  @visibility("read", "create")
  infrastructureResourceGroup?: string;

  /**
   * Peer authentication settings for the Managed Environment
   */
  peerAuthentication?: ManagedEnvironmentPropertiesPeerAuthentication;
}

/**
 * Configuration properties for apps environment to join a Virtual Network
 */
model VnetConfiguration {
  /**
   * Boolean indicating the environment only has an internal load balancer. These environments do not have a public static IP resource. They must provide infrastructureSubnetId if enabling this property
   */
  @visibility("read", "create")
  internal?: boolean;

  /**
   * Resource ID of a subnet for infrastructure components. Must not overlap with any other provided IP ranges.
   */
  @visibility("read", "create")
  infrastructureSubnetId?: string;

  /**
   * CIDR notation IP range assigned to the Docker bridge, network. Must not overlap with any other provided IP ranges.
   */
  @visibility("read", "create")
  dockerBridgeCidr?: string;

  /**
   * IP range in CIDR notation that can be reserved for environment infrastructure IP addresses. Must not overlap with any other provided IP ranges.
   */
  @visibility("read", "create")
  platformReservedCidr?: string;

  /**
   *  An IP address from the IP range defined by platformReservedCidr that will be reserved for the internal DNS server.
   */
  @visibility("read", "create")
  platformReservedDnsIP?: string;
}

/**
 * Configuration of application logs
 */
model AppLogsConfiguration {
  /**
   * Logs destination, can be 'log-analytics', 'azure-monitor' or 'none'
   */
  destination?: string;

  /**
   * Log Analytics configuration, must only be provided when destination is configured as 'log-analytics'
   */
  logAnalyticsConfiguration?: LogAnalyticsConfiguration;
}

/**
 * Log Analytics configuration, must only be provided when destination is configured as 'log-analytics'
 */
model LogAnalyticsConfiguration {
  /**
   * Log analytics customer id
   */
  customerId?: string;

  /**
   * Log analytics customer key
   */
  @visibility("create", "update")
  sharedKey?: string;
}

/**
 * Workload profile to scope container app execution.
 */
model WorkloadProfile {
  /**
   * Workload profile type for the workloads to run on.
   */
  name: string;

  /**
   * Workload profile type for the workloads to run on.
   */
  workloadProfileType: string;

  /**
   * The minimum capacity.
   */
  minimumCount?: int32;

  /**
   * The maximum capacity.
   */
  maximumCount?: int32;
}

/**
 * Configuration properties Keda component
 */
model KedaConfiguration {
  /**
   * The version of Keda
   */
  @visibility("read")
  version?: string;
}

/**
 * Configuration properties Dapr component
 */
model DaprConfiguration {
  /**
   * The version of Dapr
   */
  @visibility("read")
  version?: string;
}

/**
 * Peer authentication settings for the Managed Environment
 */
model ManagedEnvironmentPropertiesPeerAuthentication {
  /**
   * Mutual TLS authentication settings for the Managed Environment
   */
  mtls?: Mtls;
}

/**
 * Configuration properties for mutual TLS authentication
 */
model Mtls {
  /**
   * Boolean indicating whether the mutual TLS authentication is enabled
   */
  @projectedName("json", "enabled")
  IsEnabled?: boolean;
}

/**
 * Operation detail payload
 */
model OperationDetail {
  /**
   * Name of the operation
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * Display of the operation
   */
  display?: OperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;
}

/**
 * Container Apps Job resource specific properties.
 */
model JobProperties {
  /**
   * Provisioning state of the Container Apps Job.
   */
  @visibility("read")
  provisioningState?: JobProvisioningState;

  /**
   * Resource ID of environment.
   */
  @visibility("read", "create")
  environmentId?: string;

  /**
   * Workload profile name to pin for container apps job execution.
   */
  workloadProfileName?: string;

  /**
   * Container Apps Job configuration properties.
   */
  configuration?: JobConfiguration;

  /**
   * Container Apps job definition.
   */
  template?: JobTemplate;

  /**
   * Outbound IP Addresses of a container apps job.
   */
  @visibility("read")
  outboundIpAddresses?: string[];

  /**
   * The endpoint of the eventstream of the container apps job.
   */
  @visibility("read")
  eventStreamEndpoint?: string;
}

/**
 * Non versioned Container Apps Job configuration properties
 */
model JobConfiguration {
  /**
   * Collection of secrets used by a Container Apps Job
   */
  secrets?: Secret[];

  /**
   * Trigger type of the job
   */
  triggerType: TriggerType = TriggerType.Manual;

  /**
   * Maximum number of seconds a replica is allowed to run.
   */
  replicaTimeout: int32;

  /**
   * Maximum number of retries before failing the job.
   */
  replicaRetryLimit?: int32;

  /**
   * Manual trigger configuration for a single execution job. Properties replicaCompletionCount and parallelism would be set to 1 by default
   */
  manualTriggerConfig?: JobConfigurationManualTriggerConfig;

  /**
   * Cron formatted repeating trigger schedule ("* * * * *") for cronjobs. Properties completions and parallelism would be set to 1 by default
   */
  scheduleTriggerConfig?: JobConfigurationScheduleTriggerConfig;

  /**
   * Trigger configuration of an event driven job.
   */
  eventTriggerConfig?: JobConfigurationEventTriggerConfig;

  /**
   * Collection of private container registry credentials used by a Container apps job
   */
  registries?: RegistryCredentials[];
}

/**
 * Manual trigger configuration for a single execution job. Properties replicaCompletionCount and parallelism would be set to 1 by default
 */
model JobConfigurationManualTriggerConfig {
  /**
   * Minimum number of successful replica completions before overall job completion.
   */
  replicaCompletionCount?: int32;

  /**
   * Number of parallel replicas of a job that can run at a given time.
   */
  parallelism?: int32;
}

/**
 * Cron formatted repeating trigger schedule ("* * * * *") for cronjobs. Properties completions and parallelism would be set to 1 by default
 */
model JobConfigurationScheduleTriggerConfig {
  /**
   * Minimum number of successful replica completions before overall job completion.
   */
  replicaCompletionCount?: int32;

  /**
   * Cron formatted repeating schedule ("* * * * *") of a Cron Job.
   */
  cronExpression: string;

  /**
   * Number of parallel replicas of a job that can run at a given time.
   */
  parallelism?: int32;
}

/**
 * Trigger configuration of an event driven job.
 */
model JobConfigurationEventTriggerConfig {
  /**
   * Minimum number of successful replica completions before overall job completion.
   */
  replicaCompletionCount?: int32;

  /**
   * Number of parallel replicas of a job that can run at a given time.
   */
  parallelism?: int32;

  /**
   * Scaling configurations for event driven jobs.
   */
  scale?: JobScale;
}

/**
 * Scaling configurations for event driven jobs.
 */
model JobScale {
  /**
   * Interval to check each event source in seconds. Defaults to 30s
   */
  pollingInterval?: int32;

  /**
   * Minimum number of job executions that are created for a trigger, default 0
   */
  minExecutions?: int32;

  /**
   * Maximum number of job executions that are created for a trigger, default 100.
   */
  maxExecutions?: int32 = 100;

  /**
   * Scaling rules.
   */
  rules?: JobScaleRule[];
}

/**
 * Scaling rule.
 */
model JobScaleRule {
  /**
   * Scale Rule Name
   */
  name?: string;

  /**
   * Type of the scale rule
   * eg: azure-servicebus, redis etc.
   */
  type?: string;

  /**
   * Metadata properties to describe the scale rule.
   */
  metadata?: Record<unknown>;

  /**
   * Authentication secrets for the scale rule.
   */
  auth?: ScaleRuleAuth[];
}

/**
 * Container Apps Job versioned application definition. Defines the desired state of an immutable revision. Any changes to this section Will result in a new revision being created
 */
model JobTemplate {
  /**
   * List of specialized containers that run before app containers.
   */
  initContainers?: InitContainer[];

  /**
   * List of container definitions for the Container App.
   */
  containers?: Container[];

  /**
   * List of volume definitions for the Container App.
   */
  volumes?: Volume[];
}

/**
 * Container Apps Job resource specific properties.
 */
model JobPatchProperties {
  /**
   * Managed identities needed by a container app job to interact with other Azure services to not maintain any secrets or credentials in code.
   */
  identity?: ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  properties?: JobPatchPropertiesProperties;
}

model JobPatchPropertiesProperties {
  /**
   * Resource ID of environment.
   */
  @visibility("read", "create", "update")
  environmentId?: string;

  /**
   * Container Apps Job configuration properties.
   */
  configuration?: JobConfiguration;

  /**
   * Container Apps job definition.
   */
  template?: JobTemplate;

  /**
   * Outbound IP Addresses of a container apps job.
   */
  outboundIpAddresses?: string[];

  /**
   * The endpoint of the eventstream of the container apps job.
   */
  eventStreamEndpoint?: string;
}

/**
 * Job's execution template, containing container configuration for a job's execution
 */
model JobExecutionTemplate {
  /**
   * List of container definitions for the Container Apps Job.
   */
  containers?: JobExecutionContainer[];

  /**
   * List of specialized containers that run before job containers.
   */
  initContainers?: JobExecutionContainer[];
}

/**
 * Container Apps Jobs execution container definition.
 */
model JobExecutionContainer {
  /**
   * Container image tag.
   */
  image?: string;

  /**
   * Custom container name.
   */
  name?: string;

  /**
   * Container start command.
   */
  command?: string[];

  /**
   * Container start command arguments.
   */
  args?: string[];

  /**
   * Container environment variables.
   */
  env?: EnvironmentVar[];

  /**
   * Container resource requirements.
   */
  resources?: ContainerResources;
}

/**
 * Container App's Job execution name.
 */
model JobExecutionBase {
  /**
   * Job execution name.
   */
  name?: string;

  /**
   * Job execution Id.
   */
  id?: string;
}

/**
 * Container Apps Job Secrets Collection ARM resource.
 */
model JobSecretsCollection {
  /**
   * Collection of resources.
   */
  value: Secret[];
}

/**
 * Collection of Environments
 */
model ManagedEnvironmentsCollection is Azure.Core.Page<ManagedEnvironment>;

/**
 * Certificate resource specific properties
 */
model ManagedCertificateProperties {
  /**
   * Provisioning state of the certificate.
   */
  @visibility("read")
  provisioningState?: CertificateProvisioningState;

  /**
   * Subject name of the certificate.
   */
  subjectName?: string;

  /**
   * Any error occurred during the certificate provision.
   */
  @visibility("read")
  error?: string;

  /**
   * Selected type of domain control validation for managed certificates.
   */
  domainControlValidation?: ManagedCertificateDomainControlValidation;

  /**
   * A TXT token used for DNS TXT domain control validation when issuing this type of managed certificates.
   */
  @visibility("read")
  validationToken?: string;
}

/**
 * A managed certificate to update
 */
model ManagedCertificatePatch {
  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  tags?: Record<string>;
}

/**
 * Environment Auth Token.
 */
model EnvironmentAuthToken extends TrackedResource<{}> {
  /**
   * Environment auth token resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: EnvironmentAuthTokenProperties;
}

/**
 * Environment auth token resource specific properties
 */
model EnvironmentAuthTokenProperties {
  /**
   * Auth token value.
   */
  @visibility("read")
  token?: string;

  /**
   * Token expiration date.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

/**
 * Collection of workloadProfileStates
 */
model WorkloadProfileStatesCollection is Azure.Core.Page<WorkloadProfileStates>;

/**
 * Collection of all the workload Profile States for a Managed Environment..
 */
model WorkloadProfileStates extends ProxyResource<{}> {
  /**
   * Workload Profile resource specific properties.
   */
  properties?: WorkloadProfileStatesProperties;
}

/**
 * Workload Profile resource specific properties.
 */
model WorkloadProfileStatesProperties {
  /**
   * Minimum count of instances.
   */
  minimumCount?: int32;

  /**
   * Maximum count of nodes.
   */
  maximumCount?: int32;

  /**
   * Current count of nodes.
   */
  currentCount?: int32;
}

/**
 * Storage properties
 */
model ManagedEnvironmentStorageProperties {
  /**
   * Azure file properties
   */
  azureFile?: AzureFileProperties;
}

/**
 * SourceControl resource specific properties
 */
model SourceControlProperties {
  /**
   * Current provisioning State of the operation
   */
  @visibility("read")
  operationState?: SourceControlOperationState;

  /**
   * The repo url which will be integrated to ContainerApp.
   */
  repoUrl?: string;

  /**
   * The branch which will trigger the auto deployment
   */
  branch?: string;

  /**
   * Container App Revision Template with all possible settings and the
   * defaults if user did not provide them. The defaults are populated
   * as they were at the creation time
   */
  githubActionConfiguration?: GithubActionConfiguration;
}

/**
 * Configuration properties that define the mutable settings of a Container App SourceControl
 */
model GithubActionConfiguration {
  /**
   * Registry configurations.
   */
  registryInfo?: RegistryInfo;

  /**
   * AzureCredentials configurations.
   */
  azureCredentials?: AzureCredentials;

  /**
   * Context path
   */
  contextPath?: string;

  /**
   * One time Github PAT to configure github environment
   */
  @visibility("create", "update")
  githubPersonalAccessToken?: string;

  /**
   * Image name
   */
  image?: string;

  /**
   * Code or Image
   */
  publishType?: string;

  /**
   * Operation system
   */
  os?: string;

  /**
   * Runtime stack
   */
  runtimeStack?: string;

  /**
   * Runtime version
   */
  runtimeVersion?: string;
}

/**
 * Container App registry information.
 */
model RegistryInfo {
  /**
   * registry server Url.
   */
  registryUrl?: string;

  /**
   * registry username.
   */
  registryUserName?: string;

  /**
   * registry secret.
   */
  @visibility("create", "update")
  registryPassword?: string;
}

/**
 * Container App credentials.
 */
model AzureCredentials {
  /**
   * Client Id.
   */
  @visibility("create", "update")
  clientId?: string;

  /**
   * Client Secret.
   */
  @visibility("create", "update")
  clientSecret?: string;

  /**
   * Tenant Id.
   */
  @visibility("create", "update")
  tenantId?: string;

  /**
   * Kind of auth github does for deploying the template
   */
  @visibility("create", "update")
  kind?: string;

  /**
   * Subscription Id.
   */
  subscriptionId?: string;
}

/**
 * Container App executions names list.
 */
model JobExecutionNamesCollection {
  /**
   * Collection of resources.
   */
  value: JobExecutionBase[];
}
