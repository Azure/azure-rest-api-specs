import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.KubernetesConfiguration;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(FluxConfiguration.properties);
