import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NginxDeploymentScalingProperties.autoScaleSettings);

@@clientName(NginxDeploymentApiKeyResponses.createOrUpdate::parameters.properties,
  "body"
);

@@clientName(NginxCertificates.createOrUpdate::parameters.body, "body");

@@clientName(NginxConfigurationResponses.createOrUpdate::parameters.properties,
  "body"
);

@@clientName(NginxDeployments.createOrUpdate::parameters.body, "body");
@@clientName(NginxDeployments.update::parameters.body, "body");
@@clientName(AnalysisResultData, "NginxAnalysisResultDetails", "csharp");

@@clientName(NginxConfigurationProtectedFileRequest,
  "NginxConfigurationProtectedFileContent",
  "csharp"
);
@@clientName(NginxConfigurationProtectedFileResponse,
  "NginxConfigurationProtectedFileResult",
  "csharp"
);
