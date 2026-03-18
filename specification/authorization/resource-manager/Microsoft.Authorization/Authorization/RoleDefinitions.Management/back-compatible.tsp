import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

@@clientName(RoleDefinitionProperties.type, "roleType");

@@clientName(RoleDefinitions.createOrUpdate::parameters.resource,
  "roleDefinition"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(RoleDefinition.properties);

@@clientLocation(PermissionsOperationGroup.listForResourceGroup, "Permissions");
@@clientLocation(PermissionsOperationGroup.listForResource, "Permissions");
