import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent a AppComplianceAutomation snapshot resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
@parentResource(ReportResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
model SnapshotResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Snapshot Name.
   */
  @path
  @key("snapshotName")
  @segment("snapshots")
  @visibility("read")
  @pattern("^[a-zA-Z0-9-_]{1,64}$")
  name: string;

  /**
   * Snapshot's property.
   */
  #suppress "deprecated" "Legacy flatten"
  @Azure.ClientGenerator.Core.flattenProperty
  properties?: SnapshotProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface Snapshot {
  /**
   * Get the AppComplianceAutomation snapshot and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Snapshot_Get")
  get is ArmResourceRead<SnapshotResource>;

  /**
   * Get the AppComplianceAutomation snapshot list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Snapshot_List")
  list is ArmResourceListByParent<
    SnapshotResource,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<SnapshotResource>;
      ...QueryParameters;
    }
  >;

  /**
   * Download compliance needs from snapshot, like: Compliance Report, Resource List.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Snapshot_Download")
  download is ArmResourceActionAsync<
    SnapshotResource,
    SnapshotDownloadRequest,
    DownloadResponse,
    Azure.ResourceManager.Foundations.BaseParameters<SnapshotResource>
  >;
}

@@doc(Snapshot.download::parameters.body, "Parameters for the query operation");
