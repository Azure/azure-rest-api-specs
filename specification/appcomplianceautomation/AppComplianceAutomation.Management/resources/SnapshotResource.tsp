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
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Azure specs should not be using decorator"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Referencing elements inside Private namespace"
@parentResource(ReportResource)
@Http.Private.includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
model SnapshotResource extends Foundations.ProxyResource {
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
   * Snapshot's property'.
   */
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flattening"
  @Azure.ClientGenerator.Core.Legacy.flattenProperty
  @extension("x-ms-client-name", "properties")
  properties?: SnapshotProperties;
}

@armResourceOperations
@tag("AppComplianceAutomation")
interface SnapshotResources {
  /**
   * Get the AppComplianceAutomation snapshot and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Snapshots_Get")
  get is ArmResourceRead<SnapshotResource>;

  /**
   * Get the AppComplianceAutomation snapshot list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Snapshots_List")
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "For backward compatibility"
  @operationId("Snapshots_Download")
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
