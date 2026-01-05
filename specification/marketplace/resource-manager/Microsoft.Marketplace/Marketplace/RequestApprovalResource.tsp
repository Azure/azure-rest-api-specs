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

@armResourceOperations
interface RequestApprovalResources {
  /**
   * Get open request approval details
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_GetRequestApproval")
  getRequestApproval is ArmResourceRead<RequestApprovalResource>;

  /**
   * Create approval request
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateStore_CreateApprovalRequest")
  createApprovalRequest is ArmResourceCreateOrReplaceSync<
    RequestApprovalResource,
    Response = ArmResourceUpdatedResponse<RequestApprovalResource>
  >;

  /**
   * Get all open approval requests of current user
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_GetApprovalRequestsList")
  getApprovalRequestsList is ArmResourceListByParent<
    RequestApprovalResource,
    Response = ArmResponse<RequestApprovalsList>
  >;

  /**
   * Get request statuses foreach plan, this api is used as a complex GET action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_QueryRequestApproval")
  @action("query")
  queryRequestApproval is ArmResourceActionSync<
    RequestApprovalResource,
    QueryRequestApprovalProperties,
    ArmResponse<QueryRequestApproval>,
    OptionalRequestBody = true
  >;

  /**
   * Withdraw a user request approval on specific plan
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_WithdrawPlan")
  withdrawPlan is ArmResourceActionSync<
    RequestApprovalResource,
    WithdrawProperties,
    OkResponse,
    OptionalRequestBody = true
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
