import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using WorkbookTemplatesApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkbookTemplateUpdateParameters.properties);

@@clientName(WorkbookTemplates.createOrUpdate::parameters.resource,
  "workbookTemplateProperties"
);
@@clientName(WorkbookTemplates.update::parameters.properties,
  "WorkbookTemplateUpdateParameters"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(WorkbookTemplate.properties);
