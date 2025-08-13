import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "./models.tsp";
import "../Microsoft.Monitor.Accounts.Management/typespec/models.tsp";
import "../Microsoft.Monitor.Accounts.Management/typespec/service.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.Monitor;

@doc("The issue properties")
model IssueProperties {
  ...IssuePayload;
  ...DefaultProvisioningStateProperty;
}

@resource("issues")
@parentResource(AzureMonitorWorkspaceResource)
@doc("The Issue resource")
model IssueResource is ProxyResource<IssueProperties> {
  ...ResourceNameParameter<
    Resource = IssueResource,
    KeyName = "issueName",
    SegmentName = "issues",
    NamePattern = "^(?!-)[a-zA-Z0-9-]+[^-]$"
  >;
}

@armResourceOperations(IssueResource)
interface Issue {
  @doc("Create a new issue or updates an existing one")
  create is ArmResourceCreateOrReplaceSync<IssueResource>;

  @doc("Update an issue")
  update is ArmResourcePatchSync<IssueResource, IssueProperties>;

  @doc("Get issue properties")
  get is ArmResourceRead<IssueResource>;

  @doc("Delete an issue")
  delete is ArmResourceDeleteSync<IssueResource>;

  @doc("List all issues under the parent")
  list is ArmResourceListByParent<IssueResource>;

  @doc("Start a new investigation")
  startInvestigation is ArmResourceActionSync<
    IssueResource,
    StartInvestigationParameters,
    InvestigationMetadata
  >;
  @doc("Fetch investigation result")
  fetchInvestigationResult is ArmResourceActionSync<
    IssueResource,
    FetchInvestigationResultParameters,
    InvestigationResult
  >;

  @doc("List all alerts in the issue - this method uses pagination to return all alerts")
  listAlerts is ArmResourceActionSync<
    IssueResource,
    ListParameter,
    Page<RelatedAlert>
  >;
  @doc("Add or update alerts in the issue")
  addOrUpdateAlerts is ArmResourceActionSync<
    IssueResource,
    RelatedAlerts,
    RelatedAlerts
  >;

  @doc("List all resources in the issue - this method uses pagination to return all resources")
  listResources is ArmResourceActionSync<
    IssueResource,
    ListParameter,
    Page<RelatedResource>
  >;
  @doc("Add or update resources in the issue")
  addOrUpdateResources is ArmResourceActionSync<
    IssueResource,
    RelatedResources,
    RelatedResources
  >;
}
