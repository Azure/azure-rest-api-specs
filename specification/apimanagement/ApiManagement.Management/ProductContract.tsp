import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiManagementServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Product details.
 */
@parentResource(ApiManagementServiceResource)
model ProductContract
  is Azure.ResourceManager.ProxyResource<ProductContractProperties> {
  ...ResourceNameParameter<
    Resource = ProductContract,
    KeyName = "productId",
    SegmentName = "products",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ProductContractOps
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
        serviceName: string,
      },
      {
        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        productId: string,
      }
    > {}

@armResourceOperations
interface ProductContracts {
  /**
   * Gets the details of the product specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Product_Get")
  get is ProductContractOps.Read<ProductContract>;

  /**
   * Gets the entity state (Etag) version of the product specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Product_GetEntityTag")
  getEntityTag is ProductContractOps.CheckExistence<ProductContract>;

  /**
   * Creates or Updates a product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Product_CreateOrUpdate")
  createOrUpdate is ProductContractOps.CreateOrUpdateSync<
    ProductContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Update existing product details.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Product_Update")
  @patch(#{ implicitOptionality: false })
  update is ProductContractOps.CustomPatchSync<
    ProductContract,
    PatchModel = ProductUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Delete product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Product_Delete")
  delete is ProductContractOps.DeleteSync<
    ProductContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;

      /**
       * Delete existing subscriptions associated with the product or not.
       */
      @query("deleteSubscriptions")
      deleteSubscriptions?: boolean;
    }
  >;

  /**
   * Lists a collection of products in the specified service instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Product_ListByService")
  listByService is ProductContractOps.List<
    ProductContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| terms | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| state | filter | eq |     |</br>| groups | expand |     |     |</br>
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
      @query("$skip")
      $skip?: int32;

      /**
       * When set to true, the response contains an array of groups that have visibility to the product. The default is false.
       */
      @query("expandGroups")
      expandGroups?: boolean;

      /**
       * Products which are part of a specific tag.
       */
      @query("tags")
      tags?: string;
    },
    Response = ArmResponse<ProductCollection>
  >;

  /**
   * Lists a collection of the APIs associated with a product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApi_ListByProduct")
  @get
  @action("apis")
  listByProduct is ProductContractOps.ActionSync<
    ProductContract,
    void,
    ArmResponse<ApiCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| serviceUrl | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| path | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Checks that API entity specified by identifier is associated with the Product entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApi_CheckEntityExists")
  @head
  @action("{apiId}")
  checkEntityExists is ProductContractOps.ActionSync<
    ProductContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number.
       */
      @maxLength(256)
      @minLength(1)
      @pattern("^[^*#&+:<>?]+$")
      @path
      apiId: string;
    }
  >;

  /**
   * Adds an API to the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApi_CreateOrUpdate")
  @put
  @action("{apiId}")
  productApiCreateOrUpdate is ProductContractOps.ActionSync<
    ProductContract,
    void,
    ArmResponse<ApiContract> | ArmResourceCreatedSyncResponse<ApiContract>,
    Parameters = {
      /**
       * API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number.
       */
      @maxLength(256)
      @minLength(1)
      @pattern("^[^*#&+:<>?]+$")
      @path
      apiId: string;
    }
  >;

  /**
   * Deletes the specified API from the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApi_Delete")
  @delete
  @action("{apiId}")
  productApiDelete is ProductContractOps.ActionSync<
    ProductContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number.
       */
      @maxLength(256)
      @minLength(1)
      @pattern("^[^*#&+:<>?]+$")
      @path
      apiId: string;
    }
  >;

  /**
   * Lists the collection of developer groups associated with the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroup_ListByProduct")
  @get
  @action("groups")
  productGroupListByProduct is ProductContractOps.ActionSync<
    ProductContract,
    void,
    ArmResponse<GroupCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt |     |</br>| displayName | filter | eq, ne |     |</br>| description | filter | eq, ne |     |</br>
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
      @query("$skip")
      $skip?: int32;
    }
  >;

  /**
   * Checks that Group entity specified by identifier is associated with the Product entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroup_CheckEntityExists")
  @head
  @action("{groupId}")
  productGroupCheckEntityExists is ProductContractOps.ActionSync<
    ProductContract,
    void,
    NoContentResponse,
    Parameters = {
      /**
       * Group identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(256)
      @minLength(1)
      @path
      groupId: string;
    }
  >;

  /**
   * Adds the association between the specified developer group with the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroup_CreateOrUpdate")
  @put
  @action("{groupId}")
  productGroupCreateOrUpdate is ProductContractOps.ActionSync<
    ProductContract,
    void,
    ArmResponse<GroupContract> | ArmResourceCreatedSyncResponse<GroupContract>,
    Parameters = {
      /**
       * Group identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(256)
      @minLength(1)
      @path
      groupId: string;
    }
  >;

  /**
   * Deletes the association between the specified group and product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroup_Delete")
  @delete
  @action("{groupId}")
  productGroupDelete is ProductContractOps.ActionSync<
    ProductContract,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * Group identifier. Must be unique in the current API Management service instance.
       */
      @maxLength(256)
      @minLength(1)
      @path
      groupId: string;
    }
  >;

  /**
   * Lists the collection of subscriptions to the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductSubscriptions_List")
  @get
  @action("subscriptions")
  list is ProductContractOps.ActionSync<
    ProductContract,
    void,
    ArmResponse<SubscriptionCollection>,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| stateComment | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| ownerId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| scope | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| userId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| productId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| state | filter | eq |     |</br>| user | expand |     |     |</br>
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
      @query("$skip")
      $skip?: int32;
    }
  >;
}
@armResourceOperations
interface WorkspaceProductOps
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
        serviceName: string,

        /** Workspace identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[^*#&+:<>?]+$")
        workspaceId: string,
      },
      {
        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        productId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceProduct {
  /**
   * Gets the details of the product specified by its identifier.
   */
  get is WorkspaceProductOps.Read<ProductContract>;

  /**
   * Gets the entity state (Etag) version of the product specified by its identifier.
   */
  getEntityTag is WorkspaceProductOps.CheckExistence<ProductContract>;

  /**
   * Creates or Updates a product.
   */
  createOrUpdate is WorkspaceProductOps.CreateOrUpdateSync<
    ProductContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      @header
      `If-Match`?: string;
    }
  >;

  /**
   * Update existing product details.
   */
  @patch(#{ implicitOptionality: false })
  update is WorkspaceProductOps.CustomPatchSync<
    ProductContract,
    PatchModel = ProductUpdateParameters,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;
    }
  >;

  /**
   * Delete product.
   */
  delete is WorkspaceProductOps.DeleteSync<
    ProductContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      @header
      `If-Match`: string;

      /**
       * Delete existing subscriptions associated with the product or not.
       */
      @query("deleteSubscriptions")
      deleteSubscriptions?: boolean;
    }
  >;

  /**
   * Lists a collection of products in the specified workspace in a service instance.
   */
  listByService is WorkspaceProductOps.List<
    ProductContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| terms | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| state | filter | eq |     |</br>| groups | expand |     |     |</br>
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
      @query("$skip")
      $skip?: int32;

      /**
       * When set to true, the response contains an array of groups that have visibility to the product. The default is false.
       */
      @query("expandGroups")
      expandGroups?: boolean;

      /**
       * Products which are part of a specific tag.
       */
      @query("tags")
      tags?: string;
    },
    Response = ArmResponse<ProductCollection>
  >;
}

@@maxLength(ProductContract.name, 256);
@@minLength(ProductContract.name, 1);
@@doc(ProductContract.name,
  "Product identifier. Must be unique in the current API Management service instance."
);
@@doc(ProductContract.properties, "Product entity contract properties.");
@@doc(ProductContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(ProductContracts.update::parameters.properties, "Update parameters.");
@@doc(WorkspaceProduct.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceProduct.update::parameters.properties, "Update parameters.");
