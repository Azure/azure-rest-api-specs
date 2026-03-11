import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using GraphQuery;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GraphQueryUpdateParameters.properties);

@@clientLocation(global.GraphQuery.GraphQuery.get, "GraphQuery");
@@clientLocation(global.GraphQuery.GraphQuery.createOrUpdate, "GraphQuery");
@@clientName(global.GraphQuery.GraphQuery.createOrUpdate::parameters.resource,
  "properties"
);
@@clientLocation(global.GraphQuery.GraphQuery.update, "GraphQuery");
@@clientName(global.GraphQuery.GraphQuery.update::parameters.properties, "body");
@@clientLocation(global.GraphQuery.GraphQuery.delete, "GraphQuery");
@@clientLocation(global.GraphQuery.GraphQuery.list, "GraphQuery");
@@clientLocation(global.GraphQuery.GraphQuery.listBySubscription, "GraphQuery");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(GraphQueryResource.properties);