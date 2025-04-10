import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Transform encapsulates the rules or instructions for generating desired outputs from input media, such as by transcoding or by extracting insights. After the Transform is created, it can be applied to input media by creating Jobs.
 */
model Transform is Azure.ResourceManager.ProxyResource<TransformProperties> {
  ...ResourceNameParameter<
    Resource = Transform,
    KeyName = "transformName",
    SegmentName = "transforms",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Transforms {
  /**
   * Gets a Transform.
   */
  get is ArmResourceRead<Transform>;

  /**
   * Creates or updates a new Transform.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Transform>;

  /**
   * Updates a Transform.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Transform, PatchModel = Transform>;

  /**
   * Deletes a Transform.
   */
  delete is ArmResourceDeleteSync<Transform>;

  /**
   * Lists the Transforms in the account.
   */
  list is ArmResourceListByParent<
    Transform,
    Parameters = {
      /**
       * Restricts the set of items returned.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Specifies the key by which the result collection should be ordered.
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<TransformCollection>
  >;
}

@@doc(Transform.name, "The Transform name.");
@@doc(Transform.properties, "The resource properties.");
@@doc(Transforms.createOrUpdate::parameters.resource, "The request parameters");
@@doc(Transforms.update::parameters.properties, "The request parameters");
