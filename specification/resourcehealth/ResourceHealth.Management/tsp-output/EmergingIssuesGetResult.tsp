import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ResourceHealth;
@doc("The Get EmergingIssues operation response.")
@tenantResource
model EmergingIssuesGetResult is ProxyResource<EmergingIssue> {
  @doc("The name of the emerging issue.")
  @key("issueName")
  @segment("emergingIssues")
  name: IssueNameParameter;
}

@armResourceOperations
interface EmergingIssues {
  @doc("Gets Azure services' emerging issues.")
  get is ArmResourceRead<EmergingIssuesGetResult>;
  @doc("Lists Azure services' emerging issues.")
  list is ArmResourceListByParent<EmergingIssuesGetResult>;
}
