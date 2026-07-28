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

using ApplicationInsightsCommonTypes;

namespace LiveTokenApi;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface LiveTokenOperationGroup {
  /**
   * **Gets an access token for live metrics stream data.**
   */
  @tag("LiveToken")
  @autoRoute
  @action("generatelivetoken")
  get is ArmProviderActionSync<
    Response = LiveTokenResponse,
    Scope = ExtensionResourceActionScope,
    Error = ErrorResponseLinkedStorage
  >;
}
