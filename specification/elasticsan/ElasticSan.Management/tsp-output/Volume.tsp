import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./VolumeGroup.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
/**
 * Response for Volume request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(VolumeGroup)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VolumeProperties)
model Volume extends ProxyResourceBase {
  /**
   * The name of the Volume.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[a-z0-9]+(-[a-z0-9A-Z]+)*$")
  @path
  @key("volumeName")
  @segment("volumes")
  @visibility("read")
  name: string;

  /**
   * Properties of Volume.
   */
  @extension("x-ms-client-flatten", true)
  properties: VolumeProperties;
}

@armResourceOperations
interface Volumes {
  /**
   * Get an Volume.
   */
  get is ArmResourceRead<Volume>;

  /**
   * Create a Volume.
   */
  create is ArmResourceCreateOrReplaceAsync<
    Volume,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Update an Volume.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Volume,
    VolumeUpdate,
    BaseParameters<Volume>,
    ArmLroLocationHeader
  >;

  /**
   * Delete an Volume.
   */
  delete is ArmResourceDeleteAsync<
    Volume,
    {
      ...BaseParameters<Volume>;

      /**
       * Optional, used to delete snapshots under volume. Allowed value are only true or false. Default value is false.
       */
      @header
      `x-ms-delete-snapshots`?: XMsDeleteSnapshots;

      /**
       * Optional, used to delete volume if active sessions present. Allowed value are only true or false. Default value is false.
       */
      @header
      `x-ms-force-delete`?: XMsForceDelete;
    },
    ArmLroLocationHeader
  >;

  /**
   * List Volumes in a VolumeGroup.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Volumes_ListByVolumeGroup")
  listByVolumeGroup is ArmResourceListByParent<Volume>;
}

@@projectedName(Volumes.create::parameters.resource, "json", "parameters");
@@extension(Volumes.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Volumes.create::parameters.resource, "Volume object.");
@@projectedName(Volumes.update::parameters.properties, "json", "parameters");
@@extension(Volumes.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Volumes.update::parameters.properties, "Volume object.");
