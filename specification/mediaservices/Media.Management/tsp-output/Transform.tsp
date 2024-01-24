import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MediaService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Media;
/**
 * A Transform encapsulates the rules or instructions for generating desired outputs from input media, such as by transcoding or by extracting insights. After the Transform is created, it can be applied to input media by creating Jobs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(MediaService)
@Azure.ResourceManager.Private.armResourceInternal(TransformProperties)
@includeInapplicableMetadataInPayload(false)
model Transform extends ProxyResourceBase {
  /**
   * The Transform name.
   */
  @path
  @key("transformName")
  @segment("transforms")
  name: string;

  /**
   * The resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: TransformProperties;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Transform, Transform>;

  /**
   * Deletes a Transform.
   */
  delete is ArmResourceDeleteSync<Transform>;

  /**
   * Lists the Transforms in the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Transforms_List")
  list is ArmResourceListByParent<
    Transform,
    {
      ...BaseParameters<Transform>;

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
    }
  >;
}

@@projectedName(Transforms.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Transforms.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Transforms.createOrUpdate::parameters.resource, "The request parameters");
@@projectedName(Transforms.update::parameters.properties, "json", "parameters");
@@extension(Transforms.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Transforms.update::parameters.properties, "The request parameters");
