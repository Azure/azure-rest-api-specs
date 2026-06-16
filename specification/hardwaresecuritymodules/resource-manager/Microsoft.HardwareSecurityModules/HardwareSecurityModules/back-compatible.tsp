import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HardwareSecurityModules;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BackupResult.properties,
  "!python,!java,!csharp,!javascript"
);
@@clientName(Error.innererror, "innerError");
@@clientName(CloudHsmClusters.createOrUpdate::parameters.resource, "body");
@@clientName(CloudHsmClusters.update::parameters.properties, "body");
@@clientName(CloudHsmClusters.restore::parameters.body,
  "restoreRequestProperties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudHsmCluster.properties,
  "!python,!java,!csharp,!javascript"
);
@@clientName(PrivateEndpointConnections.create::parameters.resource,
  "properties"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PrivateEndpointConnection.properties,
  "!python,!java,!csharp,!javascript"
);
@@clientName(DedicatedHsms.createOrUpdate::parameters.resource, "parameters");
@@clientName(DedicatedHsms.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DedicatedHsm.properties,
  "!python,!java,!csharp,!javascript"
);
@@clientName(CloudHsmClusters.validateBackupProperties::parameters.body,
  "backupRequestProperties",
  "!csharp"
);
@@clientName(CloudHsmClusters.backup::parameters.body,
  "backupRequestProperties",
  "!csharp"
);
@@clientName(CloudHsmClusters.validateRestoreProperties::parameters.body,
  "restoreRequestProperties",
  "!csharp"
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
  "CloudHsmClusterPrivateEndpointConnections",
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.create,
  "CloudHsmClusterPrivateEndpointConnections",
  "!csharp"
);
@@clientLocation(PrivateEndpointConnections.delete,
  "CloudHsmClusterPrivateEndpointConnections",
  "!csharp"
);
//DedicatedHsms operations
@@clientLocation(DedicatedHsms.get, "DedicatedHsm", "!csharp");
@@clientLocation(DedicatedHsms.createOrUpdate, "DedicatedHsm", "!csharp");
@@clientLocation(DedicatedHsms.update, "DedicatedHsm", "!csharp");
@@clientLocation(DedicatedHsms.delete, "DedicatedHsm", "!csharp");
@@clientLocation(DedicatedHsms.listByResourceGroup, "DedicatedHsm", "!csharp");
@@clientLocation(DedicatedHsms.listBySubscription, "DedicatedHsm", "!csharp");
@@clientLocation(DedicatedHsms.listOutboundNetworkDependenciesEndpoints,
  "DedicatedHsm",
  "!csharp"
);
