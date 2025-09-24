import "./versions.tsp";
import "./models.tsp";
import "./workspace.tsp";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.StorageDiscovery;

@parentResource(StorageDiscoveryWorkspace)
@doc("A report resource")
model ReportResource is Azure.ResourceManager.ProxyResource<ReportProperties> {
  ...ResourceNameParameter<
    Resource = ReportResource,
    KeyName = "discoveryResourceName",
    SegmentName = "reports"
  >;
}

@doc("Properties for the Report resource used only as a proxy for the Report API.")
model ReportProperties {
  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: Azure.ResourceManager.ResourceProvisioningState;
}

@armResourceOperations
interface Report {
  get is ArmResourceRead<ReportResource>;
  @autoRoute
  @post
  generateReport is ArmResourceActionAsync<
    ReportResource,
    GetReportContent,
    GetReportResult
  >;
  listByResourceGroup is ArmResourceListByParent<ReportResource>;
  listBySubscription is ArmListBySubscription<ReportResource>;
}
