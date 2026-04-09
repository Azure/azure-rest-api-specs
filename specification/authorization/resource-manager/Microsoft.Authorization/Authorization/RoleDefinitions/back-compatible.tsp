import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.RoleDefinitions;

@@clientName(RoleDefinitionProperties.type, "roleType");

@@clientName(RoleDefinitions.createOrUpdate::parameters.resource,
  "roleDefinition"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RoleDefinition.properties);

@@clientLocation(PermissionsOperationGroup.listForResourceGroup, "Permissions");
@@clientLocation(PermissionsOperationGroup.listForResource, "Permissions");
@@clientLocation(RoleDefinitionsByIdOperationGroup.getById, "RoleDefinitions");
