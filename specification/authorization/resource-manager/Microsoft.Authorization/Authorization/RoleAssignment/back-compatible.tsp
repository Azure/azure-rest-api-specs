import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RoleAssignment;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleAssignmentCreateParameters.properties);

@@clientName(RoleAssignments.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleAssignment.properties);

@@clientName(RoleAssignmentsByIdOperations.createById::parameters.resource,
  "parameters"
);

@@clientLocation(RoleAssignmentsByIdOperations.getById, RoleAssignments);
@@clientName(RoleAssignmentsByIdOperations.getById, "GetById");
@@clientLocation(RoleAssignmentsByIdOperations.createById, RoleAssignments);
@@clientName(RoleAssignmentsByIdOperations.createById, "CreateById");
@@clientLocation(RoleAssignmentsByIdOperations.deleteById, RoleAssignments);
@@clientName(RoleAssignmentsByIdOperations.deleteById, "DeleteById");
