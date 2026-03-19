import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Authorization;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ClassicAdministrator.properties);

@@clientLocation(ClassicAdministratorsOperationGroup.list,
  "ClassicAdministrators"
);

@@clientLocation(GlobalAdministratorOperationGroup.elevateAccess,
  "GlobalAdministrator"
);
