import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AnalysisCreate.config);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(AnalysisResult.data);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentProperties.nginxAppProtect);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentScalingProperties.autoScaleSettings);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ScaleProfile.capacity);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentUpdateProperties.nginxAppProtect);

@@clientLocation(NginxDeploymentApiKeyResponses.get, "ApiKeys");
@@clientLocation(NginxDeploymentApiKeyResponses.createOrUpdate, "ApiKeys");
@@clientName(NginxDeploymentApiKeyResponses.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(NginxDeploymentApiKeyResponses.delete, "ApiKeys");
@@clientLocation(NginxDeploymentApiKeyResponses.list, "ApiKeys");

@@clientLocation(NginxCertificates.get, "Certificates");
@@clientLocation(NginxCertificates.createOrUpdate, "Certificates");
@@clientName(NginxCertificates.createOrUpdate::parameters.resource, "body");
@@clientLocation(NginxCertificates.delete, "Certificates");
@@clientLocation(NginxCertificates.list, "Certificates");

@@clientLocation(NginxConfigurationResponses.get, "Configurations");
@@clientLocation(NginxConfigurationResponses.createOrUpdate, "Configurations");
@@clientName(NginxConfigurationResponses.createOrUpdate::parameters.resource,
  "body"
);
@@clientLocation(NginxConfigurationResponses.delete, "Configurations");
@@clientLocation(NginxConfigurationResponses.list, "Configurations");
@@clientLocation(NginxConfigurationResponses.analysis, "Configurations");

@@clientLocation(NginxDeployments.get, "Deployments", "!csharp");
@@clientLocation(NginxDeployments.createOrUpdate, "Deployments");
@@clientName(NginxDeployments.createOrUpdate::parameters.resource, "body");
@@clientLocation(NginxDeployments.update, "Deployments");
@@clientName(NginxDeployments.update::parameters.properties, "body");
@@clientLocation(NginxDeployments.delete, "Deployments");
@@clientLocation(NginxDeployments.listByResourceGroup, "Deployments");
@@clientLocation(NginxDeployments.list, "Deployments");
@@clientLocation(NginxDeployments.wafPolicyList, "WafPolicy");
@@clientName(NginxDeployments.wafPolicyList, "List");
@@clientLocation(NginxDeployments.defaultWafPolicyList, "DefaultWafPolicy");
@@clientName(NginxDeployments.defaultWafPolicyList, "List");

@@clientLocation(NginxDeploymentWafPolicies.get, "WafPolicy");
@@clientLocation(NginxDeploymentWafPolicies.create, "WafPolicy");
@@clientName(NginxDeploymentWafPolicies.create::parameters.resource, "body");
@@clientLocation(NginxDeploymentWafPolicies.delete, "WafPolicy");
