import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;
using Http;

@@clientName(Sku, "SkuInfo", "go");
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
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(Users.delete, UsersDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<User>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<User>,
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

@@override(Users.get, UsersGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op UsersCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(Users.createOrUpdate, UsersCreateOrUpdateCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<StorageAccount>,
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

@@override(StorageAccounts.delete,
  StorageAccountsDeleteCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<StorageAccount>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): StorageAccountList;

@@override(StorageAccounts.listByDataBoxEdgeDevice,
  StorageAccountsListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(StorageAccounts.get, StorageAccountsGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountsCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<MonitoringMetricConfiguration>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsListCustomized(
  ...Azure.ResourceManager.ProviderNamespace<MonitoringMetricConfiguration>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op MonitoringMetricConfigurationsCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OperationsStatusGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Job>,
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

@@override(OperationsStatus.get, OperationsStatusGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op JobsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Job>,
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

@@override(Jobs.get, JobsGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Role>,
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

@@override(Roles.delete, RolesDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Role>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): RoleList;

@@override(Roles.listByDataBoxEdgeDevice,
  RolesListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Role>,
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

@@override(Roles.get, RolesGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op RolesCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Role>,
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

@@override(Roles.createOrUpdate, RolesCreateOrUpdateCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Share>,
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

@@override(Shares.delete, SharesDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Share>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): ShareList;

@@override(Shares.listByDataBoxEdgeDevice,
  SharesListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesRefreshCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Share>,
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

@@override(Shares.refresh, SharesRefreshCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Share>,
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

@@override(Shares.get, SharesGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op SharesCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Share>,
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

@@override(Shares.createOrUpdate, SharesCreateOrUpdateCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Container>,
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

@@override(Containers.delete, ContainersDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersRefreshCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Container>,
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

@@override(Containers.refresh, ContainersRefreshCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersListByStorageAccountCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Container>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(Containers.get, ContainersGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op ContainersCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(Orders.delete, OrdersDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrderslistDCAccessCodeCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(Orders.listDCAccessCode,
  OrderslistDCAccessCodeCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): OrderList;

@@override(Orders.listByDataBoxEdgeDevice,
  OrdersListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Order>,
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

@@override(Orders.get, OrdersGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op OrdersCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Order>,
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

@@override(Orders.createOrUpdate, OrdersCreateOrUpdateCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Trigger>,
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

@@override(Triggers.delete, TriggersDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Trigger>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Trigger>,
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

@@override(Triggers.get, TriggersGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op TriggersCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Trigger>,
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

@@override(Triggers.createOrUpdate,
  TriggersCreateOrUpdateCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Addon>,
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

@@override(Addons.delete, AddonsDeleteCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsListByRoleCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Addon>,
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

@@override(Addons.listByRole, AddonsListByRoleCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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

@@override(Addons.get, AddonsGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AddonsCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Addon>,
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

@@override(Addons.createOrUpdate, AddonsCreateOrUpdateCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AlertsListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Alert>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): AlertList;

@@override(Alerts.listByDataBoxEdgeDevice,
  AlertsListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AlertsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<Alert>,
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

@@override(Alerts.get, AlertsGetCustomized, "python,go");

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<BandwidthSchedule>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<BandwidthSchedule>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): BandwidthSchedulesList;

@@override(BandwidthSchedules.listByDataBoxEdgeDevice,
  BandwidthSchedulesListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<BandwidthSchedule>,
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

@@override(BandwidthSchedules.get,
  BandwidthSchedulesGetCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op BandwidthSchedulesCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<BandwidthSchedule>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<StorageAccountCredential>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<StorageAccountCredential>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): StorageAccountCredentialList;

@@override(StorageAccountCredentials.listByDataBoxEdgeDevice,
  StorageAccountCredentialsListByDataBoxEdgeDeviceCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<StorageAccount>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op StorageAccountCredentialsCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesListByDataBoxEdgeDeviceCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesDeleteCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): void;

@@override(DataBoxEdgeDevices.delete,
  DataBoxEdgeDevicesDeleteCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesCreateOrUpdateSecuritySettingsCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesUploadCertificateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesInstallUpdatesCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetNetworkSettingsCustomized(
  ...Azure.ResourceManager.ProviderNamespace<NetworkSettings>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGenerateCertificateCustomized(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesScanForUpdatesCustomized(
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetCustomized(
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
  @path
  deviceName: string,

  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
): DataBoxEdgeDevices;

@@override(DataBoxEdgeDevices.get,
  DataBoxEdgeDevicesGetCustomized,
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesUpdateCustomized(
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetUpdateSummaryCustomized(
  ...Azure.ResourceManager.ProviderNamespace<UpdateSummary>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesUpdateExtendedInformationCustomized(
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesDownloadUpdatesCustomized(
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
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
  "python,go"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op DataBoxEdgeDevicesGetExtendedInformationCustomized(
  ...Azure.ResourceManager.ProviderNamespace<DataBoxEdgeDevice>,
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
  "python,go"
);
