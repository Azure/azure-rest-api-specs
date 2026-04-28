import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.HanaOnAzure;

@@clientName(SapMonitors.create::parameters.resource, "sapMonitorParameter");
@@clientName(SapMonitors.update::parameters.properties, "tagsParameter");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(SapMonitor.properties);

@@clientName(ProviderInstances.create::parameters.resource,
  "providerInstanceParameter"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ProviderInstance.properties);
