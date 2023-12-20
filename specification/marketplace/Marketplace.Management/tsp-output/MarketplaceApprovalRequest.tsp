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
@doc("Request approval resource.")
@parentResource(PrivateStore)
model MarketplaceApprovalRequest is ProxyResource<RequestApprovalProperties> {
  @doc("The request approval ID to get create or update")
  @path
  @key("requestApprovalId")
  @segment("requestApprovals")
  name: string;
}

@armResourceOperations
interface MarketplaceApprovalRequests {
  @doc("Get open request approval details")
  getRequestApproval is ArmResourceRead<MarketplaceApprovalRequest>;
  @doc("Create approval request")
  createApprovalRequest is ArmResourceCreateOrReplaceSync<MarketplaceApprovalRequest>;
  @doc("Get all open approval requests of current user")
  getApprovalRequestsList is ArmResourceListByParent<MarketplaceApprovalRequest>;
  @doc("Get request statuses foreach plan, this api is used as a complex GET action.")
  queryRequestApproval is ArmResourceActionSync<
    MarketplaceApprovalRequest,
    QueryRequestApprovalProperties,
    QueryRequestApproval
  >;
  @doc("Withdraw a user request approval on specific plan")
  withdrawPlan is ArmResourceActionSync<
    MarketplaceApprovalRequest,
    WithdrawProperties,
    void
  >;
}
