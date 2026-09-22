import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;
using Http;

@@clientName(Sku, "SkuInfo", "go");
@@clientName(DataBoxEdgeSku, "AvailableDataBoxEdgeSku", "csharp");
@@clientName(Alert, "DataBoxEdgeAlert", "csharp");
@@clientName(Order, "DataBoxEdgeOrder", "csharp");
@@clientName(Addon, "DataBoxEdgeRoleAddon", "csharp");
@@clientName(Role, "DataBoxEdgeRole", "csharp");
@@clientName(Share, "DataBoxEdgeShare", "csharp");
@@clientName(
  StorageAccountCredential,
  "DataBoxEdgeStorageAccountCredential",
  "csharp"
);
@@clientName(StorageAccount, "DataBoxEdgeStorageAccount", "csharp");
@@clientName(Container, "DataBoxEdgeStorageContainer", "csharp");
@@clientName(Trigger, "DataBoxEdgeTrigger", "csharp");
@@clientName(User, "DataBoxEdgeUser", "csharp");
@@clientName(
  DiagnosticProactiveLogCollectionSettings,
  "DiagnosticProactiveLogCollectionSetting",
  "csharp"
);
@@clientName(
  DiagnosticRemoteSupportSettings,
  "DiagnosticRemoteSupportSetting",
  "csharp"
);

@@clientName(SSLStatus, "SslStatus", "java");
@@clientName(NetworkAdapterDHCPStatus, "NetworkAdapterDhcpStatus", "java");
@@clientName(NetworkAdapterRDMAStatus, "NetworkAdapterRdmaStatus", "java");
@@clientName(ARMBaseModel, "ArmBaseModel", "java");
@@clientName(
  RefreshDetails.lastCompletedRefreshJobTimeInUTC,
  "lastCompletedRefreshJobTimeInUtc",
  "java"
);
@@clientName(StorageAccountCredentialProperties.userName, "username", "java");
@@clientName(
  Microsoft.DataBoxEdge,
  "DataBoxEdgeManagementClient",
  "javascript, python"
);

@@override(
  Users.delete,
  reorderParameters(
    Users.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Users.listByDataBoxEdgeDevice,
  reorderParameters(
    Users.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "$filter",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Users.get,
  reorderParameters(
    Users.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Users.createOrUpdate,
  reorderParameters(
    Users.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Users.createOrUpdate::parameters.resource,
  "user",
  "python,go,javascript"
);

@@override(
  StorageAccounts.delete,
  reorderParameters(
    StorageAccounts.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  StorageAccounts.listByDataBoxEdgeDevice,
  reorderParameters(
    StorageAccounts.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  StorageAccounts.get,
  reorderParameters(
    StorageAccounts.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  StorageAccounts.createOrUpdate,
  reorderParameters(
    StorageAccounts.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  StorageAccounts.createOrUpdate::parameters.resource,
  "storageAccount",
  "python,go,javascript"
);

@@override(
  MonitoringMetricConfigurations.delete,
  reorderParameters(
    MonitoringMetricConfigurations.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  MonitoringMetricConfigurations.list,
  reorderParameters(
    MonitoringMetricConfigurations.list,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  MonitoringMetricConfigurations.get,
  reorderParameters(
    MonitoringMetricConfigurations.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  MonitoringMetricConfigurations.createOrUpdate,
  reorderParameters(
    MonitoringMetricConfigurations.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  MonitoringMetricConfigurations.createOrUpdate::parameters.resource,
  "monitoringMetricConfiguration",
  "python,go,javascript"
);

@@override(
  OperationsStatus.get,
  reorderParameters(
    OperationsStatus.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

// Core lib supports query operation status, so scope out this operation for .NET.
@@scope(OperationsStatus.get, "!csharp");

@@override(
  Jobs.get,
  reorderParameters(
    Jobs.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Roles.delete,
  reorderParameters(
    Roles.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Roles.listByDataBoxEdgeDevice,
  reorderParameters(
    Roles.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Roles.get,
  reorderParameters(
    Roles.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Roles.createOrUpdate,
  reorderParameters(
    Roles.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Roles.createOrUpdate::parameters.resource,
  "role",
  "python,go,javascript"
);

@@override(
  Shares.delete,
  reorderParameters(
    Shares.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Shares.listByDataBoxEdgeDevice,
  reorderParameters(
    Shares.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Shares.refresh,
  reorderParameters(
    Shares.refresh,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Shares.get,
  reorderParameters(
    Shares.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Shares.createOrUpdate,
  reorderParameters(
    Shares.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Shares.createOrUpdate::parameters.resource,
  "share",
  "python,go,javascript"
);

@@override(
  Containers.delete,
  reorderParameters(
    Containers.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "containerName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Containers.refresh,
  reorderParameters(
    Containers.refresh,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "containerName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Containers.listByStorageAccount,
  reorderParameters(
    Containers.listByStorageAccount,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Containers.get,
  reorderParameters(
    Containers.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "containerName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Containers.createOrUpdate,
  reorderParameters(
    Containers.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "storageAccountName",
      "containerName",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Containers.createOrUpdate::parameters.resource,
  "container",
  "python,go,javascript"
);

@@override(
  Orders.delete,
  reorderParameters(
    Orders.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "orderName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Orders.listDCAccessCode,
  reorderParameters(
    Orders.listDCAccessCode,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "orderName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Orders.listByDataBoxEdgeDevice,
  reorderParameters(
    Orders.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Orders.get,
  reorderParameters(
    Orders.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "orderName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Orders.createOrUpdate,
  reorderParameters(
    Orders.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "orderName",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Orders.createOrUpdate::parameters.resource,
  "order",
  "python,go,javascript"
);

@@override(
  Triggers.delete,
  reorderParameters(
    Triggers.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Triggers.listByDataBoxEdgeDevice,
  reorderParameters(
    Triggers.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "$filter",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Triggers.get,
  reorderParameters(
    Triggers.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Triggers.createOrUpdate,
  reorderParameters(
    Triggers.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Triggers.createOrUpdate::parameters.resource,
  "trigger",
  "python,go,javascript"
);

@@override(
  Addons.delete,
  reorderParameters(
    Addons.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "addonName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Addons.listByRole,
  reorderParameters(
    Addons.listByRole,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Addons.get,
  reorderParameters(
    Addons.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "addonName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Addons.createOrUpdate,
  reorderParameters(
    Addons.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "roleName",
      "addonName",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  Addons.createOrUpdate::parameters.resource,
  "addon",
  "python,go,javascript"
);

@@override(
  Alerts.listByDataBoxEdgeDevice,
  reorderParameters(
    Alerts.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Alerts.get,
  reorderParameters(
    Alerts.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  BandwidthSchedules.delete,
  reorderParameters(
    BandwidthSchedules.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  BandwidthSchedules.listByDataBoxEdgeDevice,
  reorderParameters(
    BandwidthSchedules.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  BandwidthSchedules.get,
  reorderParameters(
    BandwidthSchedules.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  BandwidthSchedules.createOrUpdate,
  reorderParameters(
    BandwidthSchedules.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  BandwidthSchedules.createOrUpdate::parameters.resource,
  "parameters",
  "python,go,javascript"
);

@@override(
  StorageAccountCredentials.delete,
  reorderParameters(
    StorageAccountCredentials.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  StorageAccountCredentials.listByDataBoxEdgeDevice,
  reorderParameters(
    StorageAccountCredentials.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  StorageAccountCredentials.get,
  reorderParameters(
    StorageAccountCredentials.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  StorageAccountCredentials.createOrUpdate,
  reorderParameters(
    StorageAccountCredentials.createOrUpdate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "name",
      "resourceGroupName",
      "resource"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  StorageAccountCredentials.createOrUpdate::parameters.resource,
  "storageAccountCredential",
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.listByDataBoxEdgeDevice,
  reorderParameters(
    DataBoxEdgeDevices.listByDataBoxEdgeDevice,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.delete,
  reorderParameters(
    DataBoxEdgeDevices.delete,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.createOrUpdateSecuritySettings,
  reorderParameters(
    DataBoxEdgeDevices.createOrUpdateSecuritySettings,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName",
      "body"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  DataBoxEdgeDevices.createOrUpdateSecuritySettings::parameters.body,
  "securitySettings",
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.uploadCertificate,
  reorderParameters(
    DataBoxEdgeDevices.uploadCertificate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName",
      "body"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  DataBoxEdgeDevices.uploadCertificate::parameters.body,
  "parameters",
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.installUpdates,
  reorderParameters(
    DataBoxEdgeDevices.installUpdates,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  Devices.getNetworkSettings,
  reorderParameters(
    Devices.getNetworkSettings,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "networkSetting",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.generateCertificate,
  reorderParameters(
    DataBoxEdgeDevices.generateCertificate,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName",
      "body"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.scanForUpdates,
  reorderParameters(
    DataBoxEdgeDevices.scanForUpdates,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.get,
  reorderParameters(
    DataBoxEdgeDevices.get,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.update,
  reorderParameters(
    DataBoxEdgeDevices.update,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName",
      "properties"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  DataBoxEdgeDevices.update::parameters.properties,
  "parameters",
  "python,go,javascript"
);

@@override(
  UpdateSummaries.getUpdateSummary,
  reorderParameters(
    UpdateSummaries.getUpdateSummary,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "updateSummary",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.updateExtendedInformation,
  reorderParameters(
    DataBoxEdgeDevices.updateExtendedInformation,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "resourceGroupName",
      "body"
    ]
  ),
  "python,go,javascript"
);

@@clientName(
  DataBoxEdgeDevices.updateExtendedInformation::parameters.body,
  "parameters",
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.downloadUpdates,
  reorderParameters(
    DataBoxEdgeDevices.downloadUpdates,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@override(
  DataBoxEdgeDevices.getExtendedInformation,
  reorderParameters(
    DataBoxEdgeDevices.getExtendedInformation,
    #[
      "provider",
      "apiVersion",
      "subscriptionId",
      "deviceName",
      "body",
      "resourceGroupName"
    ]
  ),
  "python,go,javascript"
);

@@clientName(DataBoxEdgeSkuList, "AvailableDataBoxEdgeSkuList", "csharp");
@@clientName(AddonState, "DataBoxEdgeRoleAddonProvisioningState", "csharp");
@@clientName(AlertProperties.appearedAtDateTime, "AppearedOn", "csharp");
@@clientName(BandwidthScheduleProperties.start, "StartOn", "csharp");
@@clientName(BandwidthScheduleProperties.stop, "StopOn", "csharp");
@@alternateType(BandwidthScheduleProperties.start, duration, "csharp");
@@alternateType(BandwidthScheduleProperties.stop, duration, "csharp");
@@clientName(
  DataBoxEdgeDeviceProperties.systemData,
  "DataBoxEdgeSystemData",
  "csharp"
);
@@clientName(DCAccessCode, "DataBoxEdgeDataCenterAccessCode", "csharp");
@@clientName(SSLStatus, "DataBoxEdgeStorageAccountSslStatus", "csharp");
@@clientName(AccessLevel, "EdgeRemoteApplicationAccessLevel", "csharp");
@@clientName(AccountType, "DataBoxEdgeStorageAccountType", "csharp");
@@clientName(Address, "DataBoxEdgeShippingAddress", "csharp");
@@clientName(
  ClusterMemoryCapacity.clusterFailoverMemoryMb,
  "ClusterFailoverMemoryInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterFreeMemoryMb,
  "ClusterFreeMemoryInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterUsedMemoryMb,
  "ClusterUsedMemoryInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterFragmentationMemoryMb,
  "ClusterFragmentationMemoryInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterInfraVmMemoryMb,
  "ClusterInfraVmMemoryInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterTotalMemoryMb,
  "ClusterTotalMemoryInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterNonFailoverVmMb,
  "ClusterNonFailoverVmInMB",
  "csharp"
);
@@clientName(
  ClusterMemoryCapacity.clusterMemoryUsedByVmsMb,
  "ClusterMemoryUsedByVmsInMB",
  "csharp"
);
@@clientName(
  ClusterStorageViewData.clusterFreeStorageMb,
  "ClusterFreeStorageInMB",
  "csharp"
);
@@clientName(
  ClusterStorageViewData.clusterTotalStorageMb,
  "ClusterTotalStorageInMB",
  "csharp"
);
@@clientName(GenerateCertResponse, "GenerateCertResult", "csharp");
@@clientName(GenerateCertResponse.expiryTimeInUTC, "ExpireOn", "csharp");
@@clientName(
  HostCapacity.effectiveAvailableMemoryMbOnHost,
  "EffectiveAvailableMemoryInMBOnHost",
  "csharp"
);
@@clientName(NodeInfo, "EdgeKubernetesNodeInfo", "csharp");
@@clientName(
  NumaNodeData.effectiveAvailableMemoryInMb,
  "EffectiveAvailableMemoryInMB",
  "csharp"
);
@@clientName(NumaNodeData.totalMemoryInMb, "TotalMemoryInMB", "csharp");
@@clientName(NumaNodeData, "NumaNodeInfo", "csharp");
@@clientName(PlatformType, "DataBoxEdgeOSPlatformType", "csharp");
@@clientName(
  RemoteSupportSettings.expirationTimeStampInUTC,
  "ExpireOn",
  "csharp"
);
@@clientName(Secret, "DataBoxEdgeDeviceSecret", "csharp");
@@clientName(UpdateDetails.updateSize, "UpdateSizeInBytes", "csharp");
@@alternateType(
  UserAccessRight.userId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(VmMemory.startupMemoryMB, "StartupMemoryInMB", "csharp");
@@clientName(VmMemory.currentMemoryUsageMB, "CurrentMemoryUsageInMB", "csharp");
@@clientName(UpdateSummary, "DataBoxEdgeDeviceUpdateSummary", "csharp");
@@clientName(NetworkSettings, "DataBoxEdgeDeviceNetworkSettings", "csharp");
@@clientName(DeviceCapacityInfo, "DataBoxEdgeDeviceCapacityInfo", "csharp");
@@alternateType(
  IoTDeviceInfo.ioTHostHubId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(
  AzureContainerDataFormat,
  "DataBoxEdgeStorageContainerDataFormat",
  "csharp"
);
@@clientName(AzureContainerInfo, "DataBoxEdgeStorageContainerInfo", "csharp");
@@clientName(ContainerStatus, "DataBoxEdgeStorageContainerStatus", "csharp");
@@clientName(ComputeResource, "EdgeComputeResourceInfo", "csharp");
@@clientName(MonitoringStatus, "DataBoxEdgeShareMonitoringStatus", "csharp");
@@alternateType(
  MetricConfiguration.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(ArcAddon, "EdgeArcAddon", "csharp");
@@clientName(IoTAddon, "EdgeIotAddon", "csharp");
@@clientName(IoTDeviceInfo, "EdgeIotDeviceInfo", "csharp");
@@clientName(IoTRole, "EdgeIotRole", "csharp");
@@clientName(Ipv4Config, "DataBoxEdgeIPv4Config", "csharp");
@@clientName(Ipv6Config, "DataBoxEdgeIPv6Config", "csharp");
@@clientName(ClientPermissionType, "EdgeClientPermissionType", "csharp");
@@clientName(ClusterMemoryCapacity, "EdgeClusterMemoryCapacity", "csharp");
@@clientName(ClusterCapacityViewData, "EdgeClusterCapacityViewInfo", "csharp");
@@clientName(ClusterStorageViewData, "EdgeClusterStorageViewInfo", "csharp");
@@clientName(ClusterGpuCapacity, "EdgeClusterGpuCapacity", "csharp");
@@clientName(ClusterWitnessType, "EdgeClusterWitnessType", "csharp");
@@alternateType(
  EdgeProfileSubscription.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(FileSourceInfo, "EdgeFileSourceInfo", "csharp");
@@clientName(FileEventTrigger, "EdgeFileEventTrigger", "csharp");
@@clientName(KeyVaultSyncStatus, "EdgeKeyVaultSyncStatus", "csharp");
@@clientName(KubernetesClusterInfo, "EdgeKubernetesClusterInfo", "csharp");
@@clientName(
  KubernetesIPConfiguration,
  "EdgeKubernetesIPConfiguration",
  "csharp"
);
@@clientName(KubernetesNodeType, "EdgeKubernetesNodeType", "csharp");
@@clientName(KubernetesRole, "EdgeKubernetesRole", "csharp");
@@clientName(KubernetesRoleCompute, "EdgeKubernetesRoleCompute", "csharp");
@@clientName(KubernetesRoleNetwork, "EdgeKubernetesRoleNetwork", "csharp");
@@clientName(KubernetesRoleResources, "EdgeKubernetesRoleResources", "csharp");
@@clientName(KubernetesRoleStorage, "EdgeKubernetesRoleStorage", "csharp");
@@clientName(
  KubernetesRoleStorageClassInfo,
  "EdgeKubernetesRoleStorageClassInfo",
  "csharp"
);
@@clientName(KubernetesState, "EdgeKubernetesState", "csharp");
@@clientName(
  NetworkAdapterPosition,
  "DataBoxEdgeNetworkAdapterPosition",
  "csharp"
);
@@clientName(NetworkAdapterStatus, "DataBoxEdgeNetworkAdapterStatus", "csharp");
@@clientName(RemoteSupportSettings, "EdgeRemoteSupportSettings", "csharp");
@@clientName(RemoteApplicationType, "EdgeRemoteApplicationType", "csharp");
@@alternateType(
  DataBoxEdgeDevice.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(ResourceIdentity.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(SubscriptionProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(
  UploadCertificateResponse.aadTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  ArcAddonProperties.resourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(
  EdgeProfileSubscription.registrationId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(NetworkAdapter.nodeId, Azure.Core.uuid, "csharp");
@@alternateType(NodeProperties.nodeInstanceId, Azure.Core.uuid, "csharp");
@@alternateType(
  UploadCertificateResponse.servicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  UploadCertificateResponse.servicePrincipalClientId,
  Azure.Core.uuid,
  "csharp"
);
@@clientName(Job, "DataBoxEdgeJob", "csharp");
@@clientName(JobStatus, "DataBoxEdgeJobStatus", "csharp");
@@clientName(JobErrorDetails, "DataBoxEdgeJobErrorDetails", "csharp");
@@clientName(JobErrorItem, "DataBoxEdgeJobErrorItem", "csharp");
@@clientName(JobType, "DataBoxEdgeJobType", "csharp");
@@clientName(AlertSeverity, "DataBoxEdgeAlertSeverity", "csharp");
@@clientName(OrderStatus, "DataBoxEdgeOrderStatus", "csharp");
@@clientName(OrderState, "DataBoxEdgeOrderState", "csharp");
@@clientName(StorageAccountStatus, "DataBoxEdgeStorageAccountStatus", "csharp");
@@clientName(DayOfWeek, "DataBoxEdgeDayOfWeek", "csharp");
@@clientName(Node, "DataBoxEdgeNode", "csharp");
@@clientName(NodeList, "DataBoxEdgeNodeList", "csharp");
@@clientName(NodeStatus, "DataBoxEdgeNodeStatus", "csharp");
@@clientName(EncryptionAlgorithm, "DataBoxEdgeEncryptionAlgorithm", "csharp");
@@clientName(AuthenticationType, "DataBoxEdgeAuthenticationType", "csharp");
@@clientName(ContactDetails, "DataBoxEdgeContactDetails", "csharp");
@@clientName(DataPolicy, "DataBoxEdgeDataPolicy", "csharp");
@@clientName(DataResidencyType, "DataBoxEdgeDataResidencyType", "csharp");
@@clientName(DataBoxEdgeDeviceProperties.dataResidency, "Residency", "csharp");
@@clientName(DeviceType, "DataBoxEdgeDeviceType", "csharp");
@@clientName(DownloadPhase, "DataBoxEdgeDownloadPhase", "csharp");
@@clientName(EtcdInfo, "DataBoxEdgeEtcdInfo", "csharp");
@@clientName(LoadBalancerConfig, "DataBoxEdgeLoadBalancerConfig", "csharp");
@@clientName(MetricConfiguration, "DataBoxEdgeMetricConfiguration", "csharp");
@@clientName(MetricCounter, "DataBoxEdgeMetricCounter", "csharp");
@@clientName(MetricCounterSet, "DataBoxEdgeMetricCounterSet", "csharp");
@@clientName(MetricDimension, "DataBoxEdgeMetricDimension", "csharp");
@@clientName(MountPointMap, "DataBoxEdgeMountPointMap", "csharp");
@@clientName(MountType, "DataBoxEdgeMountType", "csharp");
@@clientName(NetworkAdapter, "DataBoxEdgeNetworkAdapter", "csharp");
@@clientName(NetworkGroup, "DataBoxEdgeNetworkGroup", "csharp");
@@clientName(RefreshDetails, "DataBoxEdgeRefreshDetails", "csharp");
@@clientName(ResourceMoveDetails, "DataBoxEdgeResourceMoveDetails", "csharp");
@@clientName(ResourceMoveStatus, "DataBoxEdgeResourceMoveStatus", "csharp");
@@clientName(RoleStatus, "DataBoxEdgeRoleStatus", "csharp");
@@clientName(RoleTypes, "DataBoxEdgeRoleType", "csharp");
@@clientName(RoleSinkInfo, "DataBoxEdgeRoleSinkInfo", "csharp");
@@clientName(SecuritySettings, "DataBoxEdgeSecuritySettings", "csharp");
@@clientName(ShipmentType, "DataBoxEdgeShipmentType", "csharp");
@@clientName(SkuAvailability, "DataBoxEdgeSkuAvailability", "csharp");
@@clientName(SkuCapability, "DataBoxEdgeSkuCapability", "csharp");
@@clientName(SkuCost, "DataBoxEdgeSkuCost", "csharp");
@@clientName(SkuLocationInfo, "DataBoxEdgeSkuLocationInfo", "csharp");
@@clientName(SkuSignupOption, "DataBoxEdgeSkuSignupOption", "csharp");
@@clientName(SkuVersion, "DataBoxEdgeSkuVersion", "csharp");
@@clientName(SubscriptionState, "DataBoxEdgeSubscriptionState", "csharp");
@@clientName(SymmetricKey, "DataBoxEdgeSymmetricKey", "csharp");
@@clientName(TrackingInfo, "DataBoxEdgeTrackingInfo", "csharp");
@@clientName(UpdateDetails, "DataBoxEdgeUpdateDetails", "csharp");
@@clientName(UpdateOperation, "DataBoxEdgeUpdateOperation", "csharp");
@@clientName(UpdateStatus, "DataBoxEdgeUpdateStatus", "csharp");
@@clientName(UpdateType, "DataBoxEdgeUpdateType", "csharp");
@@clientName(UserType, "DataBoxEdgeUserType", "csharp");
@@clientName(VmMemory, "DataBoxEdgeVmMemory", "csharp");
@@clientName(AlertErrorDetails, "DataBoxEdgeAlertErrorDetails", "csharp");

@@clientName(IoTEdgeAgentInfo, "IotEdgeAgentInfo", "csharp");
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(
  JobProperties.refreshedEntityId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  StorageAccountCredentialProperties.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AzureContainerInfo.storageAccountCredentialId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  StorageAccountProperties.storageAccountCredentialId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataBoxEdgeDeviceExtendedInfoProperties.clientSecretStoreId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  DataBoxEdgeDeviceExtendedInfoPatch.clientSecretStoreId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  EdgeProfileSubscriptionPatch.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MountPointMap.roleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  MountPointMap.shareId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ShareAccessRight.shareId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  FileSourceInfo.shareId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RoleSinkInfo.roleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  RefreshDetails.inProgressRefreshJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  UpdateSummaryProperties.lastCompletedDownloadJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  UpdateSummaryProperties.lastCompletedInstallJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  UpdateSummaryProperties.inProgressDownloadJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  UpdateSummaryProperties.inProgressInstallJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

@@alternateType(DataBoxEdgeDevice.etag, Azure.Core.eTag, "csharp");

@@clientName(MECRole, "MecRole", "csharp");
@@clientName(UploadCertificateRequest, "UploadCertificateContent", "csharp");
@@clientName(
  DeviceCapacityRequestInfo,
  "DeviceCapacityRequestContent",
  "csharp"
);
@@clientName(
  TriggerSupportPackageRequest,
  "TriggerSupportPackageContent",
  "csharp"
);
@@clientName(
  NetworkAdapterDHCPStatus,
  "DataBoxEdgeNetworkAdapterDhcpStatus",
  "csharp"
);
@@clientName(
  NetworkAdapterRDMAStatus,
  "DataBoxEdgeNetworkAdapterRdmaStatus",
  "csharp"
);

@@clientName(ShareAccessProtocol.SMB, "Smb", "csharp");
@@clientName(ShareAccessProtocol.NFS, "Nfs", "csharp");
@@clientName(RoleTypes.IOT, "IoT", "csharp");
@@clientName(RoleTypes.ASA, "Asa", "csharp");

@@clientName(MetricDimension_V1, "MetricDimensionV1", "python");
@@clientName(MetricSpecification_V1, "MetricSpecificationV1", "python");
@@clientName(RoleTypes.MEC, "Mec", "csharp");
@@clientName(NetworkGroup.NonRDMA, "NonRdma", "csharp");
@@clientName(NetworkGroup.RDMA, "Rdma", "csharp");
@@clientName(RemoteApplicationType.WAC, "Wac", "csharp");
@@clientName(HostPlatformType.LinuxVM, "LinuxVm", "csharp");
@@clientName(UserType.ARM, "Arm", "csharp");

@@clientName(NetworkAdapter.ipv4Configuration, "IPv4Configuration", "csharp");
@@clientName(NetworkAdapter.ipv6Configuration, "IPv6Configuration", "csharp");
@@clientName(
  NetworkAdapter.ipv6LinkLocalAddress,
  "IPv6LinkLocalAddress",
  "csharp"
);
@@clientName(Ipv4Config.ipAddress, "IPAddress", "csharp");
@@clientName(Ipv6Config.ipAddress, "IPAddress", "csharp");
@@clientName(KubernetesIPConfiguration.ipAddress, "IPAddress", "csharp");
@@clientName(NodeInfo.ipConfiguration, "IPConfiguration", "csharp");
@@clientName(NodeInfo.type, "NodeType", "csharp");

@@clientName(EtcdInfo.type, "EtcdInfoType", "csharp");
@@clientName(CniConfig.type, "CniConfigType", "csharp");
@@clientName(
  KubernetesRoleStorageClassInfo.type,
  "KubernetesRoleStorageClassInfoType",
  "csharp"
);
@@clientName(LoadBalancerConfig.type, "LoadBalancerConfigType", "csharp");
@@clientName(
  ClusterMemoryCapacity.clusterHypervReserveMemoryMb,
  "ClusterHyperVReserveMemoryMb",
  "csharp"
);
@@clientName(
  RefreshDetails.lastCompletedRefreshJobTimeInUTC,
  "LastCompletedRefreshJobTimeInUtc",
  "csharp"
);
@@clientName(
  ResourceMoveDetails.operationInProgressLockTimeoutInUTC,
  "OperationInProgressLockTimeoutInUtc",
  "csharp"
);
@@clientName(
  DataBoxEdgeDeviceExtendedInfoProperties.clientSecretStoreUrl,
  "ClientSecretStoreUri",
  "csharp"
);
@@clientName(
  DataBoxEdgeDeviceExtendedInfoPatch.clientSecretStoreUrl,
  "ClientSecretStoreUri",
  "csharp"
);
@@clientName(TrackingInfo.trackingUrl, "TrackingUri", "csharp");
@@clientName(
  ImageRepositoryCredential.imageRepositoryUrl,
  "ImageRepositoryUri",
  "csharp"
);
@@clientName(SkuName.TEA_1Node, "Tea1Node", "csharp");
@@clientName(SkuName.TEA_1Node_UPS, "Tea1NodeUps", "csharp");
@@clientName(SkuName.TEA_1Node_Heater, "Tea1NodeHeater", "csharp");
@@clientName(SkuName.TEA_1Node_UPS_Heater, "Tea1NodeUpsHeater", "csharp");
@@clientName(SkuName.TEA_4Node_Heater, "Tea4NodeHeater", "csharp");
@@clientName(SkuName.TEA_4Node_UPS_Heater, "Tea4NodeUpsHeater", "csharp");
@@clientName(SkuName.TMA, "Tma", "csharp");
@@clientName(SkuName.TDC, "Tdc", "csharp");
@@clientName(SkuName.TCA_Small, "TcaSmall", "csharp");
@@clientName(SkuName.GPU, "Gpu", "csharp");
@@clientName(SkuName.TCA_Large, "TcaLarge", "csharp");
@@clientName(SkuName.EdgePR_Base_UPS, "EdgePRBaseUps", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  SkuName.EP2_64_1VPU_W,
  Azure.ClientGenerator.Core.exact("EP2_64_1VpuW"),
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  SkuName.EP2_128_1T4_Mx1_W,
  Azure.ClientGenerator.Core.exact("EP2_128_1T4Mx1W"),
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  SkuName.EP2_256_2T4_W,
  Azure.ClientGenerator.Core.exact("EP2_256_2T4W"),
  "csharp"
);
@@clientName(SkuName.RCA_Small, "RcaSmall", "csharp");
@@clientName(SkuName.RCA_Large, "RcaLarge", "csharp");
@@clientName(SkuName.RDC, "Rdc", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  SkuName.EP2_64_Mx1_W,
  Azure.ClientGenerator.Core.exact("EP2_64_Mx1W"),
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  SkuName.EP2_128_GPU1_Mx1_W,
  Azure.ClientGenerator.Core.exact("EP2_128Gpu1Mx1W"),
  "csharp"
);
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  SkuName.EP2_256_GPU2_Mx1,
  Azure.ClientGenerator.Core.exact("EP2_256Gpu2Mx1"),
  "csharp"
);
@@clientName(SkuName.EdgeMR_TCP, "EdgeMRTcp", "csharp");

@@clientName(EncryptionAlgorithm.AES256, "Aes256", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" "Underscores required in C# client name to match existing SDK enum member for backward compatibility."
@@clientName(
  EncryptionAlgorithm.RSAES_PKCS1_v_1_5,
  Azure.ClientGenerator.Core.exact("RsaesPkcs1V1_5"),
  "csharp"
);

@@usage(Alert, Usage.input | Usage.output, "csharp");
@@usage(DiagnosticRemoteSupportSettings, Usage.input | Usage.output, "csharp");
@@usage(DataBoxEdgeDeviceExtendedInfo, Usage.input | Usage.output, "csharp");
@@usage(Node, Usage.input | Usage.output, "csharp");
@@usage(VmMemory, Usage.input | Usage.output, "csharp");
@@usage(ClusterCapacityViewData, Usage.input | Usage.output, "csharp");
@@usage(ClusterGpuCapacity, Usage.input | Usage.output, "csharp");
@@usage(ClusterMemoryCapacity, Usage.input | Usage.output, "csharp");
@@usage(ClusterStorageViewData, Usage.input | Usage.output, "csharp");
@@usage(HostCapacity, Usage.input | Usage.output, "csharp");
@@usage(NumaNodeData, Usage.input | Usage.output, "csharp");
@@usage(TriggerSupportPackageRequest, Usage.input | Usage.output, "csharp");
@@usage(UploadCertificateRequest, Usage.input | Usage.output, "csharp");
@@usage(SecuritySettings, Usage.input | Usage.output, "csharp");
@@usage(DeviceCapacityInfo, Usage.input | Usage.output, "csharp");
@@usage(NetworkSettings, Usage.input | Usage.output, "csharp");
@@usage(UpdateSummary, Usage.input | Usage.output, "csharp");

@@access(RoleSinkInfo, Access.public, "csharp");
@@access(FileSourceInfo, Access.public, "csharp");

@@alternateType(
  DataBoxEdgeDeviceExtendedInfoProperties.clientSecretStoreUrl,
  url,
  "csharp"
);
@@alternateType(
  DataBoxEdgeDeviceExtendedInfoPatch.clientSecretStoreUrl,
  url,
  "csharp"
);
@@alternateType(TrackingInfo.trackingUrl, url, "csharp");
@@alternateType(ImageRepositoryCredential.imageRepositoryUrl, url, "csharp");
@@alternateType(Ipv4Config.ipAddress, Azure.Core.ipV4Address, "csharp");
@@alternateType(SkuLocationInfo.location, Azure.Core.azureLocation, "csharp");
@@alternateType(DataBoxEdgeSku.locations, Azure.Core.azureLocation[], "csharp");
@@alternateType(GenerateCertResponse.expiryTimeInUTC, utcDateTime, "csharp");
@@alternateType(
  DataBoxEdgeDevicePatch.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(DataBoxEdgeDevicePropertiesPatch.edgeProfile, "Profile", "csharp");
@@clientName(IoTDeviceInfo.authentication, "Profile", "csharp");
@@clientName(IoTDeviceInfo.ioTHostHub, "IotHostHub", "csharp");
@@clientName(IoTDeviceInfo.ioTHostHubId, "IotHostHubId", "csharp");
@@clientName(IoTRoleProperties.ioTDeviceDetails, "IotDeviceDetails", "csharp");
@@clientName(
  IoTRoleProperties.ioTEdgeDeviceDetails,
  "IotEdgeDeviceDetails",
  "csharp"
);
@@clientName(IoTRoleProperties.ioTEdgeAgentInfo, "IotEdgeAgentInfo", "csharp");
@@clientName(IoTAddonProperties.ioTDeviceDetails, "IotDeviceDetails", "csharp");
@@clientName(
  IoTAddonProperties.ioTEdgeDeviceDetails,
  "IotEdgeDeviceDetails",
  "csharp"
);
@@clientName(
  DataBoxEdgeDevices.listByDataBoxEdgeDevice,
  "GetEdgeNodes",
  "csharp"
);
@@clientName(Orders.listDCAccessCode, "GetDataCenterAccessCode", "csharp");
@@clientName(AvailableSkusOperationGroup.list, "GetAvailableSkus", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  DataBoxEdgeDeviceExtendedInfo,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  Node,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  SecuritySettings,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  TriggerSupportPackageRequest,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  DeviceCapacityInfo.properties,
  "csharp"
);

@@alternateType(
  CloudEdgeManagementRoleProperties.roleStatus,
  RoleStatus | null,
  "csharp"
);
@@alternateType(IoTRoleProperties.roleStatus, RoleStatus | null, "csharp");
@@alternateType(IoTRoleProperties.hostPlatform, PlatformType | null, "csharp");
@@alternateType(
  KubernetesRoleProperties.roleStatus,
  RoleStatus | null,
  "csharp"
);
@@alternateType(
  KubernetesRoleProperties.hostPlatform,
  PlatformType | null,
  "csharp"
);
@@alternateType(MECRoleProperties.roleStatus, RoleStatus | null, "csharp");

@@override(
  DataBoxEdgeDevices.checkResourceCreationFeasibility,
  reorderParameters(
    DataBoxEdgeDevices.checkResourceCreationFeasibility,
    #[
      "subscriptionId",
      "resourceGroupName",
      "provider",
      "apiVersion",
      "deviceName",
      "body",
      "capacityName"
    ]
  )
);

@@clientName(
  DataBoxEdgeDevices.checkResourceCreationFeasibility::parameters.body,
  "deviceCapacityRequestInfo"
);

@@override(
  DataBoxEdgeDevices.createOrUpdate,
  reorderParameters(
    DataBoxEdgeDevices.createOrUpdate,
    #[
      "provider",
      "subscriptionId",
      "deviceName",
      "resourceGroupName",
      "resource",
      "apiVersion"
    ]
  )
);

@@clientName(
  DataBoxEdgeDevices.createOrUpdate::parameters.resource,
  "dataBoxEdgeDevice"
);

@@override(
  DiagnosticSettings.getDiagnosticProactiveLogCollectionSettings,
  reorderParameters(
    DiagnosticSettings.getDiagnosticProactiveLogCollectionSettings,
    #[
      "provider",
      "deviceName",
      "diagnosticProactiveLogCollectionSetting",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion"
    ]
  )
);

@@override(
  DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings,
  reorderParameters(
    DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings,
    #[
      "provider",
      "deviceName",
      "diagnosticProactiveLogCollectionSetting",
      "resourceGroupName",
      "resource",
      "subscriptionId",
      "apiVersion"
    ]
  )
);

@@clientName(
  DiagnosticSettings.updateDiagnosticProactiveLogCollectionSettings::parameters.resource,
  "proactiveLogCollectionSettings"
);

@@override(
  DiagnosticRemoteSupportSettingsOperationGroup.getDiagnosticRemoteSupportSettings,
  reorderParameters(
    DiagnosticRemoteSupportSettingsOperationGroup.getDiagnosticRemoteSupportSettings,
    #[
      "provider",
      "deviceName",
      "diagnosticRemoteSupportSetting",
      "subscriptionId",
      "resourceGroupName",
      "apiVersion"
    ]
  )
);

@@override(
  DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings,
  reorderParameters(
    DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings,
    #[
      "provider",
      "deviceName",
      "diagnosticRemoteSupportSetting",
      "resourceGroupName",
      "resource",
      "subscriptionId",
      "apiVersion"
    ]
  )
);

@@clientName(
  DiagnosticRemoteSupportSettingsOperationGroup.updateDiagnosticRemoteSupportSettings::parameters.resource,
  "diagnosticRemoteSupportSettings"
);

@@override(
  DataBoxEdgeDevices.triggerSupportPackage,
  reorderParameters(
    DataBoxEdgeDevices.triggerSupportPackage,
    #[
      "provider",
      "deviceName",
      "resourceGroupName",
      "body",
      "subscriptionId",
      "apiVersion"
    ]
  )
);

@@clientName(
  DataBoxEdgeDevices.triggerSupportPackage::parameters.body,
  "triggerSupportPackageRequest"
);

@@clientName(DataBoxEdgeSku, "ResourceTypeSku", "java");
@@clientLocation(AvailableSkusOperationGroup.list, "Skus", "java");
