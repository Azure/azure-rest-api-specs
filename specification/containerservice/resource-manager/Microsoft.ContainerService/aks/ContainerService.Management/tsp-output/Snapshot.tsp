import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ContainerService;
/**
 * A node pool snapshot resource.
 */
model Snapshot is TrackedResource<SnapshotProperties> {
  /**
   * The name of the managed cluster resource.
   */
  @maxLength(63)
  @minLength(1)
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  @path
  @key("resourceName")
  @segment("snapshots")
  name: string;
}

@armResourceOperations
interface Snapshots {
  /**
   * Gets a snapshot.
   */
  get is ArmResourceRead<Snapshot>;

  /**
   * Creates or updates a snapshot.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Snapshot>;

  /**
   * Updates tags on a snapshot.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<Snapshot, TagsObject>;

  /**
   * Deletes a snapshot.
   */
  delete is ArmResourceDeleteSync<Snapshot>;

  /**
   * Lists snapshots in the specified subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Snapshots_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Snapshot>;

  /**
   * Gets a list of snapshots in the specified subscription.
   */
  list is ArmListBySubscription<Snapshot>;
}

@@projectedName(Snapshots.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Snapshots.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Snapshots.createOrUpdate::parameters.resource,
  "The snapshot to create or update."
);
@@projectedName(Snapshots.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(Snapshots.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Snapshots.updateTags::parameters.properties,
  "Parameters supplied to the Update snapshot Tags operation."
);
