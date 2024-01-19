import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppComplianceAutomation;
@doc("A class represent a AppComplianceAutomation snapshot resource.")
@parentResource(ReportResource)
model SnapshotResource is ProxyResource<SnapshotProperties> {
  @doc("Snapshot Name.")
  @path
  @key("snapshotName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
interface SnapshotResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the AppComplianceAutomation snapshot and its properties.")
  @operationId("Snapshot_Get")
  get is ArmResourceRead<SnapshotResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the AppComplianceAutomation snapshot list.")
  @operationId("Snapshots_List")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Download compliance needs from snapshot, like: Compliance Report, Resource List.")
  @operationId("Snapshot_Download")
  download is ArmResourceActionAsync<
    SnapshotResource,
    SnapshotDownloadRequest,
    DownloadResponse,
    BaseParameters<SnapshotResource>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SnapshotResources.download::parameters.body,
  "json",
  "parameters"
);
@@extension(SnapshotResources.download::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(SnapshotResources.download::parameters.body,
  "Parameters for the query operation"
);
