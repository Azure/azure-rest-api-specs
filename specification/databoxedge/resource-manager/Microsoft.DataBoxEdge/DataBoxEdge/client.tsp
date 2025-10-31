import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;
using Http;

@@clientName(DataBoxEdgeSku, "AvailableDataBoxEdgeSku", "csharp");

@@clientName(SSLStatus, "SslStatus", "java");
@@clientName(NetworkAdapterDHCPStatus, "NetworkAdapterDhcpStatus", "java");
@@clientName(NetworkAdapterRDMAStatus, "NetworkAdapterRdmaStatus", "java");
@@clientName(ARMBaseModel, "ArmBaseModel", "java");
@@clientName(RefreshDetails.lastCompletedRefreshJobTimeInUTC,
  "lastCompletedRefreshJobTimeInUtc",
  "java"
);
@@clientName(StorageAccountCredentialProperties.userName, "username", "java");
@@clientName(Microsoft.DataBoxEdge,
  "DataBoxEdgeManagementClient",
  "javascript, python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Users.delete, UsersDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("$filter")
  $filter?: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): UserList;

@@override(Users.listByDataBoxEdgeDevice,
  UsersListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): User;

@@override(Users.get, UsersGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  user: User,
): void;

@@override(Users.createOrUpdate, UsersCreateOrUpdateCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(StorageAccounts.delete, StorageAccountsDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): StorageAccountList;

@@override(StorageAccounts.listByDataBoxEdgeDevice,
  StorageAccountsListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): StorageAccount;

@@override(StorageAccounts.get, StorageAccountsGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  storageAccount: StorageAccount,
): void;

@@override(StorageAccounts.createOrUpdate,
  StorageAccountsCreateOrUpdateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(MonitoringMetricConfigurations.delete,
  MonitoringMetricConfigurationsDeleteCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsListCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): MonitoringMetricConfigurationList;

@@override(MonitoringMetricConfigurations.list,
  MonitoringMetricConfigurationsListCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): MonitoringMetricConfiguration;

@@override(MonitoringMetricConfigurations.get,
  MonitoringMetricConfigurationsGetCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  MonitoringMetricConfiguration: MonitoringMetricConfiguration,
): void;

@@override(MonitoringMetricConfigurations.createOrUpdate,
  MonitoringMetricConfigurationsCreateOrUpdateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OperationsStatusGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): OperationsStatus;

@@override(OperationsStatus.get, OperationsStatusGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op JobsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Job;

@@override(Jobs.get, JobsGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Roles.delete, RolesDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): RoleList;

@@override(Roles.listByDataBoxEdgeDevice,
  RolesListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Role;

@@override(Roles.get, RolesGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: Role,
): void;

@@override(Roles.createOrUpdate, RolesCreateOrUpdateCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Shares.delete, SharesDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): ShareList;

@@override(Shares.listByDataBoxEdgeDevice,
  SharesListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesRefreshCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Shares.refresh, SharesRefreshCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Share;

@@override(Shares.get, SharesGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: Share,
): void;

@@override(Shares.createOrUpdate, SharesCreateOrUpdateCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Containers.delete, ContainersDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersRefreshCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Containers.refresh, ContainersRefreshCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersListByStorageAccountCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): ContainerList;

@@override(Containers.listByStorageAccount,
  ContainersListByStorageAccountCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Container;

@@override(Containers.get, ContainersGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  storageAccountName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  containerName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: Container,
): void;

@@override(Containers.createOrUpdate,
  ContainersCreateOrUpdateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  order: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Orders.delete, OrdersDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrderslistDCAccessCodeCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  order: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): DCAccessCode;

@@override(Orders.listDCAccessCode, OrderslistDCAccessCodeCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): OrderList;

@@override(Orders.listByDataBoxEdgeDevice,
  OrdersListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  order: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Order;

@@override(Orders.get, OrdersGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  order: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: Order,
): void;

@@override(Orders.createOrUpdate, OrdersCreateOrUpdateCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Triggers.delete, TriggersDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @query("$filter")
  $filter?: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): TriggerList;

@@override(Triggers.listByDataBoxEdgeDevice,
  TriggersListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Trigger;

@@override(Triggers.get, TriggersGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: Trigger,
): void;

@@override(Triggers.createOrUpdate, TriggersCreateOrUpdateCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  addonName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(Addons.delete, AddonsDeleteCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsListByRoleCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): AddonList;

@@override(Addons.listByRole, AddonsListByRoleCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  addonName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Addon;

@@override(Addons.get, AddonsGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  roleName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  addonName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: Addon,
): void;

@@override(Addons.createOrUpdate, AddonsCreateOrUpdateCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AlertsListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): AlertList;

@@override(Alerts.listByDataBoxEdgeDevice,
  AlertsListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AlertsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): Alert;

@@override(Alerts.get, AlertsGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(BandwidthSchedules.delete,
  BandwidthSchedulesDeleteCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): BandwidthSchedulesList;

@@override(BandwidthSchedules.listByDataBoxEdgeDevice,
  BandwidthSchedulesListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): BandwidthSchedule;

@@override(BandwidthSchedules.get, BandwidthSchedulesGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: BandwidthSchedule,
): void;

@@override(BandwidthSchedules.createOrUpdate,
  BandwidthSchedulesCreateOrUpdateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(StorageAccountCredentials.delete,
  StorageAccountCredentialsDeleteCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): StorageAccountCredentialList;

@@override(StorageAccountCredentials.listByDataBoxEdgeDevice,
  StorageAccountCredentialsListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): StorageAccountCredential;

@@override(StorageAccountCredentials.get,
  StorageAccountCredentialsGetCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsCreateOrUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  name: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  resource: StorageAccountCredential,
): void;

@@override(StorageAccountCredentials.createOrUpdate,
  StorageAccountCredentialsCreateOrUpdateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesListByDataBoxEdgeDeviceCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): NodeList;

@@override(DataBoxEdgeDevices.listByDataBoxEdgeDevice,
  DataBoxEdgeDevicesListByDataBoxEdgeDeviceCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesDeleteCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(DataBoxEdgeDevices.delete,
  DataBoxEdgeDevicesDeleteCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesCreateOrUpdateSecuritySettingsCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  body: SecuritySettings,
): void;

@@override(DataBoxEdgeDevices.createOrUpdateSecuritySettings,
  DataBoxEdgeDevicesCreateOrUpdateSecuritySettingsCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesUploadCertificateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  body: UploadCertificateRequest,
): UploadCertificateResponse;

@@override(DataBoxEdgeDevices.uploadCertificate,
  DataBoxEdgeDevicesUploadCertificateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesInstallUpdatesCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(DataBoxEdgeDevices.installUpdates,
  DataBoxEdgeDevicesInstallUpdatesCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetNetworkSettingsCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  networkSetting: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): NetworkSettings;

@@override(Devices.getNetworkSettings,
  DataBoxEdgeDevicesGetNetworkSettingsCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGenerateCertificateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  body: void,
): GenerateCertResponse;

@@override(DataBoxEdgeDevices.generateCertificate,
  DataBoxEdgeDevicesGenerateCertificateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesScanForUpdatesCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(DataBoxEdgeDevices.scanForUpdates,
  DataBoxEdgeDevicesScanForUpdatesCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): DataBoxEdgeDevices;

@@override(DataBoxEdgeDevices.get, DataBoxEdgeDevicesGetCustomized, "python");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesUpdateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  properties: DataBoxEdgeDevicePatch,
): DataBoxEdgeDevices;

@@override(DataBoxEdgeDevices.update,
  DataBoxEdgeDevicesUpdateCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetUpdateSummaryCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  updateSummary: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): UpdateSummary;

@@override(UpdateSummaries.getUpdateSummary,
  DataBoxEdgeDevicesGetUpdateSummaryCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesUpdateExtendedInformationCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,

  @body
  body: DataBoxEdgeDeviceExtendedInfoPatch,
): DataBoxEdgeDeviceExtendedInfo;

@@override(DataBoxEdgeDevices.updateExtendedInformation,
  DataBoxEdgeDevicesUpdateExtendedInformationCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesDownloadUpdatesCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(DataBoxEdgeDevices.downloadUpdates,
  DataBoxEdgeDevicesDownloadUpdatesCustomized,
  "python"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetExtendedInformationCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  provider: "Microsoft.ThisWillBeReplaced",

  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  @body
  body: void,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): DataBoxEdgeDeviceExtendedInfo;

@@override(DataBoxEdgeDevices.getExtendedInformation,
  DataBoxEdgeDevicesGetExtendedInformationCustomized,
  "python"
);
