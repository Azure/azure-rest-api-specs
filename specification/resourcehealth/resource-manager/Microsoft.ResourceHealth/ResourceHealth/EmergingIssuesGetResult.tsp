import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ResourceHealth;
/**
 * The Get EmergingIssues operation response.
 */
@tenantResource
model EmergingIssuesGetResult
  is Azure.ResourceManager.ProxyResource<EmergingIssue> {
  ...ResourceNameParameter<
    Resource = EmergingIssuesGetResult,
    KeyName = "issueName",
    SegmentName = "emergingIssues",
    NamePattern = "",
    Type = IssueNameParameter
  >;
}

@armResourceOperations
interface EmergingIssuesGetResults {
  /**
   * Gets Azure services' emerging issues.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EmergingIssues_Get")
  get is ArmResourceRead<
    EmergingIssuesGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Lists Azure services' emerging issues.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EmergingIssues_List")
  list is ArmResourceListByParent<
    EmergingIssuesGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(EmergingIssuesGetResult.name, "The name of the emerging issue.");
@@doc(EmergingIssuesGetResult.properties,
  "The emerging issue entity properties."
);
