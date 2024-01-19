import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
@doc("The Get EmergingIssues operation response.")
@tenantResource
model EmergingIssuesGetResult is ProxyResource<EmergingIssue> {
  @doc("The name of the emerging issue.")
  @path
  @key("issueName")
  @segment("emergingIssues")
  name: IssueNameParameter;
}

@armResourceOperations
interface EmergingIssuesGetResults {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets Azure services' emerging issues.")
  @operationId("EmergingIssues_Get")
  get is ArmResourceRead<EmergingIssuesGetResult>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Lists Azure services' emerging issues.")
  @operationId("EmergingIssues_List")
  list is ArmResourceListByParent<EmergingIssuesGetResult>;
}
