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

namespace Microsoft.ResourceIntelligence;

@armResourceOperations
interface QueryOperationGroup {
  /**
   * Generates ARG query for a given user prompt.
   */
  @autoRoute
  @action("generateQuery")
  generate is ArmProviderActionSync<
    Request = QueryGenerationRequest,
    Response = QueryGenerationResult
  >;
}
