// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.SaaSHub;

@armResourceOperations
interface ProviderLevelActions {
  /**
   * Evaluates whether the request payload can create a new resource. Currently only supports SaaS resource type.
   */
  @route("/providers/Microsoft.SaaSHub")
  @post
  @armResourceAction(SaasResource)
  tenantLevelCanCreate(
    ...ApiVersionParameter,

    /**
     * Request parameters that are provided to the create SaaSHub resource operation.
     */
    @bodyRoot
    body: CanCreateRequest,
  ): ArmResponse<CanCreateResult> | ErrorResponse;
}
