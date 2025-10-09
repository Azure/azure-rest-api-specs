import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NGINX.NGINXPLUS;

@@clientName(NGINX.NGINXPLUS, "NginxManagementClient", "javascript");

// Method name overrides
@@clientName(Configurations.analyze, "analysis", "!csharp");

// Model name overrides
@@clientName(Certificate, "NginxCertificate", "!csharp");
@@clientName(ApiKey, "NginxDeploymentApiKeyResponse", "!csharp");
@@clientName(ApiKeyResponseProperties,
  "NginxDeploymentApiKeyResponseProperties",
  "!csharp"
);
@@clientName(ApiKeyRequest, "NginxDeploymentApiKeyRequest", "!csharp");
@@clientName(ApiKeyRequestProperties,
  "NginxDeploymentApiKeyRequestProperties",
  "!csharp"
);
@@clientName(Configuration, "NginxConfigurationResponse", "!csharp");
@@clientName(NginxConfigurationProtectedFileResult,
  "NginxConfigurationProtectedFileResponse",
  "!csharp"
);
@@clientName(NginxConfigurationProtectedFileContent,
  "NginxConfigurationProtectedFileRequest",
  "!csharp"
);
@@clientName(AnalysisConfig, "AnalysisCreateConfig", "!csharp");
@@clientName(AnalysisResultContent, "AnalysisResultData", "!csharp");
@@clientName(DiagnosticLevel, "Level", "!csharp");

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

// Anonymous model named by m4
@@clientName(NginxAppProtect,
  "NginxDeploymentPropertiesNginxAppProtect",
  "!csharp"
);
// @@clientName(AutoScaleSettings,
//   "NginxDeploymentScalingPropertiesAutoScaleSettings",
//   "!csharp"
// );

// Client location overrides for NginxDeployments operations
@@clientLocation(NginxDeployments.get, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.createOrUpdate, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.update, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.delete, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.listByResourceGroup,
  "Deployments",
  "!csharp"
);
@@clientLocation(NginxDeployments.listBySubscription, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.listDefaultWafPolicies,
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
