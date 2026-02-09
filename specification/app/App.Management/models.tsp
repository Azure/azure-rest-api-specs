import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;
using Azure.ResourceManager.Foundations;

namespace Microsoft.App;

/**
 * Logic App call response object.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
model Object {}

/**
 * Custom domain verification Id of a subscription
 */
scalar CustomDomainVerificationId extends string;

/**
 * indicates whether the profile is default for the location.
 */
union Applicability {
  string,

  /**
   * LocationDefault
   */
  LocationDefault: "LocationDefault",

  /**
   * Custom
   */
  Custom: "Custom",
}

/**
 * Resource instance provisioning state.
 */
union BuilderProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Provisioning state of the Kubernetes Environment.
 */
union ConnectedEnvironmentProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Waiting
   */
  Waiting: "Waiting",

  /**
   * InitializationInProgress
   */
  InitializationInProgress: "InitializationInProgress",

  /**
   * InfrastructureSetupInProgress
   */
  InfrastructureSetupInProgress: "InfrastructureSetupInProgress",

  /**
   * InfrastructureSetupComplete
   */
  InfrastructureSetupComplete: "InfrastructureSetupComplete",

  /**
   * ScheduledForDelete
   */
  ScheduledForDelete: "ScheduledForDelete",
}

/**
 * The reason why the given name is not available.
 */
union CheckNameAvailabilityReason {
  string,

  /**
   * Invalid
   */
  Invalid: "Invalid",

  /**
   * AlreadyExists
   */
  AlreadyExists: "AlreadyExists",
}

/**
 * Provisioning state of the certificate.
 */
union CertificateProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * DeleteFailed
   */
  DeleteFailed: "DeleteFailed",

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * The type of the certificate. Allowed values are `ServerSSLCertificate` and `ImagePullTrustedCA`
 */
union CertificateType {
  string,

  /**
   * ServerSSLCertificate
   */
  ServerSSLCertificate: "ServerSSLCertificate",

  /**
   * ImagePullTrustedCA
   */
  ImagePullTrustedCA: "ImagePullTrustedCA",
}

/**
 * Provisioning state of the Connected Environment Dapr Component.
 */
union DaprComponentProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Provisioning state of the storage.
 */
union ConnectedEnvironmentStorageProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Access mode for storage
 */
union AccessMode {
  string,

  /**
   * ReadOnly
   */
  ReadOnly: "ReadOnly",

  /**
   * ReadWrite
   */
  ReadWrite: "ReadWrite",
}

/**
 * Provisioning state of the Environment.
 */
union EnvironmentProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Waiting
   */
  Waiting: "Waiting",

  /**
   * InitializationInProgress
   */
  InitializationInProgress: "InitializationInProgress",

  /**
   * InfrastructureSetupInProgress
   */
  InfrastructureSetupInProgress: "InfrastructureSetupInProgress",

  /**
   * InfrastructureSetupComplete
   */
  InfrastructureSetupComplete: "InfrastructureSetupComplete",

  /**
   * ScheduledForDelete
   */
  ScheduledForDelete: "ScheduledForDelete",

  /**
   * UpgradeRequested
   */
  UpgradeRequested: "UpgradeRequested",

  /**
   * UpgradeFailed
   */
  UpgradeFailed: "UpgradeFailed",
}

/**
 * The private endpoint connection status.
 */
union PrivateEndpointServiceConnectionStatus {
  string,

  /**
   * Pending
   */
  Pending: "Pending",

  /**
   * Approved
   */
  Approved: "Approved",

  /**
   * Rejected
   */
  Rejected: "Rejected",

  /**
   * Disconnected
   */
  Disconnected: "Disconnected",
}

/**
 * The current provisioning state.
 */
union PrivateEndpointConnectionProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Waiting
   */
  Waiting: "Waiting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Property to allow or block all public traffic. Allowed Values: 'Enabled', 'Disabled'.
 */
union PublicNetworkAccess {
  string,

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * Selected type of domain control validation for managed certificates.
 */
union ManagedCertificateDomainControlValidation {
  string,

  /**
   * CNAME
   */
  CNAME: "CNAME",

  /**
   * HTTP
   */
  HTTP: "HTTP",

  /**
   * TXT
   */
  TXT: "TXT",
}

/**
 * The current provisioning state.
 */
union HttpRouteProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Waiting
   */
  Waiting: "Waiting",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * Pending
   */
  Pending: "Pending",
}

/**
 * Provisioning state of the Container Apps Job.
 */
union JobProvisioningState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Current running state of the job
 */
union JobRunningState {
  string,

  /**
   * Ready
   */
  Ready: "Ready",

  /**
   * Progressing
   */
  Progressing: "Progressing",

  /**
   * Suspended
   */
  Suspended: "Suspended",
}

/**
 * Trigger type of the job
 */
union TriggerType {
  string,

  /**
   * Schedule
   */
  Schedule: "Schedule",

  /**
   * Event
   */
  Event: "Event",

  /**
   * Manual
   */
  Manual: "Manual",
}

/**
 * Current running State of the job
 */
union JobExecutionRunningState {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Processing
   */
  Processing: "Processing",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Unknown
   */
  Unknown: "Unknown",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",
}

/**
 * The action to take when an unauthenticated client attempts to access the app.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum UnauthenticatedClientActionV2 {
  /**
   * RedirectToLoginPage
   */
  RedirectToLoginPage,

  /**
   * AllowAnonymous
   */
  AllowAnonymous,

  /**
   * Return401
   */
  Return401,

  /**
   * Return403
   */
  Return403,
}

/**
 * The convention used when determining the session cookie's expiration.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum CookieExpirationConvention {
  /**
   * FixedTime
   */
  FixedTime,

  /**
   * IdentityProviderDerived
   */
  IdentityProviderDerived,
}

/**
 * The convention used to determine the url of the request made.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ForwardProxyConvention {
  /**
   * NoProxy
   */
  NoProxy,

  /**
   * Standard
   */
  Standard,

  /**
   * Custom
   */
  Custom,
}

/**
 * Day of the week when a managed environment can be patched.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum WeekDay {
  /**
   * Monday
   */
  Monday,

  /**
   * Tuesday
   */
  Tuesday,

  /**
   * Wednesday
   */
  Wednesday,

  /**
   * Thursday
   */
  Thursday,

  /**
   * Friday
   */
  Friday,

  /**
   * Saturday
   */
  Saturday,

  /**
   * Sunday
   */
  Sunday,
}

/**
 * App Resiliency resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model AppResiliencyProperties {
  /**
   * Policy to set request timeouts
   */
  timeoutPolicy?: TimeoutPolicy;

  /**
   * Policy that defines http request retry conditions
   */
  httpRetryPolicy?: HttpRetryPolicy;

  /**
   * Policy that defines tcp request retry conditions
   */
  tcpRetryPolicy?: TcpRetryPolicy;

  /**
   * Policy that defines circuit breaker conditions
   */
  circuitBreakerPolicy?: CircuitBreakerPolicy;

  /**
   * Defines parameters for http connection pooling
   */
  httpConnectionPool?: HttpConnectionPool;

  /**
   * Defines parameters for tcp connection pooling
   */
  tcpConnectionPool?: TcpConnectionPool;
}

/**
 * Policy to set request timeouts
 */
model TimeoutPolicy {
  /**
   * Timeout, in seconds, for a request to respond
   */
  responseTimeoutInSeconds?: int32;

  /**
   * Timeout, in seconds, for a request to initiate a connection
   */
  connectionTimeoutInSeconds?: int32;
}

/**
 * Policy that defines http request retry conditions
 */
model HttpRetryPolicy {
  /**
   * Maximum number of times a request will retry
   */
  maxRetries?: int32;

  /**
   * Settings for retry backoff characteristics
   */
  retryBackOff?: HttpRetryPolicyRetryBackOff;

  /**
   * Conditions that must be met for a request to be retried
   */
  matches?: HttpRetryPolicyMatches;
}

/**
 * Settings for retry backoff characteristics
 */
model HttpRetryPolicyRetryBackOff {
  /**
   * Initial delay, in milliseconds, before retrying a request
   */
  initialDelayInMilliseconds?: int64;

  /**
   * Maximum interval, in milliseconds, between retries
   */
  maxIntervalInMilliseconds?: int64;
}

/**
 * Conditions that must be met for a request to be retried
 */
model HttpRetryPolicyMatches {
  /**
   * Headers that must be present for a request to be retried
   */
  @identifiers(#["header"])
  headers?: HeaderMatch[];

  /**
   * Additional http status codes that can trigger a retry
   */
  httpStatusCodes?: int32[];

  /**
   * Errors that can trigger a retry
   */
  errors?: string[];
}

/**
 * Conditions required to match a header
 */
model HeaderMatch {
  /**
   * Name of the header
   */
  header?: string;

  /**
   * Type of match to perform
   */
  match?: HeaderMatchMatch;
}

/**
 * Type of match to perform
 */
model HeaderMatchMatch {
  /**
   * Exact value of the header
   */
  exactMatch?: string;

  /**
   * Prefix value of the header
   */
  prefixMatch?: string;

  /**
   * Suffix value of the header
   */
  suffixMatch?: string;

  /**
   * Regex value of the header
   */
  regexMatch?: string;
}

/**
 * Policy that defines tcp request retry conditions
 */
model TcpRetryPolicy {
  /**
   * Maximum number of attempts to connect to the tcp service
   */
  maxConnectAttempts?: int32;
}

/**
 * Policy that defines circuit breaker conditions
 */
model CircuitBreakerPolicy {
  /**
   * Number of consecutive errors before the circuit breaker opens
   */
  consecutiveErrors?: int32;

  /**
   * The time interval, in seconds, between endpoint checks. This can result in opening the circuit breaker if the check fails as well as closing the circuit breaker if the check succeeds. Defaults to 10s.
   */
  intervalInSeconds?: int32;

  /**
   * Maximum percentage of hosts that will be ejected after failure threshold has been met
   */
  maxEjectionPercent?: int32;
}

/**
 * Defines parameters for http connection pooling
 */
model HttpConnectionPool {
  /**
   * Maximum number of pending http1 requests allowed
   */
  http1MaxPendingRequests?: int32;

  /**
   * Maximum number of http2 requests allowed
   */
  http2MaxRequests?: int32;
}

/**
 * Defines parameters for tcp connection pooling
 */
model TcpConnectionPool {
  /**
   * Maximum number of tcp connections allowed
   */
  maxConnections?: int32;
}

/**
 * Error model.
 */
model DefaultErrorResponseError {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * Details or the error
   */
  @identifiers(#["code"])
  details?: DefaultErrorResponseErrorDetailsItem[];

  /**
   * More information to debug error.
   */
  @visibility(Lifecycle.Read)
  innererror?: string;
}

/**
 * Collection of AppResiliency policies
 */
model AppResiliencyCollection is Azure.Core.Page<AppResiliency>;

/**
 * AuthConfig collection ARM resource.
 */
model AuthConfigCollection is Azure.Core.Page<AuthConfig>;

/**
 * AuthConfig resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
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

  /**
   * The configuration settings of the secrets references of encryption key and signing key for ContainerApp Service Authentication/Authorization.
   */
  encryptionSettings?: EncryptionSettings;
}

/**
 * The configuration settings of the platform of ContainerApp Service Authentication/Authorization.
 */
model AuthPlatform {
  /**
   * <code>true</code> if the Authentication / Authorization feature is enabled for the current app; otherwise, <code>false</code>.
   */
  enabled?: boolean;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  customOpenIdConnectProviders?: Record<CustomOpenIdConnectProvider>;
}

/**
 * The configuration settings of the Azure Active directory provider.
 */
model AzureActiveDirectory {
  /**
   * <code>false</code> if the Azure Active Directory provider should not be enabled despite the set registration; otherwise, <code>true</code>.
   */
  enabled?: boolean;

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
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
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
  enabled?: boolean;

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
  enabled?: boolean;

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
  enabled?: boolean;

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
  enabled?: boolean;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" ""
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
  enabled?: boolean;

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
  enabled?: boolean;

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
  enabled?: boolean;

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
   * The configuration settings of the token store.
   */
  tokenStore?: TokenStore;

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
 * The configuration settings of the token store.
 */
model TokenStore {
  /**
   * <code>true</code> to durably store platform-specific security tokens that are obtained during login flows; otherwise, <code>false</code>.
   *  The default is <code>false</code>.
   */
  enabled?: boolean;

  /**
   * The number of hours after session token expiration that a session token can be used to
   * call the token refresh API. The default is 72 hours.
   */
  tokenRefreshExtensionHours?: float64;

  /**
   * The configuration settings of the storage of the tokens if blob storage is used.
   */
  azureBlobStorage?: BlobStorageTokenStore;
}

/**
 * The configuration settings of the storage of the tokens if blob storage is used.
 */
model BlobStorageTokenStore {
  /**
   * The name of the app secrets containing the SAS URL of the blob storage containing the tokens. Should not be used along with blobContainerUri.
   */
  sasUrlSettingName?: string;

  /**
   * The URI of the blob storage containing the tokens. Should not be used along with sasUrlSettingName.
   */
  blobContainerUri?: string;

  /**
   * The Client ID of a User-Assigned Managed Identity. Should not be used along with managedIdentityResourceId.
   */
  clientId?: string;

  /**
   * The Resource ID of a User-Assigned Managed Identity. Should not be used along with clientId.
   */
  managedIdentityResourceId?: string;
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
 * The configuration settings of the secrets references of encryption key and signing key for ContainerApp Service Authentication/Authorization.
 */
model EncryptionSettings {
  /**
   * The secret name which is referenced for EncryptionKey.
   */
  containerAppAuthEncryptionSecretName?: string;

  /**
   * The secret name which is referenced for SigningKey.
   */
  containerAppAuthSigningSecretName?: string;
}

/**
 * Collection of available workload profiles in the location.
 */
model AvailableWorkloadProfilesCollection
  is Azure.Core.Page<AvailableWorkloadProfile>;

/**
 * A workload profile with specific hardware configure to run container apps.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model AvailableWorkloadProfile
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
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
   * Number of GPUs.
   */
  gpus?: int32;

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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model BillingMeter extends Azure.ResourceManager.CommonTypes.ProxyResource {
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
 * The response of a BuilderResource list operation.
 */
model BuilderCollection is Azure.Core.Page<BuilderResource>;

/**
 * The builder properties.
 */
model BuilderProperties {
  /**
   * Provisioning state of a builder resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuilderProvisioningState;

  /**
   * Resource ID of the container apps environment that the builder is associated with.
   */
  environmentId: Azure.Core.armResourceIdentifier;

  /**
   * List of mappings of container registries and the managed identity used to connect to it.
   */
  @identifiers(#["containerRegistryServer"])
  containerRegistries?: ContainerRegistry[];
}

/**
 * Model representing a mapping from a container registry to the identity used to connect to it.
 */
model ContainerRegistry {
  /**
   * Login server of the container registry.
   */
  containerRegistryServer: string;

  /**
   * Resource ID of the managed identity.
   */
  identityResourceId: Azure.Core.armResourceIdentifier;
}

/**
 * The type used for update operations of the BuilderResource.
 */
model BuilderResourceUpdate {
  /**
   * The managed service identities assigned to this resource.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;

  /**
   * The updatable properties of the BuilderResource.
   */
  properties?: BuilderResourceUpdateProperties;
}

/**
 * The updatable properties of the BuilderResource.
 */
model BuilderResourceUpdateProperties {
  /**
   * Resource ID of the container apps environment that the builder is associated with.
   */
  environmentId?: Azure.Core.armResourceIdentifier;
}

/**
 * The response of a BuildResource list operation.
 */
model BuildCollection is Azure.Core.Page<BuildResource>;

/**
 * The build properties.
 */
model BuildProperties {
  /**
   * Build provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuildProvisioningState;

  /**
   * Status of the build once it has been provisioned.
   */
  @visibility(Lifecycle.Read)
  buildStatus?: BuildStatus;

  /**
   * Container registry that the final image will be uploaded to.
   */
  destinationContainerRegistry?: ContainerRegistryWithCustomImage;

  /**
   * Configuration of the build.
   */
  configuration?: BuildConfiguration;

  /**
   * Endpoint to which the source code should be uploaded.
   */
  @visibility(Lifecycle.Read)
  uploadEndpoint?: string;

  /**
   * Endpoint from which the build logs can be streamed.
   */
  @visibility(Lifecycle.Read)
  logStreamEndpoint?: string;

  /**
   * Endpoint to use to retrieve an authentication token for log streaming and uploading source code.
   */
  @visibility(Lifecycle.Read)
  tokenEndpoint?: string;
}

/**
 * Configuration of the build.
 */
model BuildConfiguration {
  /**
   * Base OS used to build and run the app.
   */
  baseOs?: string;

  /**
   * Platform to be used to build and run the app.
   */
  platform?: string;

  /**
   * Platform version to be used to build and run the app.
   */
  platformVersion?: string;

  /**
   * List of environment variables to be passed to the build, secrets should not be used in environment variable.
   */
  @identifiers(#["name"])
  environmentVariables?: EnvironmentVariable[];

  /**
   * List of steps to perform before the build.
   */
  @identifiers(#[])
  preBuildSteps?: PreBuildStep[];
}

/**
 * Build Auth Token.
 */
model BuildToken {
  /**
   * Authentication token.
   */
  @visibility(Lifecycle.Read)
  @secret
  token?: string;

  /**
   * Token expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

/**
 * Collection of connectedEnvironments
 */
model ConnectedEnvironmentCollection is Azure.Core.Page<ConnectedEnvironment>;

/**
 * ConnectedEnvironment resource specific properties
 */
model ConnectedEnvironmentProperties {
  /**
   * Provisioning state of the Kubernetes Environment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConnectedEnvironmentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Default Domain Name for the cluster
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * Static IP of the connectedEnvironment
   */
  staticIp?: string;

  /**
   * Application Insights connection string used by Dapr to export Service to Service communication telemetry
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @secret
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
  @visibility(Lifecycle.Read)
  customDomainVerificationId?: string;

  /**
   * Dns suffix for the environment domain
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dnsSuffix?: string;

  /**
   * Certificate stored in Azure Key Vault.
   */
  certificateKeyVaultProperties?: CertificateKeyVaultProperties;

  /**
   * PFX or PEM blob
   */
  @secret
  certificateValue?: bytes;

  /**
   * Certificate password
   */
  @secret
  certificatePassword?: string;

  /**
   * Certificate expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility(Lifecycle.Read)
  subjectName?: string;
}

/**
 * Properties for a certificate stored in a Key Vault.
 */
model CertificateKeyVaultProperties {
  /**
   * Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
   */
  identity?: string;

  /**
   * URL pointing to the Azure Key Vault secret that holds the certificate.
   */
  keyVaultUrl?: url;
}

/**
 * Connected environment patch properties
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
model ConnectedEnvironmentPatchResource extends ResourceTags {}

/**
 * List of key value pairs that describe the resource. This will overwrite the existing tags.
 */
model ResourceTags {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Collection of Certificates.
 */
model CertificateCollection is Azure.Core.Page<Certificate>;

/**
 * Certificate resource specific properties
 */
model CertificateProperties {
  /**
   * Provisioning state of the certificate.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CertificateProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Properties for a certificate stored in a Key Vault.
   */
  certificateKeyVaultProperties?: CertificateKeyVaultProperties;

  /**
   * Certificate password.
   */
  @visibility(Lifecycle.Create)
  @secret
  password?: string;

  /**
   * Subject name of the certificate.
   */
  @visibility(Lifecycle.Read)
  subjectName?: string;

  /**
   * Subject alternative names the certificate applies to.
   */
  @visibility(Lifecycle.Read)
  subjectAlternativeNames?: string[];

  /**
   * PFX or PEM blob
   */
  @visibility(Lifecycle.Create)
  @secret
  value?: bytes;

  /**
   * Certificate issuer.
   */
  @visibility(Lifecycle.Read)
  issuer?: string;

  /**
   * Certificate issue Date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  issueDate?: utcDateTime;

  /**
   * Certificate expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expirationDate?: utcDateTime;

  /**
   * Certificate thumbprint.
   */
  @visibility(Lifecycle.Read)
  thumbprint?: string;

  /**
   * Is the certificate valid?.
   */
  @visibility(Lifecycle.Read)
  valid?: boolean;

  /**
   * Public key hash.
   */
  @visibility(Lifecycle.Read)
  publicKeyHash?: string;

  /**
   * The type of the certificate. Allowed values are `ServerSSLCertificate` and `ImagePullTrustedCA`
   */
  certificateType?: CertificateType;
}

/**
 * A certificate to update
 */
model CertificatePatch {
  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Dapr Components ARM resource.
 */
model DaprComponentsCollection is Azure.Core.Page<DaprComponent>;

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
  ignoreErrors?: boolean = false;

  /**
   * Initialization timeout
   */
  initTimeout?: string;

  /**
   * Collection of secrets used by a Dapr component
   */
  @identifiers(#["name"])
  secrets?: Secret[];

  /**
   * Name of a Dapr component to retrieve component secrets from
   */
  secretStoreComponent?: string;

  /**
   * Component metadata
   */
  @identifiers(#["name"])
  metadata?: DaprMetadata[];

  /**
   * Names of container apps that can use this Dapr component
   */
  scopes?: string[];

  /**
   * List of container app services that are bound to the Dapr component
   */
  @identifiers(#["name"])
  serviceComponentBind?: DaprComponentServiceBinding[];

  /**
   * Provisioning state of the Connected Environment Dapr Component.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DaprComponentProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;
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
 * Configuration to bind a Dapr Component to a dev ContainerApp Service
 */
model DaprComponentServiceBinding {
  /**
   * Name of the service bind
   */
  name?: string;

  /**
   * Resource id of the target service
   */
  serviceId?: string;

  /**
   * Service bind metadata
   */
  metadata?: DaprServiceBindMetadata;
}

/**
 * Dapr component metadata.
 */
model DaprServiceBindMetadata {
  /**
   * Service bind metadata property name.
   */
  name?: string;

  /**
   * Service bind metadata property value.
   */
  value?: string;
}

/**
 * Dapr component Secrets Collection for ListSecrets Action.
 */
model DaprSecretsCollection {
  /**
   * Collection of secrets used by a Dapr component
   */
  @pageItems
  @identifiers(#["name"])
  value: DaprSecret[];
}

/**
 * Dapr component Secret for ListSecrets Action
 */
model DaprSecret {
  /**
   * Secret Name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Secret Value.
   */
  @visibility(Lifecycle.Read)
  @secret
  value?: string;
}

/**
 * Collection of Storage for Environments
 */
model ConnectedEnvironmentStoragesCollection {
  /**
   * Collection of storage resources.
   */
  @pageItems
  value: ConnectedEnvironmentStorage[];
}

/**
 * Storage properties
 */
model ConnectedEnvironmentStorageProperties {
  /**
   * Provisioning state of the storage.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ConnectedEnvironmentStorageProvisioningState;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Azure file properties
   */
  azureFile?: AzureFileProperties;

  /**
   * SMB storage properties
   */
  smb?: SmbStorage;
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
  @secret
  accountKey?: string;

  /**
   * Storage account key stored as an Azure Key Vault secret.
   */
  accountKeyVaultProperties?: SecretKeyVaultProperties;

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
 * Properties for a secret stored in a Key Vault.
 */
model SecretKeyVaultProperties {
  /**
   * Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
   */
  identity?: string;

  /**
   * URL pointing to the Azure Key Vault secret.
   */
  keyVaultUrl?: string;
}

/**
 * SMB storage properties
 */
model SmbStorage {
  /**
   * The host name or IP address of the SMB server.
   */
  host?: string;

  /**
   * The path to the SMB shared folder.
   */
  shareName?: string;

  /**
   * The user to log on to the SMB server.
   */
  username?: string;

  /**
   * The domain name for the user.
   */
  domain?: string;

  /**
   * The password for the user.
   */
  @secret
  password?: string;

  /**
   * Access mode for storage
   */
  accessMode?: AccessMode;
}

/**
 * Collection of Environments
 */
model ManagedEnvironmentsCollection is Azure.Core.Page<ManagedEnvironment>;

/**
 * Managed environment resource specific properties
 */
model ManagedEnvironmentProperties {
  /**
   * Provisioning state of the Environment.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: EnvironmentProvisioningState;

  /**
   * Azure Monitor instrumentation key used by Dapr to export Service to Service communication telemetry
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @secret
  daprAIInstrumentationKey?: string;

  /**
   * Application Insights connection string used by Dapr to export Service to Service communication telemetry
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @secret
  daprAIConnectionString?: string;

  /**
   * Vnet configuration for the environment
   */
  vnetConfiguration?: VnetConfiguration;

  /**
   * Any errors that occurred during deployment or deployment validation
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Default Domain Name for the cluster
   */
  @visibility(Lifecycle.Read)
  defaultDomain?: string;

  /**
   * Private Link Default Domain Name for the environment
   */
  @visibility(Lifecycle.Read)
  privateLinkDefaultDomain?: string;

  /**
   * Static IP of the Environment
   */
  @visibility(Lifecycle.Read)
  staticIp?: string;

  /**
   * Cluster configuration which enables the log daemon to export app logs to configured destination
   */
  appLogsConfiguration?: AppLogsConfiguration;

  /**
   * Environment level Application Insights configuration
   */
  appInsightsConfiguration?: AppInsightsConfiguration;

  /**
   * Environment Open Telemetry configuration
   */
  openTelemetryConfiguration?: OpenTelemetryConfiguration;

  /**
   * Whether or not this Managed Environment is zone-redundant.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  zoneRedundant?: boolean;

  /**
   * The list of availability zones to use for managed environment
   */
  availabilityZones?: string[];

  /**
   * Custom domain configuration for the environment
   */
  customDomainConfiguration?: CustomDomainConfiguration;

  /**
   * The endpoint of the eventstream of the Environment.
   */
  @visibility(Lifecycle.Read)
  eventStreamEndpoint?: string;

  /**
   * Workload profiles configured for the Managed Environment.
   */
  @identifiers(#["name"])
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  infrastructureResourceGroup?: string;

  /**
   * Peer authentication settings for the Managed Environment
   */
  peerAuthentication?: ManagedEnvironmentPropertiesPeerAuthentication;

  /**
   * Peer traffic settings for the Managed Environment
   */
  peerTrafficConfiguration?: ManagedEnvironmentPropertiesPeerTrafficConfiguration;

  /**
   * Ingress configuration for the Managed Environment.
   */
  ingressConfiguration?: IngressConfiguration;

  /**
   * Private endpoint connections to the resource.
   */
  @visibility(Lifecycle.Read)
  privateEndpointConnections?: PrivateEndpointConnection[];

  /**
   * Property to allow or block all public traffic. Allowed Values: 'Enabled', 'Disabled'.
   */
  publicNetworkAccess?: PublicNetworkAccess;

  /**
   * Disk encryption configuration for the Managed Environment.
   */
  diskEncryptionConfiguration?: DiskEncryptionConfiguration;
}

/**
 * Configuration properties for apps environment to join a Virtual Network
 */
model VnetConfiguration {
  /**
   * Boolean indicating the environment only has an internal load balancer. These environments do not have a public static IP resource. They must provide infrastructureSubnetId if enabling this property
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  internal?: boolean;

  /**
   * Resource ID of a subnet for infrastructure components. Must not overlap with any other provided IP ranges.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  infrastructureSubnetId?: string;

  /**
   * CIDR notation IP range assigned to the Docker bridge, network. Must not overlap with any other provided IP ranges.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  dockerBridgeCidr?: string;

  /**
   * IP range in CIDR notation that can be reserved for environment infrastructure IP addresses. Must not overlap with any other provided IP ranges.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  platformReservedCidr?: string;

  /**
   *  An IP address from the IP range defined by platformReservedCidr that will be reserved for the internal DNS server.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  sharedKey?: string;

  /**
   * Boolean indicating whether to parse json string log into dynamic json columns
   */
  dynamicJsonColumns?: boolean;
}

/**
 * Configuration of Application Insights
 */
model AppInsightsConfiguration {
  /**
   * Application Insights connection string
   */
  @secret
  connectionString?: string;
}

/**
 * Configuration of Open Telemetry
 */
model OpenTelemetryConfiguration {
  /**
   * Open telemetry destinations configuration
   */
  destinationsConfiguration?: DestinationsConfiguration;

  /**
   * Open telemetry trace configuration
   */
  tracesConfiguration?: TracesConfiguration;

  /**
   * Open telemetry logs configuration
   */
  logsConfiguration?: LogsConfiguration;

  /**
   * Open telemetry metrics configuration
   */
  metricsConfiguration?: MetricsConfiguration;
}

/**
 * Configuration of Open Telemetry destinations
 */
model DestinationsConfiguration {
  /**
   * Open telemetry datadog destination configuration
   */
  dataDogConfiguration?: DataDogConfiguration;

  /**
   * Open telemetry otlp configurations
   */
  @identifiers(#["name"])
  otlpConfigurations?: OtlpConfiguration[];
}

/**
 * Configuration of datadog
 */
model DataDogConfiguration {
  /**
   * The data dog site
   */
  site?: string;

  /**
   * The data dog api key
   */
  @secret
  key?: string;
}

/**
 * Configuration of otlp
 */
model OtlpConfiguration {
  /**
   * The name of otlp configuration
   */
  name?: string;

  /**
   * The endpoint of otlp configuration
   */
  endpoint?: string;

  /**
   * Boolean indicating if otlp configuration is insecure
   */
  insecure?: boolean;

  /**
   * Headers of otlp configurations
   */
  @identifiers(#["key"])
  headers?: Header[];
}

/**
 * Header of otlp configuration
 */
model Header {
  /**
   * The key of otlp configuration header
   */
  key?: string;

  /**
   * The value of otlp configuration header
   */
  value?: string;
}

/**
 * Configuration of Open Telemetry traces
 */
model TracesConfiguration {
  /**
   * Boolean indicating if including dapr traces
   */
  includeDapr?: boolean;

  /**
   * Open telemetry traces destinations
   */
  destinations?: string[];
}

/**
 * Configuration of Open Telemetry logs
 */
model LogsConfiguration {
  /**
   * Open telemetry logs destinations
   */
  destinations?: string[];
}

/**
 * Configuration of Open Telemetry metrics
 */
model MetricsConfiguration {
  /**
   * Boolean indicating if including keda metrics
   */
  includeKeda?: boolean;

  /**
   * Open telemetry metrics destinations
   */
  destinations?: string[];
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
   * Whether to use a FIPS-enabled OS. Supported only for dedicated workload profiles.
   */
  enableFips?: boolean = false;

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
  @visibility(Lifecycle.Read)
  version?: string;
}

/**
 * Configuration properties Dapr component
 */
model DaprConfiguration {
  /**
   * The version of Dapr
   */
  @visibility(Lifecycle.Read)
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
  enabled?: boolean;
}

/**
 * Peer traffic settings for the Managed Environment
 */
model ManagedEnvironmentPropertiesPeerTrafficConfiguration {
  /**
   * Peer traffic encryption settings for the Managed Environment
   */
  encryption?: ManagedEnvironmentPropertiesPeerTrafficConfigurationEncryption;
}

/**
 * Peer traffic encryption settings for the Managed Environment
 */
model ManagedEnvironmentPropertiesPeerTrafficConfigurationEncryption {
  /**
   * Boolean indicating whether the peer traffic encryption is enabled
   */
  enabled?: boolean;
}

/**
 * Settings for the ingress component, including workload profile, scaling, and connection handling.
 */
model IngressConfiguration {
  /**
   * Name of the workload profile used by the ingress component. Required.
   */
  workloadProfileName?: string;

  /**
   * Time (in seconds) to allow active connections to complete on termination. Must be between 0 and 3600. Defaults to 480 seconds.
   */
  terminationGracePeriodSeconds?: int32;

  /**
   * Maximum number of headers per request allowed by the ingress. Must be at least 1. Defaults to 100.
   */
  headerCountLimit?: int32;

  /**
   * Duration (in minutes) before idle requests are timed out. Must be between 4 and 30 inclusive. Defaults to 4 minutes.
   */
  requestIdleTimeout?: int32;
}

/**
 * Properties of the private endpoint connection.
 */
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility(Lifecycle.Read)
  groupIds?: string[];

  /**
   * The resource of private end point.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: PrivateEndpointConnectionProvisioningState;
}

/**
 * The Private Endpoint resource.
 */
model PrivateEndpoint {
  /**
   * The ARM identifier for Private Endpoint
   */
  @visibility(Lifecycle.Read)
  id?: Azure.Core.armResourceIdentifier;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * Configuration properties for disk encryption
 */
model DiskEncryptionConfiguration {
  /**
   * The Key Vault that contains your key to use for disk encryption. The Key Vault must be in the same region as the Managed Environment.
   */
  keyVaultConfiguration?: DiskEncryptionConfigurationKeyVaultConfiguration;
}

/**
 * The Key Vault that contains your key to use for disk encryption. The Key Vault must be in the same region as the Managed Environment.
 */
model DiskEncryptionConfigurationKeyVaultConfiguration {
  /**
   * Key URL pointing to a key in KeyVault. Version segment of the Url is required.
   */
  keyUrl?: url;

  /**
   * Configuration properties for the authentication to the Key Vault
   */
  auth?: DiskEncryptionConfigurationKeyVaultConfigurationAuth;
}

/**
 * Configuration properties for the authentication to the Key Vault
 */
model DiskEncryptionConfigurationKeyVaultConfigurationAuth {
  /**
   * Resource ID of a user-assigned managed identity to authenticate to the Key Vault. The identity must be assigned to the managed environment, in the same tenant as the Key Vault, and it must have the following key permissions on the Key Vault: wrapkey, unwrapkey, get.
   */
  identity?: Azure.Core.armResourceIdentifier;
}

/**
 * Certificate resource specific properties
 */
model ManagedCertificateProperties {
  /**
   * Provisioning state of the certificate.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: CertificateProvisioningState;

  /**
   * Subject name of the certificate.
   */
  subjectName?: string;

  /**
   * Any error occurred during the certificate provision.
   */
  @visibility(Lifecycle.Read)
  error?: string;

  /**
   * Selected type of domain control validation for managed certificates.
   */
  domainControlValidation?: ManagedCertificateDomainControlValidation;

  /**
   * A TXT token used for DNS TXT domain control validation when issuing this type of managed certificates.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" ""
  @visibility(Lifecycle.Read)
  validationToken?: string;
}

/**
 * A managed certificate to update
 */
model ManagedCertificatePatch {
  /**
   * Application-specific metadata in the form of key-value pairs.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

/**
 * Collection of Managed Certificates.
 */
model ManagedCertificateCollection is Azure.Core.Page<ManagedCertificate>;

/**
 * Environment Auth Token.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model EnvironmentAuthToken
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * Environment auth token resource specific properties
   */
  properties?: EnvironmentAuthTokenProperties;
}

/**
 * Environment auth token resource specific properties
 */
model EnvironmentAuthTokenProperties {
  /**
   * Auth token value.
   */
  @visibility(Lifecycle.Read)
  @secret
  token?: string;

  /**
   * Token expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

/**
 * Collection of workloadProfileStates
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
model workloadProfileStatesCollection is Azure.Core.Page<workloadProfileStates>;

/**
 * Collection of all the workload Profile States for a Managed Environment..
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model workloadProfileStates
  extends Azure.ResourceManager.CommonTypes.ProxyResource {
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
 * A private link resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model PrivateLinkResource extends Azure.ResourceManager.CommonTypes.Resource {
  /**
   * Resource properties.
   */
  properties?: PrivateLinkResourceProperties;
}

/**
 * Properties of a private link resource.
 */
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility(Lifecycle.Read)
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility(Lifecycle.Read)
  requiredMembers?: string[];

  /**
   * The private link resource private link DNS zone name.
   */
  requiredZoneNames?: string[];
}

/**
 * Dapr Component Resiliency Policies ARM resource.
 */
model DaprComponentResiliencyPoliciesCollection
  is Azure.Core.Page<DaprComponentResiliencyPolicy>;

/**
 * Dapr Component Resiliency Policy resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DaprComponentResiliencyPolicyProperties {
  /**
   * The optional inbound component resiliency policy configuration
   */
  inboundPolicy?: DaprComponentResiliencyPolicyConfiguration;

  /**
   * The optional outbound component resiliency policy configuration
   */
  outboundPolicy?: DaprComponentResiliencyPolicyConfiguration;
}

/**
 * Dapr Component Resiliency Policy Configuration.
 */
model DaprComponentResiliencyPolicyConfiguration {
  /**
   * The optional HTTP retry policy configuration
   */
  httpRetryPolicy?: DaprComponentResiliencyPolicyHttpRetryPolicyConfiguration;

  /**
   * The optional timeout policy configuration
   */
  timeoutPolicy?: DaprComponentResiliencyPolicyTimeoutPolicyConfiguration;

  /**
   * The optional circuit breaker policy configuration
   */
  circuitBreakerPolicy?: DaprComponentResiliencyPolicyCircuitBreakerPolicyConfiguration;
}

/**
 * Dapr Component Resiliency Policy HTTP Retry Policy Configuration.
 */
model DaprComponentResiliencyPolicyHttpRetryPolicyConfiguration {
  /**
   * The optional maximum number of retries
   */
  maxRetries?: int32;

  /**
   * The optional retry backoff configuration
   */
  retryBackOff?: DaprComponentResiliencyPolicyHttpRetryBackOffConfiguration;
}

/**
 * Dapr Component Resiliency Policy HTTP Retry Backoff Configuration.
 */
model DaprComponentResiliencyPolicyHttpRetryBackOffConfiguration {
  /**
   * The optional initial delay in milliseconds before an operation is retried
   */
  initialDelayInMilliseconds?: int32;

  /**
   * The optional maximum time interval in milliseconds between retry attempts
   */
  maxIntervalInMilliseconds?: int32;
}

/**
 * Dapr Component Resiliency Policy Timeout Policy Configuration.
 */
model DaprComponentResiliencyPolicyTimeoutPolicyConfiguration {
  /**
   * The optional response timeout in seconds
   */
  responseTimeoutInSeconds?: int32;
}

/**
 * Dapr Component Resiliency Policy Circuit Breaker Policy Configuration.
 */
model DaprComponentResiliencyPolicyCircuitBreakerPolicyConfiguration {
  /**
   * The number of consecutive errors before the circuit is opened.
   */
  consecutiveErrors?: int32;

  /**
   * The interval in seconds until a retry attempt is made after the circuit is opened.
   */
  timeoutInSeconds?: int32;

  /**
   * The optional interval in seconds after which the error count resets to 0. An interval of 0 will never reset. If not specified, the timeoutInSeconds value will be used.
   */
  intervalInSeconds?: int32;
}

/**
 * Dapr Subscriptions ARM resource.
 */
model DaprSubscriptionsCollection is Azure.Core.Page<DaprSubscription>;

/**
 * Dapr PubSub Event Subscription resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model DaprSubscriptionProperties {
  /**
   * Dapr PubSub component name
   */
  pubsubName?: string;

  /**
   * Topic name
   */
  topic?: string;

  /**
   * Deadletter topic name
   */
  deadLetterTopic?: string;

  /**
   * Subscription routes
   */
  routes?: DaprSubscriptionRoutes;

  /**
   * Application scopes to restrict the subscription to specific apps.
   */
  scopes?: string[];

  /**
   * Subscription metadata
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Bulk subscription options
   */
  bulkSubscribe?: DaprSubscriptionBulkSubscribeOptions;
}

/**
 * Dapr PubSub Event Subscription Routes configuration.
 */
model DaprSubscriptionRoutes {
  /**
   * The list of Dapr PubSub Event Subscription Route Rules.
   */
  @identifiers(#[])
  rules?: DaprSubscriptionRouteRule[];

  /**
   * The default path to deliver events that do not match any of the rules.
   */
  default?: string;
}

/**
 * Dapr Pubsub Event Subscription Route Rule is used to specify the condition for sending a message to a specific path.
 */
model DaprSubscriptionRouteRule {
  /**
   * The optional CEL expression used to match the event. If the match is not specified, then the route is considered the default. The rules are tested in the order specified, so they should be define from most-to-least specific. The default route should appear last in the list.
   */
  match?: string;

  /**
   * The path for events that match this rule
   */
  path?: string;
}

/**
 * Dapr PubSub Bulk Subscription Options.
 */
model DaprSubscriptionBulkSubscribeOptions {
  /**
   * Enable bulk subscription
   */
  enabled?: boolean = false;

  /**
   * Maximum number of messages to deliver in a bulk message.
   */
  maxMessagesCount?: int32;

  /**
   * Maximum duration in milliseconds to wait before a bulk message is sent to the app.
   */
  maxAwaitDurationMs?: int32;
}

/**
 * Http Route Config properties
 */
model HttpRouteConfigProperties {
  /**
   * The provisioning state of the Http Route Config in cluster
   */
  @visibility(Lifecycle.Read)
  provisioningState?: HttpRouteProvisioningState;

  /**
   * List of errors when trying to reconcile http routes
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @visibility(Lifecycle.Read)
  provisioningErrors?: HttpRouteProvisioningErrors[];

  /**
   * FQDN of the route resource.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * Custom domain bindings for http Routes' hostnames.
   */
  @identifiers(#["name"])
  customDomains?: CustomDomain[];

  /**
   * Routing Rules for http route resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @identifiers(#["name"])
  rules?: HttpRouteRule[];
}

/**
 * List of provisioning errors for a http route config object
 */
model HttpRouteProvisioningErrors {
  /**
   * Timestamp error occured at
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timestamp?: utcDateTime;

  /**
   * Description or error message
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Http Route rule.
 */
model HttpRouteRule {
  /**
   * Targets- container apps, revisions, labels
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @identifiers(#["name"])
  targets?: HttpRouteTarget[];

  /**
   * Routing configuration that will allow matches on specific paths/headers.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @identifiers(#["name"])
  routes?: HttpRoute[];

  /**
   * Description of rule. Optional.
   */
  description?: string;
}

/**
 * Targets - Container App Names, Revision Names, Labels.
 */
model HttpRouteTarget {
  /**
   * Container App Name to route requests to
   */
  containerApp: string;

  /**
   * Revision to route requests to
   */
  revision?: string;

  /**
   * Label/Revision to route requests to
   */
  label?: string;

  /**
   * Weighted routing
   */
  @minValue(0)
  @maxValue(100)
  weight?: int32;
}

/**
 * Http Routes configuration, including paths to match on and whether or not rewrites are to be done.
 */
model HttpRoute {
  /**
   * Conditions route will match on
   */
  match?: HttpRouteMatch;

  /**
   * Once route is matched, what is the desired action
   */
  action?: HttpRouteAction;
}

/**
 * Criteria to match on
 */
model HttpRouteMatch {
  /**
   * match on all prefix's. Not exact
   */
  prefix?: string;

  /**
   * match on exact path
   */
  path?: string;

  /**
   * match on all prefix's. Not exact
   */
  pathSeparatedPrefix?: string;

  /**
   * path case sensitive, default is true
   */
  caseSensitive?: boolean;
}

/**
 * Action to perform once matching of routes is done
 */
model HttpRouteAction {
  /**
   * Rewrite prefix, default is no rewrites
   */
  prefixRewrite?: string;
}

/**
 * Collection of Advanced Ingress Routing Config resources.
 */
model HttpRouteConfigCollection is Azure.Core.Page<HttpRouteConfig>;

/**
 * The response of list maintenance configuration resources.
 */
model MaintenanceConfigurationCollection
  is Azure.Core.Page<MaintenanceConfigurationResource>;

/**
 * List of maintenance schedules for a managed environment.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ScheduledEntries {
  /**
   * List of maintenance schedules for a managed environment.
   */
  #suppress "@azure-tools/typespec-client-generator-core/property-name-conflict" ""
  @identifiers(#[])
  scheduledEntries: ScheduledEntry[];
}

/**
 * Maintenance schedule entry for a managed environment.
 */
model ScheduledEntry {
  /**
   * Day of the week when a managed environment can be patched.
   */
  weekDay: WeekDay;

  /**
   * Start hour after which managed environment maintenance can start from 0 to 23 hour.
   */
  startHourUtc: int32;

  /**
   * Length of maintenance window range from 8 to 24 hours.
   */
  durationHours: int32;
}

/**
 * Collection of Storage for Environments
 */
model ManagedEnvironmentStoragesCollection {
  /**
   * Collection of storage resources.
   */
  @pageItems
  value: ManagedEnvironmentStorage[];
}

/**
 * Storage properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ManagedEnvironmentStorageProperties {
  /**
   * Azure file properties
   */
  azureFile?: AzureFileProperties;

  /**
   * NFS Azure file properties
   */
  nfsAzureFile?: NfsAzureFileProperties;
}

/**
 * NFS Azure File Properties.
 */
model NfsAzureFileProperties {
  /**
   * Server for NFS azure file.
   */
  server?: string;

  /**
   * Access mode for storage
   */
  accessMode?: AccessMode;

  /**
   * NFS Azure file share name.
   */
  shareName?: string;
}

/**
 * Container Apps Jobs collection ARM resource.
 */
model JobsCollection is Azure.Core.Page<Job>;

/**
 * Container Apps Job resource specific properties.
 */
model JobProperties {
  /**
   * Provisioning state of the Container Apps Job.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: JobProvisioningState;

  /**
   * Current running state of the job
   */
  @visibility(Lifecycle.Read)
  runningState?: JobRunningState;

  /**
   * Resource ID of environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
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
  @visibility(Lifecycle.Read)
  outboundIpAddresses?: string[];

  /**
   * The endpoint of the eventstream of the container apps job.
   */
  @visibility(Lifecycle.Read)
  eventStreamEndpoint?: string;
}

/**
 * Non versioned Container Apps Job configuration properties
 */
model JobConfiguration {
  /**
   * Collection of secrets used by a Container Apps Job
   */
  @identifiers(#["name"])
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
  @identifiers(#["server"])
  registries?: RegistryCredentials[];

  /**
   * Optional settings for Managed Identities that are assigned to the Container App Job. If a Managed Identity is not specified here, default settings will be used.
   */
  @identifiers(#["identity"])
  identitySettings?: IdentitySettings[];
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
  minExecutions?: int32 = 0;

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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  metadata?: unknown;

  /**
   * Authentication secrets for the scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  auth?: ScaleRuleAuth[];

  /**
   * The resource ID of a user-assigned managed identity that is assigned to the job, or 'system' for system-assigned identity.
   */
  identity?: string;
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
 * Container Apps Job versioned application definition. Defines the desired state of an immutable revision. Any changes to this section Will result in a new revision being created
 */
model JobTemplate {
  /**
   * List of specialized containers that run before app containers.
   */
  @identifiers(#["name"])
  initContainers?: InitContainer[];

  /**
   * List of container definitions for the Container App.
   */
  @identifiers(#["name"])
  containers?: Container[];

  /**
   * List of volume definitions for the Container App.
   */
  @identifiers(#["name"])
  volumes?: Volume[];
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
  @identifiers(#["secretRef"])
  secrets?: SecretVolumeItem[];

  /**
   * Mount options used while mounting the Azure file share or NFS Azure file share. Must be a comma-separated string.
   */
  mountOptions?: string;
}

/**
 * Container Apps Job resource specific properties.
 */
model JobPatchProperties {
  /**
   * The complex type of the extended location.
   */
  extendedLocation?: ExtendedLocation;

  /**
   * Managed identities needed by a container app job to interact with other Azure services to not maintain any secrets or credentials in code.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
  properties?: JobPatchPropertiesProperties;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model JobPatchPropertiesProperties {
  /**
   * Resource ID of environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
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
  @identifiers(#["name"])
  containers?: JobExecutionContainer[];

  /**
   * List of specialized containers that run before job containers.
   */
  @identifiers(#["name"])
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
  @identifiers(#["name"])
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
 * Container App executions collection ARM resource.
 */
model ContainerAppJobExecutions is Azure.Core.Page<JobExecution>;

/**
 * Container Apps Job execution specific properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model JobExecutionProperties {
  /**
   * Current running State of the job
   */
  @visibility(Lifecycle.Read)
  status?: JobExecutionRunningState;

  /**
   * Job execution start time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  startTime?: utcDateTime;

  /**
   * Job execution end time.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  endTime?: utcDateTime;

  /**
   * Job's execution container.
   */
  template?: JobExecutionTemplate;

  /**
   * Detailed status of the job execution.
   */
  detailedStatus?: ExecutionStatus;

  /**
   * Reason for the current condition of job execution.
   */
  @visibility(Lifecycle.Read)
  reason?: string;

  /**
   * Human readable message indicating details about the current condition of the job execution.
   */
  @visibility(Lifecycle.Read)
  message?: string;
}

/**
 * Container Apps Job execution status.
 */
model ExecutionStatus {
  /**
   * Replicas in the execution.
   */
  @identifiers(#["name"])
  replicas?: ReplicaExecutionStatus[];
}

/**
 * Container Apps Job execution replica status.
 */
model ReplicaExecutionStatus {
  /**
   * Replica Name.
   */
  name?: string;

  /**
   * Containers in the execution replica
   */
  @identifiers(#["name"])
  containers?: ContainerExecutionStatus[];
}

/**
 * Container Apps Job execution container status. Contains status code and reason
 */
model ContainerExecutionStatus {
  /**
   * Container Name.
   */
  name?: string;

  /**
   * Exit code
   */
  code?: int32;

  /**
   * Additional information for the container status
   */
  additionalInformation?: string;

  /**
   * Status of the container
   */
  status?: string;
}

/**
 * Container Apps Job Secrets Collection ARM resource.
 */
model JobSecretsCollection {
  /**
   * Collection of resources.
   */
  @pageItems
  @identifiers(#["name"])
  value: Secret[];
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];

  /**
   * The resource ID of a user-assigned managed identity that is assigned to the Container App, or 'system' for system-assigned identity.
   */
  identity?: string;
}

/**
 * Container App container Tcp scaling rule.
 */
model TcpScaleRule {
  /**
   * Metadata properties to describe tcp scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the tcp scale rule.
   */
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];

  /**
   * The resource ID of a user-assigned managed identity that is assigned to the Container App, or 'system' for system-assigned identity.
   */
  identity?: string;
}

/**
 * Container App container Azure Queue based scaling rule.
 */
model QueueScaleRule {
  /**
   * Storage account name. required if using managed identity to authenticate
   */
  accountName?: string;

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
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];

  /**
   * The resource ID of a user-assigned managed identity that is assigned to the Container App, or 'system' for system-assigned identity.
   */
  identity?: string;
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
  @identifiers(#["name"])
  initContainers?: InitContainer[];

  /**
   * List of container definitions for the Container App.
   */
  @identifiers(#["name"])
  containers?: Container[];

  /**
   * Scaling properties for the Container App.
   */
  scale?: Scale;

  /**
   * List of volume definitions for the Container App.
   */
  @identifiers(#["name"])
  volumes?: Volume[];

  /**
   * List of container app services bound to the app
   */
  @identifiers(#["name"])
  serviceBinds?: ServiceBind[];
}

/**
 * Diagnostics data collection for a resource.
 */
model DiagnosticsCollection is Azure.Core.Page<Diagnostics>;

/**
 * Diagnostics resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
model DiagnosticsProperties {
  /**
   * Metadata of the diagnostics response.
   */
  metadata?: DiagnosticsDefinition;

  /**
   * Set of data collections associated with the response.
   */
  @identifiers(#[])
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
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Display Name of the detector
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Details of the diagnostics info
   */
  @visibility(Lifecycle.Read)
  description?: string;

  /**
   * Authors' names of the detector
   */
  @visibility(Lifecycle.Read)
  author?: string;

  /**
   * Category of the detector
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Authors' names of the detector
   */
  @visibility(Lifecycle.Read)
  score?: float32;
}

/**
 * Support topic information
 */
model DiagnosticSupportTopic {
  /**
   * Unique topic identifier
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * PES identifier
   */
  @visibility(Lifecycle.Read)
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
  @identifiers(#["columnName"])
  columns?: DiagnosticDataTableResponseColumn[];

  /**
   * Rows in the table
   */
  // @identifiers(#[])
  rows?: unknown[];
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
  @identifiers(#["name"])
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
 * Container App executions names list.
 */
model JobExecutionNamesCollection {
  /**
   * Collection of resources.
   */
  value: JobExecutionBase[];
}

/**
 * The container type of the sessions.
 */
union ContainerType {
  string,

  /**
   * CustomContainer
   */
  CustomContainer: "CustomContainer",

  /**
   * PythonLTS
   */
  PythonLTS: "PythonLTS",
}

/**
 * The pool management type of the session pool.
 */
union PoolManagementType {
  string,

  /**
   * Manual
   */
  Manual: "Manual",

  /**
   * Dynamic
   */
  Dynamic: "Dynamic",
}

/**
 * The lifecycle type of the session pool.
 */
union LifecycleType {
  string,

  /**
   * Timed
   */
  Timed: "Timed",

  /**
   * OnContainerExit
   */
  OnContainerExit: "OnContainerExit",
}

/**
 * Denotes the type of probe. Can be Liveness or Startup, Readiness probe is not supported in sessions. Type must be unique for each probe within the context of a list of probes (SessionProbes).
 */
union SessionProbeType {
  string,

  /**
   * Liveness
   */
  Liveness: "Liveness",

  /**
   * Startup
   */
  Startup: "Startup",
}

/**
 * Scheme to use for connecting to the host. Defaults to HTTP.
 */
union Scheme {
  string,

  /**
   * HTTP
   */
  HTTP: "HTTP",

  /**
   * HTTPS
   */
  HTTPS: "HTTPS",
}

/**
 * Network status for the sessions.
 */
union SessionNetworkStatus {
  string,

  /**
   * EgressEnabled
   */
  EgressEnabled: "EgressEnabled",

  /**
   * EgressDisabled
   */
  EgressDisabled: "EgressDisabled",
}

/**
 * Provisioning state of the session pool.
 */
union SessionPoolProvisioningState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Use to select the lifecycle stages of a Session Pool during which the Managed Identity should be available.
 */
union IdentitySettingsLifeCycle {
  string,

  /**
   * None
   */
  None: "None",

  /**
   * Main
   */
  Main: "Main",

  /**
   * Init
   */
  Init: "Init",

  /**
   * All
   */
  All: "All",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Current provisioning State of the operation
 */
union SourceControlOperationState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",
}

/**
 * The type of extendedLocation.
 */
union ExtendedLocationTypes {
  string,

  /**
   * CustomLocation
   */
  CustomLocation: "CustomLocation",
}

/**
 * Metadata to represent the container app kind, representing if a container app is workflowapp or functionapp.
 */
union Kind {
  string,

  /**
   * workflowapp
   */
  workflowapp: "workflowapp",

  /**
   * functionapp
   */
  functionapp: "functionapp",
}

/**
 * Provisioning state of the Container App.
 */
union ContainerAppProvisioningState {
  string,

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Running status of the Container App.
 */
union ContainerAppRunningStatus {
  string,

  /**
   * Container App is transitioning between Stopped and Running states.
   */
  Progressing: "Progressing",

  /**
   * Container App is in Running state.
   */
  Running: "Running",

  /**
   * Container App is in Stopped state.
   */
  Stopped: "Stopped",

  /**
   * Container App Job is in Suspended state.
   */
  Suspended: "Suspended",

  /**
   * Container App Job is in Ready state.
   */
  Ready: "Ready",
}

/**
 * Patching mode for the container app. Null or default in this field will be interpreted as Automatic by RP. Automatic mode will automatically apply available patches. Manual mode will require the user to manually apply patches. Disabled mode will stop patch detection and auto patching.
 */
union PatchingMode {
  string,

  /**
   * Automatic
   */
  Automatic: "Automatic",

  /**
   * Manual
   */
  Manual: "Manual",

  /**
   * Disabled
   */
  Disabled: "Disabled",
}

/**
 * ActiveRevisionsMode controls how active revisions are handled for the Container app:
 * <list><item>Single: Only one revision can be active at a time. Traffic weights cannot be used. This is the default.</item><item>Multiple: Multiple revisions can be active, including optional traffic weights and labels.</item><item>Labels: Only revisions with labels are active. Traffic weights can be applied to labels.</item></list>
 */
union ActiveRevisionsMode {
  string,

  /**
   * Multiple
   */
  Multiple: "Multiple",

  /**
   * Single
   */
  Single: "Single",

  /**
   * Labels
   */
  Labels: "Labels",
}

/**
 * Ingress transport protocol
 */
union IngressTransportMethod {
  string,

  /**
   * auto
   */
  auto: "auto",

  /**
   * http
   */
  http: "http",

  /**
   * http2
   */
  http2: "http2",

  /**
   * tcp
   */
  tcp: "tcp",
}

/**
 * Custom Domain binding type.
 */
union BindingType {
  string,

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * SniEnabled
   */
  SniEnabled: "SniEnabled",

  /**
   * Auto
   */
  Auto: "Auto",
}

/**
 * Allow or Deny rules to determine for incoming IP. Note: Rules can only consist of ALL Allow or ALL Deny
 */
union Action {
  string,

  /**
   * Allow
   */
  Allow: "Allow",

  /**
   * Deny
   */
  Deny: "Deny",
}

/**
 * Sticky Session Affinity
 */
union Affinity {
  string,

  /**
   * sticky
   */
  sticky: "sticky",

  /**
   * none
   */
  none: "none",
}

/**
 * Client certificate mode for mTLS authentication. Ignore indicates server drops client certificate on forwarding. Accept indicates server forwards client certificate but does not require a client certificate. Require indicates server requires a client certificate.
 */
union IngressClientCertificateMode {
  string,

  /**
   * ignore
   */
  ignore: "ignore",

  /**
   * accept
   */
  accept: "accept",

  /**
   * require
   */
  require: "require",
}

/**
 * Whether an http app listens on http or https
 */
union IngressTargetPortHttpScheme {
  string,

  /**
   * http
   */
  http: "http",

  /**
   * https
   */
  https: "https",
}

/**
 * Tells Dapr which protocol your application is using. Valid options are http and grpc. Default is http
 */
union AppProtocol {
  string,

  /**
   * http
   */
  http: "http",

  /**
   * grpc
   */
  grpc: "grpc",
}

/**
 * Sets the log level for the Dapr sidecar. Allowed values are debug, info, warn, error. Default is info.
 */
union LogLevel {
  string,

  /**
   * info
   */
  info: "info",

  /**
   * debug
   */
  debug: "debug",

  /**
   * warn
   */
  warn: "warn",

  /**
   * error
   */
  error: "error",
}

/**
 * The specified logger's log level.
 */
union Level {
  string,

  /**
   * off
   */
  off: "off",

  /**
   * error
   */
  error: "error",

  /**
   * info
   */
  info: "info",

  /**
   * debug
   */
  debug: "debug",

  /**
   * trace
   */
  trace: "trace",

  /**
   * warn
   */
  warn: "warn",
}

/**
 * The type of the image. Set to CloudBuild to let the system manages the image, where user will not be able to update image through image field. Set to ContainerImage for user provided image.
 */
union ImageType {
  string,

  /**
   * CloudBuild
   */
  CloudBuild: "CloudBuild",

  /**
   * ContainerImage
   */
  ContainerImage: "ContainerImage",
}

/**
 * The type of probe.
 */
union Type {
  string,

  /**
   * Liveness
   */
  Liveness: "Liveness",

  /**
   * Readiness
   */
  Readiness: "Readiness",

  /**
   * Startup
   */
  Startup: "Startup",
}

/**
 * Storage type for the volume. If not provided, use EmptyDir.
 */
union StorageType {
  string,

  /**
   * AzureFile
   */
  AzureFile: "AzureFile",

  /**
   * EmptyDir
   */
  EmptyDir: "EmptyDir",

  /**
   * Secret
   */
  Secret: "Secret",

  /**
   * NfsAzureFile
   */
  NfsAzureFile: "NfsAzureFile",

  /**
   * Smb
   */
  Smb: "Smb",
}

/**
 * Resource instance provisioning state.
 */
union BuildProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Creating
   */
  Creating: "Creating",

  /**
   * Updating
   */
  Updating: "Updating",

  /**
   * Deleting
   */
  Deleting: "Deleting",
}

/**
 * Status of the build once it has been provisioned.
 */
union BuildStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * InProgress
   */
  InProgress: "InProgress",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * Status of the label history record.
 */
union Status {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Starting
   */
  Starting: "Starting",
}

/**
 * The status of the patch once it has been provisioned
 */
union PatchApplyStatus {
  string,

  /**
   * NotStarted
   */
  NotStarted: "NotStarted",

  /**
   * RebaseInProgress
   */
  RebaseInProgress: "RebaseInProgress",

  /**
   * CreatingRevision
   */
  CreatingRevision: "CreatingRevision",

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * RebaseFailed
   */
  RebaseFailed: "RebaseFailed",

  /**
   * RevisionCreationFailed
   */
  RevisionCreationFailed: "RevisionCreationFailed",

  /**
   * ImagePushPullFailed
   */
  ImagePushPullFailed: "ImagePushPullFailed",

  /**
   * ManuallySkipped
   */
  ManuallySkipped: "ManuallySkipped",
}

/**
 * The status of the patch detection.
 */
union DetectionStatus {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * RegistryLoginFailed
   */
  RegistryLoginFailed: "RegistryLoginFailed",

  /**
   * Failed
   */
  Failed: "Failed",
}

/**
 * The type for the patch.
 */
union PatchType {
  string,

  /**
   * FrameworkSecurity
   */
  FrameworkSecurity: "FrameworkSecurity",

  /**
   * OSSecurity
   */
  OSSecurity: "OSSecurity",

  /**
   * FrameworkAndOSSecurity
   */
  FrameworkAndOSSecurity: "FrameworkAndOSSecurity",

  /**
   * Other
   */
  Other: "Other",
}

/**
 * Current health State of the revision
 */
union RevisionHealthState {
  string,

  /**
   * Healthy
   */
  Healthy: "Healthy",

  /**
   * Unhealthy
   */
  Unhealthy: "Unhealthy",

  /**
   * None
   */
  None: "None",
}

/**
 * Current provisioning State of the revision
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
union RevisionProvisioningState {
  string,

  /**
   * Provisioning
   */
  Provisioning: "Provisioning",

  /**
   * Provisioned
   */
  Provisioned: "Provisioned",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Deprovisioning
   */
  Deprovisioning: "Deprovisioning",

  /**
   * Deprovisioned
   */
  Deprovisioned: "Deprovisioned",
}

/**
 * Current running state of the revision
 */
union RevisionRunningState {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Processing
   */
  Processing: "Processing",

  /**
   * Stopped
   */
  Stopped: "Stopped",

  /**
   * Degraded
   */
  Degraded: "Degraded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Current running state of the replica
 */
union ContainerAppReplicaRunningState {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * NotRunning
   */
  NotRunning: "NotRunning",

  /**
   * Unknown
   */
  Unknown: "Unknown",
}

/**
 * Current running state of the container
 */
union ContainerAppContainerRunningState {
  string,

  /**
   * Running
   */
  Running: "Running",

  /**
   * Terminated
   */
  Terminated: "Terminated",

  /**
   * Waiting
   */
  Waiting: "Waiting",
}

/**
 * Type of the .NET Component.
 */
union DotNetComponentType {
  string,

  /**
   * AspireDashboard
   */
  AspireDashboard: "AspireDashboard",
}

/**
 * Provisioning state of the .NET Component.
 */
union DotNetComponentProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * Type of the Java Component.
 */
union JavaComponentType {
  string,

  /**
   * SpringBootAdmin
   */
  SpringBootAdmin: "SpringBootAdmin",

  /**
   * SpringCloudEureka
   */
  SpringCloudEureka: "SpringCloudEureka",

  /**
   * SpringCloudConfig
   */
  SpringCloudConfig: "SpringCloudConfig",

  /**
   * SpringCloudGateway
   */
  SpringCloudGateway: "SpringCloudGateway",

  /**
   * Nacos
   */
  Nacos: "Nacos",
}

/**
 * Provisioning state of the Java Component.
 */
union JavaComponentProvisioningState {
  string,

  /**
   * Succeeded
   */
  Succeeded: "Succeeded",

  /**
   * Failed
   */
  Failed: "Failed",

  /**
   * Canceled
   */
  Canceled: "Canceled",

  /**
   * Deleting
   */
  Deleting: "Deleting",

  /**
   * InProgress
   */
  InProgress: "InProgress",
}

/**
 * Gets the logic app hybrid workflow kind.
 */
union WorkflowKind {
  string,

  /**
   * Stateful
   */
  Stateful: "Stateful",

  /**
   * Stateless
   */
  Stateless: "Stateless",

  /**
   * Agentic
   */
  Agentic: "Agentic",
}

/**
 * The workflow state.
 */
union WorkflowState {
  string,

  /**
   * NotSpecified
   */
  NotSpecified: "NotSpecified",

  /**
   * Completed
   */
  Completed: "Completed",

  /**
   * Enabled
   */
  Enabled: "Enabled",

  /**
   * Disabled
   */
  Disabled: "Disabled",

  /**
   * Deleted
   */
  Deleted: "Deleted",

  /**
   * Suspended
   */
  Suspended: "Suspended",
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
union LogicAppsProxyMethod {
  string,

  /**
   * GET
   */
  GET: "GET",

  /**
   * POST
   */
  POST: "POST",
}

/**
 * DNS verification test result.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum DnsVerificationTestResult {
  /**
   * Passed
   */
  Passed,

  /**
   * Failed
   */
  Failed,

  /**
   * Skipped
   */
  Skipped,
}

/**
 * Gets or sets the workflow health state.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum WorkflowHealthState {
  /**
   * NotSpecified
   */
  NotSpecified,

  /**
   * Healthy
   */
  Healthy,

  /**
   * Unhealthy
   */
  Unhealthy,

  /**
   * Unknown
   */
  Unknown,
}

/**
 * Session pool collection Azure resource.
 */
model SessionPoolCollection is Azure.Core.Page<SessionPool>;

/**
 * Container App session pool resource specific properties
 */
model SessionPoolProperties {
  /**
   * Resource ID of the session pool's environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.App/managedEnvironments";
    }
  ]>;

  /**
   * The container type of the sessions.
   */
  containerType?: ContainerType;

  /**
   * The pool management type of the session pool.
   */
  poolManagementType?: PoolManagementType;

  /**
   * The number of nodes the session pool is using.
   */
  @visibility(Lifecycle.Read)
  nodeCount?: int32;

  /**
   * The scale configuration of the session pool.
   */
  scaleConfiguration?: ScaleConfiguration;

  /**
   * The secrets of the session pool.
   */
  @identifiers(#["name"])
  secrets?: SessionPoolSecret[];

  /**
   * The pool configuration if the poolManagementType is dynamic.
   */
  dynamicPoolConfiguration?: DynamicPoolConfiguration;

  /**
   * The custom container configuration if the containerType is CustomContainer.
   */
  customContainerTemplate?: CustomContainerTemplate;

  /**
   * The network configuration of the sessions in the session pool.
   */
  sessionNetworkConfiguration?: SessionNetworkConfiguration;

  /**
   * The template status of the session pool, showing active template, or desired template during session pool update. This is only available if the containerType is CustomContainer.
   */
  @visibility(Lifecycle.Read)
  templateUpdateStatus?: TemplateUpdateStatus;

  /**
   * The endpoint to manage the pool.
   */
  @visibility(Lifecycle.Read)
  poolManagementEndpoint?: url;

  /**
   * Provisioning state of the session pool.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: SessionPoolProvisioningState;

  /**
   * Optional settings for a Managed Identity that is assigned to the Session pool.
   */
  @identifiers(#["identity"])
  managedIdentitySettings?: ManagedIdentitySetting[];

  /**
   * The MCP (Model Context Protocol) server settings of the session pool.
   */
  mcpServerSettings?: McpServerSettings;
}

/**
 * Scale configuration.
 */
model ScaleConfiguration {
  /**
   * The maximum count of sessions at the same time.
   */
  maxConcurrentSessions?: int32;

  /**
   * The minimum count of ready session instances.
   */
  readySessionInstances?: int32;
}

/**
 * Secret definition.
 */
model SessionPoolSecret {
  /**
   * Secret Name.
   */
  name?: string;

  /**
   * Secret Value.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  value?: string;
}

/**
 * Dynamic pool configuration.
 */
model DynamicPoolConfiguration {
  /**
   * The lifecycle configuration of a session in the dynamic session pool
   */
  lifecycleConfiguration?: LifecycleConfiguration;
}

/**
 * The lifecycle configuration properties of a session in the dynamic session pool
 */
model LifecycleConfiguration {
  /**
   * The lifecycle type of the session pool.
   */
  lifecycleType?: LifecycleType;

  /**
   * The cooldown period of a session in seconds when the lifecycle type is 'Timed'.
   */
  cooldownPeriodInSeconds?: int32;

  /**
   * The maximum alive period of a session in seconds when the lifecycle type is 'OnContainerExit'.
   */
  maxAlivePeriodInSeconds?: int32;
}

/**
 * Custom container configuration.
 */
model CustomContainerTemplate {
  /**
   * Private container registry credentials for containers used by the sessions of the session pool.
   */
  registryCredentials?: SessionRegistryCredentials;

  /**
   * List of container definitions for the sessions of the session pool.
   */
  @identifiers(#["name"])
  containers?: SessionContainer[];

  /**
   * Session pool ingress configuration.
   */
  ingress?: SessionIngress;
}

/**
 * Session pool private registry credentials.
 */
model SessionRegistryCredentials {
  /**
   * Container registry server.
   */
  server?: string;

  /**
   * Container registry username.
   */
  username?: string;

  /**
   * The name of the secret that contains the registry login password
   */
  passwordSecretRef?: string;

  /**
   * A Managed Identity to use to authenticate with Azure Container Registry. For user-assigned identities, use the full user-assigned identity Resource ID. For system-assigned identities, use 'system'
   */
  identity?: string;
}

/**
 * Container definitions for the sessions of the session pool.
 */
model SessionContainer {
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
  @identifiers(#["name"])
  env?: EnvironmentVar[];

  /**
   * Container resource requirements.
   */
  resources?: SessionContainerResources;

  /**
   * List of probes for the container.
   */
  @identifiers(#["type"])
  probes?: SessionProbe[];
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
 * Container resource requirements for sessions of the session pool.
 */
model SessionContainerResources {
  /**
   * Required CPU in cores, e.g. 0.5
   */
  cpu?: float64;

  /**
   * Required memory, e.g. "250Mb"
   */
  memory?: string;
}

/**
 * Session probe configuration.
 */
model SessionProbe {
  /**
   * Denotes the type of probe. Can be Liveness or Startup, Readiness probe is not supported in sessions. Type must be unique for each probe within the context of a list of probes (SessionProbes).
   */
  type?: SessionProbeType;

  /**
   * HTTPGet specifies the http request to perform.
   */
  httpGet?: SessionProbeHttpGet;

  /**
   * TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported.
   */
  tcpSocket?: SessionProbeTcpSocket;

  /**
   * Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1. Maximum value is 10.
   */
  failureThreshold?: int32;

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
   * Optional duration in seconds the pod needs to terminate gracefully upon probe failure. The grace period is the duration in seconds after the processes running in the pod are sent a termination signal and the time when the processes are forcibly halted with a kill signal. Set this value longer than the expected cleanup time for your process. If this value is nil, the pod's terminationGracePeriodSeconds will be used. Otherwise, this value overrides the value provided by the pod spec. Value must be non-negative integer. The value zero indicates stop immediately via the kill signal (no opportunity to shut down). This is an alpha field and requires enabling ProbeTerminationGracePeriod feature gate. Maximum value is 3600 seconds (1 hour)
   */
  terminationGracePeriodSeconds?: int64;

  /**
   * Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. Maximum value is 240.
   */
  timeoutSeconds?: int32;
}

/**
 * HTTPGet specifies the http request to perform.
 */
model SessionProbeHttpGet {
  /**
   * Host name to connect to, defaults to the pod IP. You probably want to set "Host" in httpHeaders instead.
   */
  host?: string;

  /**
   * Custom headers to set in the request. HTTP allows repeated headers.
   */
  @identifiers(#["name"])
  httpHeaders?: SessionProbeHttpGetHttpHeadersItem[];

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
model SessionProbeHttpGetHttpHeadersItem {
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
model SessionProbeTcpSocket {
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
 * Session pool ingress configuration.
 */
model SessionIngress {
  /**
   * Target port in containers for traffic from ingress
   */
  targetPort?: int32;
}

/**
 * Session network configuration.
 */
model SessionNetworkConfiguration {
  /**
   * Network status for the sessions.
   */
  status?: SessionNetworkStatus;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model TemplateUpdateStatus {
  /**
   * The status of the current active template.
   */
  activeTemplate?: TemplateStatus;

  /**
   * The status of the desired template during session pool update.
   */
  desiredTemplate?: TemplateStatus;
}

/**
 * The status of the session pool template.
 */
model TemplateStatus {
  /**
   * The detailed status of this template.
   */
  details?: string;

  /**
   * The creation time of this template.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * The status of this template.
   */
  status?: TemplatePoolStatus;

  /**
   * List of container definitions for the sessions of this template.
   */
  @identifiers(#["name"])
  containers?: SessionContainer[];

  /**
   * Session pool ingress configuration of this template.
   */
  ingress?: SessionIngress;
}

/**
 * The status of pods in the pool of this template.
 */
model TemplatePoolStatus {
  /**
   * The expected count of pods in this pool
   */
  expectedCount?: int32;

  /**
   * The ready count of pods in this pool
   */
  readyCount?: int32;

  /**
   * The pending count of pods in this pool
   */
  pendingCount?: int32;

  /**
   * The image pull fail count of pods in this pool
   */
  imagePullFailCount?: int32;

  /**
   * The crash count of pods in this pool
   */
  crashCount?: int32;

  /**
   * The allocated count of pods in this pool
   */
  allocatedCount?: int32;
}

/**
 * Optional settings for a Managed Identity that is assigned to the Session pool.
 */
model ManagedIdentitySetting {
  /**
   * The resource ID of a user-assigned managed identity that is assigned to the Session Pool, or 'system' for system-assigned identity.
   */
  identity: string;

  /**
   * Use to select the lifecycle stages of a Session Pool during which the Managed Identity should be available.
   */
  lifecycle?: IdentitySettingsLifeCycle = "None";
}

/**
 * The settings of the MCP (Model Context Protocol) server for this session pool.
 */
model McpServerSettings {
  /**
   * Indicates whether the MCP server is enabled.
   */
  isMcpServerEnabled?: boolean = false;

  /**
   * Indicates whether the MCP server API key is disabled.
   */
  isMcpServerApiKeyDisabled?: boolean = false;

  /**
   * The endpoint of the MCP server.
   */
  @visibility(Lifecycle.Read)
  mcpServerEndpoint?: url;
}

/**
 * Container App session pool updatable properties.
 */
model SessionPoolUpdatableProperties {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;

  /**
   * Managed identities needed by a session pool to interact with other Azure services to not maintain any secrets or credentials in code.
   */
  identity?: Azure.ResourceManager.CommonTypes.ManagedServiceIdentity;

  /**
   * Session pool resource specific updatable properties.
   */
  properties?: SessionPoolUpdatablePropertiesProperties;
}

/**
 * Session pool resource specific updatable properties.
 */
model SessionPoolUpdatablePropertiesProperties {
  /**
   * The scale configuration of the session pool.
   */
  scaleConfiguration?: ScaleConfiguration;

  /**
   * The secrets of the session pool.
   */
  @identifiers(#["name"])
  secrets?: SessionPoolSecret[];

  /**
   * The pool configuration if the poolManagementType is dynamic.
   */
  dynamicPoolConfiguration?: DynamicPoolConfiguration;

  /**
   * The custom container configuration if the containerType is CustomContainer.
   */
  customContainerTemplate?: CustomContainerTemplate;

  /**
   * The network configuration of the sessions in the session pool.
   */
  sessionNetworkConfiguration?: SessionNetworkConfiguration;
}

/**
 * The credentials used for the MCP server endpoint authentication.
 */
model McpServerCredential {
  /**
   * The API key for the MCP server.
   */
  @visibility(Lifecycle.Read)
  @secret
  apiKey?: string;
}

/**
 * SourceControl collection ARM resource.
 */
model SourceControlCollection is Azure.Core.Page<SourceControl>;

/**
 * SourceControl resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model SourceControlProperties {
  /**
   * Current provisioning State of the operation
   */
  @visibility(Lifecycle.Read)
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
   * Dockerfile path
   */
  dockerfilePath?: string;

  /**
   * One time Github PAT to configure github environment
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
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

  /**
   * List of environment variables to be passed to the build.
   */
  @identifiers(#["name"])
  buildEnvironmentVariables?: EnvironmentVariable[];
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" ""
  @visibility(Lifecycle.Create, Lifecycle.Update)
  registryPassword?: string;
}

/**
 * Container App credentials.
 */
model AzureCredentials {
  /**
   * Client Id.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  clientId?: string;

  /**
   * Client Secret.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  clientSecret?: string;

  /**
   * Tenant Id.
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
  tenantId?: string;

  /**
   * Kind of auth github does for deploying the template
   */
  @visibility(Lifecycle.Create, Lifecycle.Update)
  kind?: string;

  /**
   * Subscription Id.
   */
  subscriptionId?: string;
}

/**
 * Model representing an environment variable.
 */
model EnvironmentVariable {
  /**
   * Environment variable name.
   */
  name: string;

  /**
   * Environment variable value.
   */
  value: string;
}

/**
 * App Service error response.
 */
@error
model DefaultErrorResponse {
  /**
   * Error model.
   */
  @visibility(Lifecycle.Read)
  error?: DefaultErrorResponseError;
}

/**
 * Detailed errors.
 */
model DefaultErrorResponseErrorDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
model ListUsagesResult is Azure.Core.Page<Usage>;

/**
 * Describes Compute Resource Usage.
 */
model Usage {
  /**
   * An enum describing the unit of usage measurement.
   */
  unit: "Count";

  /**
   * The current usage of the resource.
   */
  currentValue: float32;

  /**
   * The maximum permitted usage of the resource.
   */
  limit: float32;

  /**
   * The name of the type of usage.
   */
  name: UsageName;
}

/**
 * The Usage Names.
 */
model UsageName {
  /**
   * The name of the resource.
   */
  value?: string;

  /**
   * The localized name of the resource.
   */
  localizedValue?: string;
}

/**
 * Container App collection ARM resource.
 */
model ContainerAppCollection is Azure.Core.Page<ContainerApp>;

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
 * ContainerApp resource specific properties
 */
model ContainerAppProperties {
  /**
   * Provisioning state of the Container App.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ContainerAppProvisioningState;

  /**
   * Running status of the Container App.
   */
  @visibility(Lifecycle.Read)
  runningStatus?: ContainerAppRunningStatus;

  /**
   * Any errors that occurred during deployment
   */
  @visibility(Lifecycle.Read)
  deploymentErrors?: string;

  /**
   * Deprecated. Resource ID of the Container App's environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedEnvironmentId?: string;

  /**
   * Resource ID of environment.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  environmentId?: string;

  /**
   * Workload profile name to pin for container app execution.
   */
  workloadProfileName?: string;

  /**
   * Container App auto patch configuration.
   */
  patchingConfiguration?: ContainerAppPropertiesPatchingConfiguration;

  /**
   * Name of the latest revision of the Container App.
   */
  @visibility(Lifecycle.Read)
  latestRevisionName?: string;

  /**
   * Name of the latest ready revision of the Container App.
   */
  @visibility(Lifecycle.Read)
  latestReadyRevisionName?: string;

  /**
   * Fully Qualified Domain Name of the latest revision of the Container App.
   */
  @visibility(Lifecycle.Read)
  latestRevisionFqdn?: string;

  /**
   * Id used to verify domain name ownership
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  outboundIpAddresses?: string[];

  /**
   * The endpoint of the eventstream of the container app.
   */
  @visibility(Lifecycle.Read)
  eventStreamEndpoint?: string;
}

/**
 * Container App auto patch configuration.
 */
model ContainerAppPropertiesPatchingConfiguration {
  /**
   * Patching mode for the container app. Null or default in this field will be interpreted as Automatic by RP. Automatic mode will automatically apply available patches. Manual mode will require the user to manually apply patches. Disabled mode will stop patch detection and auto patching.
   */
  patchingMode?: PatchingMode;
}

/**
 * Non versioned Container App configuration properties that define the mutable settings of a Container app
 */
model Configuration {
  /**
   * Collection of secrets used by a Container app
   */
  @identifiers(#["name"])
  secrets?: Secret[];

  /**
   * ActiveRevisionsMode controls how active revisions are handled for the Container app:
   * <list><item>Single: Only one revision can be active at a time. Traffic weights cannot be used. This is the default.</item><item>Multiple: Multiple revisions can be active, including optional traffic weights and labels.</item><item>Labels: Only revisions with labels are active. Traffic weights can be applied to labels.</item></list>
   */
  activeRevisionsMode?: ActiveRevisionsMode = ActiveRevisionsMode.Single;

  /**
   * Required in labels revisions mode. Label to apply to newly created revision.
   */
  targetLabel?: string;

  /**
   * Ingress configurations.
   */
  ingress?: Ingress;

  /**
   * Collection of private container registry credentials for containers used by the Container app
   */
  @identifiers(#["server"])
  registries?: RegistryCredentials[];

  /**
   * Dapr configuration for the Container App.
   */
  dapr?: Dapr;

  /**
   * App runtime configuration for the Container App.
   */
  runtime?: Runtime;

  /**
   * Optional. Max inactive revisions a Container App can have.
   */
  maxInactiveRevisions?: int32;

  /**
   * Optional. The percent of the total number of replicas that must be brought up before revision transition occurs. Defaults to 100 when none is given. Value must be greater than 0 and less than or equal to 100.
   */
  @maxValue(100)
  @minValue(1)
  revisionTransitionThreshold?: int32;

  /**
   * Container App to be a dev Container App Service
   */
  service?: Service;

  /**
   * Optional settings for Managed Identities that are assigned to the Container App. If a Managed Identity is not specified here, default settings will be used.
   */
  @identifiers(#["identity"])
  identitySettings?: IdentitySettings[];
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
  @visibility(Lifecycle.Create, Lifecycle.Update)
  @secret
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
 * Container App Ingress configuration.
 */
model Ingress {
  /**
   * Hostname.
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * Bool indicating if app exposes an external http endpoint
   */
  external?: boolean = false;

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
  @identifiers(#["revisionName"])
  traffic?: TrafficWeight[];

  /**
   * custom domain bindings for Container Apps' hostnames.
   */
  @identifiers(#["name"])
  customDomains?: CustomDomain[];

  /**
   * Bool indicating if HTTP connections to is allowed. If set to false HTTP connections are automatically redirected to HTTPS connections
   */
  allowInsecure?: boolean = false;

  /**
   * Rules to restrict incoming IP address.
   */
  @identifiers(#["name"])
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

  /**
   * Settings to expose additional ports on container app
   */
  @identifiers(#["targetPort"])
  additionalPortMappings?: IngressPortMapping[];

  /**
   * Whether an http app listens on http or https
   */
  targetPortHttpScheme?: IngressTargetPortHttpScheme;
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
  latestRevision?: boolean = false;

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
 * Port mappings of container app ingress
 */
model IngressPortMapping {
  /**
   * Specifies whether the app port is accessible outside of the environment
   */
  external: boolean;

  /**
   * Specifies the port user's container listens on
   */
  targetPort: int32;

  /**
   * Specifies the exposed port for the target port. If not specified, it defaults to target port
   */
  exposedPort?: int32;
}

/**
 * Container App Dapr configuration.
 */
model Dapr {
  /**
   * Boolean indicating if the Dapr side car is enabled
   */
  enabled?: boolean = false;

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

  /**
   * Dapr application health check configuration
   */
  appHealth?: DaprAppHealth;

  /**
   * Maximum number of concurrent requests, events handled by the Dapr sidecar
   */
  maxConcurrency?: int32;
}

/**
 * Dapr application health check configuration
 */
model DaprAppHealth {
  /**
   * Boolean indicating if the health probe is enabled
   */
  enabled?: boolean;

  /**
   * Path for the health probe
   */
  path?: string;

  /**
   * Interval for the health probe in seconds
   */
  @minValue(1)
  probeIntervalSeconds?: int32;

  /**
   * Timeout for the health probe in milliseconds
   */
  @minValue(1)
  probeTimeoutMilliseconds?: int32;

  /**
   * Threshold for the health probe
   */
  @minValue(1)
  threshold?: int32;
}

/**
 * Container App Runtime configuration.
 */
model Runtime {
  /**
   * Java app configuration
   */
  java?: RuntimeJava;

  /**
   * .NET app configuration
   */
  dotnet?: RuntimeDotnet;
}

/**
 * Java app configuration
 */
model RuntimeJava {
  /**
   * Enable jmx core metrics for the java app
   */
  enableMetrics?: boolean;

  /**
   * Diagnostic capabilities achieved by java agent
   */
  javaAgent?: RuntimeJavaJavaAgent;
}

/**
 * Diagnostic capabilities achieved by java agent
 */
model RuntimeJavaJavaAgent {
  /**
   * Enable java agent injection for the java app.
   */
  enabled?: boolean;

  /**
   * Capabilities on the java logging scenario.
   */
  logging?: RuntimeJavaJavaAgentLogging;
}

/**
 * Capabilities on the java logging scenario.
 */
model RuntimeJavaJavaAgentLogging {
  /**
   * Settings of the logger for the java app.
   */
  @identifiers(#["logger", "level"])
  loggerSettings?: LoggerSetting[];
}

/**
 * Logger settings for java workloads.
 */
model LoggerSetting {
  /**
   * Logger name.
   */
  logger: string;

  /**
   * The specified logger's log level.
   */
  level: Level;
}

/**
 * .NET app configuration
 */
model RuntimeDotnet {
  /**
   * Auto configure the ASP.NET Core Data Protection feature
   */
  autoConfigureDataProtection?: boolean;
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
 * Optional settings for a Managed Identity that is assigned to the Container App.
 */
model IdentitySettings {
  /**
   * The resource ID of a user-assigned managed identity that is assigned to the Container App, or 'system' for system-assigned identity.
   */
  identity: string;

  /**
   * Use to select the lifecycle stages of a Container App during which the Managed Identity should be available.
   */
  lifecycle?: IdentitySettingsLifeCycle = "All";
}

/**
 * Container App init container definition
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
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
   * The type of the image. Set to CloudBuild to let the system manages the image, where user will not be able to update image through image field. Set to ContainerImage for user provided image.
   */
  imageType?: ImageType;

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
  @identifiers(#["name"])
  env?: EnvironmentVar[];

  /**
   * Container resource requirements.
   */
  resources?: ContainerResources;

  /**
   * Container volume mounts.
   */
  @identifiers(#["volumeName"])
  volumeMounts?: VolumeMount[];
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
  @visibility(Lifecycle.Read)
  ephemeralStorage?: string;

  /**
   * Required GPU in cores for GPU based app, e.g. 1.0
   */
  gpu?: float64;
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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model Container extends BaseContainer {
  /**
   * List of probes for the container.
   */
  @identifiers(#["type"])
  probes?: ContainerAppProbe[];
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
  @identifiers(#["name"])
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
   * Optional. KEDA Cooldown Period. Defaults to 300 seconds if not set.
   */
  cooldownPeriod?: int32;

  /**
   * Optional. KEDA Polling Interval. Defaults to 30 seconds if not set.
   */
  pollingInterval?: int32;

  /**
   * Scaling rules.
   */
  @identifiers(#["name"])
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
 * Container App container Http scaling rule.
 */
model HttpScaleRule {
  /**
   * Metadata properties to describe http scale rule.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  metadata?: Record<string>;

  /**
   * Authentication secrets for the custom scale rule.
   */
  @identifiers(#["triggerParameter"])
  auth?: ScaleRuleAuth[];

  /**
   * The resource ID of a user-assigned managed identity that is assigned to the Container App, or 'system' for system-assigned identity.
   */
  identity?: string;
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

  /**
   * Type of the client to be used to connect to the service
   */
  clientType?: string;

  /**
   * Customized keys for customizing injected values to the app
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  customizedKeys?: Record<string>;
}

/**
 * Custom domain analysis.
 */
model CustomHostnameAnalysisResult {
  /**
   * Host name that was analyzed
   */
  @visibility(Lifecycle.Read)
  hostName?: string;

  /**
   * <code>true</code> if hostname is already verified; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  isHostnameAlreadyVerified?: boolean;

  /**
   * DNS verification test result.
   */
  @visibility(Lifecycle.Read)
  customDomainVerificationTest?: DnsVerificationTestResult;

  /**
   * Raw failure information if DNS verification fails.
   */
  @visibility(Lifecycle.Read)
  customDomainVerificationFailureInfo?: CustomHostnameAnalysisResultCustomDomainVerificationFailureInfo;

  /**
   * <code>true</code> if there is a conflict on the Container App's managed environment; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  hasConflictOnManagedEnvironment?: boolean;

  /**
   * <code>true</code> if there is a conflict on the Container App's managed environment level custom domain; otherwise, <code>false</code>.
   */
  @visibility(Lifecycle.Read)
  conflictWithEnvironmentCustomDomain?: boolean;

  /**
   * Name of the conflicting Container App on the Managed Environment if it's within the same subscription.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
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
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;

  /**
   * Details or the error
   */
  @identifiers(#["code"])
  details?: CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem[];
}

/**
 * Detailed errors.
 */
model CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem {
  /**
   * Standardized string to programmatically identify the error.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  message?: string;

  /**
   * Detailed error description and debugging information.
   */
  @visibility(Lifecycle.Read)
  target?: string;
}

/**
 * Container App Secrets Collection ARM resource.
 */
model SecretsCollection {
  /**
   * Collection of resources.
   */
  @pageItems
  @identifiers(#["name"])
  value: ContainerAppSecret[];
}

/**
 * Container App Secret.
 */
model ContainerAppSecret {
  /**
   * Secret Name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Secret Value.
   */
  @visibility(Lifecycle.Read)
  @secret
  value?: string;

  /**
   * Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
   */
  @visibility(Lifecycle.Read)
  identity?: string;

  /**
   * Azure Key Vault URL pointing to the secret referenced by the container app.
   */
  @visibility(Lifecycle.Read)
  keyVaultUrl?: string;
}

/**
 * Container App Auth Token.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
model ContainerAppAuthToken
  extends Azure.ResourceManager.CommonTypes.TrackedResource {
  /**
   * Container App auth token resource specific properties
   */
  properties?: ContainerAppAuthTokenProperties;
}

/**
 * Container App auth token resource specific properties
 */
model ContainerAppAuthTokenProperties {
  /**
   * Auth token value.
   */
  @visibility(Lifecycle.Read)
  @secret
  token?: string;

  /**
   * Token expiration date.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expires?: utcDateTime;
}

/**
 * The response of a Container Apps Build Resource list operation.
 */
model ContainerAppsBuildCollection
  is Azure.Core.Page<ContainerAppsBuildResource>;

/**
 * The ContainerAppBuild properties.
 */
model ContainerAppsBuildProperties {
  /**
   * Build provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: BuildProvisioningState;

  /**
   * Status of the build once it has been provisioned.
   */
  @visibility(Lifecycle.Read)
  buildStatus?: BuildStatus;

  /**
   * Container registry that the final image will be uploaded to.
   */
  @visibility(Lifecycle.Read)
  destinationContainerRegistry?: ContainerRegistryWithCustomImage;

  /**
   * Configuration of the build.
   */
  @visibility(Lifecycle.Read)
  configuration?: ContainerAppsBuildConfiguration;

  /**
   * Endpoint from which the build logs can be streamed.
   */
  @visibility(Lifecycle.Read)
  logStreamEndpoint?: string;
}

/**
 * Container registry that the final image will be uploaded to.
 */
model ContainerRegistryWithCustomImage {
  /**
   * Login server of the container registry that the final image should be uploaded to. Builder resource needs to have this container registry defined along with an identity to use to access it.
   */
  server: string;

  /**
   * Full name that the final image should be uploaded as, including both image name and tag.
   */
  image?: string;
}

/**
 * Configuration of the build.
 */
model ContainerAppsBuildConfiguration {
  /**
   * Base OS used to build and run the app.
   */
  @visibility(Lifecycle.Read)
  baseOs?: string;

  /**
   * Platform to be used to build and run the app.
   */
  @visibility(Lifecycle.Read)
  platform?: string;

  /**
   * Platform version to be used to build and run the app.
   */
  @visibility(Lifecycle.Read)
  platformVersion?: string;

  /**
   * List of environment variables to be passed to the build, secrets should not be used in environment variable.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["name"])
  environmentVariables?: EnvironmentVariable[];

  /**
   * List of steps to perform before the build.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  preBuildSteps?: PreBuildStep[];
}

/**
 * Model representing a pre-build step.
 */
model PreBuildStep {
  /**
   * Description of the pre-build step.
   */
  description?: string;

  /**
   * List of custom commands to run.
   */
  scripts?: string[];

  /**
   * Http get request to send before the build.
   */
  // @identifiers(#[])
  httpGet?: HttpGet;
}

/**
 * Model representing a http get request.
 */
model HttpGet {
  /**
   * URL to make HTTP GET request against.
   */
  url: string;

  /**
   * Name of the file that the request should be saved to.
   */
  fileName?: string;

  /**
   * List of headers to send with the request.
   */
  headers?: string[];
}

/**
 * Container App Functions collection ARM resource.
 */
model ContainerAppsFunctionCollection is Azure.Core.Page<ContainerAppsFunction>;

/**
 * Function resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ContainerAppsFunctionProperties {
  /**
   * Invoke URL for the function.
   */
  @visibility(Lifecycle.Read)
  invokeUrlTemplate?: url;

  /**
   * Trigger type of the function.
   */
  @visibility(Lifecycle.Read)
  triggerType?: string;

  /**
   * Programming language of the function.
   */
  @visibility(Lifecycle.Read)
  language?: string;

  /**
   * Indicates whether the function is disabled.
   */
  @visibility(Lifecycle.Read)
  isDisabled?: boolean;
}

/**
 * Container App Label History collection ARM resource.
 */
model LabelHistoryCollection is Azure.Core.Page<LabelHistory>;

/**
 * Container App Label History resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model LabelHistoryProperties {
  /**
   * List of label history records.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" ""
  @visibility(Lifecycle.Read)
  @identifiers(#["label"])
  records?: LabelHistoryRecordItem[];
}

/**
 * Container App Label History Item resource specific properties
 */
model LabelHistoryRecordItem {
  /**
   * Container App revision name that label was applied to.
   */
  @visibility(Lifecycle.Read)
  revision?: string;

  /**
   * Timestamp describing when the label was applied to the revision.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start?: utcDateTime;

  /**
   * Timestamp describing when the label was removed from the revision. Only meaningful when the label is currently applied to the revision.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  stop?: utcDateTime;

  /**
   * Status of the label history record.
   */
  @visibility(Lifecycle.Read)
  status?: Status;
}

/**
 * Container App patch collection
 */
model PatchCollection is Azure.Core.Page<ContainerAppsPatchResource>;

/**
 * Top level properties that describes current states of the patch resource
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model PatchProperties {
  /**
   * The Azure resource id of the target environment for the patch.
   */
  targetEnvironmentId?: Azure.Core.armResourceIdentifier;

  /**
   * The Azure resource id of the target container app for the patch.
   */
  targetContainerAppId?: Azure.Core.armResourceIdentifier;

  /**
   * The Azure resource id of the target revision for the patch.
   */
  targetRevisionId?: Azure.Core.armResourceIdentifier;

  /**
   * The status of the patch operation.
   */
  @visibility(Lifecycle.Read)
  patchApplyStatus?: PatchApplyStatus;

  /**
   * The UTC timestamp that describes when the patch object was created.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The UTC timestamp that describes when the patch object was last updated.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;

  /**
   * Detailed info describes the patch operation for the target container app.
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  patchDetails?: PatchDetails[];
}

/**
 * The detailed info of patch operation performing when applying a patch.
 */
model PatchDetails {
  /**
   * The name of the target container for the patch.
   */
  @visibility(Lifecycle.Read)
  targetContainerName: string;

  /**
   * The name of the target image for the patch.
   */
  @visibility(Lifecycle.Read)
  targetImage: string;

  /**
   * The UTC timestamp that describes the latest detection was done.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastDetectionTime: utcDateTime;

  /**
   * The status of the patch detection.
   */
  @visibility(Lifecycle.Read)
  detectionStatus: DetectionStatus;

  /**
   * The name of the new image created by the patch.
   */
  @visibility(Lifecycle.Read)
  newImageName?: string;

  /**
   * New layer update details in the target image.
   */
  @visibility(Lifecycle.Read)
  newLayer?: PatchDetailsNewLayer;

  /**
   * The old layer details in the target image.
   */
  @visibility(Lifecycle.Read)
  oldLayer?: PatchDetailsOldLayer;

  /**
   * The type for the patch.
   */
  @visibility(Lifecycle.Read)
  patchType?: PatchType;
}

/**
 * New layer update details in the target image.
 */
model PatchDetailsNewLayer {
  /**
   * The details of the new layer for the target image.
   */
  name?: string;

  /**
   * The framework and its version in the new run image for the target image.
   */
  frameworkAndVersion?: string;

  /**
   * The OS name and its version in the new run image for the target image.
   */
  osAndVersion?: string;
}

/**
 * The old layer details in the target image.
 */
model PatchDetailsOldLayer {
  /**
   * The details of the old layer for the target image.
   */
  name?: string;

  /**
   * The framework and its version in the old run image for the target image.
   */
  frameworkAndVersion?: string;

  /**
   * The OS name and its version in the old run image for the target image.
   */
  osAndVersion?: string;
}

/**
 * The configuration for patcher to skip a patch or not.
 */
model PatchSkipConfig {
  /**
   * The flag to indicate whether to skip the patch or not.
   */
  skip?: boolean;
}

/**
 * Container App Revisions collection ARM resource.
 */
model RevisionCollection is Azure.Core.Page<Revision>;

/**
 * Revision resource specific properties
 */
model RevisionProperties {
  /**
   * Timestamp describing when the revision was created
   * by controller
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Timestamp describing when the revision was last active. Only meaningful when revision is inactive
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastActiveTime?: utcDateTime;

  /**
   * Fully qualified domain name of the revision
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;

  /**
   * Container App Revision Template with all possible settings and the
   * defaults if user did not provide them. The defaults are populated
   * as they were at the creation time
   */
  @visibility(Lifecycle.Read)
  template?: Template;

  /**
   * Boolean describing if the Revision is Active
   */
  @visibility(Lifecycle.Read)
  active?: boolean;

  /**
   * Number of pods currently running for this revision
   */
  @visibility(Lifecycle.Read)
  replicas?: int32;

  /**
   * Traffic weight assigned to this revision
   */
  @visibility(Lifecycle.Read)
  trafficWeight?: int32;

  /**
   * List of labels assigned to this revision.
   */
  @visibility(Lifecycle.Read)
  labels?: string[];

  /**
   * Optional Field - Platform Error Message
   */
  @visibility(Lifecycle.Read)
  provisioningError?: string;

  /**
   * Current health State of the revision
   */
  @visibility(Lifecycle.Read)
  healthState?: RevisionHealthState;

  /**
   * Current provisioning State of the revision
   */
  @visibility(Lifecycle.Read)
  provisioningState?: RevisionProvisioningState;

  /**
   * Current running state of the revision
   */
  @visibility(Lifecycle.Read)
  runningState?: RevisionRunningState;
}

/**
 * Replica resource specific properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model ReplicaProperties {
  /**
   * Timestamp describing when the pod was created by controller
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdTime?: utcDateTime;

  /**
   * Current running state of the replica
   */
  @visibility(Lifecycle.Read)
  runningState?: ContainerAppReplicaRunningState;

  /**
   * The details of replica current running state
   */
  @visibility(Lifecycle.Read)
  runningStateDetails?: string;

  /**
   * The containers collection under a replica.
   */
  @identifiers(#["name"])
  containers?: ReplicaContainer[];

  /**
   * The init containers collection under a replica.
   */
  @identifiers(#["name"])
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
  @visibility(Lifecycle.Read)
  runningState?: ContainerAppContainerRunningState;

  /**
   * The details of container current running state
   */
  @visibility(Lifecycle.Read)
  runningStateDetails?: string;

  /**
   * Log Stream endpoint
   */
  @visibility(Lifecycle.Read)
  logStreamEndpoint?: string;

  /**
   * Container exec endpoint
   */
  @visibility(Lifecycle.Read)
  execEndpoint?: string;

  /**
   * Container debug endpoint
   */
  @visibility(Lifecycle.Read)
  debugEndpoint?: string;
}

/**
 * Container App Revision Replicas collection ARM resource.
 */
model ReplicaCollection {
  /**
   * Collection of resources.
   */
  @pageItems
  value: Replica[];
}

/**
 * .NET Components ARM resource.
 */
model DotNetComponentsCollection is Azure.Core.Page<DotNetComponent>;

/**
 * .NET Component resource specific properties
 */
model DotNetComponentProperties {
  /**
   * Type of the .NET Component.
   */
  componentType?: DotNetComponentType;

  /**
   * Provisioning state of the .NET Component.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: DotNetComponentProvisioningState;

  /**
   * List of .NET Components configuration properties
   */
  @identifiers(#["propertyName"])
  configurations?: DotNetComponentConfigurationProperty[];

  /**
   * List of .NET Components that are bound to the .NET component
   */
  @identifiers(#["name"])
  serviceBinds?: DotNetComponentServiceBind[];
}

/**
 * Configuration properties for a .NET Component
 */
model DotNetComponentConfigurationProperty {
  /**
   * The name of the property
   */
  propertyName?: string;

  /**
   * The value of the property
   */
  value?: string;
}

/**
 * Configuration to bind a .NET Component to another .NET Component
 */
model DotNetComponentServiceBind {
  /**
   * Name of the service bind
   */
  name?: string;

  /**
   * Resource id of the target service
   */
  serviceId?: Azure.Core.armResourceIdentifier;
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
 * Operation display payload
 */
model OperationDisplay {
  /**
   * Resource provider of the operation
   */
  provider?: string;

  /**
   * Resource of the operation
   */
  resource?: string;

  /**
   * Localized friendly name for the operation
   */
  operation?: string;

  /**
   * Localized friendly description for the operation
   */
  description?: string;
}

/**
 * Java Components ARM resource.
 */
model JavaComponentsCollection is Azure.Core.Page<JavaComponent>;

/**
 * Java Component common properties.
 */
@discriminator("componentType")
model JavaComponentProperties {
  /**
   * Type of the Java Component.
   */
  componentType: JavaComponentType;

  /**
   * Provisioning state of the Java Component.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: JavaComponentProvisioningState;

  /**
   * List of Java Components configuration properties
   */
  @identifiers(#["propertyName"])
  configurations?: JavaComponentConfigurationProperty[];

  /**
   * Java component scaling configurations
   */
  scale?: JavaComponentPropertiesScale;

  /**
   * List of Java Components that are bound to the Java component
   */
  @identifiers(#["name"])
  serviceBinds?: JavaComponentServiceBind[];
}

/**
 * Configuration properties for a Java Component
 */
model JavaComponentConfigurationProperty {
  /**
   * The name of the property
   */
  propertyName?: string;

  /**
   * The value of the property
   */
  value?: string;
}

/**
 * Java component scaling configurations
 */
model JavaComponentPropertiesScale {
  /**
   * Optional. Minimum number of Java component replicas. Defaults to 1 if not set
   */
  minReplicas?: int32;

  /**
   * Optional. Maximum number of Java component replicas
   */
  maxReplicas?: int32;
}

/**
 * Configuration to bind a Java Component to another Java Component
 */
model JavaComponentServiceBind {
  /**
   * Name of the service bind
   */
  name?: string;

  /**
   * Resource id of the target service
   */
  serviceId?: Azure.Core.armResourceIdentifier;
}

/**
 * Collection of workflow information elements.
 */
model WorkflowEnvelopeCollection is Azure.Core.Page<WorkflowEnvelope>;

/**
 * Logic App properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" ""
#suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" ""
model LogicAppProperties {}

/**
 * Additional workflow properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "For backward compatibility"
model WorkflowEnvelopeProperties {
  /**
   * Gets or sets the files.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  files?: unknown;

  /**
   * Gets or sets the state of the workflow.
   */
  flowState?: WorkflowState;

  /**
   * Gets or sets workflow health.
   */
  health?: WorkflowHealth;
}

/**
 * Represents the workflow health.
 */
model WorkflowHealth {
  /**
   * Gets or sets the workflow health state.
   */
  state: WorkflowHealthState;

  /**
   * Gets or sets the workflow error.
   */
  error?: ErrorEntity;
}

/**
 * Body of the error response returned from the API.
 */
model ErrorEntity {
  /**
   * Type of error.
   */
  extendedCode?: string;

  /**
   * Message template.
   */
  messageTemplate?: string;

  /**
   * Parameters for the template.
   */
  parameters?: string[];

  /**
   * Inner errors.
   */
  @identifiers(#[])
  innerErrors?: ErrorEntity[];

  /**
   * Error Details.
   */
  @identifiers(#[])
  details?: ErrorEntity[];

  /**
   * The error target.
   */
  target?: string;

  /**
   * Basic error code.
   */
  code?: string;

  /**
   * Any details of the error.
   */
  message?: string;
}

/**
 * The workflow filter.
 */
@secret
model WorkflowArtifacts {
  /**
   * Application settings of the workflow.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  appSettings?: unknown;

  /**
   * Files of the app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
  files?: unknown;

  /**
   * Files of the app to delete.
   */
  filesToDelete?: string[];
}

/**
 * Spring Cloud Gateway route definition
 */
model ScgRoute {
  /**
   * Id of the route
   */
  id: string;

  /**
   * Uri of the route
   */
  uri: string;

  /**
   * Predicates of the route
   */
  predicates?: string[];

  /**
   * Filters of the route
   */
  filters?: string[];

  /**
   * Order of the route
   */
  order?: int64;
}

/**
 * Container App Ingress configuration.
 */
model JavaComponentIngress {
  /**
   * Hostname of the Java Component endpoint
   */
  @visibility(Lifecycle.Read)
  fqdn?: string;
}

/**
 * Spring Cloud Gateway properties.
 */
model SpringCloudGatewayComponent extends JavaComponentProperties {
  /**
   * Java Component Ingress configurations.
   */
  ingress?: JavaComponentIngress;

  /**
   * Gateway route definition
   */
  @identifiers(#["id"])
  springCloudGatewayRoutes?: ScgRoute[];

  /**
   * Type of the Java Component.
   */
  componentType: "SpringCloudGateway";
}

/**
 * Spring Boot Admin properties.
 */
model SpringBootAdminComponent extends JavaComponentProperties {
  /**
   * Java Component Ingress configurations.
   */
  ingress?: JavaComponentIngress;

  /**
   * Type of the Java Component.
   */
  componentType: "SpringBootAdmin";
}

/**
 * Nacos properties.
 */
model NacosComponent extends JavaComponentProperties {
  /**
   * Java Component Ingress configurations.
   */
  ingress?: JavaComponentIngress;

  /**
   * Type of the Java Component.
   */
  componentType: "Nacos";
}

/**
 * Spring Cloud Eureka properties.
 */
model SpringCloudEurekaComponent extends JavaComponentProperties {
  /**
   * Java Component Ingress configurations.
   */
  ingress?: JavaComponentIngress;

  /**
   * Type of the Java Component.
   */
  componentType: "SpringCloudEureka";
}

/**
 * Spring Cloud Config properties.
 */
model SpringCloudConfigComponent extends JavaComponentProperties {
  /**
   * Type of the Java Component.
   */
  componentType: "SpringCloudConfig";
}

/**
 * Available operations of the service
 */
model AvailableOperations is Azure.Core.Page<OperationDetail>;

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@error
model ContainerAppsNotFoundError {
  ...NotFoundResponse;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
@error
model ManagedCertificateBadRequestError {
  ...BadRequestResponse;
}
