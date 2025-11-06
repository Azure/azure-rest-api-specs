import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HybridConnectivity;

@@Legacy.flattenProperty(EndpointResource.properties, "autorest");
@@Legacy.flattenProperty(InventoryResource.properties, "autorest");
@@Legacy.flattenProperty(PublicCloudConnector.properties, "autorest");
@@Legacy.flattenProperty(ServiceConfigurationResource.properties, "autorest");
@@Legacy.flattenProperty(SolutionConfiguration.properties, "autorest");
@@Legacy.flattenProperty(SolutionTypeResource.properties, "autorest");
