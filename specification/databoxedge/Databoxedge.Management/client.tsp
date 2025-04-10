import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;

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

@@clientName(DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "dataBoxEdgeDevice"
);
@@clientName(DataBoxEdgeDevices.update::parameters.properties, "parameters");
@@clientName(DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "securitySettings"
);
@@clientName(DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "parameters"
);
@@clientName(DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "parameters"
);
@@clientName(DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "deviceCapacityRequestInfo"
);
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DeviceCapacityInfo.properties);

@@clientName(DiagnosticProactiveLogCollectionSettingsOperationGroup,
  "DiagnosticProactiveLogCollectionSettings"
);
@@clientName(DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "proactiveLogCollectionSettings"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticProactiveLogCollectionSettings.properties);

@@clientName(DiagnosticRemoteSupportSettingsOperationGroup,
  "DiagnosticRemoteSupportSettings"
);
@@clientName(DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "diagnosticRemoteSupportSettings"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DiagnosticRemoteSupportSettings.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Job.properties);

@@clientName(NetworkSettingsOperationGroup, "NetworkSettings");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSettings.properties);

@@clientName(Orders.createOrUpdate::parameters.resource, "order");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Order.properties);

@@clientName(Roles.createOrUpdate::parameters.resource, "role");

@@clientName(Addons.createOrUpdate::parameters.resource, "addon");

@@clientName(MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "monitoringMetricConfiguration"
);
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

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(UpdateSummary.properties);

@@clientName(Users.createOrUpdate::parameters.resource, "user");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(User.properties);
