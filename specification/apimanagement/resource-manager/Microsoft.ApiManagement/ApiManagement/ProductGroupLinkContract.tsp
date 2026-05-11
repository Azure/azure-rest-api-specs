import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProductContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Product-group link details.
 */
@parentResource(ProductContract)
model ProductGroupLinkContract
  is Azure.ResourceManager.ProxyResource<ProductGroupLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = ProductGroupLinkContract,
    KeyName = "groupLinkId",
    SegmentName = "groupLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface ProductGroupLinkContractOps
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

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        @minLength(1)
        @maxLength(256)
        productId: string,
      },
      {
        /** Product-Group link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("groupLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        groupLinkId: string,
      }
    > {}

@armResourceOperations
interface ProductGroupLinkContracts {
  /**
   * Gets the group link for the product.
   */
  get is ProductGroupLinkContractOps.Read<
    ProductGroupLinkContract,
    Response = ArmResponse<ProductGroupLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds a group to the specified product via link.
   */
  createOrUpdate is ProductGroupLinkContractOps.CreateOrUpdateSync<ProductGroupLinkContract>;

  /**
   * Deletes the specified group from the specified product.
   */
  delete is ProductGroupLinkContractOps.DeleteSync<ProductGroupLinkContract>;

  /**
   * Lists a collection of the group links associated with a product.
   */
  listByProduct is ProductGroupLinkContractOps.List<
    ProductGroupLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| groupId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<ProductGroupLinkCollection>
  >;
}
@armResourceOperations
interface WorkspaceProductGroupLinkOps
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

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        @minLength(1)
        @maxLength(256)
        productId: string,
      },
      {
        /** Product-Group link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("groupLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        groupLinkId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceProductGroupLink {
  /**
   * Gets the group link for the product.
   */
  get is WorkspaceProductGroupLinkOps.Read<
    ProductGroupLinkContract,
    Response = ArmResponse<ProductGroupLinkContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Adds a group to the specified product via link.
   */
  createOrUpdate is WorkspaceProductGroupLinkOps.CreateOrUpdateSync<ProductGroupLinkContract>;

  /**
   * Deletes the specified group from the specified product.
   */
  delete is WorkspaceProductGroupLinkOps.DeleteSync<ProductGroupLinkContract>;

  /**
   * Lists a collection of the group links associated with a product.
   */
  listByProduct is WorkspaceProductGroupLinkOps.List<
    ProductGroupLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| groupId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<ProductGroupLinkCollection>
  >;
}

@@maxLength(ProductGroupLinkContract.name, 80);
@@minLength(ProductGroupLinkContract.name, 1);
@@doc(ProductGroupLinkContract.name,
  "Product-Group link identifier. Must be unique in the current API Management service instance."
);
@@doc(ProductGroupLinkContract.properties,
  "Product-group link entity contract properties."
);
@@doc(ProductGroupLinkContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceProductGroupLink.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
