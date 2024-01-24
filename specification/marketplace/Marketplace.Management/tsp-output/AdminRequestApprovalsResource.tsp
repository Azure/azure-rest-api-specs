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
 * Admin request approval resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(PrivateStore)
@Azure.ResourceManager.Private.armResourceInternal(
  AdminRequestApprovalProperties
)
@includeInapplicableMetadataInPayload(false)
model AdminRequestApprovalsResource extends Resource {
  /**
   * The admin request approval ID to get create or update
   */
  @path
  @key("adminRequestApprovalId")
  @segment("adminRequestApprovals")
  name: string;

  /**
   * The privateStore admin Approval request data structure.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AdminRequestApprovalProperties;
}

@armResourceOperations
interface AdminRequestApprovalsResources {
  /**
   * Get open approval requests
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_GetAdminRequestApproval")
  getAdminRequestApproval is ArmResourceRead<
    AdminRequestApprovalsResource,
    {
      ...BaseParameters<AdminRequestApprovalsResource>;

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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_UpdateAdminRequestApproval")
  updateAdminRequestApproval is ArmResourceCreateOrReplaceSync<AdminRequestApprovalsResource>;

  /**
   * Get list of admin request approvals
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_AdminRequestApprovalsList")
  adminRequestApprovalsList is ArmResourceListByParent<AdminRequestApprovalsResource>;
}

@@projectedName(AdminRequestApprovalsResources.updateAdminRequestApproval::parameters.resource,
  "json",
  "payload"
);
@@extension(AdminRequestApprovalsResources.updateAdminRequestApproval::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@doc(AdminRequestApprovalsResources.updateAdminRequestApproval::parameters.resource,
  ""
);
