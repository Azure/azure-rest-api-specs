import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.App;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("indicates whether the profile is default for the location.")
enum Applicability {
  LocationDefault,
  Custom,
}

@doc("The type of extendedLocation.")
enum ExtendedLocationTypes {
  CustomLocation,
}

@doc("Provisioning state of the Kubernetes Environment.")
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

@doc("Provisioning state of the certificate.")
enum CertificateProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  DeleteFailed,
  Pending,
}

@doc("Access mode for storage")
enum AccessMode {
  ReadOnly,
  ReadWrite,
}

@doc("Type of managed service identity (where both SystemAssigned and UserAssigned types are allowed).")
enum ManagedServiceIdentityType {
  None,
  SystemAssigned,
  UserAssigned,
  `SystemAssigned,UserAssigned`,
}

@doc("Provisioning state of the Container App.")
enum ContainerAppProvisioningState {
  InProgress,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
}

@doc("""
ActiveRevisionsMode controls how active revisions are handled for the Container app:
<list><item>Multiple: multiple revisions can be active.</item><item>Single: Only one revision can be active at a time. Revision weights can not be used in this mode. If no value if provided, this is the default.</item></list>
""")
enum ActiveRevisionsMode {
  Multiple,
  Single,
}

@doc("Ingress transport protocol")
enum IngressTransportMethod {
  auto,
  http,
  http2,
  tcp,
}

@doc("Custom Domain binding type.")
enum BindingType {
  Disabled,
  SniEnabled,
}

@doc("Allow or Deny rules to determine for incoming IP. Note: Rules can only consist of ALL Allow or ALL Deny")
enum Action {
  Allow,
  Deny,
}

@doc("Sticky Session Affinity")
enum Affinity {
  sticky,
  none,
}

@doc("Client certificate mode for mTLS authentication. Ignore indicates server drops client certificate on forwarding. Accept indicates server forwards client certificate but does not require a client certificate. Require indicates server requires a client certificate.")
enum IngressClientCertificateMode {
  ignore,
  accept,
  require,
}

@doc("Tells Dapr which protocol your application is using. Valid options are http and grpc. Default is http")
enum AppProtocol {
  http,
  grpc,
}

@doc("Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.")
enum LogLevel {
  info,
  debug,
  warn,
  error,
}

@doc("Scheme to use for connecting to the host. Defaults to HTTP.")
enum Scheme {
  HTTP,
  HTTPS,
}

@doc("The type of probe.")
enum Type {
  Liveness,
  Readiness,
  Startup,
}

@doc("Storage type for the volume. If not provided, use EmptyDir.")
enum StorageType {
  AzureFile,
  EmptyDir,
  Secret,
}

@doc("Current health State of the revision")
enum RevisionHealthState {
  Healthy,
  Unhealthy,
  None,
}

@doc("Current provisioning State of the revision")
enum RevisionProvisioningState {
  Provisioning,
  Provisioned,
  Failed,
  Deprovisioning,
  Deprovisioned,
}

@doc("Current running state of the revision")
enum RevisionRunningState {
  Running,
  Processing,
  Stopped,
  Degraded,
  Failed,
  Unknown,
}

@doc("Current running state of the replica")
enum ContainerAppReplicaRunningState {
  Running,
  NotRunning,
  Unknown,
}

@doc("Current running state of the container")
enum ContainerAppContainerRunningState {
  Running,
  Terminated,
  Waiting,
}

@doc("Provisioning state of the Environment.")
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

@doc("Provisioning state of the Container Apps Job.")
enum JobProvisioningState {
  InProgress,
  Succeeded,
  Failed,
  Canceled,
  Deleting,
}

@doc("Trigger type of the job")
enum TriggerType {
  Schedule,
  Event,
  Manual,
}

@doc("Current running State of the job")
enum JobExecutionRunningState {
  Running,
  Processing,
  Stopped,
  Degraded,
  Failed,
  Unknown,
  Succeeded,
}

@doc("Selected type of domain control validation for managed certificates.")
enum ManagedCertificateDomainControlValidation {
  CNAME,
  HTTP,
  TXT,
}

@doc("Current provisioning State of the operation")
enum SourceControlOperationState {
  InProgress,
  Succeeded,
  Failed,
  Canceled,
}

@doc("The action to take when an unauthenticated client attempts to access the app.")
@fixed
enum UnauthenticatedClientActionV2 {
  RedirectToLoginPage,
  AllowAnonymous,
  Return401,
  Return403,
}

@doc("The convention used when determining the session cookie's expiration.")
@fixed
enum CookieExpirationConvention {
  FixedTime,
  IdentityProviderDerived,
}

@doc("The convention used to determine the url of the request made.")
@fixed
enum ForwardProxyConvention {
  NoProxy,
  Standard,
  Custom,
}

@doc("DNS verification test result.")
@fixed
enum DnsVerificationTestResult {
  Passed,
  Failed,
  Skipped,
}

@doc("AuthConfig resource specific properties")
model AuthConfigProperties {
  @doc("The configuration settings of the platform of ContainerApp Service Authentication/Authorization.")
  platform?: AuthPlatform;

  @doc("The configuration settings that determines the validation flow of users using  Service Authentication/Authorization.")
  globalValidation?: GlobalValidation;

  @doc("The configuration settings of each of the identity providers used to configure ContainerApp Service Authentication/Authorization.")
  identityProviders?: IdentityProviders;

  @doc("The configuration settings of the login flow of users using ContainerApp Service Authentication/Authorization.")
  login?: Login;

  @doc("The configuration settings of the HTTP requests for authentication and authorization requests made against ContainerApp Service Authentication/Authorization.")
  httpSettings?: HttpSettings;
}

@doc("The configuration settings of the platform of ContainerApp Service Authentication/Authorization.")
model AuthPlatform {
  @doc("<code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("""
The RuntimeVersion of the Authentication / Authorization feature in use for the current app.
The setting in this value can control the behavior of certain features in the Authentication / Authorization module.
""")
  runtimeVersion?: string;
}

@doc("The configuration settings that determines the validation flow of users using ContainerApp Service Authentication/Authorization.")
model GlobalValidation {
  @doc("The action to take when an unauthenticated client attempts to access the app.")
  unauthenticatedClientAction?: UnauthenticatedClientActionV2;

  @doc("""
The default authentication provider to use when multiple providers are configured.
This setting is only needed if multiple providers are configured and the unauthenticated client
action is set to \"RedirectToLoginPage\".
""")
  redirectToProvider?: string;

  @doc("The paths for which unauthenticated flow would not be redirected to the login page.")
  excludedPaths?: string[];
}

@doc("The configuration settings of each of the identity providers used to configure ContainerApp Service Authentication/Authorization.")
model IdentityProviders {
  @doc("The configuration settings of the Azure Active directory provider.")
  azureActiveDirectory?: AzureActiveDirectory;

  @doc("The configuration settings of the Facebook provider.")
  facebook?: Facebook;

  @doc("The configuration settings of the GitHub provider.")
  gitHub?: GitHub;

  @doc("The configuration settings of the Google provider.")
  google?: Google;

  @doc("The configuration settings of the Twitter provider.")
  twitter?: Twitter;

  @doc("The configuration settings of the Apple provider.")
  apple?: Apple;

  @doc("The configuration settings of the Azure Static Web Apps provider.")
  azureStaticWebApps?: AzureStaticWebApps;

  @doc("""
The map of the name of the alias of each custom Open ID Connect provider to the
configuration settings of the custom Open ID Connect provider.
""")
  customOpenIdConnectProviders?: Record<CustomOpenIdConnectProvider>;
}

@doc("The configuration settings of the Azure Active directory provider.")
model AzureActiveDirectory {
  @doc("<code>false</code> if the Azure Active Directory provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the Azure Active Directory app registration.")
  registration?: AzureActiveDirectoryRegistration;

  @doc("The configuration settings of the Azure Active Directory login flow.")
  login?: AzureActiveDirectoryLogin;

  @doc("The configuration settings of the Azure Active Directory token validation flow.")
  validation?: AzureActiveDirectoryValidation;

  @doc("""
Gets a value indicating whether the Azure AD configuration was auto-provisioned using 1st party tooling.
This is an internal flag primarily intended to support the Azure Management Portal. Users should not
read or write to this property.
""")
  isAutoProvisioned?: boolean;
}

@doc("The configuration settings of the Azure Active Directory app registration.")
model AzureActiveDirectoryRegistration {
  @doc("""
The OpenID Connect Issuer URI that represents the entity which issues access tokens for this application.
When using Azure Active Directory, this value is the URI of the directory tenant, e.g. https://login.microsoftonline.com/v2.0/{tenant-guid}/.
This URI is a case-sensitive identifier for the token issuer.
More information on OpenID Connect Discovery: http://openid.net/specs/openid-connect-discovery-1_0.html
""")
  openIdIssuer?: string;

  @doc("""
The Client ID of this relying party application, known as the client_id.
This setting is required for enabling OpenID Connection authentication with Azure Active Directory or 
other 3rd party OpenID Connect providers.
More information on OpenID Connect: http://openid.net/specs/openid-connect-core-1_0.html
""")
  clientId?: string;

  @doc("The app setting name that contains the client secret of the relying party application.")
  clientSecretSettingName?: string;

  @doc("""
An alternative to the client secret, that is the thumbprint of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret. It is also optional.
""")
  clientSecretCertificateThumbprint?: string;

  @doc("""
An alternative to the client secret thumbprint, that is the subject alternative name of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret Certificate Thumbprint. It is also optional.
""")
  clientSecretCertificateSubjectAlternativeName?: string;

  @doc("""
An alternative to the client secret thumbprint, that is the issuer of a certificate used for signing purposes. This property acts as
a replacement for the Client Secret Certificate Thumbprint. It is also optional.
""")
  clientSecretCertificateIssuer?: string;
}

@doc("The configuration settings of the Azure Active Directory login flow.")
model AzureActiveDirectoryLogin {
  @doc("""
Login parameters to send to the OpenID Connect authorization endpoint when
a user logs in. Each parameter must be in the form \"key=value\".
""")
  loginParameters?: string[];

  @doc("<code>true</code> if the www-authenticate provider should be omitted from the request; otherwise, <code>false</code>.")
  disableWWWAuthenticate?: boolean;
}

@doc("The configuration settings of the Azure Active Directory token validation flow.")
model AzureActiveDirectoryValidation {
  @doc("The configuration settings of the checks that should be made while validating the JWT Claims.")
  jwtClaimChecks?: JwtClaimChecks;

  @doc("The list of audiences that can make successful authentication/authorization requests.")
  allowedAudiences?: string[];

  @doc("The configuration settings of the default authorization policy.")
  defaultAuthorizationPolicy?: DefaultAuthorizationPolicy;
}

@doc("The configuration settings of the checks that should be made while validating the JWT Claims.")
model JwtClaimChecks {
  @doc("The list of the allowed groups.")
  allowedGroups?: string[];

  @doc("The list of the allowed client applications.")
  allowedClientApplications?: string[];
}

@doc("The configuration settings of the Azure Active Directory default authorization policy.")
model DefaultAuthorizationPolicy {
  @doc("The configuration settings of the Azure Active Directory allowed principals.")
  allowedPrincipals?: AllowedPrincipals;

  @doc("The configuration settings of the Azure Active Directory allowed applications.")
  allowedApplications?: string[];
}

@doc("The configuration settings of the Azure Active Directory allowed principals.")
model AllowedPrincipals {
  @doc("The list of the allowed groups.")
  groups?: string[];

  @doc("The list of the allowed identities.")
  identities?: string[];
}

@doc("The configuration settings of the Facebook provider.")
model Facebook {
  @doc("<code>false</code> if the Facebook provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the app registration for the Facebook provider.")
  registration?: AppRegistration;

  @doc("The version of the Facebook api to be used while logging in.")
  graphApiVersion?: string;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;
}

@doc("The configuration settings of the app registration for providers that have app ids and app secrets")
model AppRegistration {
  @doc("The App ID of the app used for login.")
  appId?: string;

  @doc("The app setting name that contains the app secret.")
  appSecretSettingName?: string;
}

@doc("The configuration settings of the login flow, including the scopes that should be requested.")
model LoginScopes {
  @doc("A list of the scopes that should be requested while authenticating.")
  scopes?: string[];
}

@doc("The configuration settings of the GitHub provider.")
model GitHub {
  @doc("<code>false</code> if the GitHub provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the app registration for the GitHub provider.")
  registration?: ClientRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;
}

@doc("The configuration settings of the app registration for providers that have client ids and client secrets")
model ClientRegistration {
  @doc("The Client ID of the app used for login.")
  clientId?: string;

  @doc("The app setting name that contains the client secret.")
  clientSecretSettingName?: string;
}

@doc("The configuration settings of the Google provider.")
model Google {
  @doc("<code>false</code> if the Google provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the app registration for the Google provider.")
  registration?: ClientRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;

  @doc("The configuration settings of the Azure Active Directory token validation flow.")
  validation?: AllowedAudiencesValidation;
}

@doc("The configuration settings of the Allowed Audiences validation flow.")
model AllowedAudiencesValidation {
  @doc("The configuration settings of the allowed list of audiences from which to validate the JWT token.")
  allowedAudiences?: string[];
}

@doc("The configuration settings of the Twitter provider.")
model Twitter {
  @doc("<code>false</code> if the Twitter provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the app registration for the Twitter provider.")
  registration?: TwitterRegistration;
}

@doc("The configuration settings of the app registration for the Twitter provider.")
model TwitterRegistration {
  @doc("""
The OAuth 1.0a consumer key of the Twitter application used for sign-in.
This setting is required for enabling Twitter Sign-In.
Twitter Sign-In documentation: https://dev.twitter.com/web/sign-in
""")
  consumerKey?: string;

  @doc("""
The app setting name that contains the OAuth 1.0a consumer secret of the Twitter
application used for sign-in.
""")
  consumerSecretSettingName?: string;
}

@doc("The configuration settings of the Apple provider.")
model Apple {
  @doc("<code>false</code> if the Apple provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the Apple registration.")
  registration?: AppleRegistration;

  @doc("The configuration settings of the login flow.")
  login?: LoginScopes;
}

@doc("The configuration settings of the registration for the Apple provider")
model AppleRegistration {
  @doc("The Client ID of the app used for login.")
  clientId?: string;

  @doc("The app setting name that contains the client secret.")
  clientSecretSettingName?: string;
}

@doc("The configuration settings of the Azure Static Web Apps provider.")
model AzureStaticWebApps {
  @doc("<code>false</code> if the Azure Static Web Apps provider should not be enabled despite the set registration; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the Azure Static Web Apps registration.")
  registration?: AzureStaticWebAppsRegistration;
}

@doc("The configuration settings of the registration for the Azure Static Web Apps provider")
model AzureStaticWebAppsRegistration {
  @doc("The Client ID of the app used for login.")
  clientId?: string;
}

@doc("The configuration settings of the custom Open ID Connect provider.")
model CustomOpenIdConnectProvider {
  @doc("<code>false</code> if the custom Open ID provider provider should not be enabled; otherwise, <code>true</code>.")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("The configuration settings of the app registration for the custom Open ID Connect provider.")
  registration?: OpenIdConnectRegistration;

  @doc("The configuration settings of the login flow of the custom Open ID Connect provider.")
  login?: OpenIdConnectLogin;
}

@doc("The configuration settings of the app registration for the custom Open ID Connect provider.")
model OpenIdConnectRegistration {
  @doc("The client id of the custom Open ID Connect provider.")
  clientId?: string;

  @doc("The authentication credentials of the custom Open ID Connect provider.")
  clientCredential?: OpenIdConnectClientCredential;

  @doc("The configuration settings of the endpoints used for the custom Open ID Connect provider.")
  openIdConnectConfiguration?: OpenIdConnectConfig;
}

@doc("The authentication client credentials of the custom Open ID Connect provider.")
model OpenIdConnectClientCredential {
  @doc("The method that should be used to authenticate the user.")
  method?: "ClientSecretPost";

  @doc("The app setting that contains the client secret for the custom Open ID Connect provider.")
  clientSecretSettingName?: string;
}

@doc("The configuration settings of the endpoints used for the custom Open ID Connect provider.")
model OpenIdConnectConfig {
  @doc("The endpoint to be used to make an authorization request.")
  authorizationEndpoint?: string;

  @doc("The endpoint to be used to request a token.")
  tokenEndpoint?: string;

  @doc("The endpoint that issues the token.")
  issuer?: string;

  @doc("The endpoint that provides the keys necessary to validate the token.")
  certificationUri?: string;

  @doc("The endpoint that contains all the configuration endpoints for the provider.")
  wellKnownOpenIdConfiguration?: string;
}

@doc("The configuration settings of the login flow of the custom Open ID Connect provider.")
model OpenIdConnectLogin {
  @doc("The name of the claim that contains the users name.")
  nameClaimType?: string;

  @doc("A list of the scopes that should be requested while authenticating.")
  scopes?: string[];
}

@doc("The configuration settings of the login flow of users using ContainerApp Service Authentication/Authorization.")
model Login {
  @doc("The routes that specify the endpoints used for login and logout requests.")
  routes?: LoginRoutes;

  @doc("<code>true</code> if the fragments from the request are preserved after the login request is made; otherwise, <code>false</code>.")
  preserveUrlFragmentsForLogins?: boolean;

  @doc("""
External URLs that can be redirected to as part of logging in or logging out of the app. Note that the query string part of the URL is ignored.
This is an advanced setting typically only needed by Windows Store application backends.
Note that URLs within the current domain are always implicitly allowed.
""")
  allowedExternalRedirectUrls?: string[];

  @doc("The configuration settings of the session cookie's expiration.")
  cookieExpiration?: CookieExpiration;

  @doc("The configuration settings of the nonce used in the login flow.")
  nonce?: Nonce;
}

@doc("The routes that specify the endpoints used for login and logout requests.")
model LoginRoutes {
  @doc("The endpoint at which a logout request should be made.")
  logoutEndpoint?: string;
}

@doc("The configuration settings of the session cookie's expiration.")
model CookieExpiration {
  @doc("The convention used when determining the session cookie's expiration.")
  convention?: CookieExpirationConvention;

  @doc("The time after the request is made when the session cookie should expire.")
  timeToExpiration?: string;
}

@doc("The configuration settings of the nonce used in the login flow.")
model Nonce {
  @doc("<code>false</code> if the nonce should not be validated while completing the login flow; otherwise, <code>true</code>.")
  validateNonce?: boolean;

  @doc("The time after the request is made when the nonce should expire.")
  nonceExpirationInterval?: string;
}

@doc("The configuration settings of the HTTP requests for authentication and authorization requests made against ContainerApp Service Authentication/Authorization.")
model HttpSettings {
  @doc("<code>false</code> if the authentication/authorization responses not having the HTTPS scheme are permissible; otherwise, <code>true</code>.")
  requireHttps?: boolean;

  @doc("The configuration settings of the paths HTTP requests.")
  routes?: HttpSettingsRoutes;

  @doc("The configuration settings of a forward proxy used to make the requests.")
  forwardProxy?: ForwardProxy;
}

@doc("The configuration settings of the paths HTTP requests.")
model HttpSettingsRoutes {
  @doc("The prefix that should precede all the authentication/authorization paths.")
  apiPrefix?: string;
}

@doc("The configuration settings of a forward proxy used to make the requests.")
model ForwardProxy {
  @doc("The convention used to determine the url of the request made.")
  convention?: ForwardProxyConvention;

  @doc("The name of the header containing the host of the request.")
  customHostHeaderName?: string;

  @doc("The name of the header containing the scheme of the request.")
  customProtoHeaderName?: string;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("App Service error response.")
@error
model DefaultErrorResponse {
  @doc("Error model.")
  @visibility("read")
  error?: DefaultErrorResponseError;
}

@doc("Error model.")
model DefaultErrorResponseError {
  @doc("Standardized string to programmatically identify the error.")
  @visibility("read")
  code?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  message?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  target?: string;

  @doc("Details or the error")
  details?: DefaultErrorResponseErrorDetailsItem[];

  @doc("More information to debug error.")
  @visibility("read")
  innererror?: string;
}

@doc("Detailed errors.")
model DefaultErrorResponseErrorDetailsItem {
  @doc("Standardized string to programmatically identify the error.")
  @visibility("read")
  code?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  message?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  target?: string;
}

@doc("Collection of available workload profiles in the location.")
model AvailableWorkloadProfilesCollection
  is Azure.Core.Page<AvailableWorkloadProfile>;

@doc("A workload profile with specific hardware configure to run container apps.")
model AvailableWorkloadProfile extends ProxyResource {
  @doc("Region of the workload profile.")
  location?: string;

  @doc("Revision resource specific properties")
  properties?: AvailableWorkloadProfileProperties;
}

@doc("Revision resource specific properties")
model AvailableWorkloadProfileProperties {
  @doc("Used to categorize workload profiles.")
  category?: string;

  @doc("indicates whether the profile is default for the location.")
  applicability?: Applicability;

  @doc("Number of cores in CPU.")
  cores?: int32;

  @doc("Memory in GiB.")
  memoryGiB?: int32;

  @doc("The everyday name of the workload profile.")
  displayName?: string;
}

@doc("Collection of billing meters.")
model BillingMeterCollection {
  @doc("Collection of billing meters.")
  value: BillingMeter[];
}

@doc("Billing meter.")
model BillingMeter extends ProxyResource {
  @doc("Region for the billing meter.")
  location?: string;

  @doc("Revision resource specific properties")
  properties?: BillingMeterProperties;
}

@doc("Revision resource specific properties")
model BillingMeterProperties {
  @doc("Used to categorize billing meters.")
  category?: string;

  @doc("Billing meter type.")
  meterType?: string;

  @doc("The everyday name of the billing meter.")
  displayName?: string;
}

@doc("The complex type of the extended location.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name?: string;

  @doc("The type of the extended location.")
  type?: ExtendedLocationTypes;
}

@doc("ConnectedEnvironment resource specific properties")
model ConnectedEnvironmentProperties {
  @doc("Provisioning state of the Kubernetes Environment.")
  @visibility("read")
  provisioningState?: ConnectedEnvironmentProvisioningState;

  @doc("Any errors that occurred during deployment or deployment validation")
  @visibility("read")
  deploymentErrors?: string;

  @doc("Default Domain Name for the cluster")
  @visibility("read")
  defaultDomain?: string;

  @doc("Static IP of the connectedEnvironment")
  staticIp?: string;

  @doc("Application Insights connection string used by Dapr to export Service to Service communication telemetry")
  daprAIConnectionString?: string;

  @doc("Custom domain configuration for the environment")
  customDomainConfiguration?: CustomDomainConfiguration;
}

@doc("Configuration properties for apps environment custom domain")
model CustomDomainConfiguration {
  @doc("Id used to verify domain name ownership")
  @visibility("read")
  customDomainVerificationId?: string;

  @doc("Dns suffix for the environment domain")
  @visibility("read", "create")
  dnsSuffix?: string;

  @doc("PFX or PEM blob")
  certificateValue?: bytes;

  @doc("Certificate password")
  certificatePassword?: string;

  @doc("Certificate expiration date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Certificate thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Subject name of the certificate.")
  @visibility("read")
  subjectName?: string;
}

@doc("The check availability request body.")
model CheckNameAvailabilityRequest {
  @doc("The name of the resource for which availability needs to be checked.")
  name?: string;

  @doc("The resource type.")
  type?: string;
}

@doc("The check availability result.")
model CheckNameAvailabilityResponse {
  @doc("Indicates if the resource name is available.")
  nameAvailable?: boolean;

  @doc("The reason why the given name is not available.")
  reason?: CheckNameAvailabilityReason;

  @doc("Detailed reason why the given name is available.")
  message?: string;
}

@doc("Certificate resource specific properties")
model CertificateProperties {
  @doc("Provisioning state of the certificate.")
  @visibility("read")
  provisioningState?: CertificateProvisioningState;

  @doc("Certificate password.")
  @visibility("create")
  password?: string;

  @doc("Subject name of the certificate.")
  @visibility("read")
  subjectName?: string;

  @doc("Subject alternative names the certificate applies to.")
  @visibility("read")
  subjectAlternativeNames?: string[];

  @doc("PFX or PEM blob")
  @visibility("create")
  value?: bytes;

  @doc("Certificate issuer.")
  @visibility("read")
  issuer?: string;

  @doc("Certificate issue Date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  @doc("Certificate expiration date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  @doc("Certificate thumbprint.")
  @visibility("read")
  thumbprint?: string;

  @doc("Is the certificate valid?.")
  @visibility("read")
  valid?: boolean;

  @doc("Public key hash.")
  @visibility("read")
  publicKeyHash?: string;
}

@doc("A certificate to update")
model CertificatePatch {
  @doc("Application-specific metadata in the form of key-value pairs.")
  tags?: Record<string>;
}

@doc("Dapr Component resource specific properties")
model DaprComponentProperties {
  @doc("Component type")
  componentType?: string;

  @doc("Component version")
  version?: string;

  @doc("Boolean describing if the component errors are ignores")
  ignoreErrors?: boolean;

  @doc("Initialization timeout")
  initTimeout?: string;

  @doc("Collection of secrets used by a Dapr component")
  secrets?: Secret[];

  @doc("Name of a Dapr component to retrieve component secrets from")
  secretStoreComponent?: string;

  @doc("Component metadata")
  metadata?: DaprMetadata[];

  @doc("Names of container apps that can use this Dapr component")
  scopes?: string[];
}

@doc("Secret definition.")
model Secret {
  @doc("Secret Name.")
  name?: string;

  @doc("Secret Value.")
  @visibility("create", "update")
  value?: string;

  @doc("Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.")
  identity?: string;

  @doc("Azure Key Vault URL pointing to the secret referenced by the container app.")
  keyVaultUrl?: string;
}

@doc("Dapr component metadata.")
model DaprMetadata {
  @doc("Metadata property name.")
  name?: string;

  @doc("Metadata property value.")
  value?: string;

  @doc("Name of the Dapr Component secret from which to pull the metadata property value.")
  secretRef?: string;
}

@doc("Dapr component Secrets Collection for ListSecrets Action.")
model DaprSecretsCollection {
  @doc("Collection of secrets used by a Dapr component")
  value: DaprSecret[];
}

@doc("Dapr component Secret for ListSecrets Action")
model DaprSecret {
  @doc("Secret Name.")
  @visibility("read")
  name?: string;

  @doc("Secret Value.")
  @visibility("read")
  value?: string;
}

@doc("Storage properties")
model ConnectedEnvironmentStorageProperties {
  @doc("Azure file properties")
  azureFile?: AzureFileProperties;
}

@doc("Azure File Properties.")
model AzureFileProperties {
  @doc("Storage account name for azure file.")
  accountName?: string;

  @doc("Storage account key for azure file.")
  accountKey?: string;

  @doc("Access mode for storage")
  accessMode?: AccessMode;

  @doc("Azure file share name.")
  shareName?: string;
}

@doc("ContainerApp resource specific properties")
model ContainerAppProperties {
  @doc("Provisioning state of the Container App.")
  @visibility("read")
  provisioningState?: ContainerAppProvisioningState;

  @doc("Deprecated. Resource ID of the Container App's environment.")
  @visibility("read", "create")
  managedEnvironmentId?: string;

  @doc("Resource ID of environment.")
  @visibility("read", "create")
  environmentId?: string;

  @doc("Workload profile name to pin for container app execution.")
  workloadProfileName?: string;

  @doc("Name of the latest revision of the Container App.")
  @visibility("read")
  latestRevisionName?: string;

  @doc("Name of the latest ready revision of the Container App.")
  @visibility("read")
  latestReadyRevisionName?: string;

  @doc("Fully Qualified Domain Name of the latest revision of the Container App.")
  @visibility("read")
  latestRevisionFqdn?: string;

  @doc("Id used to verify domain name ownership")
  @visibility("read")
  customDomainVerificationId?: string;

  @doc("Non versioned Container App configuration properties.")
  configuration?: Configuration;

  @doc("Container App versioned application definition.")
  template?: Template;

  @doc("Outbound IP Addresses for container app.")
  @visibility("read")
  outboundIpAddresses?: string[];

  @doc("The endpoint of the eventstream of the container app.")
  @visibility("read")
  eventStreamEndpoint?: string;
}

@doc("Non versioned Container App configuration properties that define the mutable settings of a Container app")
model Configuration {
  @doc("Collection of secrets used by a Container app")
  secrets?: Secret[];

  @doc("""
ActiveRevisionsMode controls how active revisions are handled for the Container app:
<list><item>Multiple: multiple revisions can be active.</item><item>Single: Only one revision can be active at a time. Revision weights can not be used in this mode. If no value if provided, this is the default.</item></list>
""")
  activeRevisionsMode?: ActiveRevisionsMode;

  @doc("Ingress configurations.")
  ingress?: Ingress;

  @doc("Collection of private container registry credentials for containers used by the Container app")
  registries?: RegistryCredentials[];

  @doc("Dapr configuration for the Container App.")
  dapr?: Dapr;

  @doc("Optional. Max inactive revisions a Container App can have.")
  maxInactiveRevisions?: int32;

  @doc("Container App to be a dev Container App Service")
  service?: Service;
}

@doc("Container App Ingress configuration.")
model Ingress {
  @doc("Hostname.")
  @visibility("read")
  fqdn?: string;

  @doc("Bool indicating if app exposes an external http endpoint")
  external?: boolean;

  @doc("Target Port in containers for traffic from ingress")
  targetPort?: int32;

  @doc("Exposed Port in containers for TCP traffic from ingress")
  exposedPort?: int32;

  @doc("Ingress transport protocol")
  transport?: IngressTransportMethod;

  @doc("Traffic weights for app's revisions")
  traffic?: TrafficWeight[];

  @doc("custom domain bindings for Container Apps' hostnames.")
  customDomains?: CustomDomain[];

  @doc("Bool indicating if HTTP connections to is allowed. If set to false HTTP connections are automatically redirected to HTTPS connections")
  allowInsecure?: boolean;

  @doc("Rules to restrict incoming IP address.")
  ipSecurityRestrictions?: IpSecurityRestrictionRule[];

  @doc("Sticky Sessions for Single Revision Mode")
  stickySessions?: IngressStickySessions;

  @doc("Client certificate mode for mTLS authentication. Ignore indicates server drops client certificate on forwarding. Accept indicates server forwards client certificate but does not require a client certificate. Require indicates server requires a client certificate.")
  clientCertificateMode?: IngressClientCertificateMode;

  @doc("CORS policy for container app")
  corsPolicy?: CorsPolicy;
}

@doc("Traffic weight assigned to a revision")
model TrafficWeight {
  @doc("Name of a revision")
  revisionName?: string;

  @doc("Traffic weight assigned to a revision")
  weight?: int32;

  @doc("Indicates that the traffic weight belongs to a latest stable revision")
  latestRevision?: boolean;

  @doc("Associates a traffic label with a revision")
  label?: string;
}

@doc("Custom Domain of a Container App")
model CustomDomain {
  @doc("Hostname.")
  name: string;

  @doc("Custom Domain binding type.")
  bindingType?: BindingType;

  @doc("Resource Id of the Certificate to be bound to this hostname. Must exist in the Managed Environment.")
  certificateId?: string;
}

@doc("Rule to restrict incoming IP address.")
model IpSecurityRestrictionRule {
  @doc("Name for the IP restriction rule.")
  name: string;

  @doc("Describe the IP restriction rule that is being sent to the container-app. This is an optional field.")
  description?: string;

  @doc("CIDR notation to match incoming IP address")
  ipAddressRange: string;

  @doc("Allow or Deny rules to determine for incoming IP. Note: Rules can only consist of ALL Allow or ALL Deny")
  action: Action;
}

@doc("Sticky Sessions for Single Revision Mode")
model IngressStickySessions {
  @doc("Sticky Session Affinity")
  affinity?: Affinity;
}

@doc("Cross-Origin-Resource-Sharing policy")
model CorsPolicy {
  @doc("Specifies the content for the access-control-allow-origins header")
  allowedOrigins: string[];

  @doc("Specifies the content for the access-control-allow-methods header")
  allowedMethods?: string[];

  @doc("Specifies the content for the access-control-allow-headers header")
  allowedHeaders?: string[];

  @doc("Specifies the content for the access-control-expose-headers header ")
  exposeHeaders?: string[];

  @doc("Specifies the content for the access-control-max-age header")
  maxAge?: int32;

  @doc("Specifies whether the resource allows credentials")
  allowCredentials?: boolean;
}

@doc("Container App Private Registry")
model RegistryCredentials {
  @doc("Container Registry Server")
  server?: string;

  @doc("Container Registry Username")
  username?: string;

  @doc("The name of the Secret that contains the registry login password")
  passwordSecretRef?: string;

  @doc("A Managed Identity to use to authenticate with Azure Container Registry. For user-assigned identities, use the full user-assigned identity Resource ID. For system-assigned identities, use 'system'")
  identity?: string;
}

@doc("Container App Dapr configuration.")
model Dapr {
  @doc("Boolean indicating if the Dapr side car is enabled")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;

  @doc("Dapr application identifier")
  appId?: string;

  @doc("Tells Dapr which protocol your application is using. Valid options are http and grpc. Default is http")
  appProtocol?: AppProtocol;

  @doc("Tells Dapr which port your application is listening on")
  appPort?: int32;

  @doc("Dapr max size of http header read buffer in KB to handle when sending multi-KB headers. Default is 65KB.")
  httpReadBufferSize?: int32;

  @doc("Increasing max size of request body http and grpc servers parameter in MB to handle uploading of big files. Default is 4 MB.")
  httpMaxRequestSize?: int32;

  @doc("Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.")
  logLevel?: LogLevel;

  @doc("Enables API logging for the Dapr sidecar")
  enableApiLogging?: boolean;
}

@doc("Container App to be a dev service")
model Service {
  @doc("Dev ContainerApp service type")
  type: string;
}

@doc("""
Container App versioned application definition.
Defines the desired state of an immutable revision.
Any changes to this section Will result in a new revision being created
""")
model Template {
  @doc("User friendly suffix that is appended to the revision name")
  revisionSuffix?: string;

  @doc("Optional duration in seconds the Container App Instance needs to terminate gracefully. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). If this value is nil, the default grace period will be used instead. Set this value longer than the expected cleanup time for your process. Defaults to 30 seconds.")
  terminationGracePeriodSeconds?: int32;

  @doc("List of specialized containers that run before app containers.")
  initContainers?: InitContainer[];

  @doc("List of container definitions for the Container App.")
  containers?: Container[];

  @doc("Scaling properties for the Container App.")
  scale?: Scale;

  @doc("List of volume definitions for the Container App.")
  volumes?: Volume[];

  @doc("List of container app services bound to the app")
  serviceBinds?: ServiceBind[];
}

@doc("Container App init container definition")
model InitContainer extends BaseContainer {}

@doc("Container App base container definition.")
model BaseContainer {
  @doc("Container image tag.")
  image?: string;

  @doc("Custom container name.")
  name?: string;

  @doc("Container start command.")
  command?: string[];

  @doc("Container start command arguments.")
  args?: string[];

  @doc("Container environment variables.")
  env?: EnvironmentVar[];

  @doc("Container resource requirements.")
  resources?: ContainerResources;

  @doc("Container volume mounts.")
  volumeMounts?: VolumeMount[];
}

@doc("Container App container environment variable.")
model EnvironmentVar {
  @doc("Environment variable name.")
  name?: string;

  @doc("Non-secret environment variable value.")
  value?: string;

  @doc("Name of the Container App secret from which to pull the environment variable value.")
  secretRef?: string;
}

@doc("Container App container resource requirements.")
model ContainerResources {
  @doc("Required CPU in cores, e.g. 0.5")
  cpu?: float32;

  @doc("Required memory, e.g. \"250Mb\"")
  memory?: string;

  @doc("Ephemeral Storage, e.g. \"1Gi\"")
  @visibility("read")
  ephemeralStorage?: string;
}

@doc("Volume mount for the Container App.")
model VolumeMount {
  @doc("This must match the Name of a Volume.")
  volumeName?: string;

  @doc("Path within the container at which the volume should be mounted.Must not contain ':'.")
  mountPath?: string;

  @doc("Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root).")
  subPath?: string;
}

@doc("Container App container definition")
model Container extends BaseContainer {
  @doc("List of probes for the container.")
  probes?: ContainerAppProbe[];
}

@doc("Probe describes a health check to be performed against a container to determine whether it is alive or ready to receive traffic.")
model ContainerAppProbe {
  @doc("Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. Maximum value is 10.")
  failureThreshold?: int32;

  @doc("HTTPGet specifies the http request to perform.")
  httpGet?: ContainerAppProbeHttpGet;

  @doc("Number of seconds after the container has started before liveness probes are initiated. Minimum value is 1. Maximum value is 60.")
  initialDelaySeconds?: int32;

  @doc("How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1. Maximum value is 240.")
  periodSeconds?: int32;

  @doc("Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1. Maximum value is 10.")
  successThreshold?: int32;

  @doc("TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported.")
  tcpSocket?: ContainerAppProbeTcpSocket;

  @doc("Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is an alpha field and requires enabling ProbeTerminationGracePeriod feature gate. Maximum value is 3600 seconds (1 hour)")
  terminationGracePeriodSeconds?: int32;

  @doc("Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. Maximum value is 240.")
  timeoutSeconds?: int32;

  @doc("The type of probe.")
  type?: Type;
}

@doc("HTTPGet specifies the http request to perform.")
model ContainerAppProbeHttpGet {
  @doc("Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead.")
  host?: string;

  @doc("Custom headers to set in the request. HTTP allows repeated headers.")
  httpHeaders?: ContainerAppProbeHttpGetHttpHeadersItem[];

  @doc("Path to access on the HTTP server.")
  path?: string;

  @doc("Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.")
  port: int32;

  @doc("Scheme to use for connecting to the host. Defaults to HTTP.")
  scheme?: Scheme;
}

@doc("HTTPHeader describes a custom header to be used in HTTP probes")
model ContainerAppProbeHttpGetHttpHeadersItem {
  @doc("The header field name")
  name: string;

  @doc("The header field value")
  value: string;
}

@doc("TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported.")
model ContainerAppProbeTcpSocket {
  @doc("Optional: Host name to connect to, defaults to the pod IP.")
  host?: string;

  @doc("Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME.")
  port: int32;
}

@doc("Container App scaling configurations.")
model Scale {
  @doc("Optional. Minimum number of container replicas.")
  minReplicas?: int32;

  @doc("Optional. Maximum number of container replicas. Defaults to 10 if not set.")
  maxReplicas?: int32;

  @doc("Scaling rules.")
  rules?: ScaleRule[];
}

@doc("Container App container scaling rule.")
model ScaleRule {
  @doc("Scale Rule Name")
  name?: string;

  @doc("Azure Queue based scaling.")
  azureQueue?: QueueScaleRule;

  @doc("Custom scale rule.")
  custom?: CustomScaleRule;

  @doc("HTTP requests based scaling.")
  http?: HttpScaleRule;

  @doc("Tcp requests based scaling.")
  tcp?: TcpScaleRule;
}

@doc("Container App container Azure Queue based scaling rule.")
model QueueScaleRule {
  @doc("Queue name.")
  queueName?: string;

  @doc("Queue length.")
  queueLength?: int32;

  @doc("Authentication secrets for the queue scale rule.")
  auth?: ScaleRuleAuth[];
}

@doc("Auth Secrets for Scale Rule")
model ScaleRuleAuth {
  @doc("Name of the secret from which to pull the auth params.")
  secretRef?: string;

  @doc("Trigger Parameter that uses the secret")
  triggerParameter?: string;
}

@doc("Container App container Custom scaling rule.")
model CustomScaleRule {
  @doc("""
Type of the custom scale rule
eg: azure-servicebus, redis etc.
""")
  type?: string;

  @doc("Metadata properties to describe custom scale rule.")
  metadata?: Record<string>;

  @doc("Authentication secrets for the custom scale rule.")
  auth?: ScaleRuleAuth[];
}

@doc("Container App container Http scaling rule.")
model HttpScaleRule {
  @doc("Metadata properties to describe http scale rule.")
  metadata?: Record<string>;

  @doc("Authentication secrets for the custom scale rule.")
  auth?: ScaleRuleAuth[];
}

@doc("Container App container Tcp scaling rule.")
model TcpScaleRule {
  @doc("Metadata properties to describe tcp scale rule.")
  metadata?: Record<string>;

  @doc("Authentication secrets for the tcp scale rule.")
  auth?: ScaleRuleAuth[];
}

@doc("Volume definitions for the Container App.")
model Volume {
  @doc("Volume name.")
  name?: string;

  @doc("Storage type for the volume. If not provided, use EmptyDir.")
  storageType?: StorageType;

  @doc("Name of storage resource. No need to provide for EmptyDir and Secret.")
  storageName?: string;

  @doc("List of secrets to be added in volume. If no secrets are provided, all secrets in collection will be added to volume.")
  secrets?: SecretVolumeItem[];

  @doc("Mount options used while mounting the AzureFile. Must be a comma-separated string.")
  mountOptions?: string;
}

@doc("Secret to be added to volume.")
model SecretVolumeItem {
  @doc("Name of the Container App secret from which to pull the secret value.")
  secretRef?: string;

  @doc("Path to project secret to. If no path is provided, path defaults to name of secret listed in secretRef.")
  path?: string;
}

@doc("Configuration to bind a ContainerApp to a dev ContainerApp Service")
model ServiceBind {
  @doc("Resource id of the target service")
  serviceId?: string;

  @doc("Name of the service bind")
  name?: string;
}

@doc("Custom domain analysis.")
model CustomHostnameAnalysisResult {
  @doc("Host name that was analyzed")
  @visibility("read")
  hostName?: string;

  @doc("<code>true</code> if hostname is already verified; otherwise, <code>false</code>.")
  @visibility("read")
  isHostnameAlreadyVerified?: boolean;

  @doc("DNS verification test result.")
  @visibility("read")
  customDomainVerificationTest?: DnsVerificationTestResult;

  @doc("Raw failure information if DNS verification fails.")
  @visibility("read")
  customDomainVerificationFailureInfo?: CustomHostnameAnalysisResultCustomDomainVerificationFailureInfo;

  @doc("<code>true</code> if there is a conflict on the Container App's managed environment; otherwise, <code>false</code>.")
  @visibility("read")
  hasConflictOnManagedEnvironment?: boolean;

  @doc("<code>true</code> if there is a conflict on the Container App's managed environment level custom domain; otherwise, <code>false</code>.")
  @visibility("read")
  conflictWithEnvironmentCustomDomain?: boolean;

  @doc("Name of the conflicting Container App on the Managed Environment if it's within the same subscription.")
  @visibility("read")
  conflictingContainerAppResourceId?: string;

  @doc("CName records visible for this hostname.")
  cNameRecords?: string[];

  @doc("TXT records visible for this hostname.")
  txtRecords?: string[];

  @doc("A records visible for this hostname.")
  aRecords?: string[];

  @doc("Alternate CName records visible for this hostname.")
  alternateCNameRecords?: string[];

  @doc("Alternate TXT records visible for this hostname.")
  alternateTxtRecords?: string[];
}

@doc("Raw failure information if DNS verification fails.")
model CustomHostnameAnalysisResultCustomDomainVerificationFailureInfo {
  @doc("Standardized string to programmatically identify the error.")
  @visibility("read")
  code?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  message?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  target?: string;

  @doc("Details or the error")
  details?: CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem[];
}

@doc("Detailed errors.")
model CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem {
  @doc("Standardized string to programmatically identify the error.")
  @visibility("read")
  code?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  message?: string;

  @doc("Detailed error description and debugging information.")
  @visibility("read")
  target?: string;
}

@doc("Container App Secrets Collection ARM resource.")
model SecretsCollection {
  @doc("Collection of resources.")
  value: ContainerAppSecret[];
}

@doc("Container App Secret.")
model ContainerAppSecret {
  @doc("Secret Name.")
  @visibility("read")
  name?: string;

  @doc("Secret Value.")
  @visibility("read")
  value?: string;

  @doc("Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.")
  @visibility("read")
  identity?: string;

  @doc("Azure Key Vault URL pointing to the secret referenced by the container app.")
  @visibility("read")
  keyVaultUrl?: string;
}

@doc("Container App Auth Token.")
model ContainerAppAuthToken extends TrackedResource {
  @doc("Container App auth token resource specific properties")
  properties?: ContainerAppAuthTokenProperties;
}

@doc("Container App auth token resource specific properties")
model ContainerAppAuthTokenProperties {
  @doc("Auth token value.")
  @visibility("read")
  token?: string;

  @doc("Token expiration date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

@doc("Revision resource specific properties")
model RevisionProperties {
  @doc("""
Timestamp describing when the revision was created
by controller
""")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Timestamp describing when the revision was last active. Only meaningful when revision is inactive")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActiveTime?: utcDateTime;

  @doc("Fully qualified domain name of the revision")
  @visibility("read")
  fqdn?: string;

  @doc("""
Container App Revision Template with all possible settings and the
defaults if user did not provide them. The defaults are populated
as they were at the creation time
""")
  @visibility("read")
  template?: Template;

  @doc("Boolean describing if the Revision is Active")
  @visibility("read")
  active?: boolean;

  @doc("Number of pods currently running for this revision")
  @visibility("read")
  replicas?: int32;

  @doc("Traffic weight assigned to this revision")
  @visibility("read")
  trafficWeight?: int32;

  @doc("Optional Field - Platform Error Message")
  @visibility("read")
  provisioningError?: string;

  @doc("Current health State of the revision")
  @visibility("read")
  healthState?: RevisionHealthState;

  @doc("Current provisioning State of the revision")
  @visibility("read")
  provisioningState?: RevisionProvisioningState;

  @doc("Current running state of the revision")
  @visibility("read")
  runningState?: RevisionRunningState;
}

@doc("Replica resource specific properties")
model ReplicaProperties {
  @doc("Timestamp describing when the pod was created by controller")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  @doc("Current running state of the replica")
  @visibility("read")
  runningState?: ContainerAppReplicaRunningState;

  @doc("The details of replica current running state")
  @visibility("read")
  runningStateDetails?: string;

  @doc("The containers collection under a replica.")
  containers?: ReplicaContainer[];

  @doc("The init containers collection under a replica.")
  initContainers?: ReplicaContainer[];
}

@doc("Container object under Container App Revision Replica.")
model ReplicaContainer {
  @doc("The Name of the Container")
  name?: string;

  @doc("The Id of the Container")
  containerId?: string;

  @doc("The container ready status")
  ready?: boolean;

  @doc("The container start status")
  started?: boolean;

  @doc("The container restart count")
  restartCount?: int32;

  @doc("Current running state of the container")
  @visibility("read")
  runningState?: ContainerAppContainerRunningState;

  @doc("The details of container current running state")
  @visibility("read")
  runningStateDetails?: string;

  @doc("Log Stream endpoint")
  @visibility("read")
  logStreamEndpoint?: string;

  @doc("Container exec endpoint")
  @visibility("read")
  execEndpoint?: string;
}

@doc("Diagnostics resource specific properties")
model DiagnosticsProperties {
  @doc("Metadata of the diagnostics response.")
  metadata?: DiagnosticsDefinition;

  @doc("Set of data collections associated with the response.")
  dataset?: DiagnosticsDataApiResponse[];

  @doc("Status of the diagnostics response.")
  status?: DiagnosticsStatus;

  @doc("List of data providers' metadata.")
  dataProviderMetadata?: DiagnosticDataProviderMetadata;
}

@doc("Metadata of the diagnostics response")
model DiagnosticsDefinition {
  @doc("Unique detector name")
  @visibility("read")
  id?: string;

  @doc("Display Name of the detector")
  @visibility("read")
  name?: string;

  @doc("Details of the diagnostics info")
  @visibility("read")
  description?: string;

  @doc("Authors' names of the detector")
  @visibility("read")
  author?: string;

  @doc("Category of the detector")
  @visibility("read")
  category?: string;

  @doc("List of support topics")
  supportTopicList?: DiagnosticSupportTopic[];

  @doc("List of analysis types")
  analysisTypes?: string[];

  @doc("Authors' names of the detector")
  @visibility("read")
  type?: string;

  @doc("Authors' names of the detector")
  @visibility("read")
  score?: float32;
}

@doc("Support topic information")
model DiagnosticSupportTopic {
  @doc("Unique topic identifier")
  @visibility("read")
  id?: string;

  @doc("PES identifier")
  @visibility("read")
  pesId?: string;
}

@doc("Diagnostics data returned from a detector")
model DiagnosticsDataApiResponse {
  @doc("Table response")
  table?: DiagnosticDataTableResponseObject;

  @doc("Details of the table response")
  renderingProperties?: DiagnosticRendering;
}

@doc("Diagnostics data table")
model DiagnosticDataTableResponseObject {
  @doc("Table name")
  tableName?: string;

  @doc("Columns in the table")
  columns?: DiagnosticDataTableResponseColumn[];

  @doc("Rows in the table")
  rows?: Record<unknown>[];
}

@doc("Diagnostics data column")
model DiagnosticDataTableResponseColumn {
  @doc("Column name")
  columnName?: string;

  @doc("Data type of the column")
  dataType?: string;

  @doc("Column type")
  columnType?: string;
}

@doc("Rendering details of a diagnostics table")
model DiagnosticRendering {
  @doc("Rendering type")
  type?: int32;

  @doc("Title of the table")
  title?: string;

  @doc("Description of the table")
  description?: string;

  @doc("Flag if the table should be rendered")
  isVisible?: boolean;
}

@doc("Rendering details of a diagnostics table")
model DiagnosticsStatus {
  @doc("Diagnostic message")
  message?: string;

  @doc("Status")
  statusId?: int32;
}

@doc("Details of a diagnostics data provider")
model DiagnosticDataProviderMetadata {
  @doc("Name of data provider")
  providerName?: string;

  @doc("Collection of properties")
  propertyBag?: DiagnosticDataProviderMetadataPropertyBagItem[];
}

@doc("Property details")
model DiagnosticDataProviderMetadataPropertyBagItem {
  @doc("Property name")
  name?: string;

  @doc("Property value")
  value?: string;
}

@doc("Managed environment resource specific properties")
model ManagedEnvironmentProperties {
  @doc("Provisioning state of the Environment.")
  @visibility("read")
  provisioningState?: EnvironmentProvisioningState;

  @doc("Azure Monitor instrumentation key used by Dapr to export Service to Service communication telemetry")
  daprAIInstrumentationKey?: string;

  @doc("Application Insights connection string used by Dapr to export Service to Service communication telemetry")
  daprAIConnectionString?: string;

  @doc("Vnet configuration for the environment")
  vnetConfiguration?: VnetConfiguration;

  @doc("Any errors that occurred during deployment or deployment validation")
  @visibility("read")
  deploymentErrors?: string;

  @doc("Default Domain Name for the cluster")
  @visibility("read")
  defaultDomain?: string;

  @doc("Static IP of the Environment")
  @visibility("read")
  staticIp?: string;

  @doc("""
Cluster configuration which enables the log daemon to export
app logs to a destination. Currently only \"log-analytics\" is
supported
""")
  appLogsConfiguration?: AppLogsConfiguration;

  @doc("Whether or not this Managed Environment is zone-redundant.")
  @visibility("read", "create")
  zoneRedundant?: boolean;

  @doc("Custom domain configuration for the environment")
  customDomainConfiguration?: CustomDomainConfiguration;

  @doc("The endpoint of the eventstream of the Environment.")
  @visibility("read")
  eventStreamEndpoint?: string;

  @doc("Workload profiles configured for the Managed Environment.")
  workloadProfiles?: WorkloadProfile[];

  @doc("The configuration of Keda component.")
  kedaConfiguration?: KedaConfiguration;

  @doc("The configuration of Dapr component.")
  daprConfiguration?: DaprConfiguration;

  @doc("Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources. If a subnet ID is provided, this resource group will be created in the same subscription as the subnet.")
  @visibility("read", "create")
  infrastructureResourceGroup?: string;

  @doc("Peer authentication settings for the Managed Environment")
  peerAuthentication?: ManagedEnvironmentPropertiesPeerAuthentication;
}

@doc("Configuration properties for apps environment to join a Virtual Network")
model VnetConfiguration {
  @doc("Boolean indicating the environment only has an internal load balancer. These environments do not have a public static IP resource. They must provide infrastructureSubnetId if enabling this property")
  @visibility("read", "create")
  internal?: boolean;

  @doc("Resource ID of a subnet for infrastructure components. Must not overlap with any other provided IP ranges.")
  @visibility("read", "create")
  infrastructureSubnetId?: string;

  @doc("CIDR notation IP range assigned to the Docker bridge, network. Must not overlap with any other provided IP ranges.")
  @visibility("read", "create")
  dockerBridgeCidr?: string;

  @doc("IP range in CIDR notation that can be reserved for environment infrastructure IP addresses. Must not overlap with any other provided IP ranges.")
  @visibility("read", "create")
  platformReservedCidr?: string;

  @doc(" An IP address from the IP range defined by platformReservedCidr that will be reserved for the internal DNS server.")
  @visibility("read", "create")
  platformReservedDnsIP?: string;
}

@doc("Configuration of application logs")
model AppLogsConfiguration {
  @doc("Logs destination, can be 'log-analytics', 'azure-monitor' or 'none'")
  destination?: string;

  @doc("Log Analytics configuration, must only be provided when destination is configured as 'log-analytics'")
  logAnalyticsConfiguration?: LogAnalyticsConfiguration;
}

@doc("Log Analytics configuration, must only be provided when destination is configured as 'log-analytics'")
model LogAnalyticsConfiguration {
  @doc("Log analytics customer id")
  customerId?: string;

  @doc("Log analytics customer key")
  @visibility("create", "update")
  sharedKey?: string;
}

@doc("Workload profile to scope container app execution.")
model WorkloadProfile {
  @doc("Workload profile type for the workloads to run on.")
  name: string;

  @doc("Workload profile type for the workloads to run on.")
  workloadProfileType: string;

  @doc("The minimum capacity.")
  minimumCount?: int32;

  @doc("The maximum capacity.")
  maximumCount?: int32;
}

@doc("Configuration properties Keda component")
model KedaConfiguration {
  @doc("The version of Keda")
  @visibility("read")
  version?: string;
}

@doc("Configuration properties Dapr component")
model DaprConfiguration {
  @doc("The version of Dapr")
  @visibility("read")
  version?: string;
}

@doc("Peer authentication settings for the Managed Environment")
model ManagedEnvironmentPropertiesPeerAuthentication {
  @doc("Mutual TLS authentication settings for the Managed Environment")
  mtls?: Mtls;
}

@doc("Configuration properties for mutual TLS authentication")
model Mtls {
  @doc("Boolean indicating whether the mutual TLS authentication is enabled")
  @projectedName("json", "enabled")
  IsEnabled?: boolean;
}

@doc("Operation detail payload")
model OperationDetail {
  @doc("Name of the operation")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("Display of the operation")
  display?: OperationDisplay;

  @doc("Origin of the operation")
  origin?: string;
}

@doc("Container Apps Job resource specific properties.")
model JobProperties {
  @doc("Provisioning state of the Container Apps Job.")
  @visibility("read")
  provisioningState?: JobProvisioningState;

  @doc("Resource ID of environment.")
  @visibility("read", "create")
  environmentId?: string;

  @doc("Workload profile name to pin for container apps job execution.")
  workloadProfileName?: string;

  @doc("Container Apps Job configuration properties.")
  configuration?: JobConfiguration;

  @doc("Container Apps job definition.")
  template?: JobTemplate;

  @doc("Outbound IP Addresses of a container apps job.")
  @visibility("read")
  outboundIpAddresses?: string[];

  @doc("The endpoint of the eventstream of the container apps job.")
  @visibility("read")
  eventStreamEndpoint?: string;
}

@doc("Non versioned Container Apps Job configuration properties")
model JobConfiguration {
  @doc("Collection of secrets used by a Container Apps Job")
  secrets?: Secret[];

  @doc("Trigger type of the job")
  triggerType: TriggerType;

  @doc("Maximum number of seconds a replica is allowed to run.")
  replicaTimeout: int32;

  @doc("Maximum number of retries before failing the job.")
  replicaRetryLimit?: int32;

  @doc("Manual trigger configuration for a single execution job. Properties replicaCompletionCount and parallelism would be set to 1 by default")
  manualTriggerConfig?: JobConfigurationManualTriggerConfig;

  @doc("Cron formatted repeating trigger schedule (\"* * * * *\") for cronjobs. Properties completions and parallelism would be set to 1 by default")
  scheduleTriggerConfig?: JobConfigurationScheduleTriggerConfig;

  @doc("Trigger configuration of an event driven job.")
  eventTriggerConfig?: JobConfigurationEventTriggerConfig;

  @doc("Collection of private container registry credentials used by a Container apps job")
  registries?: RegistryCredentials[];
}

@doc("Manual trigger configuration for a single execution job. Properties replicaCompletionCount and parallelism would be set to 1 by default")
model JobConfigurationManualTriggerConfig {
  @doc("Minimum number of successful replica completions before overall job completion.")
  replicaCompletionCount?: int32;

  @doc("Number of parallel replicas of a job that can run at a given time.")
  parallelism?: int32;
}

@doc("Cron formatted repeating trigger schedule (\"* * * * *\") for cronjobs. Properties completions and parallelism would be set to 1 by default")
model JobConfigurationScheduleTriggerConfig {
  @doc("Minimum number of successful replica completions before overall job completion.")
  replicaCompletionCount?: int32;

  @doc("Cron formatted repeating schedule (\"* * * * *\") of a Cron Job.")
  cronExpression: string;

  @doc("Number of parallel replicas of a job that can run at a given time.")
  parallelism?: int32;
}

@doc("Trigger configuration of an event driven job.")
model JobConfigurationEventTriggerConfig {
  @doc("Minimum number of successful replica completions before overall job completion.")
  replicaCompletionCount?: int32;

  @doc("Number of parallel replicas of a job that can run at a given time.")
  parallelism?: int32;

  @doc("Scaling configurations for event driven jobs.")
  scale?: JobScale;
}

@doc("Scaling configurations for event driven jobs.")
model JobScale {
  @doc("Interval to check each event source in seconds. Defaults to 30s")
  pollingInterval?: int32;

  @doc("Minimum number of job executions that are created for a trigger, default 0")
  minExecutions?: int32;

  @doc("Maximum number of job executions that are created for a trigger, default 100.")
  maxExecutions?: int32;

  @doc("Scaling rules.")
  rules?: JobScaleRule[];
}

@doc("Scaling rule.")
model JobScaleRule {
  @doc("Scale Rule Name")
  name?: string;

  @doc("""
Type of the scale rule
eg: azure-servicebus, redis etc.
""")
  type?: string;

  @doc("Metadata properties to describe the scale rule.")
  metadata?: Record<unknown>;

  @doc("Authentication secrets for the scale rule.")
  auth?: ScaleRuleAuth[];
}

@doc("Container Apps Job versioned application definition. Defines the desired state of an immutable revision. Any changes to this section Will result in a new revision being created")
model JobTemplate {
  @doc("List of specialized containers that run before app containers.")
  initContainers?: InitContainer[];

  @doc("List of container definitions for the Container App.")
  containers?: Container[];

  @doc("List of volume definitions for the Container App.")
  volumes?: Volume[];
}

@doc("Container Apps Job resource specific properties.")
model JobPatchProperties {
  @doc("Managed identities needed by a container app job to interact with other Azure services to not maintain any secrets or credentials in code.")
  identity?: ManagedServiceIdentity;

  @doc("Resource tags.")
  @visibility("read", "create", "update")
  tags?: Record<string>;

  properties?: JobPatchPropertiesProperties;
}

model JobPatchPropertiesProperties {
  @doc("Resource ID of environment.")
  @visibility("read", "create", "update")
  environmentId?: string;

  @doc("Container Apps Job configuration properties.")
  configuration?: JobConfiguration;

  @doc("Container Apps job definition.")
  template?: JobTemplate;

  @doc("Outbound IP Addresses of a container apps job.")
  outboundIpAddresses?: string[];

  @doc("The endpoint of the eventstream of the container apps job.")
  eventStreamEndpoint?: string;
}

@doc("Job's execution template, containing container configuration for a job's execution")
model JobExecutionTemplate {
  @doc("List of container definitions for the Container Apps Job.")
  containers?: JobExecutionContainer[];

  @doc("List of specialized containers that run before job containers.")
  initContainers?: JobExecutionContainer[];
}

@doc("Container Apps Jobs execution container definition.")
model JobExecutionContainer {
  @doc("Container image tag.")
  image?: string;

  @doc("Custom container name.")
  name?: string;

  @doc("Container start command.")
  command?: string[];

  @doc("Container start command arguments.")
  args?: string[];

  @doc("Container environment variables.")
  env?: EnvironmentVar[];

  @doc("Container resource requirements.")
  resources?: ContainerResources;
}

@doc("Container App's Job execution name.")
model JobExecutionBase {
  @doc("Job execution name.")
  name?: string;

  @doc("Job execution Id.")
  id?: string;
}

@doc("Container Apps Job Secrets Collection ARM resource.")
model JobSecretsCollection {
  @doc("Collection of resources.")
  value: Secret[];
}

@doc("Collection of Environments")
model ManagedEnvironmentsCollection is Azure.Core.Page<ManagedEnvironment>;

@doc("Certificate resource specific properties")
model ManagedCertificateProperties {
  @doc("Provisioning state of the certificate.")
  @visibility("read")
  provisioningState?: CertificateProvisioningState;

  @doc("Subject name of the certificate.")
  subjectName?: string;

  @doc("Any error occurred during the certificate provision.")
  @visibility("read")
  error?: string;

  @doc("Selected type of domain control validation for managed certificates.")
  domainControlValidation?: ManagedCertificateDomainControlValidation;

  @doc("A TXT token used for DNS TXT domain control validation when issuing this type of managed certificates.")
  @visibility("read")
  validationToken?: string;
}

@doc("A managed certificate to update")
model ManagedCertificatePatch {
  @doc("Application-specific metadata in the form of key-value pairs.")
  tags?: Record<string>;
}

@doc("Environment Auth Token.")
model EnvironmentAuthToken extends TrackedResource {
  @doc("Environment auth token resource specific properties")
  properties?: EnvironmentAuthTokenProperties;
}

@doc("Environment auth token resource specific properties")
model EnvironmentAuthTokenProperties {
  @doc("Auth token value.")
  @visibility("read")
  token?: string;

  @doc("Token expiration date.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

@doc("Collection of workloadProfileStates")
model WorkloadProfileStatesCollection is Azure.Core.Page<WorkloadProfileStates>;

@doc("Collection of all the workload Profile States for a Managed Environment..")
model WorkloadProfileStates extends ProxyResource {
  @doc("Workload Profile resource specific properties.")
  properties?: WorkloadProfileStatesProperties;
}

@doc("Workload Profile resource specific properties.")
model WorkloadProfileStatesProperties {
  @doc("Minimum count of instances.")
  minimumCount?: int32;

  @doc("Maximum count of nodes.")
  maximumCount?: int32;

  @doc("Current count of nodes.")
  currentCount?: int32;
}

@doc("Storage properties")
model ManagedEnvironmentStorageProperties {
  @doc("Azure file properties")
  azureFile?: AzureFileProperties;
}

@doc("SourceControl resource specific properties")
model SourceControlProperties {
  @doc("Current provisioning State of the operation")
  @visibility("read")
  operationState?: SourceControlOperationState;

  @doc("The repo url which will be integrated to ContainerApp.")
  repoUrl?: string;

  @doc("The branch which will trigger the auto deployment")
  branch?: string;

  @doc("""
Container App Revision Template with all possible settings and the
defaults if user did not provide them. The defaults are populated
as they were at the creation time
""")
  githubActionConfiguration?: GithubActionConfiguration;
}

@doc("Configuration properties that define the mutable settings of a Container App SourceControl")
model GithubActionConfiguration {
  @doc("Registry configurations.")
  registryInfo?: RegistryInfo;

  @doc("AzureCredentials configurations.")
  azureCredentials?: AzureCredentials;

  @doc("Context path")
  contextPath?: string;

  @doc("One time Github PAT to configure github environment")
  @visibility("create", "update")
  githubPersonalAccessToken?: string;

  @doc("Image name")
  image?: string;

  @doc("Code or Image")
  publishType?: string;

  @doc("Operation system")
  os?: string;

  @doc("Runtime stack")
  runtimeStack?: string;

  @doc("Runtime version")
  runtimeVersion?: string;
}

@doc("Container App registry information.")
model RegistryInfo {
  @doc("registry server Url.")
  registryUrl?: string;

  @doc("registry username.")
  registryUserName?: string;

  @doc("registry secret.")
  @visibility("create", "update")
  registryPassword?: string;
}

@doc("Container App credentials.")
model AzureCredentials {
  @doc("Client Id.")
  @visibility("create", "update")
  clientId?: string;

  @doc("Client Secret.")
  @visibility("create", "update")
  clientSecret?: string;

  @doc("Tenant Id.")
  @visibility("create", "update")
  tenantId?: string;

  @doc("Kind of auth github does for deploying the template")
  @visibility("create", "update")
  kind?: string;

  @doc("Subscription Id.")
  subscriptionId?: string;
}

@doc("Container App executions names list.")
model JobExecutionNamesCollection {
  @doc("Collection of resources.")
  value: JobExecutionBase[];
}
