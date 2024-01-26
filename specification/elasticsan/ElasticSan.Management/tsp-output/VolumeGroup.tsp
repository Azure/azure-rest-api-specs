import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ElasticSan.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ElasticSan;
/**
 * Response for Volume Group request.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ElasticSan)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(VolumeGroupProperties)
model VolumeGroup extends ProxyResourceBase {
  /**
   * The name of the VolumeGroup.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[A-Za-z0-9]+((-|_)[a-z0-9A-Z]+)*$")
  @path
  @key("volumeGroupName")
  @segment("volumegroups")
  @visibility("read")
  name: string;

  /**
   * Properties of VolumeGroup.
   */
  @extension("x-ms-client-flatten", true)
  properties?: VolumeGroupProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface VolumeGroups {
  /**
   * Get an VolumeGroups.
   */
  get is ArmResourceRead<VolumeGroup>;

  /**
   * Create a Volume Group.
   */
  create is ArmResourceCreateOrReplaceAsync<
    VolumeGroup,
    BaseParameters<VolumeGroup>,
    ArmLroLocationHeader
  >;

  /**
   * Update an VolumeGroup.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VolumeGroup,
    VolumeGroupUpdate,
    BaseParameters<VolumeGroup>,
    ArmLroLocationHeader
  >;

  /**
   * Delete an VolumeGroup.
   */
  delete is ArmResourceDeleteAsync<
    VolumeGroup,
    BaseParameters<VolumeGroup>,
    ArmLroLocationHeader
  >;

  /**
   * List VolumeGroups.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeGroups_ListByElasticSan")
  listByElasticSan is ArmResourceListByParent<VolumeGroup>;
}

@@projectedName(VolumeGroups.create::parameters.resource, "json", "parameters");
@@extension(VolumeGroups.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(VolumeGroups.create::parameters.resource, "Volume Group object.");
@@projectedName(VolumeGroups.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(VolumeGroups.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(VolumeGroups.update::parameters.properties, "Volume Group object.");
