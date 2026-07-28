import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./ResourceChanges/main.tsp";
import "./ResourceGraphApi/main.tsp";
import "./ResourceHistory/main.tsp";
import "./GraphQueryApi/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-client-generator-core/inconsistent-multiple-service-dependency" "temporarily suppressing"
@client({
  name: "ResourceGraphClient",
  service: [ResourceChanges, ResourceGraphApi, ResourceHistory, GraphQueryApi],
  autoMergeService: true,
})
namespace Microsoft.ResourceGraph;

// Move namespace-level operations off the merged root client so each generated
// client carries a consistent apiVersions set.
@@clientLocation(
  ResourceChanges.resourceChanges,
  "ResourceChangesOperations",
  "csharp"
);
@@clientLocation(
  ResourceChanges.resourceChangeDetails,
  "ResourceChangesOperations",
  "csharp"
);
@@clientLocation(
  ResourceGraphApi.resources,
  "ResourceGraphOperations",
  "csharp"
);
@@clientLocation(
  ResourceHistory.resourcesHistory,
  "ResourceHistoryOperations",
  "csharp"
);

// Follow the Azure SDK Get* prefix convention for read operations.
@@clientName(ResourceChanges.resourceChanges, "GetResourceChanges", "csharp");
@@clientName(
  ResourceChanges.resourceChangeDetails,
  "GetResourceChangeDetails",
  "csharp"
);
@@clientName(ResourceHistory.resourcesHistory, "GetResourcesHistory", "csharp");

// --- C# naming customizations to match GA SDK surface ---
// Rename models to match existing GA API
@@clientName(ResourceGraphApi.QueryRequest, "ResourceQueryContent", "csharp");
@@clientName(
  ResourceGraphApi.QueryRequestOptions,
  "ResourceQueryRequestOptions",
  "csharp"
);
@@clientName(ResourceGraphApi.QueryResponse, "ResourceQueryResult", "csharp");
@@clientName(ResourceGraphCommon.ErrorDetails, "FacetErrorDetails", "csharp");

// Rename DateTimeInterval properties to match GA SDK
@@clientName(ResourceGraphCommon.DateTimeInterval.start, "StartOn", "csharp");
@@clientName(ResourceGraphCommon.DateTimeInterval.end, "EndOn", "csharp");

// Rename GraphQueryResource to ResourceGraphQuery (the old name)
@@clientName(GraphQueryApi.GraphQueryResource, "ResourceGraphQuery", "csharp");
@@clientName(
  GraphQueryApi.GraphQueryProperties.timeModified,
  "ModifiedOn",
  "csharp"
);

// Rename operations to match GA SDK
@@clientName(ResourceGraphApi.resources, "GetResources", "csharp");

// Rename patch model
@@clientName(
  GraphQueryApi.GraphQueryUpdateParameters,
  "ResourceGraphQueryPatch",
  "csharp"
);

// FacetRequest - keep GA name despite ending in "Request"
@@clientName(ResourceGraphApi.FacetRequest, "FacetRequest", "csharp");

// --- Type customizations for backward compatibility ---
// Restore TrackedResourceData inheritance for GraphQueryResource (matches GA SDK base type)
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(
  GraphQueryApi.GraphQueryResource,
  Azure.ResourceManager.Foundations.TrackedResource,
  "csharp"
);

// Change etag properties from string to Azure.ETag
@@alternateType(GraphQueryApi.GraphQueryResource.etag, eTag, "csharp");
@@alternateType(GraphQueryApi.GraphQueryUpdateParameters.etag, eTag, "csharp");
@@alternateType(ResourceHistory.ResourcesHistoryResult, unknown);
