import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.ResourceManager.Private;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@doc("Response for Volume Snapshot request.")
@parentResource(VolumeGroup)
@armResourceInternal(SnapshotProperties)
@includeInapplicableMetadataInPayload(false)
model Snapshot extends ProxyResourceBase {
  @doc("The name of the volume snapshot within the given volume group.")
  @maxLength(80)
  @minLength(1)
  @pattern("^[a-z0-9]+(?:[._-][a-z0-9]+)*$")
  @path
  @key("snapshotName")
  @segment("snapshots")
  name: string;

  @doc("Properties of Volume Snapshot.")
  @extension("x-ms-client-flatten", true)
  properties: SnapshotProperties;
}

@armResourceOperations
interface Snapshots {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Volume Snapshot.")
  @operationId("VolumeSnapshots_Get")
  get is ArmResourceRead<Snapshot>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a Volume Snapshot.")
  @operationId("VolumeSnapshots_Create")
  create is ArmResourceCreateOrUpdateAsync<
    Snapshot,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete a Volume Snapshot.")
  @operationId("VolumeSnapshots_Delete")
  delete is ArmResourceDeleteAsync<
    Snapshot,
    BaseParameters<Snapshot>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List Snapshots in a VolumeGroup or List Snapshots by Volume (name) in a VolumeGroup using filter")
  @operationId("VolumeSnapshots_ListByVolumeGroup")
  listByVolumeGroup is ArmResourceListByParent<
    Snapshot,
    {
      ...BaseParameters<Snapshot>;

      @doc("Specify $filter='volumeName eq <volume name>' to filter on volume.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@@projectedName(Snapshots.create::parameters.resource, "json", "parameters");
@@extension(Snapshots.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Snapshots.create::parameters.resource, "Snapshot object.");
