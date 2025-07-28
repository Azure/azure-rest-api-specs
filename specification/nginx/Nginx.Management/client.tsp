import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using NGINX.NGINXPLUS;

@@clientName(NGINX.NGINXPLUS, "NginxManagementClient", "javascript");

// Model name overrides
@@clientName(NGINX.NGINXPLUS.Certificate, "NginxCertificate", "!csharp");
@@clientName(NGINX.NGINXPLUS.ApiKey,
  "NginxDeploymentApiKeyResponse",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.ApiKeyResponseProperties,
  "NginxDeploymentApiKeyResponseProperties",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.ApiKeyRequest,
  "NginxDeploymentApiKeyRequest",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.ApiKeyRequestProperties,
  "NginxDeploymentApiKeyRequestProperties",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.Configuration,
  "NginxConfigurationResponse",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.NginxConfigurationProtectedFileResult,
  "NginxConfigurationProtectedFileResponse",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.NginxConfigurationProtectedFileContent,
  "NginxConfigurationProtectedFileRequest",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.AnalysisConfig, "AnalysisCreateConfig", "!csharp");
@@clientName(NGINX.NGINXPLUS.AnalysisResultContent,
  "AnalysisResultData",
  "!csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "IdentityProperties",
  "!csharp"
);
@@clientName(Azure.ResourceManager.CommonTypes.UserAssignedIdentity,
  "UserIdentityProperties",
  "!csharp"
);

// Sku has many more properties than ResourceSku
@@clientName(Azure.ResourceManager.CommonTypes.Sku, "ResourceSku", "!csharp");

// Anonymous model named by m4
@@clientName(NGINX.NGINXPLUS.NginxAppProtect,
  "NginxDeploymentPropertiesNginxAppProtect",
  "!csharp"
);
@@clientName(NGINX.NGINXPLUS.AutoScaleSettings,
  "NginxDeploymentScalingPropertiesAutoScaleSettings",
  "!csharp"
);

// Client location overrides for NginxDeployments operations
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.get,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.createOrUpdate,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.update,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.delete,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.listByResourceGroup,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.listBySubscription,
  "Deployments",
  "!csharp"
);
@@clientLocation(NGINX.NGINXPLUS.NginxDeployments.listDefaultWafPolicies,
  "Deployments",
  "!csharp"
);

// Java client name overrides to maintain consistent casing
@@clientName(NGINX.NGINXPLUS.NginxPublicIPAddress,
  "NginxPublicIpAddress",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxPrivateIPAddress,
  "NginxPrivateIpAddress",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxPrivateIPAllocationMethod,
  "NginxPrivateIpAllocationMethod",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxFrontendIPConfiguration,
  "NginxFrontendIpConfiguration",
  "java"
);

// Java property name overrides to maintain consistent casing
@@clientName(NGINX.NGINXPLUS.NginxNetworkProfile.frontEndIPConfiguration,
  "frontEndIpConfiguration",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxFrontendIPConfiguration.publicIPAddresses,
  "publicIpAddresses",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxFrontendIPConfiguration.privateIPAddresses,
  "privateIpAddresses",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxPrivateIPAddress.privateIPAddress,
  "privateIpAddress",
  "java"
);
@@clientName(NGINX.NGINXPLUS.NginxPrivateIPAddress.privateIPAllocationMethod,
  "privateIpAllocationMethod",
  "java"
);
