import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "../models/models.tsp";
import "./ReportResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.AppComplianceAutomation;
/**
 * A class represent a AppComplianceAutomation snapshot resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Legacy DO NOT EVER COPY THIS"
@parentResource(ReportResource)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
model SnapshotResource extends Azure.ResourceManager.Foundations.ProxyResource {
  /**
   * Snapshot Name.
   */
  @path
  @key("snapshotName")
  @segment("snapshots")
  @visibility(Lifecycle.Read)
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
  get is ArmResourceRead<SnapshotResource>;

  /**
   * Get the AppComplianceAutomation snapshot list.
   */
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
  download is ArmResourceActionAsync<
    SnapshotResource,
    SnapshotDownloadRequest,
    DownloadResponse,
    Azure.ResourceManager.Foundations.BaseParameters<SnapshotResource>,
    BodyParameter = {
      @doc("Parameters for the query operation")
      @bodyRoot
      body: SnapshotDownloadRequest;
    }
  >;
}
