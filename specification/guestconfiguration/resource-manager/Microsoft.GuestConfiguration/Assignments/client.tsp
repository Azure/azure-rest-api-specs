import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.GuestConfiguration;

// ============================================================================
// Type alternate types - fix property types for backward compatibility
// ============================================================================

@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VmssvmInfo.vmId, Azure.Core.uuid, "csharp");
@@alternateType(VmssvmInfo.latestReportId, Azure.Core.uuid, "csharp");
@@alternateType(VmssvmInfo.vmResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(GuestConfigurationNavigation.contentUri, url, "csharp");
@@alternateType(VMInfo.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(VMInfo.uuid, Azure.Core.uuid, "csharp");
@@alternateType(GuestConfigurationAssignmentProperties.latestReportId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AssignmentReport.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AssignmentReport.reportId, Azure.Core.uuid, "csharp");
@@alternateType(GuestConfigurationAssignmentReport.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(GuestConfigurationAssignmentReportProperties.reportId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(AssignmentReportDetails.jobId, Azure.Core.uuid, "csharp");
@@alternateType(ProxyResource.location, Azure.Core.azureLocation, "csharp");
@@clientName(ProxyResource.type, "ResourceType", "csharp");

// ============================================================================
// Type renaming - restore old SDK names for backward compatibility
// ============================================================================

@@clientName(ComplianceStatus,
  "AssignedGuestConfigurationMachineComplianceStatus",
  "csharp"
);
@@clientName(AssignmentReport,
  "GuestConfigurationAssignmentReportInfo",
  "csharp"
);
@@clientName(ProvisioningState,
  "GuestConfigurationProvisioningState",
  "csharp"
);
@@clientName(AssignmentType, "GuestConfigurationAssignmentType", "csharp");
@@clientName(ConfigurationParameter, "GuestConfigurationParameter", "csharp");
@@clientName(ConfigurationSetting, "LcmConfigurationSetting", "csharp");
@@clientName(VmssvmInfo, "GuestConfigurationVmssVmInfo", "csharp");
@@clientName(VmssvmInfo.lastComplianceChecked,
  "LastComplianceCheckedOn",
  "csharp"
);
@@clientName(GuestConfigurationAssignmentProperties.vmssVMList,
  "VmssVmList",
  "csharp"
);
@@clientName(AssignmentInfo, "GuestConfigurationAssignmentInfo", "csharp");
@@clientName(AssignmentReportResource,
  "AssignmentReportResourceInfo",
  "csharp"
);
@@clientName(VMInfo, "GuestConfigurationVmInfo", "csharp");
@@clientName(AssignmentReportDetails,
  "GuestConfigurationAssignmentReportDetails",
  "csharp"
);
@@clientName(ConfigurationMode, "LcmConfigurationMode", "csharp");
@@clientName(Kind.DSC, "Dsc", "csharp");
@@clientName(Type, "GuestConfigurationAssignmentReportType", "csharp");
@@clientName(ConfigurationInfo, "GuestConfigurationInfo", "csharp");
@@clientName(ProxyResource, "GuestConfigurationResourceData", "csharp");

// ============================================================================
// Property renaming - restore old SDK property names for backward compatibility
// ============================================================================

@@clientName(GuestConfigurationAssignmentProperties.lastComplianceStatusChecked,
  "LastComplianceStatusCheckedOn",
  "csharp"
);
@@clientName(GuestConfigurationNavigation.configurationParameter,
  "ConfigurationParameters",
  "csharp"
);
@@clientName(GuestConfigurationNavigation.configurationProtectedParameter,
  "ConfigurationProtectedParameters",
  "csharp"
);
@@clientName(ConfigurationSetting.allowModuleOverwrite,
  "IsModuleOverwriteAllowed",
  "csharp"
);
@@clientName(ConfigurationSetting.configurationModeFrequencyMins,
  "ConfigurationModeFrequencyInMins",
  "csharp"
);
@@clientName(ConfigurationSetting.refreshFrequencyMins,
  "RefreshFrequencyInMins",
  "csharp"
);
@@clientName(AssignmentReportResource.resourceId,
  "AssignmentResourceSettingName",
  "csharp"
);

// ============================================================================
// Operation renaming - disambiguate methods for different parent resource types
// ============================================================================

// VM operations (GuestConfigurationAssignments interface)
@@clientName(GuestConfigurationAssignments.get,
  "GetForVirtualMachine",
  "csharp"
);
@@clientName(GuestConfigurationAssignments.createOrUpdate,
  "CreateOrUpdateForVirtualMachine",
  "csharp"
);
@@clientName(GuestConfigurationAssignments.delete,
  "DeleteForVirtualMachine",
  "csharp"
);
@@clientName(GuestConfigurationAssignments.list,
  "GetAllForVirtualMachine",
  "csharp"
);

// HCRP operations (GuestConfigurationHCRPAssignments interface)
@@clientName(GuestConfigurationHCRPAssignments.get, "GetForMachine", "csharp");
@@clientName(GuestConfigurationHCRPAssignments.createOrUpdate,
  "CreateOrUpdateForMachine",
  "csharp"
);
@@clientName(GuestConfigurationHCRPAssignments.delete,
  "DeleteForMachine",
  "csharp"
);
@@clientName(GuestConfigurationHCRPAssignments.list,
  "GetAllForMachine",
  "csharp"
);

// VMSS operations (GuestConfigurationAssignmentsVMSS interface)
@@clientName(GuestConfigurationAssignmentsVMSS.get, "GetForVmss", "csharp");
@@clientName(GuestConfigurationAssignmentsVMSS.createOrUpdate,
  "CreateOrUpdateForVmss",
  "csharp"
);
@@clientName(GuestConfigurationAssignmentsVMSS.delete,
  "DeleteForVmss",
  "csharp"
);
@@clientName(GuestConfigurationAssignmentsVMSS.list, "GetAllForVmss", "csharp");

// VMwarevSphere operations (GuestConfigurationConnectedVMwarevSphereAssignments interface)
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.get,
  "GetForConnectedVMwarevSphere",
  "csharp"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.createOrUpdate,
  "CreateOrUpdateForConnectedVMwarevSphere",
  "csharp"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.delete,
  "DeleteForConnectedVMwarevSphere",
  "csharp"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.list,
  "GetAllForConnectedVMwarevSphere",
  "csharp"
);

// ============================================================================
// Report operation renaming - avoid collision with resource Get/GetAsync
// ============================================================================

// VM report operations
@@clientName(GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  "GetReports",
  "csharp"
);
@@clientName(GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "GetReport",
  "csharp"
);

// HCRP report operations
@@clientName(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  "GetReports",
  "csharp"
);
@@clientName(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "GetReport",
  "csharp"
);

// VMSS report operations
@@clientName(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSList,
  "GetReports",
  "csharp"
);
@@clientName(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "GetReport",
  "csharp"
);

// VMwarevSphere report operations
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "GetReports",
  "csharp"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "GetReport",
  "csharp"
);

// ============================================================================
// Mark report list operations as pageable for backward compatibility
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "csharp"
);
