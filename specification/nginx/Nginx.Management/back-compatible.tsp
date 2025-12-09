import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Nginx.NginxPlus;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AnalysisCreate.config, "autorest");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AnalysisResult.data, "autorest");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentProperties.nginxAppProtect, "autorest");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentScalingProperties.autoScaleSettings);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ScaleProfile.capacity, "autorest");

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentUpdateProperties.nginxAppProtect, "autorest");

@@clientLocation(NginxDeploymentApiKeyResponses.get, "ApiKeys", "!csharp");
@@clientLocation(NginxDeploymentApiKeyResponses.createOrUpdate,
  "ApiKeys",
  "!csharp"
);
@@clientName(NginxDeploymentApiKeyResponses.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(NginxDeploymentApiKeyResponses.delete, "ApiKeys", "!csharp");
@@clientLocation(NginxDeploymentApiKeyResponses.list, "ApiKeys", "!csharp");

@@clientLocation(NginxCertificates.get, "Certificates", "!csharp");
@@clientLocation(NginxCertificates.createOrUpdate, "Certificates", "!csharp");
@@clientName(NginxCertificates.createOrUpdate::parameters.resource, "body");
@@clientLocation(NginxCertificates.delete, "Certificates", "!csharp");
@@clientLocation(NginxCertificates.list, "Certificates", "!csharp");

@@clientLocation(NginxConfigurationResponses.get, "Configurations", "!csharp");
@@clientLocation(NginxConfigurationResponses.createOrUpdate,
  "Configurations",
  "!csharp"
);
@@clientName(NginxConfigurationResponses.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(NginxConfigurationResponses.delete,
  "Configurations",
  "!csharp"
);
@@clientLocation(NginxConfigurationResponses.list, "Configurations", "!csharp");
@@clientLocation(NginxConfigurationResponses.analysis,
  "Configurations",
  "!csharp"
);

@@clientLocation(NginxDeployments.get, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.createOrUpdate, "Deployments", "!csharp");
@@clientName(NginxDeployments.createOrUpdate::parameters.resource, "body");
@@clientLocation(NginxDeployments.update, "Deployments", "!csharp");
@@clientName(NginxDeployments.update::parameters.properties, "body");
@@clientLocation(NginxDeployments.delete, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.listByResourceGroup,
  "Deployments",
  "!csharp"
);
@@clientLocation(NginxDeployments.list, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.wafPolicyList, "WafPolicy", "!csharp");
@@clientLocation(NginxDeployments.defaultWafPolicyList,
  "DefaultWafPolicy",
  "!csharp"
);
@@clientName(NginxDeployments.wafPolicyList, "list");
@@clientName(NginxDeployments.defaultWafPolicyList, "list");

@@clientLocation(NginxDeploymentWafPolicies.get, "WafPolicy", "!csharp");
@@clientLocation(NginxDeploymentWafPolicies.create, "WafPolicy", "!csharp");
@@clientName(NginxDeploymentWafPolicies.create::parameters.resource, "body");
@@clientLocation(NginxDeploymentWafPolicies.delete, "WafPolicy", "!csharp");
