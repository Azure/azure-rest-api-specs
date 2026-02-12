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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface AdminRequestApprovalsResources {
  /**
   * Get open approval requests
   */
  getAdminRequestApproval is ArmResourceRead<
    AdminRequestApprovalsResource,
    Parameters = {
      /**
       * The publisher id of this offer.
       */
      @query("publisherId")
      publisherId: string;
    },
    Error = ErrorResponse
  >;

  /**
   * Update the admin action, weather the request is approved or rejected and the approved plans
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  updateAdminRequestApproval is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    AdminRequestApprovalsResource,
    Response = ArmResourceUpdatedResponse<AdminRequestApprovalsResource>,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Get list of admin request approvals
   */
  adminRequestApprovalsList is Azure.ResourceManager.Legacy.ArmListSinglePageByParent<
    AdminRequestApprovalsResource,
    Response = ArmResponse<AdminRequestApprovalsList>,
    Error = ErrorResponse
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
