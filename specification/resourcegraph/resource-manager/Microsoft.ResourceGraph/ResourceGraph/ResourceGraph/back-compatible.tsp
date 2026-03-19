import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using ResourceGraph;

// @@clientName(QueryRequestOptions.$skipToken, "skipToken");
// @@clientName(QueryRequestOptions.$top, "top");
// @@clientName(QueryRequestOptions.$skip, "skip");

// @@clientName(FacetRequestOptions.$top, "top");

// @@clientName(QueryResponse.$skipToken, "skipToken");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(GraphQueryResource.properties);

@@clientName(resources::parameters.body, "query");
