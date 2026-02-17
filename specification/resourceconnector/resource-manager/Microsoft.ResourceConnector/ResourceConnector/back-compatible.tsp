import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceConnector;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ApplianceOperation.display);

@@clientName(Appliances.createOrUpdate::parameters.resource, "parameters");
@@clientName(Appliances.update::parameters.properties, "parameters");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Appliance.properties);

@@clientLocation(AppliancesOperationGroup.getTelemetryConfig, Appliances);
@@clientLocation(Operations.list, Appliances);
@@clientName(Operations.list, "ListOperations");

@@clientName(PatchableAppliance, "patchableAppliance");
@@clientName(ApplianceOperation, "applianceOperation");
@@clientName(ApplianceOperationsList, "applianceOperationsList");
@@clientName(ApplianceProperties, "applianceProperties");
@@clientName(Appliance, "appliance");
@@clientName(ApplianceListResult, "applianceListResult");
@@clientName(ApplianceListCredentialResults, "applianceListCredentialResults");
@@clientName(ApplianceListKeysResults, "applianceListKeysResults");
@@clientName(ApplianceGetTelemetryConfigResult,
  "applianceGetTelemetryConfigResult"
);
@@clientName(ApplianceOperationValueDisplay, "applianceOperationValueDisplay");
@@clientName(ApplianceCredentialKubeconfig, "applianceCredentialKubeconfig");
@@clientName(AppliancePropertiesInfrastructureConfig,
  "appliancePropertiesInfrastructureConfig"
);
