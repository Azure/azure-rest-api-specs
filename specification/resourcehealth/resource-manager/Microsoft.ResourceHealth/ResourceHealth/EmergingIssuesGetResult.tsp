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

@armResourceOperations(#{ omitTags: true })
interface EmergingIssuesGetResults {
  /**
   * Gets Azure services' emerging issues.
   */
  @tag("EmergingIssues")
  get is ArmResourceRead<
    EmergingIssuesGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = EmergingIssuesGetResult,
    Error = ErrorResponse
  >;

  /**
   * Lists Azure services' emerging issues.
   */
  @tag("EmergingIssues")
  list is ArmResourceListByParent<
    EmergingIssuesGetResult,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = emergingIssueListResult,
    Error = ErrorResponse
  >;
}

@@doc(EmergingIssuesGetResult.name, "The name of the emerging issue.");
@@doc(EmergingIssuesGetResult.properties,
  "The emerging issue entity properties."
);
