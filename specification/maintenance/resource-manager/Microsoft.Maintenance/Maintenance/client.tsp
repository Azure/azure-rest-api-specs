import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.Maintenance;

@@clientName(Microsoft.Maintenance,
  "MaintenanceManagementClient",
  "javascript"
);

// csharp configurations
@@clientName(ConfigurationAssignment,
  "MaintenanceConfigurationAssignmentData",
  "csharp"
);
@@clientName(ConfigurationAssignmentFilterProperties,
  "MaintenanceConfigurationAssignmentFilter",
  "csharp"
);
@@alternateType(ConfigurationAssignmentFilterProperties.resourceTypes,
  Azure.Core.armResourceType,
  "csharp"
);
@@alternateType(ConfigurationAssignmentFilterProperties.locations,
  Azure.Core.azureLocation,
  "csharp"
);
@@clientName(TagOperators, "VmTagOperator", "csharp");
@@clientName(TagSettingsProperties, "VmTagSettings", "csharp");
@@alternateType(ApplyUpdateProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ConfigurationAssignmentProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(UpdateProperties.resourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(ConfigurationAssignmentProperties.maintenanceConfigurationId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@clientName(MaintenanceWindow.expirationDateTime, "ExpireOn", "csharp");
@@alternateType(MaintenanceWindow.expirationDateTime, utcDateTime, "csharp");
@@clientName(MaintenanceWindow.startDateTime, "StartOn", "csharp");
@@alternateType(MaintenanceWindow.startDateTime, utcDateTime, "csharp");
@@clientName(ListApplyUpdate, "MaintenanceApplyUpdateListResult", "csharp");
@@clientName(ListUpdatesResult, "MaintenanceUpdateListResult", "csharp");
@@clientName(ListMaintenanceConfigurationsResult,
  "MaintenanceConfigurationListResult",
  "csharp"
);
@@clientName(ListConfigurationAssignmentsResult,
  "MaintenanceConfigurationAssignmentListResult",
  "csharp"
);
@@clientName(Visibility, "MaintenanceConfigurationVisibility", "csharp");
@@clientName(MaintenanceScope.SQLDB, "SqlDB", "csharp");
@@clientName(MaintenanceScope.SQLManagedInstance, "SqlManagedInstance", "csharp");
@@clientName(ApplyUpdateProperties.lastUpdateTime, "LastUpdatedOn", "csharp");
@@clientName(InputPatchConfiguration,
  "MaintenancePatchConfiguration",
  "csharp"
);
@@clientName(InputWindowsParameters,
  "MaintenanceWindowsPatchSettings",
  "csharp"
);
@@clientName(InputWindowsParameters.excludeKbsRequiringReboot,
  "IsExcludeKbsRebootRequired",
  "csharp"
);
@@clientName(InputLinuxParameters, "MaintenanceLinuxPatchSettings", "csharp");
@@clientName(ScheduledEventApproveResponse,
  "ScheduledEventApproveResult",
  "csharp"
);
@@clientName(ApplyUpdates.getParent, "GetApplyUpdatesByParent", "csharp");
@@clientName(ApplyUpdatesOperationGroup.createOrUpdateParent,
  "CreateOrUpdateApplyUpdateByParent",
  "csharp"
);
@@clientName(ConfigurationAssignments.createOrUpdateParent,
  "CreateOrUpdateConfigurationAssignmentByParent",
  "csharp"
);
@@clientName(ConfigurationAssignments.deleteParent,
  "DeleteConfigurationAssignmentByParent",
  "csharp"
);
@@clientName(ConfigurationAssignments.getParent,
  "GetConfigurationAssignmentByParent",
  "csharp"
);
@@clientName(ConfigurationAssignments.listParent,
  "GetConfigurationAssignmentsByParent",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForResourceGroup.createOrUpdate,
  "CreateOrUpdateConfigurationAssignmentByResourceGroup",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForResourceGroup.delete,
  "DeleteConfigurationAssignmentByResourceGroup",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForResourceGroup.get,
  "GetConfigurationAssignmentByResourceGroup",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForResourceGroup.update,
  "UpdateConfigurationAssignmentByResourceGroup",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.createOrUpdate,
  "CreateOrUpdateConfigurationAssignmentBySubscription",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.delete,
  "DeleteConfigurationAssignmentBySubscription",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.get,
  "GetConfigurationAssignmentBySubscription",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.update,
  "UpdateConfigurationAssignmentBySubscription",
  "csharp"
);
@@clientName(ConfigurationAssignmentsForSubscriptions.list,
  "GetConfigurationAssignmentsBySubscription",
  "csharp"
);
@@clientName(UpdatesOperationGroup.listParent, "GetUpdatesByParent", "csharp");
@@clientName(MaintenanceConfigurationOperationGroup.delete,
  "DeleteEx",
  "csharp"
);
// csharp: keep MaintenanceConfiguration data type name (matches old SDK)
@@clientName(MaintenanceConfigurationOperationGroup,
  "MaintenanceConfiguration",
  "csharp"
);
@@clientName(ApplyUpdates, "MaintenanceApplyUpdate", "csharp");
@@clientName(ApplyUpdate, "MaintenanceApplyUpdate", "csharp");
@@clientName(ImpactType, "MaintenanceImpactType", "csharp");
@@clientName(Microsoft.Maintenance.Update, "MaintenanceUpdate", "csharp");
@@clientName(UpdateStatus, "MaintenanceUpdateStatus", "csharp");

// csharp: rename Updates.list to avoid GetAll name collision with ConfigurationAssignment list
// Both generate GetAll(string, string, string, string, CancellationToken) on SubscriptionResource
// but return different types (Update vs ConfigurationAssignmentResource)
@@clientName(UpdatesOperationGroup.list, "GetUpdates", "csharp");

// csharp: convert Duration from string to TimeSpan for backward compatibility
@@alternateType(MaintenanceWindow.duration, duration, "csharp");

// csharp: convert Location from string to AzureLocation for backward compatibility
@@alternateType(ConfigurationAssignment.location,
  Azure.Core.azureLocation,
  "csharp"
);
