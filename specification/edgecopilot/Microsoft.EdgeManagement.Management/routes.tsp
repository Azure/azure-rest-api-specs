// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.EdgeManagement;

@armResourceOperations
interface Edge {
  /**
   * Post a message to chatbot
   */
  @autoRoute
  chat is ArmProviderActionSync<
    Request = ChatRequestContent,
    Response = ChatResult,
    Scope = SubscriptionActionScope,
    Parameters = LocationParameter
  >;

  /**
   * Trigger a troubleshooting action
   */
  @added(Versions.v2025_06_01_preview)
  @autoRoute
  troubleshoot is ArmResourceActionSync<
    Resource = ExtensionResource<{}>,
    Request = ChatRequestContent,
    Response = ChatResult
  >;
}
