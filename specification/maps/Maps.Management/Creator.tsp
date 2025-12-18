import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MapsAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;
/**
 * An Azure resource which represents Maps Creator product and provides ability to manage private location data.
 */
@parentResource(MapsAccount)
model Creator
  is Azure.ResourceManager.TrackedResource<CreatorProperties, false> {
  ...ResourceNameParameter<
    Resource = Creator,
    KeyName = "creatorName",
    SegmentName = "creators",
    NamePattern = "^[^%&:\\\\/#?]+$"
  >;
}

@armResourceOperations
interface Creators {
  /**
   * Get a Maps Creator resource.
   */
  get is ArmResourceRead<Creator>;

  /**
   * Create or update a Maps Creator resource. Creator resource will manage Azure resources required to populate a custom set of mapping data. It requires an account to exist before it can be created.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Creator>;

  /**
   * Updates the Maps Creator resource. Only a subset of the parameters may be updated after creation, such as Tags.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Creator, PatchModel = CreatorUpdateParameters>;

  /**
   * Delete a Maps Creator resource.
   */
  delete is ArmResourceDeleteSync<Creator>;

  /**
   * Get all Creator instances for an Azure Maps Account
   */
  listByAccount is ArmResourceListByParent<
    Creator,
    Response = ArmResponse<CreatorList>
  >;
}

@@minLength(Creator.name, 1);
@@doc(Creator.name, "The name of the Maps Creator instance.");
@@doc(Creator.properties, "The Creator resource properties.");
@@doc(Creators.createOrUpdate::parameters.resource,
  "The new or updated parameters for the Creator resource."
);
@@doc(Creators.update::parameters.properties,
  "The update parameters for Maps Creator."
);
