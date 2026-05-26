import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Compute;
/**
 * Specifies information about the Shared Image Gallery that you want to create or update.
 */
model Gallery is Azure.ResourceManager.TrackedResource<GalleryProperties> {
  ...ResourceNameParameter<
    Resource = Gallery,
    KeyName = "galleryName",
    SegmentName = "galleries",
    NamePattern = ""
  >;

  /**
   * The identity of the gallery, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: GalleryIdentity;
}

@armResourceOperations
interface Galleries {
  /**
   * Retrieves information about a Shared Image Gallery.
   */
  get is ComputeResourceRead<
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
  createOrUpdate is ComputeResourceCreateOrReplaceAsync<
    Gallery,
    Response = ArmResourceUpdatedResponse<Gallery> | ArmResourceCreatedResponse<
      Gallery,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Gallery;
    })
  >;

  /**
   * Update a Shared Image Gallery.
   */
  @patch(#{ implicitOptionality: false })
  update is ComputeCustomPatchAsync<
    Gallery,
    PatchModel = GalleryUpdate,
    Response = ArmResponse<Gallery> &
      ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Shared Image Gallery.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ComputeResourceDeleteAsync<
    Gallery,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List galleries under a resource group.
   */
  listByResourceGroup is ComputeResourceListByParent<
    Gallery,
    Response = ArmResponse<GalleryList>
  >;

  /**
   * List galleries under a subscription.
   */
  list is ComputeListBySubscription<
    Gallery,
    Response = ArmResponse<GalleryList>
  >;

  /**
   * List soft-deleted resources of an artifact in the gallery, such as soft-deleted gallery image version of an image.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
  @get
  @action("versions")
  @list
  @operationId("SoftDeletedResource_ListByArtifactName")
  listByArtifactName is ComputeResourceActionSync<
    Gallery,
    void,
    ArmResponse<GallerySoftDeletedResourceList>,
    Parameters = {
      /**
       * The type of the artifact to be listed, such as gallery image version.
       */
      @pattern("^[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*$")
      @path
      @segment("softdeletedartifacttypes")
      artifactType: string;

      /**
       * The artifact name to be listed. If artifact type is Images, then the artifact name should be the gallery image name.
       */
      @pattern("^[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*$")
      @path
      @segment("artifacts")
      artifactName: string;
    }
  >;

  /**
   * Update sharing profile of a gallery.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body"
  @action("share")
  @operationId("GallerySharingProfile_Update")
  gallerySharingProfileUpdate is ComputeResourceActionAsyncBase<
    Gallery,
    SharingUpdate,
    ArmResponse<SharingUpdate> | (ArmAcceptedLroResponse<
      "Resource operation accepted.",
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > & {
      @bodyRoot _: SharingUpdate;
    })
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
@@doc(Galleries.gallerySharingProfileUpdate::parameters.body,
  "Parameters supplied to the update gallery sharing profile."
);

/**
 * Permanently delete a soft-deleted artifact version in the gallery.
 */
#suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
@added(Versions.v2026_03_03)
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Compute/galleries/{galleryName}/softdeletedartifacttypes/{artifactType}/artifacts/{artifactName}/versions/{artifactVersionName}")
@delete
@operationId("SoftDeletedResource_Delete")
@tag("Galleries")
op deleteSoftDeletedArtifactVersion(
  /**
   * The ID of the target subscription.
   */
  @path subscriptionId: string,

  /**
   * The name of the resource group.
   */
  @path resourceGroupName: string,

  /**
   * The name of the Shared Image Gallery.
   */
  @path
  @pattern("^[^_\\W][\\w-._]{0,79}(?<![-.])$")
  galleryName: string,

  /**
   * The type of the soft-deleted artifact, such as Images.
   */
  @path
  @pattern("^[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*$")
  artifactType: string,

  /**
   * The name of the soft-deleted artifact. If artifact type is Images, then this should be the gallery image name.
   */
  @path
  @pattern("^[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*$")
  artifactName: string,

  /**
   * The version name of the soft-deleted artifact to be permanently deleted.
   */
  @path
  @pattern("^[a-zA-Z0-9]+([_]?[a-zA-Z0-9]+)*$")
  artifactVersionName: string,

  /**
   * The API version to use for this operation.
   */
  @query("api-version") apiVersion: string,
): ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse;
