import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ClassicAdmin;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ClassicAdministrator.properties);

@@clientLocation(ClassicAdministratorsOperationGroup.list,
  "ClassicAdministrators"
);

@@clientLocation(GlobalAdministratorOperationGroup.elevateAccess,
  "GlobalAdministrator"
);
