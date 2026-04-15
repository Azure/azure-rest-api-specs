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
@@clientName(StorageAccountCredential,
  "DataBoxEdgeStorageAccountCredential",
  "csharp"
);
@@clientName(StorageAccount, "DataBoxEdgeStorageAccount", "csharp");
@@clientName(Container, "DataBoxEdgeStorageContainer", "csharp");
@@clientName(Trigger, "DataBoxEdgeTrigger", "csharp");
@@clientName(User, "DataBoxEdgeUser", "csharp");
@@clientName(DiagnosticProactiveLogCollectionSettings,
  "DiagnosticProactiveLogCollectionSetting",
  "csharp"
);
@@clientName(DiagnosticRemoteSupportSettings,
  "DiagnosticRemoteSupportSetting",
  "csharp"
);

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

@@clientName(DataBoxEdgeSkuList, "AvailableDataBoxEdgeSkuList", "csharp");
@@clientName(AddonState, "DataBoxEdgeRoleAddonProvisioningState", "csharp");
@@clientName(AlertProperties.appearedAtDateTime, "AppearedOn", "csharp");
@@clientName(BandwidthScheduleProperties.start, "StartOn", "csharp");
@@clientName(BandwidthScheduleProperties.stop, "StopOn", "csharp");
@@alternateType(BandwidthScheduleProperties.start, duration, "csharp");
@@alternateType(BandwidthScheduleProperties.stop, duration, "csharp");
@@clientName(DataBoxEdgeDeviceProperties.systemData,
  "DataBoxEdgeSystemData",
  "csharp"
);
@@clientName(DCAccessCode, "DataBoxEdgeDataCenterAccessCode", "csharp");
@@clientName(SSLStatus, "DataBoxEdgeStorageAccountSslStatus", "csharp");
@@clientName(AccessLevel, "EdgeRemoteApplicationAccessLevel", "csharp");
@@clientName(AccountType, "DataBoxEdgeStorageAccountType", "csharp");
@@clientName(Address, "DataBoxEdgeShippingAddress", "csharp");
@@clientName(ClusterMemoryCapacity.clusterFailoverMemoryMb,
  "ClusterFailoverMemoryInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterFreeMemoryMb,
  "ClusterFreeMemoryInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterUsedMemoryMb,
  "ClusterUsedMemoryInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterFragmentationMemoryMb,
  "ClusterFragmentationMemoryInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterInfraVmMemoryMb,
  "ClusterInfraVmMemoryInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterTotalMemoryMb,
  "ClusterTotalMemoryInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterNonFailoverVmMb,
  "ClusterNonFailoverVmInMB",
  "csharp"
);
@@clientName(ClusterMemoryCapacity.clusterMemoryUsedByVmsMb,
  "ClusterMemoryUsedByVmsInMB",
  "csharp"
);
@@clientName(ClusterStorageViewData.clusterFreeStorageMb,
  "ClusterFreeStorageInMB",
  "csharp"
);
@@clientName(ClusterStorageViewData.clusterTotalStorageMb,
  "ClusterTotalStorageInMB",
  "csharp"
);
@@clientName(GenerateCertResponse, "GenerateCertResult", "csharp");
@@clientName(GenerateCertResponse.expiryTimeInUTC, "ExpireOn", "csharp");
@@clientName(HostCapacity.effectiveAvailableMemoryMbOnHost,
  "EffectiveAvailableMemoryInMBOnHost",
  "csharp"
);
@@clientName(NodeInfo, "EdgeKubernetesNodeInfo", "csharp");
@@clientName(NumaNodeData.effectiveAvailableMemoryInMb,
  "EffectiveAvailableMemoryInMB",
  "csharp"
);
@@clientName(NumaNodeData.totalMemoryInMb, "TotalMemoryInMB", "csharp");
@@clientName(NumaNodeData, "NumaNodeInfo", "csharp");
@@clientName(PlatformType, "DataBoxEdgeOSPlatformType", "csharp");
@@clientName(RemoteSupportSettings.expirationTimeStampInUTC,
  "ExpireOn",
  "csharp"
);
@@clientName(Secret, "DataBoxEdgeDeviceSecret", "csharp");
@@clientName(UpdateDetails.updateSize, "UpdateSizeInBytes", "csharp");
@@alternateType(UserAccessRight.userId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(VmMemory.startupMemoryMB, "StartupMemoryInMB", "csharp");
@@clientName(VmMemory.currentMemoryUsageMB, "CurrentMemoryUsageInMB", "csharp");
@@clientName(UpdateSummary, "DataBoxEdgeDeviceUpdateSummary", "csharp");
@@clientName(NetworkSettings, "DataBoxEdgeDeviceNetworkSettings", "csharp");
@@clientName(DeviceCapacityInfo, "DataBoxEdgeDeviceCapacityInfo", "csharp");
@@alternateType(IoTDeviceInfo.ioTHostHubId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(AzureContainerDataFormat,
  "DataBoxEdgeStorageContainerDataFormat",
  "csharp"
);
@@clientName(AzureContainerInfo, "DataBoxEdgeStorageContainerInfo", "csharp");
@@clientName(ContainerStatus, "DataBoxEdgeStorageContainerStatus", "csharp");
@@clientName(ComputeResource, "EdgeComputeResourceInfo", "csharp");
@@clientName(MonitoringStatus, "DataBoxEdgeShareMonitoringStatus", "csharp");
@@alternateType(MetricConfiguration.resourceId,
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
@@alternateType(EdgeProfileSubscription.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(FileSourceInfo, "EdgeFileSourceInfo", "csharp");
@@clientName(FileEventTrigger, "EdgeFileEventTrigger", "csharp");
@@clientName(KeyVaultSyncStatus, "EdgeKeyVaultSyncStatus", "csharp");
@@clientName(KubernetesClusterInfo, "EdgeKubernetesClusterInfo", "csharp");
@@clientName(KubernetesIPConfiguration,
  "EdgeKubernetesIPConfiguration",
  "csharp"
);
@@clientName(KubernetesNodeType, "EdgeKubernetesNodeType", "csharp");
@@clientName(KubernetesRole, "EdgeKubernetesRole", "csharp");
@@clientName(KubernetesRoleCompute, "EdgeKubernetesRoleCompute", "csharp");
@@clientName(KubernetesRoleNetwork, "EdgeKubernetesRoleNetwork", "csharp");
@@clientName(KubernetesRoleResources, "EdgeKubernetesRoleResources", "csharp");
@@clientName(KubernetesRoleStorage, "EdgeKubernetesRoleStorage", "csharp");
@@clientName(KubernetesRoleStorageClassInfo,
  "EdgeKubernetesRoleStorageClassInfo",
  "csharp"
);
@@clientName(KubernetesState, "EdgeKubernetesState", "csharp");
@@clientName(NetworkAdapterPosition,
  "DataBoxEdgeNetworkAdapterPosition",
  "csharp"
);
@@clientName(NetworkAdapterStatus, "DataBoxEdgeNetworkAdapterStatus", "csharp");
@@clientName(RemoteSupportSettings, "EdgeRemoteSupportSettings", "csharp");
@@clientName(RemoteApplicationType, "EdgeRemoteApplicationType", "csharp");
@@alternateType(DataBoxEdgeDevice.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@alternateType(ResourceIdentity.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(SubscriptionProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(UploadCertificateResponse.aadTenantId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(ArcAddonProperties.resourceLocation,
  Azure.Core.azureLocation,
  "csharp"
);
@@alternateType(EdgeProfileSubscription.registrationId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(NetworkAdapter.nodeId, Azure.Core.uuid, "csharp");
@@alternateType(NodeProperties.nodeInstanceId, Azure.Core.uuid, "csharp");
@@alternateType(UploadCertificateResponse.servicePrincipalObjectId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(UploadCertificateResponse.servicePrincipalClientId,
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
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Fix string → ResourceIdentifier breakings (baseline used arm-id format-by-name-rules)
@@alternateType(JobProperties.refreshedEntityId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageAccountCredentialProperties.storageAccountId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AzureContainerInfo.storageAccountCredentialId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(StorageAccountProperties.storageAccountCredentialId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DataBoxEdgeDeviceExtendedInfoProperties.clientSecretStoreId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(DataBoxEdgeDeviceExtendedInfoPatch.clientSecretStoreId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(EdgeProfileSubscriptionPatch.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(MountPointMap.roleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(MountPointMap.shareId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ShareAccessRight.shareId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(FileSourceInfo.shareId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RoleSinkInfo.roleId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(RefreshDetails.inProgressRefreshJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(UpdateSummaryProperties.lastCompletedDownloadJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(UpdateSummaryProperties.lastCompletedInstallJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(UpdateSummaryProperties.inProgressDownloadJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(UpdateSummaryProperties.inProgressInstallJobId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// Fix string → ETag breaking (baseline had ETag? type)
@@alternateType(DataBoxEdgeDevice.etag, Azure.Core.eTag, "csharp");

// Fix TypesMustExist: naming mismatches (acronym casing + suffix renames)
@@clientName(MECRole, "MecRole", "csharp");
@@clientName(UploadCertificateRequest, "UploadCertificateContent", "csharp");
@@clientName(DeviceCapacityRequestInfo,
  "DeviceCapacityRequestContent",
  "csharp"
);
@@clientName(TriggerSupportPackageRequest,
  "TriggerSupportPackageContent",
  "csharp"
);
@@clientName(NetworkAdapterDHCPStatus,
  "DataBoxEdgeNetworkAdapterDhcpStatus",
  "csharp"
);
@@clientName(NetworkAdapterRDMAStatus,
  "DataBoxEdgeNetworkAdapterRdmaStatus",
  "csharp"
);

// Round 1: Enum/union member acronym casing (baseline used PascalCase, generated uses ALL-CAPS)
@@clientName(ShareAccessProtocol.SMB, "Smb", "csharp");
@@clientName(ShareAccessProtocol.NFS, "Nfs", "csharp");
@@clientName(RoleTypes.IOT, "IoT", "csharp");
@@clientName(RoleTypes.ASA, "Asa", "csharp");
@@clientName(RoleTypes.MEC, "Mec", "csharp");
@@clientName(NetworkGroup.NonRDMA, "NonRdma", "csharp");
@@clientName(NetworkGroup.RDMA, "Rdma", "csharp");
@@clientName(RemoteApplicationType.WAC, "Wac", "csharp");
@@clientName(HostPlatformType.LinuxVM, "LinuxVm", "csharp");
@@clientName(UserType.ARM, "Arm", "csharp");

// Round 1: Property acronym casing (IPv4/IPv6/IP)
@@clientName(NetworkAdapter.ipv4Configuration, "IPv4Configuration", "csharp");
@@clientName(NetworkAdapter.ipv6Configuration, "IPv6Configuration", "csharp");
@@clientName(NetworkAdapter.ipv6LinkLocalAddress,
  "IPv6LinkLocalAddress",
  "csharp"
);
@@clientName(Ipv4Config.ipAddress, "IPAddress", "csharp");
@@clientName(Ipv6Config.ipAddress, "IPAddress", "csharp");
@@clientName(KubernetesIPConfiguration.ipAddress, "IPAddress", "csharp");
@@clientName(NodeInfo.ipConfiguration, "IPConfiguration", "csharp");
@@clientName(NodeInfo.type, "NodeType", "csharp");

// Round 1: Property name fixes (type→XxxType, URL→Uri, UTC casing, HyperV)
@@clientName(EtcdInfo.type, "EtcdInfoType", "csharp");
@@clientName(CniConfig.type, "CniConfigType", "csharp");
@@clientName(KubernetesRoleStorageClassInfo.type,
  "KubernetesRoleStorageClassInfoType",
  "csharp"
);
@@clientName(LoadBalancerConfig.type, "LoadBalancerConfigType", "csharp");
@@clientName(ClusterMemoryCapacity.clusterHypervReserveMemoryMb,
  "ClusterHyperVReserveMemoryMb",
  "csharp"
);
@@clientName(RefreshDetails.lastCompletedRefreshJobTimeInUTC,
  "LastCompletedRefreshJobTimeInUtc",
  "csharp"
);
@@clientName(ResourceMoveDetails.operationInProgressLockTimeoutInUTC,
  "OperationInProgressLockTimeoutInUtc",
  "csharp"
);
@@clientName(DataBoxEdgeDeviceExtendedInfoProperties.clientSecretStoreUrl,
  "ClientSecretStoreUri",
  "csharp"
);
@@clientName(DataBoxEdgeDeviceExtendedInfoPatch.clientSecretStoreUrl,
  "ClientSecretStoreUri",
  "csharp"
);
@@clientName(TrackingInfo.trackingUrl, "TrackingUri", "csharp");
@@clientName(ImageRepositoryCredential.imageRepositoryUrl,
  "ImageRepositoryUri",
  "csharp"
);
@@clientName(GenerateCertResponse, "GenerateCertResult", "csharp");
@@clientName(GenerateCertResponse.expiryTimeInUTC, "ExpireOn", "csharp");

// Round 1: SkuName member casing (22 members — generated ALL-CAPS → baseline PascalCase)
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
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(SkuName.EP2_64_1VPU_W, "EP2_64_1VpuW", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(SkuName.EP2_128_1T4_Mx1_W, "EP2_128_1T4Mx1W", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(SkuName.EP2_256_2T4_W, "EP2_256_2T4W", "csharp");
@@clientName(SkuName.RCA_Small, "RcaSmall", "csharp");
@@clientName(SkuName.RCA_Large, "RcaLarge", "csharp");
@@clientName(SkuName.RDC, "Rdc", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(SkuName.EP2_64_Mx1_W, "EP2_64_Mx1W", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(SkuName.EP2_128_GPU1_Mx1_W, "EP2_128Gpu1Mx1W", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(SkuName.EP2_256_GPU2_Mx1, "EP2_256Gpu2Mx1", "csharp");
@@clientName(SkuName.EdgeMR_TCP, "EdgeMRTcp", "csharp");

@@clientName(EncryptionAlgorithm.AES256, "Aes256", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/invalid-name" ""
@@clientName(EncryptionAlgorithm.RSAES_PKCS1_v_1_5, "RsaesPkcs1V1_5", "csharp");

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
// Input usage so generator produces public ctors + real setters on non-read-only properties,
// matching the ApiCompat baseline for these output-only sub-resource models.
@@usage(DeviceCapacityInfo, Usage.input | Usage.output, "csharp");
@@usage(NetworkSettings, Usage.input | Usage.output, "csharp");
@@usage(UpdateSummary, Usage.input | Usage.output, "csharp");

@@access(RoleSinkInfo, Access.public, "csharp");
@@access(FileSourceInfo, Access.public, "csharp");

@@alternateType(DataBoxEdgeDeviceExtendedInfoProperties.clientSecretStoreUrl,
  url,
  "csharp"
);
@@alternateType(DataBoxEdgeDeviceExtendedInfoPatch.clientSecretStoreUrl,
  url,
  "csharp"
);
@@alternateType(TrackingInfo.trackingUrl, url, "csharp");
@@alternateType(ImageRepositoryCredential.imageRepositoryUrl, url, "csharp");
@@alternateType(Ipv4Config.ipAddress, Azure.Core.ipV4Address, "csharp");
@@alternateType(SkuLocationInfo.location, Azure.Core.azureLocation, "csharp");
@@alternateType(DataBoxEdgeSku.locations, Azure.Core.azureLocation[], "csharp");
@@alternateType(GenerateCertResponse.expiryTimeInUTC, utcDateTime, "csharp");
@@alternateType(DataBoxEdgeDevicePatch.identity,
  Azure.ResourceManager.CommonTypes.ManagedServiceIdentity,
  "csharp"
);
@@clientName(DataBoxEdgeDevicePropertiesPatch.edgeProfile, "Profile", "csharp");
@@clientName(IoTDeviceInfo.authentication, "Profile", "csharp");
@@clientName(IoTDeviceInfo.ioTHostHub, "IotHostHub", "csharp");
@@clientName(IoTDeviceInfo.ioTHostHubId, "IotHostHubId", "csharp");
@@clientName(IoTRoleProperties.ioTDeviceDetails, "IotDeviceDetails", "csharp");
@@clientName(IoTRoleProperties.ioTEdgeDeviceDetails,
  "IotEdgeDeviceDetails",
  "csharp"
);
@@clientName(IoTRoleProperties.ioTEdgeAgentInfo, "IotEdgeAgentInfo", "csharp");
@@clientName(IoTAddonProperties.ioTDeviceDetails, "IotDeviceDetails", "csharp");
@@clientName(IoTAddonProperties.ioTEdgeDeviceDetails,
  "IotEdgeDeviceDetails",
  "csharp"
);
@@clientName(DataBoxEdgeDevices.listByDataBoxEdgeDevice,
  "GetEdgeNodes",
  "csharp"
);
@@clientName(Orders.listDCAccessCode, "GetDataCenterAccessCode", "csharp");
@@clientName(AvailableSkusOperationGroup.list, "GetAvailableSkus", "csharp");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(DataBoxEdgeDeviceExtendedInfo,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Node,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(SecuritySettings,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(TriggerSupportPackageRequest,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(DeviceCapacityInfo.properties,
  "csharp"
);
