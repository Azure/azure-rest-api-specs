import "../models.tsp";
import "./CodeScanReport.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.ApplicationMigration;

@doc("CodeScanIssue properties.")
model CodeScanIssueProperties {
  @doc("The provisioning state of the CodeScanIssue.")
  @visibility(Lifecycle.Read)
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;

  @doc("The rule ID of the scan issue.")
  ruleId: string;

  @doc("The rule label of the scan issue.")
  ruleLabel: string;

  @doc("The issue category.")
  issueCategory: IssueCategory;

  @doc("The story points for the issue.")
  storyPoints: int32;

  @doc("Reference links for the issue.")
  @OpenAPI.extension("x-ms-identifiers", #["url"])
  referenceLinks?: ReferenceLink[];

  @doc("The number of occurrences of the issue.")
  occurrences: int32;

  @doc("The migration targets affected by this issue.")
  azureTargets: MigrationTarget[];
}

@parentResource(CodeScanReport)
@doc("CodeScanIssue resource.")
model CodeScanIssue is ProxyResource<CodeScanIssueProperties> {
  @doc("CodeScanIssue name")
  @key("codeScanIssueId")
  @segment("codescanissues")
  @path
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_.]{0,62}[a-zA-Z0-9]$")
  name: string;
}
