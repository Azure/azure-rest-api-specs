import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use." "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NginxDeploymentScalingProperties.autoScaleSettings);

@@clientName(NginxDeploymentApiKeyResponses.createOrUpdate::parameters.properties,
  "body"
);

@@clientName(NginxCertificates.createOrUpdate::parameters.resource, "body");

@@clientName(NginxConfigurationResponses.createOrUpdate::parameters.properties,
  "body"
);

@@clientName(NginxDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(NginxDeployments.update::parameters.properties, "body");
@@clientName(AnalysisResultData, "NginxAnalysisResultDetails", "csharp");

@@clientName(NginxConfigurationProtectedFileRequest,
  "NginxConfigurationProtectedFileContent",
  "csharp"
);
@@clientName(NginxConfigurationProtectedFileResponse,
  "NginxConfigurationProtectedFileResult",
  "csharp"
);
