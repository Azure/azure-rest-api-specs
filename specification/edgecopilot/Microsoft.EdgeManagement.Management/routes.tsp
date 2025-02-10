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

namespace Microsoft.EdgeManagement;

/**
 * Use ChatWrapper to define the body name
 */
model ChatWrapper {
@doc("The chat request body")
  @body
  chatRequest: ChatRequest
}

@armResourceOperations
interface Edge {
  /**
   * Post a message to chatbot
   */
  @autoRoute
  chat is ArmProviderActionSync<
    Request = ChatWrapper,
    Response = ChatResponse,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;
}
