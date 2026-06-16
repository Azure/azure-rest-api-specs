import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using DeletedWorkbookApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(DeletedWorkbook.properties);

@@clientLocation(DeletedWorkbooksOperationGroup.listBySubscription,
  "DeletedWorkbooks"
);
