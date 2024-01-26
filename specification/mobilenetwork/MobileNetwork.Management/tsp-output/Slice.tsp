import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
/**
 * Network slice resource. Must be created in the same location as its parent mobile network.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MobileNetwork)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SlicePropertiesFormat)
model Slice extends TrackedResourceBase {
  /**
   * The name of the network slice.
   */
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("sliceName")
  @segment("slices")
  @visibility("read")
  name: string;

  /**
   * Slice properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: SlicePropertiesFormat;
}

@armResourceOperations
interface Slices {
  /**
   * Gets information about the specified network slice.
   */
  get is ArmResourceRead<Slice>;

  /**
   * Creates or updates a network slice. Must be created in the same location as its parent mobile network.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Slice,
    BaseParameters<Slice>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates slice tags.
   */
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<Slice, TagsObject>;

  /**
   * Deletes the specified network slice.
   */
  delete is ArmResourceDeleteAsync<
    Slice,
    BaseParameters<Slice>,
    ArmLroLocationHeader
  >;

  /**
   * Lists all slices in the mobile network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Slices_ListByMobileNetwork")
  listByMobileNetwork is ArmResourceListByParent<Slice>;
}

@@projectedName(Slices.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Slices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Slices.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update network slice operation."
);
@@projectedName(Slices.updateTags::parameters.properties, "json", "parameters");
@@extension(Slices.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Slices.updateTags::parameters.properties,
  "Parameters supplied to update network slice tags."
);
