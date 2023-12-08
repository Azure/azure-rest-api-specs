import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Marketplace;
@doc("Admin request approval resource.")
@parentResource(PrivateStore)
model MarketplaceAdminApprovalRequest
  is ProxyResource<AdminRequestApprovalProperties> {
  @doc("The admin request approval ID to get create or update")
  @path
  @key("adminRequestApprovalId")
  @segment("adminRequestApprovals")
  name: string;
}

@armResourceOperations
interface MarketplaceAdminApprovalRequests {
  @doc("Get open approval requests")
  getAdminRequestApproval is ArmResourceRead<
    MarketplaceAdminApprovalRequest,
    {
      ...BaseParameters<MarketplaceAdminApprovalRequest>;

      @doc("The publisher id of this offer.")
      @query("publisherId")
      publisherId: string;
    }
  >;
  @doc("Update the admin action, weather the request is approved or rejected and the approved plans")
  updateAdminRequestApproval is ArmResourceCreateOrReplaceSync<MarketplaceAdminApprovalRequest>;
  @doc("Get list of admin request approvals")
  adminRequestApprovalsList is ArmResourceListByParent<MarketplaceAdminApprovalRequest>;
}
