import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;

@@clientName(Nginx.NginxPlus, "NginxManagementClient", "javascript");

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
@@clientName(ActivationState, "NginxWafActivationState", "csharp");
@@clientName(NginxConfigurationResponseProperties,
  "NginxConfigurationProperties",
  "csharp"
);
@@clientName(NginxConfigurationRequestProperties,
  "NginxConfigurationCreateOrUpdateProperties",
  "csharp"
);

@@clientName(AnalysisResult, "NginxAnalysisResult", "csharp");
@@clientName(AnalysisDiagnostic, "NginxAnalysisDiagnostic", "csharp");
@@clientName(DiagnosticItem, "NginxDiagnosticItem", "csharp");
@@clientName(ProvisioningState, "NginxProvisioningState", "csharp");
@@clientName(AutoUpgradeProfile, "NginxDeploymentAutoUpgradeProfile", "csharp");
@@clientName(ScaleProfile, "NginxScaleProfile", "csharp");
@@clientName(ScaleProfileCapacity, "NginxScaleProfileCapacity", "csharp");
@@clientName(WebApplicationFirewallSettings, "NginxWafSettings", "csharp");
@@clientName(WebApplicationFirewallStatus, "NginxWafStatus", "csharp");
@@clientName(WebApplicationFirewallPackage, "NginxWafPackage", "csharp");
@@clientName(WebApplicationFirewallComponentVersions,
  "NginxWafComponentVersions",
  "csharp"
);
