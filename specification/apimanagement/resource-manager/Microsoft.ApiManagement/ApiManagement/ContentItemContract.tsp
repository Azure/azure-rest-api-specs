import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContentTypeContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Content type contract details.
 */
@parentResource(ContentTypeContract)
model ContentItemContract
  is Azure.ResourceManager.ProxyResource<Record<unknown>> {
  ...ResourceNameParameter<
    Resource = ContentItemContract,
    KeyName = "contentItemId",
    SegmentName = "contentItems",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ContentItemContracts {
  /**
   * Returns the developer portal's content item specified by its identifier.
   */
  get is ArmResourceRead<
    ContentItemContract,
    Response = ArmResponse<ContentItemContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Returns the entity state (ETag) version of the developer portal's content item specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    ContentItemContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new developer portal's content item specified by the provided content type.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ContentItemContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<ContentItemContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<ContentItemContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Removes the specified developer portal's content item.
   */
  delete is ArmResourceDeleteSync<
    ContentItemContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    }
  >;

  /**
   * Lists developer portal's content items specified by the provided content type.
   */
  listByService is ArmResourceListByParent<
    ContentItemContract,
    Response = ArmResponse<ContentItemCollection>
  >;
}

@@maxLength(ContentItemContract.name, 80);
@@minLength(ContentItemContract.name, 1);
@@doc(ContentItemContract.name, "Content item identifier.");
@@doc(ContentItemContract.properties, "Properties of the content item.");
@@doc(ContentItemContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
