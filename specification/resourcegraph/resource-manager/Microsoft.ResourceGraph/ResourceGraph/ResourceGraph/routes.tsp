// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace ResourceGraph;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface QueryOperationGroup {
  /**
   * Generates ARG query for a given user prompt.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Query_GenerateQuery")
  @autoRoute
  @Versioning.added(Versions.v2023_09_01_preview)
  generateQuery is ArmProviderActionSync<
    Request = QueryGenerationRequest,
    Response = QueryGenerationResponse,
    Error = ErrorResponse
  >;
}

/**
 * Queries the resources managed by Azure Resource Manager for scopes specified in the request.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-openapi" ""
@autoRoute
@tag("Resources")
@externalDocs(
  "https://aka.ms/resource-graph/learntoquery",
  "Learn more about the query syntax here"
)
op resources is ArmProviderActionSync<
  Request = QueryRequest,
  Response = QueryResponse,
  Error = ErrorResponse
>;