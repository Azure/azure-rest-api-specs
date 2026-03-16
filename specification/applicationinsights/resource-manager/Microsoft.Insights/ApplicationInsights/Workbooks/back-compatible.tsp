import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WorkbooksApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkbookUpdateParameters.properties);

@@clientName(Workbooks.createOrUpdate::parameters.resource,
  "workbookProperties"
);
@@clientName(Workbooks.update::parameters.properties,
  "WorkbookUpdateParameters"
);
@@clientLocation(WorkbookOperationGroup.revisionGet, Workbooks);
@@clientLocation(WorkbookOperationGroup.listByResourceGroup, Workbooks);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Workbook.properties);
