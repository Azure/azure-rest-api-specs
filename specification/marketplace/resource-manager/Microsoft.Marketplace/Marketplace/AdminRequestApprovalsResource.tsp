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
 * Admin request approval resource.
 */
@parentResource(PrivateStore)
model AdminRequestApprovalsResource
  is Azure.ResourceManager.ProxyResource<AdminRequestApprovalProperties> {
  ...ResourceNameParameter<
    Resource = AdminRequestApprovalsResource,
    KeyName = "adminRequestApprovalId",
    SegmentName = "adminRequestApprovals",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AdminRequestApprovalsResources {
  /**
   * Get open approval requests
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_GetAdminRequestApproval")
  getAdminRequestApproval is ArmResourceRead<
    AdminRequestApprovalsResource,
    Parameters = {
      /**
       * The publisher id of this offer.
       */
      @query("publisherId")
      publisherId: string;
    }
  >;

  /**
   * Update the admin action, weather the request is approved or rejected and the approved plans
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateStore_UpdateAdminRequestApproval")
  updateAdminRequestApproval is ArmResourceCreateOrReplaceSync<
    AdminRequestApprovalsResource,
    Response = ArmResourceUpdatedResponse<AdminRequestApprovalsResource>
  >;

  /**
   * Get list of admin request approvals
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_AdminRequestApprovalsList")
  adminRequestApprovalsList is ArmResourceListByParent<
    AdminRequestApprovalsResource,
    Response = ArmResponse<AdminRequestApprovalsList>
  >;
}

@@doc(AdminRequestApprovalsResource.name,
  "The admin request approval ID to get create or update"
);
@@doc(AdminRequestApprovalsResource.properties,
  "The privateStore admin Approval request data structure."
);
@@doc(AdminRequestApprovalsResources.updateAdminRequestApproval::parameters.resource,
  ""
);
