import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/openapi";
import "./models.tsp";
import "../../Microsoft.Monitor.Accounts.Management/typespec/models.tsp";

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

enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  @doc("API Version 2025-05-03-preview")
  v2025_05_03: "2025-05-03-preview",
}

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
