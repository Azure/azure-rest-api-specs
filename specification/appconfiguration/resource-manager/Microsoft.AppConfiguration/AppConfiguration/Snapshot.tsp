import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
/**
 * The snapshot resource.
 */
@parentResource(ConfigurationStore)
model Snapshot is Azure.ResourceManager.ProxyResource<SnapshotProperties> {
  ...ResourceNameParameter<
    Resource = Snapshot,
    KeyName = "snapshotName",
    SegmentName = "snapshots",
    NamePattern = "^[^\\x00-\\x1F\\x7F]+$"
  >;
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
@@doc(Snapshots.create::parameters.resource,
  "The parameters for creating a snapshot."
);
