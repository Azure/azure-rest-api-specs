import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(EdgeProfileSubscription.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DataBoxEdgeDevicePatch.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeviceCapacityRequestInfo.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DataBoxEdgeDeviceExtendedInfo.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Node.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DCAccessCode.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SecuritySettings.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TriggerSupportPackageRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UploadCertificateRequest.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ArcAddon.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(CloudEdgeManagementRole.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(FileEventTrigger.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IoTAddon.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(IoTRole.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(KubernetesRole.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MECRole.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(PeriodicTimerEventTrigger.properties
);

@@clientLocation(DataBoxEdgeDevices.get, Devices);
@@clientLocation(DataBoxEdgeDevices.createOrUpdate, Devices);
@@clientName(DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "dataBoxEdgeDevice"
);
@@clientLocation(DataBoxEdgeDevices.update, Devices);
@@clientName(DataBoxEdgeDevices.update::parameters.properties, "parameters");
@@clientLocation(DataBoxEdgeDevices.delete, Devices);
@@clientLocation(DataBoxEdgeDevices.listByResourceGroup, Devices);
@@clientLocation(DataBoxEdgeDevices.listBySubscription, Devices);
@@clientLocation(DataBoxEdgeDevices.downloadUpdates, Devices);
@@clientLocation(DataBoxEdgeDevices.generateCertificate, Devices);
@@clientLocation(DataBoxEdgeDevices.getExtendedInformation, Devices);
@@clientLocation(DataBoxEdgeDevices.installUpdates, Devices);
@@clientLocation(DataBoxEdgeDevices.scanForUpdates, Devices);
@@clientLocation(DataBoxEdgeDevices.createOrUpdateSecuritySettings, Devices);
@@clientName(DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "securitySettings"
);
@@clientLocation(DataBoxEdgeDevices.updateExtendedInformation, Devices);
@@clientName(DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "parameters"
);
@@clientLocation(DataBoxEdgeDevices.uploadCertificate, Devices);
@@clientName(DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "parameters"
);
@@clientLocation(DataBoxEdgeDevices.checkResourceCreationFeasibility,
  "DeviceCapacityCheck"
);
@@clientName(DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "deviceCapacityRequestInfo"
);
@@clientLocation(DataBoxEdgeDevices.listByDataBoxEdgeDevice, "Nodes");
@@clientLocation(DataBoxEdgeDevices.triggerSupportPackage, "SupportPackages");
@@clientName(DataBoxEdgeDevices.triggerSupportPackage::parameters.body,
  "triggerSupportPackageRequest"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DataBoxEdgeDevice.properties
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Alert.properties);

@@clientName(BandwidthSchedules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(BandwidthSchedule.properties
);

@@clientLocation(DeviceCapacityInfos.getDeviceCapacityInfo,
  "DeviceCapacityInfo"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeviceCapacityInfo.properties
);

@@clientName(DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "proactiveLogCollectionSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiagnosticProactiveLogCollectionSettings.properties
);

@@clientLocation(DiagnosticRemoteSupportSettingsOperationGroup.getDiagnosticRemoteSupportSettings,
  DiagnosticSettings
);
@@clientLocation(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings,
  DiagnosticSettings
);
@@clientName(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "diagnosticRemoteSupportSettings"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DiagnosticRemoteSupportSettings.properties
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Job.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(NetworkSettings.properties);

@@clientName(Orders.createOrUpdate::parameters.resource, "order");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Order.properties);

@@clientName(Roles.createOrUpdate::parameters.resource, "role");

@@clientName(Addons.createOrUpdate::parameters.resource, "addon");

@@clientLocation(MonitoringMetricConfigurations.get, "MonitoringConfig");
@@clientLocation(MonitoringMetricConfigurations.createOrUpdate,
  "MonitoringConfig"
);
@@clientName(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "monitoringMetricConfiguration"
);
@@clientLocation(MonitoringMetricConfigurations.delete, "MonitoringConfig");
@@clientLocation(MonitoringMetricConfigurations.list, "MonitoringConfig");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(MonitoringMetricConfiguration.properties
);

@@clientName(Shares.createOrUpdate::parameters.resource, "share");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Share.properties);

@@clientName(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "storageAccountCredential"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageAccountCredential.properties
);

@@clientName(StorageAccounts.createOrUpdate::parameters.resource,
  "storageAccount"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(StorageAccount.properties);
@@clientName(Containers.createOrUpdate::parameters.resource, "container");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Container.properties);
@@clientName(Triggers.createOrUpdate::parameters.resource, "trigger");

@@clientLocation(UpdateSummaries.getUpdateSummary, Devices);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(UpdateSummary.properties);

@@clientName(Users.createOrUpdate::parameters.resource, "user");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(User.properties);

@@clientLocation(AvailableSkusOperationGroup.list, "AvailableSkus");
@@visibility(Alert.properties, Lifecycle.Read);
@@visibility(NetworkSettings.properties, Lifecycle.Read);

@@Azure.ResourceManager.identifiers(DataBoxEdgeSkuList.value,
  #["name", "resourceType"]
);
