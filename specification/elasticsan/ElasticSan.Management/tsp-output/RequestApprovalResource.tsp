import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;
@doc("Request approval resource.")
@parentResource(PrivateStore)
model RequestApprovalResource is ProxyResource<RequestApprovalProperties> {
  @doc("The request approval ID to get create or update")
  @path
  @key("requestApprovalId")
  @segment("requestApprovals")
  name: string;
}

@armResourceOperations
interface RequestApprovalResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get open request approval details")
  @operationId("PrivateStore_GetRequestApproval")
  getRequestApproval is ArmResourceRead<RequestApprovalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create approval request")
  @operationId("PrivateStore_CreateApprovalRequest")
  createApprovalRequest is ArmResourceCreateOrReplaceSync<RequestApprovalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get all open approval requests of current user")
  @operationId("PrivateStore_GetApprovalRequestsList")
  getApprovalRequestsList is ArmResourceListByParent<RequestApprovalResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get request statuses foreach plan, this api is used as a complex GET action.")
  @operationId("PrivateStore_QueryRequestApproval")
  queryRequestApproval is ArmResourceActionSync<
    RequestApprovalResource,
    QueryRequestApprovalProperties,
    QueryRequestApproval
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Withdraw a user request approval on specific plan")
  @operationId("PrivateStore_WithdrawPlan")
  withdrawPlan is ArmResourceActionSync<
    RequestApprovalResource,
    WithdrawProperties,
    void
  >;
}

@@projectedName(RequestApprovalResources.createApprovalRequest::parameters.resource,
  "json",
  "payload"
);
@@extension(RequestApprovalResources.createApprovalRequest::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@doc(RequestApprovalResources.createApprovalRequest::parameters.resource, "");
@@projectedName(RequestApprovalResources.queryRequestApproval::parameters.body,
  "json",
  "payload"
);
@@extension(RequestApprovalResources.queryRequestApproval::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(RequestApprovalResources.queryRequestApproval::parameters.body, "");
@@projectedName(RequestApprovalResources.withdrawPlan::parameters.body,
  "json",
  "payload"
);
@@extension(RequestApprovalResources.withdrawPlan::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(RequestApprovalResources.withdrawPlan::parameters.body, "");
