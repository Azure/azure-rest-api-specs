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

namespace LiveTokenApi;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface LiveTokenOperationGroup {
  /**
   * **Gets an access token for live metrics stream data.**
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LiveToken_Get")
  @tag("LiveToken")
  @autoRoute
  @action("generatelivetoken")
  get is ArmProviderActionSync<
    Response = LiveTokenResponse,
    Scope = ExtensionResourceActionScope,
    Error = ErrorResponseLinkedStorage
  >;
}
