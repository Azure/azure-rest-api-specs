import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HardwareSecurityModules;

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

//@@clientLocation and @@clientName decorators for operations that had custom @operationId
//These ensure consistent operationId generation and client method naming in the output
//All @operationId decorators have been removed after adding these client customizations

//CloudHsmClusters operations
@@clientLocation(CloudHsmClusters.listByCloudHsmCluster,
  "CloudHsmClusterPrivateLinkResources"
);
@@clientLocation(CloudHsmClusters.cloudHsmClusterBackupStatusGet,
  "CloudHsmClusterBackupStatus"
);
@@clientName(CloudHsmClusters.cloudHsmClusterBackupStatusGet, "Get");
@@clientLocation(CloudHsmClusters.cloudHsmClusterRestoreStatusGet,
  "CloudHsmClusterRestoreStatus"
);
@@clientName(CloudHsmClusters.cloudHsmClusterRestoreStatusGet, "Get");

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
