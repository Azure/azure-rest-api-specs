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
@@Legacy.flattenProperty(ServiceConfigurationResource.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(SolutionConfiguration.properties, "autorest");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Legacy.flattenProperty(SolutionTypeResource.properties, "autorest");

@@clientLocation(EndpointResources.get, "Endpoints");
@@clientLocation(EndpointResources.createOrUpdate, "Endpoints");
@@clientLocation(EndpointResources.update, "Endpoints");
@@clientLocation(EndpointResources.delete, "Endpoints");
@@clientLocation(EndpointResources.list, "Endpoints");
@@clientLocation(EndpointResources.listCredentials, "Endpoints");
@@clientLocation(EndpointResources.listIngressGatewayCredentials, "Endpoints");
@@clientLocation(EndpointResources.listManagedProxyDetails, "Endpoints");

@@clientLocation(ServiceConfigurationResources.get, "ServiceConfigurations");
@@clientLocation(
  ServiceConfigurationResources.createOrupdate,
  "ServiceConfigurations"
);
@@clientLocation(ServiceConfigurationResources.update, "ServiceConfigurations");
@@clientLocation(ServiceConfigurationResources.delete, "ServiceConfigurations");
@@clientLocation(
  ServiceConfigurationResources.listByEndpointResource,
  "ServiceConfigurations"
);
