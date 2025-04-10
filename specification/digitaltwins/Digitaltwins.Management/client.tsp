import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.DigitalTwins;

@@clientName(EventGrid.TopicEndpoint, "topicEndpoint");

@@clientName(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "digitalTwinsCreate"
);
@@clientName(DigitalTwinsDescriptions.update::parameters.properties,
  "digitalTwinsPatchDescription"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(DigitalTwinsDescription.properties);

@@clientName(PrivateEndpointConnections.createOrUpdate::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(DigitalTwinsEndpointResources.createOrUpdate::parameters.resource,
  "endpointDescription"
);

@@clientName(TimeSeriesDatabaseConnections.createOrUpdate::parameters.resource,
  "timeSeriesDatabaseConnectionDescription"
);
