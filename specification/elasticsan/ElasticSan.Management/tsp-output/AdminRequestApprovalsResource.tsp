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
@doc("Admin request approval resource.")
@parentResource(PrivateStore)
model AdminRequestApprovalsResource
  is ProxyResource<AdminRequestApprovalProperties> {
  @doc("The admin request approval ID to get create or update")
  @path
  @key("adminRequestApprovalId")
  @segment("adminRequestApprovals")
  name: string;
}

@armResourceOperations
interface AdminRequestApprovalsResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get open approval requests")
  @operationId("PrivateStore_GetAdminRequestApproval")
  getAdminRequestApproval is ArmResourceRead<
    AdminRequestApprovalsResource,
    {
      ...BaseParameters<AdminRequestApprovalsResource>;

      @doc("The publisher id of this offer.")
      @query("publisherId")
      publisherId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update the admin action, weather the request is approved or rejected and the approved plans")
  @operationId("PrivateStore_UpdateAdminRequestApproval")
  updateAdminRequestApproval is ArmResourceCreateOrReplaceSync<AdminRequestApprovalsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get list of admin request approvals")
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
