import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(EdgeProfileSubscription.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DataBoxEdgeDevicePatch.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeviceCapacityRequestInfo.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DataBoxEdgeDeviceExtendedInfo.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Node.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DCAccessCode.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(SecuritySettings.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(TriggerSupportPackageRequest.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(UploadCertificateRequest.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(ArcAddon.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(CloudEdgeManagementRole.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(FileEventTrigger.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(IoTAddon.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(IoTRole.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(KubernetesRole.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MECRole.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DataBoxEdgeDevice.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Alert.properties);

@@clientName(BandwidthSchedules.createOrUpdate::parameters.resource,
  "parameters"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(BandwidthSchedule.properties);

@@clientLocation(DeviceCapacityInfos.getDeviceCapacityInfo,
  "DeviceCapacityInfo"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DeviceCapacityInfo.properties);

@@clientName(DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "proactiveLogCollectionSettings"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(DiagnosticRemoteSupportSettings.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Job.properties);

#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(NetworkSettings.properties);

@@clientName(Orders.createOrUpdate::parameters.resource, "order");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(MonitoringMetricConfiguration.properties);

@@clientName(Shares.createOrUpdate::parameters.resource, "share");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Share.properties);

@@clientName(StorageAccountCredentials.createOrUpdate::parameters.resource,
  "storageAccountCredential"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageAccountCredential.properties);

@@clientName(StorageAccounts.createOrUpdate::parameters.resource,
  "storageAccount"
);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(StorageAccount.properties);

@@clientName(Containers.createOrUpdate::parameters.resource, "container");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Container.properties);

@@clientName(Triggers.createOrUpdate::parameters.resource, "trigger");

@@clientLocation(UpdateSummaries.getUpdateSummary, Devices);
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(UpdateSummary.properties);

@@clientName(Users.createOrUpdate::parameters.resource, "user");
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(User.properties);

@@clientLocation(AvailableSkusOperationGroup.list, "AvailableSkus");
@@visibility(Alert.properties, Lifecycle.Read);
@@visibility(NetworkSettings.properties, Lifecycle.Read);

@@OpenAPI.extension(DataBoxEdgeSkuList.value,
  "x-ms-identifiers",
  #["name", "resourceType"]
);
