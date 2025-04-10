import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.NetworkFunction;

@@clientName(AzureTrafficCollectors.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(AzureTrafficCollectors.updateTags::parameters.properties,
  "parameters"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AzureTrafficCollector.properties);

@@clientName(CollectorPolicies.createOrUpdate::parameters.resource,
  "parameters"
);
@@clientName(CollectorPolicies.updateTags::parameters.properties, "parameters");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CollectorPolicy.properties);
