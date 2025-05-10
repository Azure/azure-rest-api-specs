import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Nginx.NginxPlus;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NginxDeploymentScalingProperties.autoScaleSettings);

@@clientName(NginxDeploymentApiKeyResponses.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(NginxCertificates.createOrUpdate::parameters.resource, "body");

@@clientName(NginxConfigurationResponses.createOrUpdate::parameters.resource,
  "body"
);

@@clientName(NginxDeployments.createOrUpdate::parameters.resource, "body");
@@clientName(NginxDeployments.update::parameters.properties, "body");
