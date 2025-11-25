import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceConnector;

@@clientName(Appliances.createOrUpdate::parameters.resource, "parameters");
@@clientName(Appliances.update::parameters.properties, "parameters");
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Appliance.properties);

@@clientLocation(AppliancesOperationGroup.getTelemetryConfig, Appliances);
@@clientLocation(Operations.list, Appliances);
@@clientName(Operations.list, "ListOperations");

@@clientName(PatchableAppliance, "patchableAppliance");
@@clientName(ApplianceProperties, "applianceProperties");
@@clientName(Appliance, "appliance");
@@clientName(ApplianceListResult, "applianceListResult");
@@clientName(ApplianceListCredentialResults, "applianceListCredentialResults");
@@clientName(ApplianceListKeysResults, "applianceListKeysResults");
@@clientName(ApplianceGetTelemetryConfigResult,
  "applianceGetTelemetryConfigResult"
);
@@clientName(ApplianceCredentialKubeconfig, "applianceCredentialKubeconfig");
@@clientName(AppliancePropertiesInfrastructureConfig,
  "appliancePropertiesInfrastructureConfig"
);
