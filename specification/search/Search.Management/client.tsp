import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Search;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SearchServiceUpdate.properties);

@@clientName(CheckNameAvailabilityOutput.nameAvailable, "IsNameAvailable");

@@clientName(SearchServices.createOrUpdate::parameters.resource, "service");
@@clientName(SearchServices.update::parameters.properties, "service");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SearchService.properties);

@@clientName(PrivateEndpointConnections.update::parameters.resource,
  "privateEndpointConnection"
);

@@clientName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "sharedPrivateLinkResource"
);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(NetworkSecurityPerimeterConfiguration.properties);
