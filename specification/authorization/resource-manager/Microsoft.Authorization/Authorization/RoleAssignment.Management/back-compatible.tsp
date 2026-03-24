import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleAssignmentCreateParameters.properties);

@@clientName(RoleAssignments.create::parameters.resource, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
