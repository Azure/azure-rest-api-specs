import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Microsoft.GuestConfiguration;
using TypeSpec.Http;
using TypeSpec.Rest;

// ============================================================================
// Type alternate types - fix property types for backward compatibility
// ============================================================================

@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(VmssvmInfo.vmId, Azure.Core.uuid, "csharp");
@@alternateType(VmssvmInfo.latestReportId, Azure.Core.uuid, "csharp");
@@alternateType(
  VmssvmInfo.vmResourceId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(GuestConfigurationNavigation.contentUri, url, "csharp");
@@alternateType(VMInfo.id, Azure.Core.armResourceIdentifier, "csharp");
@@alternateType(VMInfo.uuid, Azure.Core.uuid, "csharp");
@@alternateType(
  GuestConfigurationAssignmentProperties.latestReportId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  AssignmentReport.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(AssignmentReport.reportId, Azure.Core.uuid, "csharp");
@@alternateType(
  GuestConfigurationAssignmentReport.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  GuestConfigurationAssignmentReportProperties.reportId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(AssignmentReportDetails.jobId, Azure.Core.uuid, "csharp");
@@alternateType(ProxyResource.location, Azure.Core.azureLocation, "csharp");
@@clientName(ProxyResource.type, "ResourceType", "csharp");

// ============================================================================
// Type renaming - restore old SDK names for backward compatibility
// ============================================================================

@@clientName(
  ComplianceStatus,
  "AssignedGuestConfigurationMachineComplianceStatus",
  "csharp"
);
@@clientName(
  AssignmentReport,
  "GuestConfigurationAssignmentReportInfo",
  "csharp"
);
@@clientName(
  ProvisioningState,
  "GuestConfigurationProvisioningState",
  "csharp"
);
@@clientName(AssignmentType, "GuestConfigurationAssignmentType", "csharp");
@@clientName(ConfigurationParameter, "GuestConfigurationParameter", "csharp");
@@clientName(ConfigurationSetting, "LcmConfigurationSetting", "csharp");
@@clientName(VmssvmInfo, "GuestConfigurationVmssVmInfo", "csharp");
@@clientName(
  VmssvmInfo.lastComplianceChecked,
  "LastComplianceCheckedOn",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignmentProperties.vmssVMList,
  "VmssVmList",
  "csharp"
);
@@clientName(AssignmentInfo, "GuestConfigurationAssignmentInfo", "csharp");
@@clientName(
  AssignmentReportResource,
  "AssignmentReportResourceInfo",
  "csharp"
);
@@clientName(VMInfo, "GuestConfigurationVmInfo", "csharp");
@@clientName(
  AssignmentReportDetails,
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

@@clientName(
  GuestConfigurationAssignmentProperties.lastComplianceStatusChecked,
  "LastComplianceStatusCheckedOn",
  "csharp"
);
@@clientName(
  GuestConfigurationNavigation.configurationParameter,
  "ConfigurationParameters",
  "csharp"
);
@@clientName(
  GuestConfigurationNavigation.configurationProtectedParameter,
  "ConfigurationProtectedParameters",
  "csharp"
);
@@clientName(
  ConfigurationSetting.allowModuleOverwrite,
  "IsModuleOverwriteAllowed",
  "csharp"
);
@@clientName(
  ConfigurationSetting.configurationModeFrequencyMins,
  "ConfigurationModeFrequencyInMins",
  "csharp"
);
@@clientName(
  ConfigurationSetting.refreshFrequencyMins,
  "RefreshFrequencyInMins",
  "csharp"
);
@@clientName(
  AssignmentReportResource.resourceId,
  "AssignmentResourceSettingName",
  "csharp"
);

// ============================================================================
// Operation renaming - disambiguate methods for different parent resource types
// ============================================================================

// VM operations (GuestConfigurationAssignments interface)
@@clientName(
  GuestConfigurationAssignments.get,
  "GetForVirtualMachine",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignments.createOrUpdate,
  "CreateOrUpdateForVirtualMachine",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignments.delete,
  "DeleteForVirtualMachine",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignments.list,
  "GetAllForVirtualMachine",
  "csharp"
);

// HCRP operations (GuestConfigurationHCRPAssignments interface)
@@clientName(GuestConfigurationHCRPAssignments.get, "GetForMachine", "csharp");
@@clientName(
  GuestConfigurationHCRPAssignments.createOrUpdate,
  "CreateOrUpdateForMachine",
  "csharp"
);
@@clientName(
  GuestConfigurationHCRPAssignments.delete,
  "DeleteForMachine",
  "csharp"
);
@@clientName(
  GuestConfigurationHCRPAssignments.list,
  "GetAllForMachine",
  "csharp"
);

// VMSS operations (GuestConfigurationAssignmentsVMSS interface)
@@clientName(GuestConfigurationAssignmentsVMSS.get, "GetForVmss", "csharp");
@@clientName(
  GuestConfigurationAssignmentsVMSS.createOrUpdate,
  "CreateOrUpdateForVmss",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignmentsVMSS.delete,
  "DeleteForVmss",
  "csharp"
);
@@clientName(GuestConfigurationAssignmentsVMSS.list, "GetAllForVmss", "csharp");

// VMwarevSphere operations (GuestConfigurationConnectedVMwarevSphereAssignments interface)
@@clientName(
  GuestConfigurationConnectedVMwarevSphereAssignments.get,
  "GetForConnectedVMwarevSphere",
  "csharp"
);
@@clientName(
  GuestConfigurationConnectedVMwarevSphereAssignments.createOrUpdate,
  "CreateOrUpdateForConnectedVMwarevSphere",
  "csharp"
);
@@clientName(
  GuestConfigurationConnectedVMwarevSphereAssignments.delete,
  "DeleteForConnectedVMwarevSphere",
  "csharp"
);
@@clientName(
  GuestConfigurationConnectedVMwarevSphereAssignments.list,
  "GetAllForConnectedVMwarevSphere",
  "csharp"
);

// ============================================================================
// Report operation renaming - avoid collision with resource Get/GetAsync
// ============================================================================

// VM report operations
@@clientName(
  GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  "GetReports",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "GetReport",
  "csharp"
);

// HCRP report operations
@@clientName(
  GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  "GetReports",
  "csharp"
);
@@clientName(
  GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "GetReport",
  "csharp"
);

// VMSS report operations
@@clientName(
  GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSList,
  "GetReports",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "GetReport",
  "csharp"
);

// VMwarevSphere report operations
@@clientName(
  GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "GetReports",
  "csharp"
);
@@clientName(
  GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "GetReport",
  "csharp"
);
@@clientName(
  GuestConfigurationAssignmentsOperationGroup.rGList,
  "GetGuestConfigurationAssignments",
  "csharp"
);

// ============================================================================
// Mark report list operations as pageable for backward compatibility
// ============================================================================

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(
  GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(
  GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "migration"
@@markAsPageable(
  GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "csharp"
);

/** Get a report for the guest configuration assignment, by reportId. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
op guestConfigurationAssignmentReportsGetCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The guest configuration assignment name. */
  @path
  guestConfigurationAssignmentName: string,

  /** The GUID for the guest configuration assignment report. */
  @path
  reportId: string,

  /** The name of the virtual machine. */
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  vmName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Void request body inherited from source operation."
  @body
  body: void,
):
  | Azure.ResourceManager.ArmResponse<GuestConfigurationAssignmentReport>
  | ErrorResponse;

/** List all reports for the guest configuration assignment, latest report first. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
op guestConfigurationAssignmentReportsListCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The provider namespace. */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.Compute",

  /** The guest configuration assignment name. */
  @path
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the virtual machine. */
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  vmName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Void request body inherited from source operation."
  @body
  body: void,
):
  | Azure.ResourceManager.ArmResponse<GuestConfigurationAssignmentReportList>
  | ErrorResponse;

/** Creates an association between a VM and guest configuration */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
op guestConfigurationAssignmentsCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,

  /** The guest configuration assignment name. */
  @path
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The provider namespace. */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.Compute",

  /** The name of the virtual machine. */
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  vmName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** Parameters supplied to the create or update guest configuration assignment. */
  @body
  parameters: GuestConfigurationAssignment,
):
  | Azure.ResourceManager.ArmResourceUpdatedResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignment>
  | Azure.ResourceManager.ArmResourceCreatedSyncResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignment>
  | Microsoft.GuestConfiguration.ErrorResponse;

/** Delete a guest configuration assignment */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Matches source delete operation response shape."
op guestConfigurationAssignmentsDeleteCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The provider namespace. */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.Compute",

  /** The guest configuration assignment name. */
  @path
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the virtual machine. */
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  vmName: string,
):
  | Azure.ResourceManager.ArmDeletedResponse
  | Microsoft.GuestConfiguration.ErrorResponse;

/** Get information about a guest configuration assignment */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
op guestConfigurationAssignmentsGetCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The provider namespace. */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.Compute",

  /** The guest configuration assignment name. */
  @path
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the virtual machine. */
  @path
  @pattern("^[a-zA-Z0-9][-a-zA-Z0-9_.]*[a-zA-Z0-9]$")
  vmName: string,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignment>
  | Microsoft.GuestConfiguration.ErrorResponse;

/** Get a report for the guest configuration assignment, by reportId. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "SDK customization override keeps HCRP acronym."
op guestConfigurationHCRPAssignmentReportsGetCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The guest configuration assignment name. */
  @path
  @segment("guestConfigurationAssignments")
  guestConfigurationAssignmentName: string,

  /** The GUID for the guest configuration assignment report. */
  @path
  reportId: string,

  /** The name of the ARC machine. */
  @path
  @segment("machines")
  machineName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Void request body inherited from source operation."
  @body
  body: void,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignmentReport>
  | Microsoft.GuestConfiguration.ErrorResponse;

/** List all reports for the guest configuration assignment, latest report first. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "SDK customization override keeps HCRP acronym."
op guestConfigurationHCRPAssignmentReportsListCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** The provider namespace. */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.HybridCompute",

  /** The guest configuration assignment name. */
  @path
  @key
  @segment("guestConfigurationAssignments")
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the ARC machine. */
  @segment("machines")
  @key
  @path
  machineName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Void request body inherited from source operation."
  @body
  body: void,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignmentReportList>
  | Microsoft.GuestConfiguration.ErrorResponse;

/** Creates an association between a ARC machine and guest configuration */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "SDK customization override keeps HCRP acronym."
op guestConfigurationHCRPAssignmentsCreateOrUpdateCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,

  /** The guest configuration assignment name. */
  @path
  @key
  @segment("guestConfigurationAssignments")
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.ResourceGroupParameter,

  /** the provider namespace */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.HybridCompute",

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the ARC machine. */
  @segment("machines")
  @key
  @path
  machineName: string,

  /** Parameters supplied to the create or update guest configuration assignment. */
  @body
  parameters: GuestConfigurationAssignment,
):
  | Azure.ResourceManager.ArmResourceUpdatedResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignment>
  | Azure.ResourceManager.ArmResourceCreatedSyncResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignment>
  | Microsoft.GuestConfiguration.ErrorResponse;

/** Delete a guest configuration assignment */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "Matches source delete operation response shape."
#suppress "@azure-tools/typespec-azure-core/casing-style" "SDK customization override keeps HCRP acronym."
op guestConfigurationHCRPAssignmentsDeleteCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** the provider namespace */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.HybridCompute",

  /** The guest configuration assignment name. */
  @path
  @key
  @segment("guestConfigurationAssignments")
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the ARC machine. */
  @segment("machines")
  @key
  @path
  machineName: string,
):
  | Azure.ResourceManager.ArmDeletedResponse
  | Microsoft.GuestConfiguration.ErrorResponse;

/** Get information about a guest configuration assignment */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "SDK customization override operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "SDK customization override keeps HCRP acronym."
op guestConfigurationHCRPAssignmentsGetCustomized(
  ...Azure.ResourceManager.ApiVersionParameter,
  ...Azure.ResourceManager.SubscriptionIdParameter,
  ...Azure.ResourceManager.ResourceGroupParameter,

  /** the provider namespace */
  @path
  @segment("providers")
  @key
  providerNamespace: "Microsoft.HybridCompute",

  /** The guest configuration assignment name. */
  @path
  @key
  @segment("guestConfigurationAssignments")
  guestConfigurationAssignmentName: string,

  ...Azure.ResourceManager.Extension.ExtensionProviderNamespace<GuestConfigurationAssignment>,

  /** The name of the ARC machine. */
  @segment("machines")
  @key
  @path
  machineName: string,
):
  | Azure.ResourceManager.ArmResponse<Microsoft.GuestConfiguration.GuestConfigurationAssignment>
  | Microsoft.GuestConfiguration.ErrorResponse;

@@override(
  GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  guestConfigurationAssignmentReportsGetCustomized
);
@@override(
  GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  guestConfigurationAssignmentReportsListCustomized
);
@@override(
  GuestConfigurationAssignments.createOrUpdate,
  guestConfigurationAssignmentsCreateOrUpdateCustomized
);
@@override(
  GuestConfigurationAssignments.delete,
  guestConfigurationAssignmentsDeleteCustomized
);
@@override(
  GuestConfigurationAssignments.get,
  guestConfigurationAssignmentsGetCustomized
);
@@override(
  GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  guestConfigurationHCRPAssignmentReportsGetCustomized
);
@@override(
  GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  guestConfigurationHCRPAssignmentReportsListCustomized
);
@@override(
  GuestConfigurationHCRPAssignments.createOrUpdate,
  guestConfigurationHCRPAssignmentsCreateOrUpdateCustomized
);
@@override(
  GuestConfigurationHCRPAssignments.delete,
  guestConfigurationHCRPAssignmentsDeleteCustomized
);
@@override(
  GuestConfigurationHCRPAssignments.get,
  guestConfigurationHCRPAssignmentsGetCustomized
);
@@clientName(
  GuestConfigurationAssignmentsOperationGroup.rGList,
  "listRGList",
  "javascript"
);
@@clientName(
  GuestConfigurationAssignments.SubscriptionList,
  "listSubscriptionList",
  "javascript"
);
