import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.DevTestLab;
/**
 * A custom image.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model CustomImage extends Resource {
  @visibility(Lifecycle.Read)
  @path
  @key
  @segment("customimages")
  name: string;

  properties: CustomImageProperties;
}

@armResourceOperations
interface CustomImageOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = CustomImage,
        KeyName = "name",
        SegmentName = "customimages",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface CustomImages {
  /**
   * Get custom image.
   */
  get is CustomImageOps.Read<
    CustomImage,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=vm)'
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Create or replace an existing custom image. This operation can take a while to complete.
   */
  createOrUpdate is CustomImageOps.CreateOrUpdateAsync<
    CustomImage,
    LroHeaders = ArmLroLocationHeader<FinalResult = CustomImage> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Allows modifying tags of custom images. All other properties will be ignored.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "CustomImageFragment contains tags as expected by the patch operation."
  @patch(#{ implicitOptionality: false })
  update is CustomImageOps.CustomPatchSync<
    CustomImage,
    PatchModel = CustomImageFragment
  >;

  /**
   * Delete custom image. This operation can take a while to complete.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is CustomImageOps.DeleteWithoutOkAsync<
    CustomImage,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List custom images in a given lab.
   */
  list is CustomImageOps.List<
    CustomImage,
    Parameters = {
      /**
       * Specify the $expand query. Example: 'properties($select=vm)'
       */
      @query("$expand")
      $expand?: string;

      /**
       * The filter to apply to the operation. Example: '$filter=contains(name,'myName')
       */
      @query("$filter")
      $filter?: string;

      /**
       * The maximum number of resources to return from the operation. Example: '$top=10'
       */
      @query("$top")
      $top?: int32;

      /**
       * The ordering expression for the results, using OData notation. Example: '$orderby=name desc'
       */
      @query("$orderby")
      $orderby?: string;
    },
    Response = ArmResponse<CustomImageList>
  >;
}

@@doc(CustomImage.name, "The name of the custom image.");
@@doc(CustomImage.properties, "The properties of the resource.");
@@doc(CustomImages.createOrUpdate::parameters.resource, "A custom image.");
@@doc(CustomImages.update::parameters.properties, "A custom image.");
