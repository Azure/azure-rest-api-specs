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
@@clientLocation(GuestConfigurationAssignments.guestConfigurationAssignmentReportsGet,
  "GuestConfigurationAssignmentReports"
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
@@clientLocation(GuestConfigurationHCRPAssignments.guestConfigurationHCRPAssignmentReportsGet,
  "GuestConfigurationHCRPAssignmentReports"
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
@@clientLocation(GuestConfigurationAssignmentsVMSS.guestConfigurationAssignmentReportsVMSSGet,
  "GuestConfigurationAssignmentReportsVMSS"
);

// GuestConfigurationConnectedVMwarevSphereAssignments interface operations
@@clientLocation(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsList,
  "GuestConfigurationConnectedVMwarevSphereAssignmentsReports"
);
@@clientLocation(GuestConfigurationConnectedVMwarevSphereAssignments.guestConfigurationConnectedVMwarevSphereAssignmentsReportsGet,
  "GuestConfigurationConnectedVMwarevSphereAssignmentsReports"
);
