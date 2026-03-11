// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace ResourceGraph;

/**
 * Queries the resources managed by Azure Resource Manager for scopes specified in the request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" ""
@autoRoute
@tag("Resources")
@OpenAPI.externalDocs(
  "https://aka.ms/resource-graph/learntoquery",
  "Learn more about the query syntax here"
)
op resources is ArmProviderActionSync<
  Request = QueryRequest,
  Response = QueryResponse
>;
