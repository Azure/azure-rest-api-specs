import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.Compute;
/**
 * Specifies information about the Shared Image Gallery that you want to create or update.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" ""
@extension("x-ms-azure-resource", false)
model Gallery is Azure.ResourceManager.TrackedResource<GalleryProperties> {
  ...ResourceNameParameter<
    Resource = Gallery,
    KeyName = "galleryName",
    SegmentName = "galleries",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Galleries {
  /**
   * Retrieves information about a Shared Image Gallery.
   */
  get is ArmResourceRead<
    Gallery,
    Parameters = {
      /**
       * The select expression to apply on the operation.
       */
      @query("$select")
      $select?: SelectPermissions;

      /**
       * The expand query option to apply on the operation.
       */
      @query("$expand")
      $expand?: GalleryExpandParams;
    }
  >;

  /**
   * Create or update a Shared Image Gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Gallery,
    Response = ArmResourceCreatedResponse<Gallery> | ArmResourceUpdatedResponse<Gallery> | (ArmAcceptedLroResponse & {
      @bodyRoot _: Gallery;
    })
  >;

  /**
   * Update a Shared Image Gallery.
   */
  @parameterVisibility
  update is ArmCustomPatchAsync<Gallery, GalleryUpdate>;

  /**
   * Delete a Shared Image Gallery.
   */
  #suppress "deprecated" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-response-body" "For backward compatibility"
  delete is ArmResourceDeleteAsync<Gallery>;

  /**
   * List galleries under a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Gallery,
    Response = GalleryList
  >;

  /**
   * List galleries under a subscription.
   */
  list is ArmListBySubscription<Gallery, Response = GalleryList>;

  /**
   * Update sharing profile of a gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GallerySharingProfile_Update")
  share is ArmResourceActionAsync<
    Gallery,
    SharingUpdate,
    SharingUpdate,
    LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader & {
        @bodyRoot _: SharingUpdate;
      }
  >;
}

@@doc(Gallery.name, "The name of the Shared Image Gallery.");
@@doc(Gallery.properties,
  "Describes the properties of a Shared Image Gallery."
);
@@doc(Galleries.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update Shared Image Gallery operation."
);
@@doc(Galleries.update::parameters.properties,
  "Parameters supplied to the update Shared Image Gallery operation."
);
@@doc(Galleries.share::parameters.body,
  "Parameters supplied to the update gallery sharing profile."
);
@@clientName(Galleries.share::parameters.body, "sharingUpdate");
@@clientName(Galleries.update::parameters.properties, "gallery");
@@clientName(Galleries.createOrUpdate::parameters.resource, "gallery");
