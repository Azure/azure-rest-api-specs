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

// @@clientLocation for @operationId operations
@@clientLocation(CloudHsmClusters.listByCloudHsmCluster,
  "CloudHsmClusterPrivateLinkResources_ListByCloudHsmCluster"
);
@@clientLocation(CloudHsmClusters.cloudHsmClusterBackupStatusGet,
  "CloudHsmClusterBackupStatus_Get"
);
@@clientLocation(CloudHsmClusters.cloudHsmClusterRestoreStatusGet,
  "CloudHsmClusterRestoreStatus_Get"
);
@@clientLocation(PrivateEndpointConnections.get,
  "CloudHsmClusterPrivateEndpointConnections_Get"
);
@@clientLocation(PrivateEndpointConnections.create,
  "CloudHsmClusterPrivateEndpointConnections_Create"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "CloudHsmClusterPrivateEndpointConnections_Delete"
);
@@clientLocation(DedicatedHsms.get, "DedicatedHsm_Get");
@@clientLocation(DedicatedHsms.createOrUpdate, "DedicatedHsm_CreateOrUpdate");
@@clientLocation(DedicatedHsms.update, "DedicatedHsm_Update");
@@clientLocation(DedicatedHsms.delete, "DedicatedHsm_Delete");
@@clientLocation(DedicatedHsms.listByResourceGroup,
  "DedicatedHsm_ListByResourceGroup"
);
@@clientLocation(DedicatedHsms.listBySubscription,
  "DedicatedHsm_ListBySubscription"
);
@@clientLocation(DedicatedHsms.listOutboundNetworkDependenciesEndpoints,
  "DedicatedHsm_ListOutboundNetworkDependenciesEndpoints"
);
