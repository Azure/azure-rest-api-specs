import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HybridConnectivity;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(EndpointResource.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(InventoryResource.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(PublicCloudConnector.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(ServiceConfigurationResource.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(SolutionConfiguration.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(SolutionTypeResource.properties, "autorest");
