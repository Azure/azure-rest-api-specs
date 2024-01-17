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
@doc("Response for Volume request.")
@parentResource(VolumeGroup)
@armResourceInternal(VolumeProperties)
@includeInapplicableMetadataInPayload(false)
model Volume extends ProxyResourceBase {
  @doc("The name of the Volume.")
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9A-Z]+)*$")
  @path
  @key("volumeName")
  @segment("volumes")
  name: string;

  @doc("Properties of Volume.")
  @extension("x-ms-client-flatten", true)
  properties: VolumeProperties;
}

@armResourceOperations
interface Volumes {
  @doc("Get an Volume.")
  get is ArmResourceRead<Volume>;

  @doc("Create a Volume.")
  create is Template.ArmResourceCreateOrUpdateAsync<
    Volume,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  @doc("Update an Volume.")
  update is ArmCustomPatchAsync<
    Volume,
    VolumeUpdate,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  @doc("Delete an Volume.")
  delete is ArmResourceDeleteAsync<
    Volume,
    {
      ...BaseParameters<Volume>;

      @doc("Optional, used to delete snapshots under volume. Allowed value are only true or false. Default value is false.")
      @header
      `x-ms-delete-snapshots`?: XMsDeleteSnapshots;

      @doc("Optional, used to delete volume if active sessions present. Allowed value are only true or false. Default value is false.")
      @header
      `x-ms-force-delete`?: XMsForceDelete;
    },
    ArmLroLocationHeader
  >;

  @doc("List Volumes in a VolumeGroup.")
  listByVolumeGroup is ArmResourceListByParent<Volume>;
}

@@doc(Volumes.create::parameters.parameters, "Volume object.");
@@projectedName(Volumes.update::parameters.properties, "json", "parameters");
@@extension(Volumes.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Volumes.update::parameters.properties, "Volume object.");
