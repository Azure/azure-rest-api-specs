import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WorkbooksApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkbookUpdateParameters.properties);

@@clientName(Workbooks.createOrUpdate::parameters.resource,
  "workbookProperties"
);
@@clientName(Workbooks.update::parameters.properties,
  "WorkbookUpdateParameters"
);
@@clientLocation(WorkbookOperationGroup.revisionGet, Workbooks);
@@clientLocation(WorkbookOperationGroup.listByResourceGroup, Workbooks);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Workbook.properties);
