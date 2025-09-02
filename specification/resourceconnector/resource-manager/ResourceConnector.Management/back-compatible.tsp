import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceConnector;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ApplianceOperation.display);

@@clientName(Appliances.createOrUpdate::parameters.resource, "parameters");
@@clientName(Appliances.update::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Appliance.properties);

@@clientLocation(AppliancesOperationGroup.getTelemetryConfig, Appliances);
