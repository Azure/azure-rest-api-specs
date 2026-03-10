import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;
/**
 * Request approval resource.
 */
@parentResource(PrivateStore)
model RequestApprovalResource
  is Azure.ResourceManager.ProxyResource<RequestApprovalProperties> {
  ...ResourceNameParameter<
    Resource = RequestApprovalResource,
    KeyName = "requestApprovalId",
    SegmentName = "requestApprovals",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface RequestApprovalResources {
  /**
   * Get open request approval details
   */
  getRequestApproval is ArmResourceRead<
    RequestApprovalResource,
    Error = ErrorResponse
  >;

  /**
   * Create approval request
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createApprovalRequest is ArmResourceCreateOrReplaceSync<
    RequestApprovalResource,
    Response = ArmResourceUpdatedResponse<RequestApprovalResource>,
    Error = ErrorResponse
  >;

  /**
   * Get all open approval requests of current user
   */
  getApprovalRequestsList is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    RequestApprovalResource,
    Response = ArmResponse<RequestApprovalsList>,
    Error = ErrorResponse
  >;

  /**
   * Get request statuses foreach plan, this api is used as a complex GET action.
   */
  @action("query")
  queryRequestApproval is ArmResourceActionSync<
    RequestApprovalResource,
    QueryRequestApprovalProperties,
    ArmResponse<QueryRequestApproval>,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Withdraw a user request approval on specific plan
   */
  withdrawPlan is ArmResourceActionSync<
    RequestApprovalResource,
    WithdrawProperties,
    OkResponse,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;
}

@@doc(RequestApprovalResource.name,
  "The request approval ID to get create or update"
);
@@doc(RequestApprovalResource.properties,
  "The privateStore approval request data structure."
);
@@doc(RequestApprovalResources.createApprovalRequest::parameters.resource, "");
@@doc(RequestApprovalResources.queryRequestApproval::parameters.body, "");
@@doc(RequestApprovalResources.withdrawPlan::parameters.body, "");
