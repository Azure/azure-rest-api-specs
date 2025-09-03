import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Operation.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(EdgeProfileSubscription.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataBoxEdgeDevicePatch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeviceCapacityRequestInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataBoxEdgeDeviceExtendedInfo.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Node.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DCAccessCode.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SecuritySettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TriggerSupportPackageRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UploadCertificateRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ArcAddon.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CloudEdgeManagementRole.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(FileEventTrigger.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IoTAddon.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(IoTRole.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(KubernetesRole.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MECRole.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PeriodicTimerEventTrigger.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DataBoxEdgeDevice.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Alert.properties);

@@clientName(BandwidthSchedules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BandwidthSchedule.properties);

@@clientLocation(DeviceCapacityInfos.getDeviceCapacityInfo,
  "DeviceCapacityInfo"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeviceCapacityInfo.properties);

@@clientName(DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "proactiveLogCollectionSettings"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticProactiveLogCollectionSettings.properties);

@@clientLocation(DiagnosticRemoteSupportSettingsOperationGroup.getDiagnosticRemoteSupportSettings,
  DiagnosticSettings
);
@@clientLocation(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings,
  DiagnosticSettings
);
@@clientName(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "diagnosticRemoteSupportSettings"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticRemoteSupportSettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Job.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSettings.properties);

@@clientName(Orders.createOrUpdate::parameters.resource, "order");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Order.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MonitoringMetricConfiguration.properties);

@@clientName(Shares.createOrUpdate::parameters.resource, "share");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Share.properties);

@@clientName(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "storageAccountCredential"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccountCredential.properties);

@@clientName(StorageAccounts.createOrUpdate::parameters.resource,
  "storageAccount"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(StorageAccount.properties);

@@clientName(Containers.createOrUpdate::parameters.resource, "container");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Container.properties);

@@clientName(Triggers.createOrUpdate::parameters.resource, "trigger");

@@clientLocation(UpdateSummaries.getUpdateSummary, Devices);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateSummary.properties);

@@clientName(Users.createOrUpdate::parameters.resource, "user");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(User.properties);

@@clientLocation(AvailableSkusOperationGroup.list, "AvailableSkus");
