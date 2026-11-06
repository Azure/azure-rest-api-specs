import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using Azure.ResourceManager;
using TypeSpec.Rest;
using Versioning;

namespace Microsoft.AppConfiguration;

@@visibility(Snapshot.name, Lifecycle.Read);

/**
 * The snapshot resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Preserve the existing snapshot resource and payload contract while replacing legacy resource registration."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Preserve the existing proxy resource inheritance and emitted snapshot schema across all API versions."
@parentResource(ConfigurationStore)
@Azure.ResourceManager.Private.armResourceInternal(SnapshotProperties)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
model Snapshot extends Azure.ResourceManager.Foundations.ProxyResource {
  ...ResourceNameParameter<
    Resource = Snapshot,
    KeyName = "snapshotName",
    SegmentName = "snapshots",
    NamePattern = "^[^\\x00-\\x1F\\x7F]+$"
  >;

  @madeRequired(Versions.v2025_08_01_preview)
  properties: SnapshotProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Resource 'Snapshot' must have a delete operation."
@armResourceOperations
interface Snapshots {
  /**
   * Gets the properties of the specified snapshot. NOTE: This operation is intended for use in ARM Template deployments. For all other scenarios involving App Configuration snapshots the data plane API should be used instead.
   */
  get is ArmResourceRead<Snapshot>;

  /**
   * Creates a snapshot. NOTE: This operation is intended for use in ARM Template deployments. For all other scenarios involving App Configuration snapshots the data plane API should be used instead.
   */
  create is ArmResourceCreateOrReplaceAsync<Snapshot>;
}

@@doc(Snapshot.name, "The name of the snapshot.");
@@doc(Snapshot.properties, "All snapshot properties.");
@@doc(
  Snapshots.create::parameters.resource,
  "The parameters for creating a snapshot."
);
