import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppComplianceAutomation;
@doc("A class represent a AppComplianceAutomation snapshot resource.")
@parentResource(ReportResource)
model SnapshotResource is ProxyResource<SnapshotProperties> {
  @doc("Snapshot Name.")
  @key("snapshotName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
@projectedName("client", "Snapshot")
interface SnapshotResources_Snapshot {
  @doc("Get the AppComplianceAutomation snapshot and its properties.")
  get is ArmResourceRead<SnapshotResource>;

  @doc("Download compliance needs from snapshot, like: Compliance Report, Resource List.")
  download is ArmResourceActionAsync<
    SnapshotResource,
    SnapshotDownloadRequest,
    DownloadResponse
  >;
}

@armResourceOperations
@projectedName("client", "Snapshots")
interface SnapshotResources_Snapshots {
  @doc("Get the AppComplianceAutomation snapshot list.")
  list is ArmResourceListByParent<
    SnapshotResource,
    {
      ...BaseParameters<SnapshotResource>;

      @doc("Skip over when retrieving results.")
      @query("$skipToken")
      $skipToken?: string;

      @doc("Number of elements to return when retrieving results.")
      @maxValue(100)
      @minValue(1)
      @query("$top")
      $top?: int32;

      @doc("OData Select statement. Limits the properties on each entry to just those requested, e.g. ?$select=reportName,id.")
      @minLength(1)
      @query("$select")
      $select?: string;

      @doc("The tenant id of the report creator.")
      @minLength(1)
      @query("reportCreatorTenantId")
      reportCreatorTenantId?: string;

      @doc("The offerGuid which mapping to the reports.")
      @minLength(1)
      @query("offerGuid")
      offerGuid?: string;
    }
  >;
}
