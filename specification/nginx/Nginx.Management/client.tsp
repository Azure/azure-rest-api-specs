import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;

@@clientName(Nginx.NginxPlus, "NginxManagementClient", "javascript");

@@alternateType(Certificate.location, Azure.Core.azureLocation, "csharp");
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
@@alternateType(ApiKeyResponseProperties.endDateTime, utcDateTime, "csharp");
@@alternateType(ApiKeyRequestProperties.endDateTime, utcDateTime, "csharp");
@@clientName(AnalysisCreate, "NginxAnalysisContent", "csharp");
@@clientName(AnalysisConfig, "NginxAnalysisConfig", "csharp");
@@clientName(NginxCertificateErrorResponseBody,
  "NginxCertificateError",
  "csharp"
);
@@clientName(ActivationState, "NginxWafActivationState", "csharp");
@@clientName(AnalysisResultContent, "NginxAnalysisResultDetails", "csharp");
@@clientName(DiagnosticLevel, "NginxDiagnosticLevel", "csharp");
@@clientName(Configuration, "NginxConfiguration", "csharp");
@@clientName(NginxConfigurationResponseProperties,
  "NginxConfigurationProperties",
  "csharp"
);
@@clientName(ApiKey, "NginxDeploymentApiKey", "csharp");
@@clientName(ApiKeyResponseProperties,
  "NginxDeploymentApiKeyProperties",
  "csharp"
);
@@clientName(NginxConfigurationRequestProperties,
  "NginxConfigurationCreateOrUpdateProperties",
  "csharp"
);

@@clientName(Certificate, "NginxCertificate", "csharp");
@@clientName(AnalysisResult, "NginxAnalysisResult", "csharp");
@@clientName(WafPolicy, "NginxDeploymentWafPolicy", "csharp");
@@clientName(AnalysisDiagnostic, "NginxAnalysisDiagnostic", "csharp");
@@clientName(DiagnosticItem, "NginxDiagnosticItem", "csharp");
@@clientName(ProvisioningState, "NginxProvisioningState", "csharp");
@@clientName(ApiKeyRequestProperties,
  "NginxDeploymentApiKeyRequestProperties",
  "csharp"
);
@@clientName(AutoScaleSettings, "NginxDeploymentAutoScaleSettings", "csharp");
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
