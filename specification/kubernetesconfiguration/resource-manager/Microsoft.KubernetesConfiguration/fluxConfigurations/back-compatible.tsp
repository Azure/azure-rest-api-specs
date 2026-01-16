import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FluxConfigurationPatch.properties);

@@clientName(FluxConfigurations.createOrUpdate::parameters.resource,
  "fluxConfiguration"
);
@@clientName(FluxConfigurations.update::parameters.properties,
  "fluxConfigurationPatch"
);
@@clientLocation(FluxConfigurations.fluxConfigOperationStatusGet,
  "FluxConfigOperationStatus"
);
@@clientName(FluxConfigurations.fluxConfigOperationStatusGet, "Get");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(FluxConfiguration.properties);
@@visibility(FluxConfigurationsList.value, Lifecycle.Read);
