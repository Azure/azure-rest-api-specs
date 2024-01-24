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
/**
 * A class represent a AppComplianceAutomation snapshot resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ReportResource)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
@includeInapplicableMetadataInPayload(false)
model SnapshotResource extends ProxyResourceBase {
  /**
   * Snapshot Name.
   */
  @path
  @key("snapshotName")
  @segment("snapshots")
  name: string;

  /**
   * Snapshot's property'.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SnapshotProperties;
}

@armResourceOperations
interface SnapshotResources {
  /**
   * Get the AppComplianceAutomation snapshot and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshot_Get")
  get is ArmResourceRead<SnapshotResource>;

  /**
   * Get the AppComplianceAutomation snapshot list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshots_List")
  list is ArmResourceListByParent<
    SnapshotResource,
    {
      ...BaseParameters<SnapshotResource>;

      /**
       * Skip over when retrieving results.
       */
      @query("$skipToken")
      $skipToken?: string;

      /**
       * Number of elements to return when retrieving results.
       */
      @maxValue(100)
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * OData Select statement. Limits the properties on each entry to just those requested, e.g. ?$select=reportName,id.
       */
      @minLength(1)
      @query("$select")
      $select?: string;

      /**
       * The tenant id of the report creator.
       */
      @minLength(1)
      @query("reportCreatorTenantId")
      reportCreatorTenantId?: string;

      /**
       * The offerGuid which mapping to the reports.
       */
      @minLength(1)
      @query("offerGuid")
      offerGuid?: string;
    }
  >;

  /**
   * Download compliance needs from snapshot, like: Compliance Report, Resource List.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
