import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WorkbookTemplatesApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkbookTemplateUpdateParameters.properties);

@@clientName(WorkbookTemplates.createOrUpdate::parameters.resource,
  "workbookTemplateProperties"
);
@@clientName(WorkbookTemplates.update::parameters.properties,
  "WorkbookTemplateUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WorkbookTemplate.properties);
