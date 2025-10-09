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
#suppress "deprecated" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(Operation.properties);
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
  "List"
);
@@clientLocation(GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "GuestConfigurationAssignmentReports"
);
@@clientName(GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "Get"
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
  "List"
);
@@clientLocation(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "GuestConfigurationHCRPAssignmentReports"
);
@@clientName(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "Get"
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
  "List"
);
@@clientLocation(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "GuestConfigurationAssignmentReportsVMSS"
);
@@clientName(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "Get"
);

// GuestConfigurationConnectedVMwarevSphereAssignments interface operations
@@clientLocation(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "GuestConfigurationConnectedVMwarevSphereAssignmentsReports"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "List"
);
@@clientLocation(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "GuestConfigurationConnectedVMwarevSphereAssignmentsReports"
);
@@clientName(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "Get"
);
@@clientName(GuestConfigurationAssignmentsOperationGroup.rGList,
  "rg_list",
  "python"
);
