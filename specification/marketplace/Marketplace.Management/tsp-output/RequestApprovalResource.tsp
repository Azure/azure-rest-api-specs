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
/**
 * Request approval resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateStore)
@Azure.ResourceManager.Private.armResourceInternal(RequestApprovalProperties)
@includeInapplicableMetadataInPayload(false)
model RequestApprovalResource extends Resource {
  /**
   * The request approval ID to get create or update
   */
  @path
  @key("requestApprovalId")
  @segment("requestApprovals")
  name: string;

  /**
   * The privateStore approval request data structure.
   */
  @extension("x-ms-client-flatten", true)
  properties?: RequestApprovalProperties;
}

@armResourceOperations
interface RequestApprovalResources {
  /**
   * Get open request approval details
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_GetRequestApproval")
  getRequestApproval is ArmResourceRead<RequestApprovalResource>;

  /**
   * Create approval request
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_CreateApprovalRequest")
  createApprovalRequest is ArmResourceCreateOrReplaceSync<RequestApprovalResource>;

  /**
   * Get all open approval requests of current user
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_GetApprovalRequestsList")
  getApprovalRequestsList is ArmResourceListByParent<RequestApprovalResource>;

  /**
   * Get request statuses foreach plan, this api is used as a complex GET action.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_QueryRequestApproval")
  queryRequestApproval is ArmResourceActionSync<
    RequestApprovalResource,
    QueryRequestApprovalProperties,
    QueryRequestApproval
  >;

  /**
   * Withdraw a user request approval on specific plan
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
