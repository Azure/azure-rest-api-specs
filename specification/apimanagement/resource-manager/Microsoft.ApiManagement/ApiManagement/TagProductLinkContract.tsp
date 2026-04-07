import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./TagContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Tag-product link details.
 */
@parentResource(TagContract)
model TagProductLinkContract
  is Azure.ResourceManager.ProxyResource<TagProductLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = TagProductLinkContract,
    KeyName = "productLinkId",
    SegmentName = "productLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface TagProductLinkContractOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      },
      {
        /** Tag-product link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("productLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        productLinkId: string,
      }
    > {}

@armResourceOperations
interface TagProductLinkContracts {
  /**
   * Gets the product link for the tag.
   */
  get is TagProductLinkContractOps.Read<
    TagProductLinkContract,
    Response = ArmResponse<TagProductLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds a product to the specified tag via link.
   */
  createOrUpdate is TagProductLinkContractOps.CreateOrUpdateSync<TagProductLinkContract>;

  /**
   * Deletes the specified product from the specified tag.
   */
  delete is TagProductLinkContractOps.DeleteSync<TagProductLinkContract>;

  /**
   * Lists a collection of the product links associated with a tag.
   */
  listByProduct is TagProductLinkContractOps.List<
    TagProductLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| productId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagProductLinkCollection>
  >;
}
@armResourceOperations
interface WorkspaceTagProductLinkOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the API Management service. */
        @path
        @segment("service")
        @key
        @pattern("^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$")
        @minLength(1)
        @maxLength(50)
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        workspaceId: string,

        /** Tag identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("tags")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagId: string,
      },
      {
        /** Tag-product link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("productLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        productLinkId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceTagProductLink {
  /**
   * Gets the product link for the tag.
   */
  get is WorkspaceTagProductLinkOps.Read<
    TagProductLinkContract,
    Response = ArmResponse<TagProductLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds a product to the specified tag via link.
   */
  createOrUpdate is WorkspaceTagProductLinkOps.CreateOrUpdateSync<TagProductLinkContract>;

  /**
   * Deletes the specified product from the specified tag.
   */
  delete is WorkspaceTagProductLinkOps.DeleteSync<TagProductLinkContract>;

  /**
   * Lists a collection of the product links associated with a tag.
   */
  listByProduct is WorkspaceTagProductLinkOps.List<
    TagProductLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| productId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of records to return.
       */
      @minValue(1)
      @query("$top")
      $top?: int32;

      /**
       * Number of records to skip.
       */
      @minValue(0)
      @query("$skip")
      $skip?: int32;
    },
    Response = ArmResponse<TagProductLinkCollection>
  >;
}

@@maxLength(TagProductLinkContract.name, 80);
@@minLength(TagProductLinkContract.name, 1);
@@doc(TagProductLinkContract.name,
  "Tag-product link identifier. Must be unique in the current API Management service instance."
);
@@doc(TagProductLinkContract.properties,
  "Tag-API link entity contract properties."
);
@@doc(TagProductLinkContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceTagProductLink.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
