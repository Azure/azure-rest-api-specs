import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.GuestConfiguration;

@@clientName(GuestConfigurationAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(GuestConfigurationHCRPAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(GuestConfigurationAssignmentsVMSS.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(VmssvmInfo, "VMSSVMInfo");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Operation.properties);
@@clientName(AssignmentReport, "CommonAssignmentReport", "go");

// @@clientLocation decorators for operations with custom @operationId
// These ensure consistent operationId generation in the output

// GuestConfigurationAssignmentsOperationGroup interface operations
@@clientLocation(GuestConfigurationAssignmentsOperationGroup.rGList,
  GuestConfigurationAssignments
);

// GuestConfigurationAssignments interface operations
@@clientLocation(GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  "GuestConfigurationAssignmentReports"
);
@@clientName(GuestConfigurationAssignments.guestConfigurationAssignmentReportsList,
  "List",
  "!csharp"
);
@@clientLocation(GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "GuestConfigurationAssignmentReports"
);
@@clientName(GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "Get",
  "!csharp"
);
// GuestConfigurationHCRPAssignments interface operations
@@clientLocation(GuestConfigurationHCRPAssignments.get,
  GuestConfigurationHCRPAssignments
);
@@clientLocation(GuestConfigurationHCRPAssignments.createOrUpdate,
  GuestConfigurationHCRPAssignments
);
@@clientLocation(GuestConfigurationHCRPAssignments.delete,
  GuestConfigurationHCRPAssignments
);
@@clientLocation(GuestConfigurationHCRPAssignments.list,
  GuestConfigurationHCRPAssignments
);
@@clientLocation(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  "GuestConfigurationHCRPAssignmentReports"
);
@@clientName(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsList,
  "List",
  "!csharp"
);
@@clientLocation(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "GuestConfigurationHCRPAssignmentReports"
);
@@clientName(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "Get",
  "!csharp"
);

// GuestConfigurationAssignmentsVMSS interface operations
@@clientLocation(GuestConfigurationAssignmentsVMSS.get,
  GuestConfigurationAssignmentsVMSS
);
@@clientLocation(GuestConfigurationAssignmentsVMSS.createOrUpdate,
  GuestConfigurationAssignmentsVMSS
);
@@clientLocation(GuestConfigurationAssignmentsVMSS.delete,
  GuestConfigurationAssignmentsVMSS
);
@@clientLocation(GuestConfigurationAssignmentsVMSS.list,
  GuestConfigurationAssignmentsVMSS
);
@@clientLocation(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSList,
  "GuestConfigurationAssignmentReportsVMSS"
);
@@clientName(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSList,
  "List",
  "!csharp"
);
@@clientLocation(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "GuestConfigurationAssignmentReportsVMSS"
);
@@clientName(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "Get",
  "!csharp"
);

// GuestConfigurationConnectedVMwarevSphereAssignments interface operations
@@clientLocation(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "GuestConfigurationConnectedVMwarevSphereAssignmentsReports"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "List",
  "!csharp"
);
@@clientLocation(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "GuestConfigurationConnectedVMwarevSphereAssignmentsReports"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "Get",
  "!csharp"
);
@@clientName(GuestConfigurationAssignmentsOperationGroup.rGList,
  "rg_list",
  "python"
);
