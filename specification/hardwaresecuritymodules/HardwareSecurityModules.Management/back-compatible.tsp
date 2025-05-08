import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HardwareSecurityModules;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BackupResult.properties);

@@clientName(Error.innererror, "innerError");

@@clientName(CloudHsmClusters.createOrUpdate::parameters.resource, "body");
@@clientName(CloudHsmClusters.update::parameters.properties, "body");
@@clientName(CloudHsmClusters.restore::parameters.body,
  "restoreRequestProperties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudHsmCluster.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(DedicatedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(DedicatedHsms.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DedicatedHsm.properties);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RestoreResult.properties);
