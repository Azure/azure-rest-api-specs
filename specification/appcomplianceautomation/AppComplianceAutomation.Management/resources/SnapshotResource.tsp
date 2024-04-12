import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent a AppComplianceAutomation snapshot resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ReportResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
model SnapshotResource extends ProxyResourceBase {
  /**
   * Snapshot Name.
   */
  @path
  @key("snapshotName")
  @segment("snapshots")
  @visibility("read")
  name: string;

  /**
   * Snapshot's property'.
   */
  @extension("x-ms-client-flatten", true)
  @extension("x-ms-client-name", "properties")
  properties?: SnapshotProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface SnapshotResources {
  /**
   * Get the AppComplianceAutomation snapshot and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshots_Get")
  @Autorest.example("./examples/Snapshot_Get.json", "Snapshots_Get")
  get is ArmResourceRead<SnapshotResource>;

  /**
   * Get the AppComplianceAutomation snapshot list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshots_List")
  @Autorest.example("./examples/Snapshots_List.json", "Snapshots_List")
  list is ArmResourceListByParent<
    SnapshotResource,
    {
      ...BaseParameters<SnapshotResource>;
      ...QueryParameters;
    }
  >;

  /**
   * Download compliance needs from snapshot, like: Compliance Report, Resource List.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshots_Download")
  @Autorest.example(
    "./examples/Snapshot_ComplianceReport_Download.json",
    "Snapshot_Download_ComplianceReport"
  )
  @Autorest.example(
    "./examples/Snapshot_CompliancePdfReport_Download.json",
    "Snapshot_Download_CompliancePdfReport"
  )
  @Autorest.example(
    "./examples/Snapshot_ComplianceDetailedPdfReport_Download.json",
    "Snapshot_Download_ComplianceDetailedPdfReport"
  )
  @Autorest.example(
    "./examples/Snapshot_ResourceList_Download.json",
    "Snapshot_Download_ResourceList"
  )
  download is ArmResourceActionAsync<
    SnapshotResource,
    SnapshotDownloadRequest,
    DownloadResponse,
    BaseParameters<SnapshotResource>
  >;
}

@@doc(SnapshotResources.download::parameters.body,
  "Parameters for the query operation"
);
