import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "./models.tsp";
import "../models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Monitor namespace (specification/monitor/resource-manager/Microsoft.Monitor/Operations)"
@armProviderNamespace("Microsoft.Monitor")
@service(#{ title: "Azure Monitor Workspaces Control Plane API" })
@versioned(Versions)
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
  create is ArmResourceCreateOrReplaceSync<
    Resource = IssueResource,
    Parameters = {
      @doc("Related resource or alert that is to be added to the issue (default: empty - the issue will be created without any related resources or alerts)")
      @query
      related?: string;

      @removed(Versions.v2025_10_03)
      @doc("Whether to automatically start an investigation once the issue is created (default: false)")
      @query
      startInvestigation?: boolean;
    }
  >;

  @doc("Update an issue")
  update is ArmResourcePatchSync<IssueResource, IssueProperties>;

  @doc("Get issue properties")
  get is ArmResourceRead<IssueResource>;

  @doc("Delete an issue")
  delete is ArmResourceDeleteSync<IssueResource>;

  @doc("List all issues under the parent")
  list is ArmResourceListByParent<IssueResource>;

  @removed(Versions.v2025_10_03)
  @doc("Start a new investigation")
  startInvestigation is ArmResourceActionSync<
    IssueResource,
    StartInvestigationParameters,
    InvestigationMetadata
  >;
  @added(Versions.v2025_10_03)
  @doc("Adds investigation result")
  addInvestigationResult is ArmResourceActionSync<
    IssueResource,
    InvestigationResult,
    InvestigationResult
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

  @added(Versions.v2025_10_03)
  @doc("Fetch the background visualization of the issue")
  fetchBackgroundVisualization is ArmResourceActionSync<
    IssueResource,
    void,
    BackgroundVisualization
  >;
  @added(Versions.v2025_10_03)
  @doc("Set the background visualization for the issue")
  setBackgroundVisualization is ArmResourceActionNoContentSync<
    IssueResource,
    BackgroundVisualization
  >;
}
