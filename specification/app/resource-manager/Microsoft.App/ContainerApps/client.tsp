import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
using Microsoft.App;

namespace Customizations;

@@clientName(Microsoft.App, "ContainerAppsAPIClient", "javascript,python");
@@clientName(Microsoft.App, "ContainerAppsApiClient", "java");
@@clientLocation(Jobs.jobExecution, Microsoft.App, "python");

@@clientLocation(getCustomDomainVerificationId, "ContainerAppsAPIClient", "go");
@@clientLocation(Jobs.jobExecution, "ContainerAppsAPIClient", "go");

@@clientName(
  VnetConfiguration.platformReservedDnsIP,
  "platformReservedDnsIp",
  "java"
);
@@clientName(RegistryInfo.registryUserName, "registryUsername", "java");
@@clientName(CustomHostnameAnalysisResult.hostName, "hostname", "java");
@@clientName(
  AzureActiveDirectoryLogin.disableWWWAuthenticate,
  "disableWwwAuthenticate",
  "java"
);
@@clientName(
  ContainerApps.listCustomHostNameAnalysis,
  "listCustomHostnameAnalysis",
  "java"
);

@@clientLocation(Jobs.jobExecution, Microsoft.App, "java,javascript");
@@clientName(RuntimeJavaJavaAgent, "RuntimeJavaAgent", "go,python");
@@clientName(
  RuntimeJavaJavaAgentLogging,
  "RuntimeJavaAgentLogging",
  "go,python"
);
@@clientName(RuntimeJavaJavaAgent, "ContainerAppRuntimeJavaAgent", "csharp");
@@clientName(
  RuntimeJavaJavaAgentLogging.loggerSettings,
  "LoggerSettings",
  "csharp"
);
@@clientName(LoggerSetting, "ContainerAppJavaLoggerSetting", "csharp");
@@clientName(Level, "ContainerAppJavaLoggerLevel", "csharp");
@@clientName(AvailableWorkloadProfilesOperationGroup.get, "list", "javascript");

// C# compatibility replacement declarations used by the decorator blocks below.
// @@hierarchyBuilding cannot preserve the previous C# ResourceData base type for
// DiagnosticsDefinition because that model is not structurally compatible with
// Azure.ResourceManager.Foundations.Resource; it is missing required ARM envelope
// properties such as systemData. Use a C#-scoped replacement model with the
// Resource base instead, so the REST/spec shape stays unchanged for other languages.
/**
 * C# compatibility replacement for diagnostics metadata.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Preserve the previous C# ResourceData base type during MPG migration"
#suppress "@azure-tools/typespec-azure-core/casing-style" "CSharp prefix marks this as a C#-only compatibility replacement during MPG migration"
model CSharpDiagnosticsDefinition
  extends Azure.ResourceManager.Foundations.Resource {
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
  score?: float32;
}

/**
 * Unit of measurement for Container App usage values.
 */
union UsageUnit {
  string,

  /** Count. */
  Count: "Count",
}

/**
 * Method used to authenticate the custom OpenID Connect provider client credential.
 */
union OpenIdConnectClientCredentialMethod {
  string,

  /** Client secret post authentication. */
  ClientSecretPost: "ClientSecretPost",
}

// C# @@alternateType customizations.
@@alternateType(DiagnosticsDefinition, CSharpDiagnosticsDefinition, "csharp");

@@alternateType(Microsoft.App.Usage.unit, UsageUnit, "csharp");

@@alternateType(
  OpenIdConnectClientCredential.method,
  OpenIdConnectClientCredentialMethod,
  "csharp"
);

@@alternateType(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  Azure.Core.armResourceType,
  "csharp"
);

@@alternateType(ConnectedEnvironmentProperties.staticIp, ipV4Address, "csharp");

@@alternateType(
  ContainerAppProperties.managedEnvironmentId,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(
  ContainerAppProperties.environmentId,
  armResourceIdentifier,
  "csharp"
);

@@alternateType(
  ContainerAppProperties.outboundIpAddresses,
  ipV4Address[],
  "csharp"
);

@@alternateType(ContainerAppProperties.eventStreamEndpoint, url, "csharp");

@@alternateType(ManagedEnvironmentProperties.staticIp, ipV4Address, "csharp");

@@alternateType(RegistryInfo.registryUrl, url, "csharp");

@@alternateType(SourceControlProperties.repoUrl, url, "csharp");

// C# @@clientName customizations.
@@clientName(
  AvailableWorkloadProfilesOperationGroup.get,
  "GetAvailableWorkloadProfiles",
  "csharp"
);

@@clientName(BillingMetersOperationGroup.get, "GetBillingMeters", "csharp");

@@clientName(BuilderResource, "Builder", "csharp");

@@clientName(BuilderCollection, "BuilderList", "csharp");

@@clientName(BuildResource, "Build", "csharp");

@@clientName(BuildCollection, "BuildList", "csharp");

@@clientName(BuildToken.expires, "ExpiresOn", "csharp");

@@clientName(
  ManagedEnvironments.list,
  "GetManagedEnvironmentPrivateLinkResources",
  "csharp"
);

@@clientName(Jobs.stopExecution, "StopExecutionJob", "csharp");

@@clientName(
  ManagedEnvironmentUsagesOperationGroup.list,
  "GetManagedEnvironmentUsages",
  "csharp"
);

@@clientName(UsagesOperationGroup.list, "GetUsages", "csharp");

@@clientName(
  OpenIdConnectClientCredentialMethod,
  "ContainerAppOpenIdConnectClientCredentialMethod",
  "csharp"
);

@@clientName(
  ContainerAppsLabelHistory.listLabelHistory,
  "ListLabelHistory",
  "csharp"
);

@@clientName(
  ContainerAppsDiagnostics.getRevision,
  "GetRevisionDiagnostic",
  "csharp"
);

@@clientName(
  ManagedEnvironments.checkNameAvailability,
  "CheckContainerAppNameAvailability",
  "csharp"
);

// C# customizations ported from the previous AutoRest rename-mapping.
@@clientName(AccessMode, "ContainerAppAccessMode", "csharp");

@@clientName(Action, "ContainerAppIPRuleAction", "csharp");

@@clientName(ActiveRevisionsMode, "ContainerAppActiveRevisionsMode", "csharp");

@@clientName(AllowedPrincipals, "ContainerAppAllowedPrincipals", "csharp");

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest,
  "ContainerAppNameAvailabilityContent",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityRequest.type,
  "ResourceType",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse,
  "ContainerAppNameAvailabilityResult",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityResponse.nameAvailable,
  "IsNameAvailable",
  "csharp"
);

@@clientName(
  Azure.ResourceManager.CommonTypes.CheckNameAvailabilityReason,
  "ContainerAppNameUnavailableReason",
  "csharp"
);

@@clientName(
  Applicability,
  "ContainerAppAvailableWorkloadProfileApplicability",
  "csharp"
);

@@clientName(Apple, "ContainerAppAppleConfiguration", "csharp");

@@clientName(Apple.enabled, "IsEnabled", "csharp");

@@clientName(
  AppleRegistration,
  "ContainerAppAppleRegistrationConfiguration",
  "csharp"
);

@@clientName(AppLogsConfiguration, "ContainerAppLogsConfiguration", "csharp");

@@clientName(AppProtocol, "ContainerAppProtocol", "csharp");

@@clientName(AppRegistration, "ContainerAppRegistration", "csharp");

@@clientName(AuthConfig, "ContainerAppAuthConfig", "csharp");

@@clientName(AuthPlatform, "ContainerAppAuthPlatform", "csharp");

@@clientName(AuthPlatform.enabled, "IsEnabled", "csharp");

@@clientName(
  AvailableWorkloadProfile,
  "ContainerAppAvailableWorkloadProfile",
  "csharp"
);

@@clientName(
  AvailableWorkloadProfileProperties,
  "ContainerAppAvailableWorkloadProfileProperties",
  "csharp"
);

@@clientName(
  AvailableWorkloadProfileProperties.memoryGiB,
  "MemoryInGiB",
  "csharp"
);

@@clientName(
  AzureActiveDirectory,
  "ContainerAppAzureActiveDirectoryConfiguration",
  "csharp"
);

@@clientName(AzureActiveDirectory.enabled, "IsEnabled", "csharp");

@@clientName(
  AzureActiveDirectoryLogin,
  "ContainerAppAzureActiveDirectoryLoginConfiguration",
  "csharp"
);

@@clientName(
  AzureActiveDirectoryLogin.disableWWWAuthenticate,
  "IsWwwAuthenticationDisabled",
  "csharp"
);

@@clientName(
  AzureActiveDirectoryRegistration,
  "ContainerAppAzureActiveDirectoryRegistrationConfiguration",
  "csharp"
);

@@clientName(
  AzureActiveDirectoryValidation,
  "ContainerAppAzureActiveDirectoryValidationConfiguration",
  "csharp"
);

@@clientName(AzureCredentials, "ContainerAppCredentials", "csharp");

@@clientName(AzureFileProperties, "ContainerAppAzureFileProperties", "csharp");

@@clientName(
  AzureStaticWebApps,
  "ContainerAppAzureStaticWebAppsConfiguration",
  "csharp"
);

@@clientName(AzureStaticWebApps.enabled, "IsEnabled", "csharp");

@@clientName(BaseContainer, "ContainerAppBaseContainer", "csharp");

@@clientName(BillingMeter, "ContainerAppBillingMeter", "csharp");

@@clientName(
  BillingMeterProperties,
  "ContainerAppBillingMeterProperties",
  "csharp"
);

@@clientName(
  BillingMeterProperties.category,
  "WorkloadProfileCategory",
  "csharp"
);

@@clientName(BindingType, "ContainerAppCustomDomainBindingType", "csharp");

@@clientName(Certificate, "ContainerAppCertificate", "csharp");

@@clientName(
  CertificateKeyVaultProperties,
  "ContainerAppCertificateKeyVaultProperties",
  "csharp"
);

@@clientName(CertificatePatch, "ContainerAppCertificatePatch", "csharp");

@@clientName(
  CertificateProperties,
  "ContainerAppCertificateProperties",
  "csharp"
);

@@clientName(CertificateProperties.valid, "IsValid", "csharp");

@@clientName(
  CertificateProvisioningState,
  "ContainerAppCertificateProvisioningState",
  "csharp"
);

@@clientName(ClientRegistration, "ContainerAppClientRegistration", "csharp");

@@clientName(Configuration, "ContainerAppConfiguration", "csharp");

@@clientName(
  ConnectedEnvironment,
  "ContainerAppConnectedEnvironment",
  "csharp"
);

@@clientName(ConnectedEnvironmentProperties.staticIp, "StaticIP", "csharp");

@@clientName(Certificates.get, "Get", "csharp");

@@clientName(Certificates.list, "List", "csharp");

@@clientName(Certificates.delete, "Delete", "csharp");

@@clientName(Certificates.createOrUpdate, "CreateOrUpdate", "csharp");

@@clientName(Certificates.update, "Update", "csharp");

@@clientName(
  ConnectedEnvironmentProvisioningState,
  "ContainerAppConnectedEnvironmentProvisioningState",
  "csharp"
);

@@clientName(
  ConnectedEnvironmentStorage,
  "ContainerAppConnectedEnvironmentStorage",
  "csharp"
);

@@clientName(
  ConnectedEnvironmentsDaprComponents,
  "ContainerAppConnectedEnvironmentDaprComponents",
  "csharp"
);

@@clientName(Container, "ContainerAppContainer", "csharp");

@@clientName(
  ContainerAppProperties.outboundIpAddresses,
  "OutboundIPAddressList",
  "csharp"
);

@@clientName(ContainerAppAuthTokenProperties.expires, "ExpireOn", "csharp");

@@clientName(ContainerAppsRevisions, "ContainerAppRevisions", "csharp");

@@clientName(ContainerAppProbe.type, "ProbeType", "csharp");

@@clientName(ContainerAppProbeHttpGet, "ContainerAppHttpRequestInfo", "csharp");

@@clientName(
  ContainerAppProbeHttpGetHttpHeadersItem,
  "ContainerAppHttpHeaderInfo",
  "csharp"
);

@@clientName(
  ContainerAppProbeTcpSocket,
  "ContainerAppTcpSocketRequestInfo",
  "csharp"
);

@@clientName(ContainerResources, "AppContainerResources", "csharp");

@@clientName(CookieExpiration, "ContainerAppCookieExpiration", "csharp");

@@clientName(
  CookieExpirationConvention,
  "ContainerAppCookieExpirationConvention",
  "csharp"
);

@@clientName(CorsPolicy, "ContainerAppCorsPolicy", "csharp");

@@clientName(CustomDomain, "ContainerAppCustomDomain", "csharp");

@@clientName(
  CustomDomainConfiguration,
  "ContainerAppCustomDomainConfiguration",
  "csharp"
);

@@clientName(
  CustomHostnameAnalysisResult,
  "ContainerAppCustomHostnameAnalysisResult",
  "csharp"
);

@@clientName(
  CustomHostnameAnalysisResultCustomDomainVerificationFailureInfo,
  "ContainerAppCustomDomainVerificationFailureInfo",
  "csharp"
);

@@clientName(
  CustomHostnameAnalysisResultCustomDomainVerificationFailureInfoDetailsItem,
  "ContainerAppCustomDomainVerificationFailureInfoDetailsItem",
  "csharp"
);

@@clientName(
  CustomOpenIdConnectProvider,
  "ContainerAppCustomOpenIdConnectProviderConfiguration",
  "csharp"
);

@@clientName(CustomOpenIdConnectProvider.enabled, "IsEnabled", "csharp");

@@clientName(CustomScaleRule, "ContainerAppCustomScaleRule", "csharp");

@@clientName(CustomScaleRule.type, "CustomScaleRuleType", "csharp");

@@clientName(DaprComponent, "ContainerAppDaprComponent", "csharp");

@@clientName(
  DaprComponents,
  "ContainerAppManagedEnvironmentDaprComponents",
  "csharp"
);

@@clientName(ConnectedEnvironmentsDaprComponents.get, "Get", "csharp");

@@clientName(ConnectedEnvironmentsDaprComponents.list, "List", "csharp");

@@clientName(ConnectedEnvironmentsDaprComponents.delete, "Delete", "csharp");

@@clientName(
  ConnectedEnvironmentsDaprComponents.createOrUpdate,
  "CreateOrUpdate",
  "csharp"
);

@@clientName(DaprMetadata, "ContainerAppDaprMetadata", "csharp");

@@clientName(DaprSecret, "ContainerAppDaprSecret", "csharp");

@@clientName(Dapr, "ContainerAppDaprConfiguration", "csharp");

@@clientName(Dapr.enabled, "IsEnabled", "csharp");

@@clientName(Dapr.enableApiLogging, "IsApiLoggingEnabled", "csharp");

@@clientName(DaprAppHealth.enabled, "IsEnabled", "csharp");

@@clientName(
  DefaultAuthorizationPolicy,
  "ContainerAppDefaultAuthorizationPolicy",
  "csharp"
);

@@clientName(Diagnostics, "ContainerAppDiagnostic", "csharp");

@@clientName(
  DiagnosticDataProviderMetadata,
  "ContainerAppDiagnosticDataProviderMetadata",
  "csharp"
);

@@clientName(
  DiagnosticDataProviderMetadataPropertyBagItem,
  "ContainerAppDiagnosticDataProviderMetadataPropertyBagItem",
  "csharp"
);

@@clientName(
  DiagnosticDataTableResponseColumn,
  "ContainerAppDiagnosticDataColumn",
  "csharp"
);

@@clientName(
  DiagnosticDataTableResponseObject,
  "ContainerAppDiagnosticDataTableResult",
  "csharp"
);

@@clientName(DiagnosticRendering, "ContainerAppDiagnosticRendering", "csharp");

@@clientName(DiagnosticRendering.type, "DiagnosticRenderingType", "csharp");

@@clientName(
  DiagnosticsDataApiResponse,
  "ContainerAppDiagnosticsDataApiResult",
  "csharp"
);

@@clientName(
  CSharpDiagnosticsDefinition,
  "ContainerAppDiagnosticsMetadata",
  "csharp"
);

@@clientName(
  DiagnosticsProperties,
  "ContainerAppDiagnosticsProperties",
  "csharp"
);

@@clientName(DiagnosticsStatus, "ContainerAppDiagnosticsStatus", "csharp");

@@clientName(
  DiagnosticSupportTopic,
  "ContainerAppDiagnosticSupportTopic",
  "csharp"
);

@@clientName(
  DnsVerificationTestResult,
  "ContainerAppDnsVerificationTestResult",
  "csharp"
);

@@clientName(
  EnvironmentAuthToken,
  "ContainerAppEnvironmentAuthToken",
  "csharp"
);

@@clientName(EnvironmentAuthTokenProperties.expires, "ExpireOn", "csharp");

@@clientName(
  EnvironmentProvisioningState,
  "ContainerAppEnvironmentProvisioningState",
  "csharp"
);

@@clientName(EnvironmentVar, "ContainerAppEnvironmentVariable", "csharp");

@@clientName(ErrorEntity, "WorkflowErrorEntity", "csharp");

@@clientName(ExtendedLocation, "ContainerAppExtendedLocation", "csharp");

@@clientName(ExtendedLocation.type, "ExtendedLocationType", "csharp");

@@clientName(
  ExtendedLocationTypes,
  "ContainerAppExtendedLocationType",
  "csharp"
);

@@clientName(Facebook, "ContainerAppFacebookConfiguration", "csharp");

@@clientName(Facebook.enabled, "IsEnabled", "csharp");

@@clientName(ForwardProxy, "ContainerAppForwardProxy", "csharp");

@@clientName(
  ForwardProxyConvention,
  "ContainerAppForwardProxyConvention",
  "csharp"
);

@@clientName(GitHub, "ContainerAppGitHubConfiguration", "csharp");

@@clientName(GitHub.enabled, "IsEnabled", "csharp");

@@clientName(
  GithubActionConfiguration,
  "ContainerAppGitHubActionConfiguration",
  "csharp"
);

@@clientName(
  GithubActionConfiguration.githubPersonalAccessToken,
  "GitHubPersonalAccessToken",
  "csharp"
);

@@clientName(GithubActionConfiguration.os, "OS", "csharp");

@@clientName(GlobalValidation, "ContainerAppGlobalValidation", "csharp");

@@clientName(Google, "ContainerAppGoogleConfiguration", "csharp");

@@clientName(Google.enabled, "IsEnabled", "csharp");

@@clientName(HttpRoute, "ContainerAppHttpRoute", "csharp");

@@clientName(HttpRouteConfig, "ContainerAppHttpRouteConfig", "csharp");

@@clientName(
  HttpRouteConfigProperties,
  "ContainerAppHttpRouteConfigProperties",
  "csharp"
);

@@clientName(HttpRouteMatch, "ContainerAppHttpRouteMatch", "csharp");

@@clientName(HttpRouteMatch.caseSensitive, "IsCaseSensitive", "csharp");

@@clientName(
  HttpRouteProvisioningErrors,
  "ContainerAppHttpRouteProvisioningErrors",
  "csharp"
);

@@clientName(
  HttpRouteProvisioningErrors.timestamp,
  "ErrorOccurredOn",
  "csharp"
);

@@clientName(
  HttpRouteProvisioningState,
  "ContainerAppHttpRouteProvisioningState",
  "csharp"
);

@@clientName(HttpRouteRule, "ContainerAppHttpRouteRule", "csharp");

@@clientName(HttpRouteTarget, "ContainerAppHttpRouteTarget", "csharp");

@@clientName(HttpScaleRule, "ContainerAppHttpScaleRule", "csharp");

@@clientName(HttpSettings, "ContainerAppHttpSettings", "csharp");

@@clientName(
  IdentityProviders,
  "ContainerAppIdentityProvidersConfiguration",
  "csharp"
);

@@clientName(IdentitySettings, "ContainerAppIdentitySettings", "csharp");

@@clientName(
  IdentitySettingsLifeCycle,
  "ContainerAppIdentitySettingsLifeCycle",
  "csharp"
);

@@clientName(Ingress, "ContainerAppIngressConfiguration", "csharp");

@@clientName(
  Ingress.ipSecurityRestrictions,
  "IPSecurityRestrictions",
  "csharp"
);

@@clientName(
  IngressClientCertificateMode,
  "ContainerAppIngressClientCertificateMode",
  "csharp"
);

@@clientName(
  IngressConfiguration,
  "ManagedEnvironmentIngressConfiguration",
  "csharp"
);

@@clientName(
  IngressTransportMethod,
  "ContainerAppIngressTransportMethod",
  "csharp"
);

@@clientName(InitContainer, "ContainerAppInitContainer", "csharp");

@@clientName(
  IpSecurityRestrictionRule,
  "ContainerAppIPSecurityRestrictionRule",
  "csharp"
);

@@clientName(
  IpSecurityRestrictionRule.ipAddressRange,
  "IPAddressRange",
  "csharp"
);

@@clientName(Job, "ContainerAppJob", "csharp");

@@clientName(Jobs, "ContainerAppJobs", "csharp");

@@clientName(JobConfiguration, "ContainerAppJobConfiguration", "csharp");

@@clientName(
  JobConfigurationEventTriggerConfig,
  "EventTriggerConfiguration",
  "csharp"
);

@@clientName(JobExecution, "ContainerAppJobExecution", "csharp");

@@clientName(JobExecutionBase, "ContainerAppJobExecutionBase", "csharp");

@@clientName(
  JobExecutionTemplate,
  "ContainerAppJobExecutionTemplate",
  "csharp"
);

@@clientName(
  JobPatchPropertiesProperties,
  "ContainerAppJobPatchProperties",
  "csharp"
);

@@clientName(
  JobPatchPropertiesProperties.outboundIpAddresses,
  "OutboundIPAddresses",
  "csharp"
);

@@clientName(
  JobProperties.outboundIpAddresses,
  "OutboundIPAddresses",
  "csharp"
);

@@clientName(
  JobProvisioningState,
  "ContainerAppJobProvisioningState",
  "csharp"
);

@@clientName(JobScale, "ContainerAppJobScale", "csharp");

@@clientName(JobScale.pollingInterval, "PollingIntervalInSeconds", "csharp");

@@clientName(JobScaleRule, "ContainerAppJobScaleRule", "csharp");

@@clientName(JobScaleRule.type, "JobScaleRuleType", "csharp");

@@clientName(JobsCollection, "ContainerAppJobsCollection", "csharp");

@@clientName(JobTemplate, "ContainerAppJobTemplate", "csharp");

@@clientName(JwtClaimChecks, "ContainerAppJwtClaimChecks", "csharp");

@@clientName(Kind, "ContainerAppKind", "csharp");

@@clientName(
  LifecycleConfiguration,
  "SessionPoolLifecycleConfiguration",
  "csharp"
);

@@clientName(LifecycleType, "SessionPoolLifecycleType", "csharp");

@@clientName(
  LogAnalyticsConfiguration,
  "ContainerAppLogAnalyticsConfiguration",
  "csharp"
);

@@clientName(
  LogAnalyticsConfiguration.dynamicJsonColumns,
  "UseDynamicJsonColumns",
  "csharp"
);

@@clientName(Login, "ContainerAppLogin", "csharp");

@@clientName(LogLevel, "ContainerAppDaprLogLevel", "csharp");

@@clientName(
  MaintenanceConfigurationResource,
  "ContainerAppMaintenanceConfiguration",
  "csharp"
);

@@clientName(ManagedCertificate, "ContainerAppManagedCertificate", "csharp");

@@clientName(
  ManagedCertificateDomainControlValidation.CNAME,
  "Cname",
  "csharp"
);

@@clientName(ManagedCertificateDomainControlValidation.HTTP, "Http", "csharp");

@@clientName(ManagedEnvironment, "ContainerAppManagedEnvironment", "csharp");

@@clientName(ManagedEnvironments, "ContainerAppManagedEnvironments", "csharp");

@@clientName(ManagedEnvironmentProperties.staticIp, "StaticIP", "csharp");

@@clientName(Certificates.getCertificates, "Get", "csharp");

@@clientName(Certificates.listCertificates, "List", "csharp");

@@clientName(Certificates.deleteCertificates, "Delete", "csharp");

@@clientName(
  Certificates.createOrUpdateCertificates,
  "CreateOrUpdate",
  "csharp"
);

@@clientName(Certificates.updateCertificates, "Update", "csharp");

@@clientName(
  ManagedEnvironmentProperties.zoneRedundant,
  "IsZoneRedundant",
  "csharp"
);

@@clientName(
  ManagedEnvironmentStorage,
  "ContainerAppManagedEnvironmentStorage",
  "csharp"
);

@@clientName(
  ManagedIdentitySetting,
  "SessionPoolManagedIdentitySetting",
  "csharp"
);

@@clientName(
  ManagedEnvironmentPropertiesPeerTrafficConfigurationEncryption.enabled,
  "IsEnabled",
  "csharp"
);

@@clientName(Mtls.enabled, "IsMtlsEnabled", "csharp");

@@clientName(
  NfsAzureFileProperties,
  "ContainerAppNfsAzureFileProperties",
  "csharp"
);

@@clientName(Nonce, "ContainerAppLoginNonce", "csharp");

@@clientName(
  OpenIdConnectClientCredential,
  "ContainerAppOpenIdConnectClientCredential",
  "csharp"
);

@@clientName(OpenIdConnectConfig, "ContainerAppOpenIdConnectConfig", "csharp");

@@clientName(OpenIdConnectLogin, "ContainerAppOpenIdConnectLogin", "csharp");

@@clientName(
  OpenIdConnectRegistration,
  "ContainerAppOpenIdConnectRegistration",
  "csharp"
);

@@clientName(
  PrivateEndpointConnection,
  "ContainerAppPrivateEndpointConnection",
  "csharp"
);

@@clientName(
  PrivateEndpointConnectionProvisioningState,
  "ContainerAppPrivateEndpointConnectionProvisioningState",
  "csharp"
);

@@clientName(
  PrivateEndpointServiceConnectionStatus,
  "ContainerAppPrivateEndpointServiceConnectionStatus",
  "csharp"
);

@@clientName(PrivateLinkResource, "ContainerAppPrivateLink", "csharp");

@@clientName(
  PrivateLinkServiceConnectionState,
  "ContainerAppPrivateLinkServiceConnectionState",
  "csharp"
);

@@clientName(
  PrivateEndpointConnectionProperties.privateLinkServiceConnectionState,
  "ConnectionState",
  "csharp"
);

@@clientName(
  CertificateType.ServerSSLCertificate,
  "ServerSslCertificate",
  "csharp"
);

@@clientName(ContainerAppsBuildResource, "ContainerAppsBuild", "csharp");

@@clientName(ContainerAppsBuildCollection, "ContainerAppsBuildList", "csharp");

@@clientName(ContainerAppsPatchResource, "ContainerAppsPatch", "csharp");

@@clientName(PatchCollection, "ContainerAppsPatchList", "csharp");

@@clientName(
  DaprSubscriptionBulkSubscribeOptions,
  "DaprSubscriptionBulkSubscribeConfig",
  "csharp"
);

@@clientName(LabelHistoryRecordItem.start, "StartedOn", "csharp");

@@clientName(LabelHistoryRecordItem.stop, "StoppedOn", "csharp");

@@clientName(MetricsConfiguration.includeKeda, "IsKedaIncluded", "csharp");

@@clientName(OtlpConfiguration.insecure, "IsInsecure", "csharp");

@@clientName(PatchSkipConfig.skip, "ShouldSkip", "csharp");

@@clientName(PublicNetworkAccess, "ContainerAppPublicNetworkAccess", "csharp");

@@clientName(QueueScaleRule, "ContainerAppQueueScaleRule", "csharp");

@@clientName(RegistryCredentials, "ContainerAppRegistryCredentials", "csharp");

@@clientName(RegistryInfo, "ContainerAppRegistryInfo", "csharp");

@@clientName(RegistryInfo.registryUrl, "RegistryServer", "csharp");

@@clientName(Replica, "ContainerAppReplica", "csharp");

@@clientName(ReplicaContainer, "ContainerAppReplicaContainer", "csharp");

@@clientName(ReplicaContainer.ready, "IsReady", "csharp");

@@clientName(ReplicaContainer.started, "IsStarted", "csharp");

@@clientName(ResourceTags, "ContainerAppResourceTags", "csharp");

@@clientName(Revision, "ContainerAppRevision", "csharp");

@@clientName(RevisionProperties.active, "IsActive", "csharp");

@@clientName(RevisionHealthState, "ContainerAppRevisionHealthState", "csharp");

@@clientName(
  RevisionProvisioningState,
  "ContainerAppRevisionProvisioningState",
  "csharp"
);

@@clientName(Scale, "ContainerAppScale", "csharp");

@@clientName(ScaleConfiguration, "SessionPoolScaleConfiguration", "csharp");

@@clientName(ScaleRule, "ContainerAppScaleRule", "csharp");

@@clientName(ScaleRuleAuth, "ContainerAppScaleRuleAuth", "csharp");

@@clientName(Scheme, "ContainerAppHttpScheme", "csharp");

@@clientName(ScheduledEntry, "ManagedEnvironmentScheduledEntry", "csharp");

@@clientName(
  ScheduledEntries,
  "ContainerAppMaintenanceScheduledEntries",
  "csharp"
);

@@clientName(ScheduledEntries.scheduledEntries, "ScheduledEntries", "csharp");

@@clientName(Secret, "ContainerAppWritableSecret", "csharp");

@@clientName(
  SecretKeyVaultProperties,
  "ContainerAppSecretKeyVaultProperties",
  "csharp"
);

@@clientName(ServiceBind, "ContainerAppServiceBind", "csharp");

@@clientName(Scheme.HTTP, "Http", "csharp");

@@clientName(Scheme.HTTPS, "Https", "csharp");

@@clientName(SourceControl, "ContainerAppSourceControl", "csharp");

@@clientName(
  SourceControlProperties.githubActionConfiguration,
  "GitHubActionConfiguration",
  "csharp"
);

@@clientName(SourceControlProperties.repoUrl, "RepoUri", "csharp");

@@clientName(
  SourceControlOperationState,
  "ContainerAppSourceControlOperationState",
  "csharp"
);

@@clientName(StorageType, "ContainerAppStorageType", "csharp");

@@clientName(TcpScaleRule, "ContainerAppTcpScaleRule", "csharp");

@@clientName(Template, "ContainerAppTemplate", "csharp");

@@clientName(TokenStore, "ContainerAppTokenStore", "csharp");

@@clientName(TokenStore.enabled, "IsEnabled", "csharp");

@@clientName(
  BlobStorageTokenStore.sasUrlSettingName,
  "AzureBlobStorageSasUrlSettingName",
  "csharp"
);

@@clientName(TrafficWeight, "ContainerAppRevisionTrafficWeight", "csharp");

@@clientName(TrafficWeight.latestRevision, "IsLatestRevision", "csharp");

@@clientName(TriggerType, "ContainerAppJobTriggerType", "csharp");

@@clientName(Twitter, "ContainerAppTwitterConfiguration", "csharp");

@@clientName(Twitter.enabled, "IsEnabled", "csharp");

@@clientName(TwitterRegistration, "ContainerAppTwitterRegistration", "csharp");

@@clientName(Type, "ContainerAppProbeType", "csharp");

@@clientName(ContainerType.PythonLTS, "PythonLts", "csharp");

@@clientName(
  UnauthenticatedClientActionV2,
  "ContainerAppUnauthenticatedClientActionV2",
  "csharp"
);

@@clientName(Microsoft.App.Usage, "ContainerAppUsage", "csharp");

@@clientName(UsageName, "ContainerAppUsageName", "csharp");

@@clientName(UsageUnit, "ContainerAppUsageUnit", "csharp");

@@clientName(VnetConfiguration, "ContainerAppVnetConfiguration", "csharp");

@@clientName(VnetConfiguration.internal, "IsInternal", "csharp");

@@clientName(Volume, "ContainerAppVolume", "csharp");

@@clientName(VolumeMount, "ContainerAppVolumeMount", "csharp");

@@clientName(WeekDay, "ManagedEnvironmentWeekDay", "csharp");

@@clientName(WorkflowEnvelope, "LogicAppWorkflowEnvelope", "csharp");

@@clientName(TracesConfiguration.includeDapr, "IsDaprIncluded", "csharp");

@@clientName(LogicAppProperties, "ContainerAppLogicAppConfiguration", "csharp");

@@clientName(
  WorkflowEnvelopeProperties,
  "LogicAppWorkflowEnvelopeProperties",
  "csharp"
);

@@clientName(WorkflowHealth, "LogicAppWorkflowHealth", "csharp");

@@clientName(WorkflowHealthState, "LogicAppWorkflowHealthState", "csharp");

@@clientName(WorkflowKind, "LogicAppWorkflowKind", "csharp");

@@clientName(WorkflowState, "LogicAppWorkflowState", "csharp");

@@clientName(WorkloadProfile, "ContainerAppWorkloadProfile", "csharp");

@@clientName(WorkloadProfile.maximumCount, "MaximumNodeCount", "csharp");

@@clientName(WorkloadProfile.minimumCount, "MinimumNodeCount", "csharp");

@@clientName(
  workloadProfileStates,
  "ContainerAppWorkloadProfileState",
  "csharp"
);

@@clientName(
  WorkloadProfileStatesProperties,
  "ContainerAppWorkloadProfileStateProperties",
  "csharp"
);

// C# @@markAsPageable customizations.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable billing meters SDK surface during MPG migration"
@@markAsPageable(BillingMetersOperationGroup.get, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable secrets SDK surface during MPG migration"
@@markAsPageable(ContainerApps.listSecrets, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable secrets SDK surface during MPG migration"
@@markAsPageable(Jobs.listSecrets, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable secrets SDK surface during MPG migration"
@@markAsPageable(ConnectedEnvironmentsDaprComponents.listSecrets, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable secrets SDK surface during MPG migration"
@@markAsPageable(DaprComponents.listSecrets, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable storage SDK surface during MPG migration"
@@markAsPageable(ConnectedEnvironmentsStorages.list, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable storage SDK surface during MPG migration"
@@markAsPageable(ManagedEnvironmentsStorages.list, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable replica SDK surface during MPG migration"
@@markAsPageable(ContainerAppsRevisionReplicas.listReplicas, "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous pageable diagnostics SDK surface during MPG migration"
@@markAsPageable(ManagedEnvironmentsDiagnostics.listDetectors, "csharp");

// C# @@scope customizations.
@@scope(ContainerAppsLabelHistory.listLabelHistory, "!csharp");

// C# @@usage customizations.
@@usage(LogicAppProperties, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  ContainerAppAuthToken,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  AvailableWorkloadProfile,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  AvailableWorkloadProfileProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(BillingMeter, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  BillingMeterProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(Diagnostics, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  DiagnosticsProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  DiagnosticsDefinition,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(DiagnosticsStatus, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  DiagnosticDataProviderMetadata,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  DiagnosticDataProviderMetadataPropertyBagItem,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  DiagnosticDataTableResponseObject,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  DiagnosticDataTableResponseColumn,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(DiagnosticRendering, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  DiagnosticsDataApiResponse,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  DiagnosticSupportTopic,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(EnvironmentAuthToken, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(PrivateLinkResource, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(Replica, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(ReplicaContainer, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(Revision, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  workloadProfileStates,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  WorkloadProfileStatesProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(
  JavaComponentProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(WorkflowEnvelope, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  WorkflowEnvelopeProperties,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

@@usage(WorkflowHealth, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(ErrorEntity, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(UsageUnit, Azure.ClientGenerator.Core.Usage.input, "csharp");

@@usage(
  OpenIdConnectClientCredentialMethod,
  Azure.ClientGenerator.Core.Usage.input,
  "csharp"
);

// C# @@clientDoc customizations. Use clientDoc (DocumentationMode.replace) so
// these descriptions apply to generated clients only and do not change the
// service swagger output.
@@clientDoc(
  JobPatchProperties.properties,
  "Container Apps Job patch resource properties.",
  DocumentationMode.replace
);

@@clientDoc(
  JobPatchPropertiesProperties,
  "Container Apps Job patch properties.",
  DocumentationMode.replace
);

@@clientDoc(
  LogicAppsProxyMethod,
  "HTTP method used by the Logic Apps proxy.",
  DocumentationMode.replace
);

@@clientDoc(
  TemplateUpdateStatus,
  "Session pool template update status.",
  DocumentationMode.replace
);

@@clientDoc(
  ActiveRevisionsMode,
  "Controls how active revisions are handled for the Container app.",
  DocumentationMode.replace
);

@@clientDoc(
  Configuration.activeRevisionsMode,
  "Controls how active revisions are handled for the Container app.",
  DocumentationMode.replace
);

// C# @@flattenProperty customizations.
#suppress "deprecated" "Preserve the previous flattened C# runtime.java.enableMetrics property during MPG migration"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous flattened C# runtime.java.enableMetrics property during MPG migration"
@@flattenProperty(Runtime.java, "csharp");

#suppress "deprecated" "Preserve the previous flattened C# runtime.java.enableMetrics property during MPG migration"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous flattened C# runtime.java.enableMetrics property during MPG migration"
@@flattenProperty(Configuration.runtime, "csharp");

#suppress "deprecated" "Preserve the previous flattened C# token store property during MPG migration"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the previous flattened C# token store property during MPG migration"
@@flattenProperty(TokenStore.azureBlobStorage, "csharp");
