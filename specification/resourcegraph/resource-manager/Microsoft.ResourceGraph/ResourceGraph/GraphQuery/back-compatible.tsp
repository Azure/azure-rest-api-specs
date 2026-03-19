import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using GraphQueryApi;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GraphQueryUpdateParameters.properties);

@@clientLocation(GraphQueryResources.get, "GraphQuery");
@@clientLocation(GraphQueryResources.createOrUpdate, "GraphQuery");
@@clientName(GraphQueryResources.createOrUpdate::parameters.resource,
  "properties"
);
@@clientLocation(GraphQueryResources.update, "GraphQuery");
@@clientName(GraphQueryResources.update::parameters.properties, "body");
@@clientLocation(GraphQueryResources.delete, "GraphQuery");
@@clientLocation(GraphQueryResources.list, "GraphQuery");
@@clientLocation(GraphQueryResources.listBySubscription, "GraphQuery");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GraphQueryResource.properties);
