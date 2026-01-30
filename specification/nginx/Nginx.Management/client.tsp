import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;
using Azure.Core;

@@clientName(Nginx.NginxPlus, "NginxManagementClient", "javascript");
@@clientName(Nginx.NginxPlus, "NginxManagementClient", "python");

// CommonTypes
@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "IdentityProperties",
  "!csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.UserAssignedIdentity,
  "UserIdentityProperties",
  "!csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType,
  "IdentityType",
  "!csharp"
);
// Sku has many more properties than ResourceSku
@@clientName(Azure.ResourceManager.CommonTypes.Sku, "ResourceSku", "!csharp");

// Client location overrides for NginxDeployments operations
@@clientLocation(NginxDeployments.get, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.createOrUpdate, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.update, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.delete, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.listByResourceGroup,
  "Deployments",
  "!csharp"
);

// Java client name overrides to maintain consistent casing
@@clientName(NginxPublicIPAddress, "NginxPublicIpAddress", "java");
@@clientName(NginxPrivateIPAddress, "NginxPrivateIpAddress", "java");
@@clientName(NginxPrivateIPAllocationMethod,
  "NginxPrivateIpAllocationMethod",
  "java"
);
@@clientName(NginxFrontendIPConfiguration,
  "NginxFrontendIpConfiguration",
  "java"
);

// Java property name overrides to maintain consistent casing
@@clientName(NginxNetworkProfile.frontEndIPConfiguration,
  "frontEndIpConfiguration",
  "java"
);
@@clientName(NginxFrontendIPConfiguration.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(NginxFrontendIPConfiguration.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(NginxPrivateIPAddress.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(NginxPrivateIPAddress.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);

@@alternateType(NginxNetworkInterfaceConfiguration.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(NginxPrivateIPAddress.privateIPAddress,
  Azure.Core.ipV4Address,
  "csharp"
);
@@alternateType(NginxPrivateIPAddress.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(NginxCertificateProperties.keyVaultSecretCreated,
  utcDateTime,
  "csharp"
);

@@clientName(AnalysisCreate, "NginxAnalysisContent", "csharp");
@@clientName(NginxCertificateErrorResponseBody,
  "NginxCertificateError",
  "csharp"
);
@@clientName(NginxConfigurationRequest,
  "NginxConfigurationCreateOrUpdateContent",
  "csharp"
);
@@clientName(NginxConfigurationRequest.type, "ResourceType", "csharp");
@@clientName(NginxConfigurationRequestProperties,
  "NginxConfigurationCreateOrUpdateProperties",
  "csharp"
);
@@clientName(NginxDeploymentApiKeyRequest,
  "NginxDeploymentApiKeyCreateOrUpdateContent",
  "csharp"
);
@@clientName(NginxDeploymentApiKeyRequest.type, "ResourceType", "csharp");
@@clientName(NginxDeploymentDefaultWafPolicyListResponse,
  "NginxDeploymentDefaultWafPolicyListResult",
  "csharp"
);
@@clientName(NginxDeploymentProperties.ipAddress, "IPAddress", "csharp");
@@clientName(NginxDeploymentScalingPropertiesAutoScaleSettings,
  "NginxDeploymentAutoScaleSettings",
  "csharp"
);

@@clientName(AnalysisResult, "NginxAnalysisResult", "csharp");
@@clientName(AnalysisDiagnostic, "NginxAnalysisDiagnostic", "csharp");
@@clientName(DiagnosticItem, "NginxDiagnosticItem", "csharp");
@@clientName(ProvisioningState, "NginxProvisioningState", "csharp");
@@clientName(ScaleProfile, "NginxScaleProfile", "csharp");
@@clientName(ScaleProfileCapacity, "NginxScaleProfileCapacity", "csharp");
@@clientName(WebApplicationFirewallSettings, "NginxWafSettings", "csharp");
@@clientName(WebApplicationFirewallStatus, "NginxWafStatus", "csharp");
@@clientName(WebApplicationFirewallPackage, "NginxWafPackage", "csharp");
@@clientName(WebApplicationFirewallComponentVersions,
  "NginxWafComponentVersions",
  "csharp"
);

@@clientName(AnalysisCreateConfig, "NginxAnalysisConfig", "csharp");
@@clientName(ActivationState,
  "WebApplicationFirewallActivationState",
  "csharp"
);
@@clientName(AnalysisResultData, "NginxAnalysisResultDetails", "csharp");
@@clientName(Level, "NginxDiagnosticLevel", "csharp");
@@clientName(NginxConfigurationResponse, "NginxConfiguration", "csharp,go");
@@usage(NginxConfigurationResponse, Usage.input, "csharp");
@@clientName(NginxConfigurationResponseProperties,
  "NginxConfigurationProperties",
  "csharp,go"
);
@@clientName(NginxDeploymentApiKeyResponse, "NginxDeploymentApiKey", "csharp");
@@clientName(NginxDeploymentApiKeyResponseProperties,
  "NginxDeploymentApiKeyProperties",
  "csharp"
);
@@clientName(NginxConfigurationProtectedFileRequest,
  "NginxConfigurationContentProtectedFile",
  "csharp"
);
@@clientName(NginxConfigurationProtectedFileResponse,
  "NginxConfigurationProtectedFile",
  "csharp"
);

@@alternateType(NginxDeploymentUpdateParameters.location,
  azureLocation,
  "csharp"
);
@@alternateType(NginxCertificate.location, azureLocation, "csharp");
@@clientName(ResourceSku, "NginxResourceSku", "csharp");
@@clientName(WebApplicationFirewallStatus,
  "WebApplicationFirewallStatus",
  "csharp"
);
@@clientName(WebApplicationFirewallPackage,
  "WebApplicationFirewallPackage",
  "csharp"
);
@@clientName(WebApplicationFirewallComponentVersions,
  "WebApplicationFirewallComponentVersions",
  "csharp"
);
@@clientName(WebApplicationFirewallSettings,
  "WebApplicationFirewallSettings",
  "csharp"
);
@@clientName(NginxDeployments.wafPolicyList, "GetWafPolicies", "csharp");
@@clientName(NginxDeployments.defaultWafPolicyList,
  "GetDefaultWafPolicies",
  "csharp"
);
@@alternateType(NginxDeployment.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(NginxDeploymentUpdateParameters.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
