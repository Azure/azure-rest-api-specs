import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HardwareSecurityModules;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateLinkResource.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BackupResult.properties);

@@clientName(Error.innererror, "innerError");

@@clientName(CloudHsmClusters.createOrUpdate::parameters.resource, "body");
@@clientName(CloudHsmClusters.update::parameters.properties, "body");
@@clientName(CloudHsmClusters.restore::parameters.body,
  "restoreRequestProperties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CloudHsmCluster.properties);

@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PrivateEndpointConnection.properties);

@@clientName(DedicatedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(DedicatedHsms.update::parameters.properties, "parameters");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DedicatedHsm.properties);
@@clientName(CloudHsmClusters.validateBackupProperties::parameters.body,
  "backupRequestProperties"
);
@@clientName(CloudHsmClusters.backup::parameters.body,
  "backupRequestProperties"
);
@@clientName(CloudHsmClusters.validateRestoreProperties::parameters.body,
  "restoreRequestProperties"
);

//@@clientLocation decorators for operations with custom @operationId
//These ensure consistent operationId generation in the output

//CloudHsmClusters operations
@@clientLocation(CloudHsmClusters.listByCloudHsmCluster,
  "CloudHsmClusterPrivateLinkResources"
);
@@clientLocation(CloudHsmClusters.cloudHsmClusterBackupStatusGet,
  "CloudHsmClusterBackupStatus"
);
@@clientLocation(CloudHsmClusters.cloudHsmClusterRestoreStatusGet,
  "CloudHsmClusterRestoreStatus"
);

//PrivateEndpointConnections operations
@@clientLocation(PrivateEndpointConnections.get,
  "CloudHsmClusterPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.create,
  "CloudHsmClusterPrivateEndpointConnections"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "CloudHsmClusterPrivateEndpointConnections"
);

//DedicatedHsms operations
@@clientLocation(DedicatedHsms.get, "DedicatedHsm");
@@clientLocation(DedicatedHsms.createOrUpdate, "DedicatedHsm");
@@clientLocation(DedicatedHsms.update, "DedicatedHsm");
@@clientLocation(DedicatedHsms.delete, "DedicatedHsm");
@@clientLocation(DedicatedHsms.listByResourceGroup, "DedicatedHsm");
@@clientLocation(DedicatedHsms.listBySubscription, "DedicatedHsm");
@@clientLocation(DedicatedHsms.listOutboundNetworkDependenciesEndpoints,
  "DedicatedHsm"
);
