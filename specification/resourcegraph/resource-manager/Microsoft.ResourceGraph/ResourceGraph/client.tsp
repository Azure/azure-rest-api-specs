import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

import "./ResourceGraph/main.tsp";
import "./GraphQuery/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;

// --- C# naming customizations to match GA SDK surface ---
// Rename models to match existing GA API
@@clientName(ResourceGraphApi.QueryRequest, "ResourceQueryContent", "csharp");
@@clientName(ResourceGraphApi.QueryRequestOptions, "ResourceQueryRequestOptions", "csharp");
@@clientName(ResourceGraphApi.QueryResponse, "ResourceQueryResult", "csharp");
@@clientName(ResourceGraphCommon.ErrorDetails, "FacetErrorDetails", "csharp");

// Rename DateTimeInterval properties to match GA SDK
@@clientName(ResourceGraphCommon.DateTimeInterval.start, "StartOn", "csharp");
@@clientName(ResourceGraphCommon.DateTimeInterval.end, "EndOn", "csharp");

// Rename GraphQueryResource to ResourceGraphQuery (the old name)
@@clientName(GraphQueryApi.GraphQueryResource, "ResourceGraphQuery", "csharp");
@@clientName(GraphQueryApi.GraphQueryProperties.timeModified, "ModifiedOn", "csharp");

// Rename operations to match GA SDK
@@clientName(ResourceGraphApi.resources, "GetResources", "csharp");

// Rename patch model
@@clientName(GraphQueryApi.GraphQueryUpdateParameters, "ResourceGraphQueryPatch", "csharp");

// FacetRequest - keep GA name despite ending in "Request"
@@clientName(ResourceGraphApi.FacetRequest, "FacetRequest", "csharp");

// --- Type customizations for backward compatibility ---
// Change etag properties from string to Azure.ETag
@@alternateType(GraphQueryApi.GraphQueryResource.etag, eTag, "csharp");
@@alternateType(GraphQueryApi.GraphQueryUpdateParameters.etag, eTag, "csharp");
