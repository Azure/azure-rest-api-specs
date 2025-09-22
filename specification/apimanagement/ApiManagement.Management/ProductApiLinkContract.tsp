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
 * Product-API link details.
 */
@parentResource(ProductContract)
model ProductApiLinkContract
  is Azure.ResourceManager.ProxyResource<ProductApiLinkContractProperties> {
  ...ResourceNameParameter<
    Resource = ProductApiLinkContract,
    KeyName = "apiLinkId",
    SegmentName = "apiLinks",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface ProductApiLinkContractOps
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

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        productId: string,
      },
      {
        /** Product-API link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiLinkId: string,
      }
    > {}

@armResourceOperations
interface ProductApiLinkContracts {
  /**
   * Gets the API link for the product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApiLink_Get")
  get is ProductApiLinkContractOps.Read<ProductApiLinkContract>;

  /**
   * Adds an API to the specified product via link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApiLink_CreateOrUpdate")
  createOrUpdate is ProductApiLinkContractOps.CreateOrUpdateSync<ProductApiLinkContract>;

  /**
   * Deletes the specified API from the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApiLink_Delete")
  delete is ProductApiLinkContractOps.DeleteSync<ProductApiLinkContract>;

  /**
   * Lists a collection of the API links associated with a product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductApiLink_ListByProduct")
  listByProduct is ProductApiLinkContractOps.List<
    ProductApiLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| apiId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    },
    Response = ArmResponse<ProductApiLinkCollection>
  >;
}
@armResourceOperations
interface WorkspaceProductApiLinkOps
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

        /** Product identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("products")
        @key
        productId: string,
      },
      {
        /** Product-API link identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apiLinks")
        @key
        @pattern("^[^*#&+:<>?]+$")
        apiLinkId: string,
      }
    > {}

@armResourceOperations
interface WorkspaceProductApiLink {
  /**
   * Gets the API link for the product.
   */
  get is WorkspaceProductApiLinkOps.Read<ProductApiLinkContract>;

  /**
   * Adds an API to the specified product via link.
   */
  createOrUpdate is WorkspaceProductApiLinkOps.CreateOrUpdateSync<ProductApiLinkContract>;

  /**
   * Deletes the specified API from the specified product.
   */
  delete is WorkspaceProductApiLinkOps.DeleteSync<ProductApiLinkContract>;

  /**
   * Lists a collection of the API links associated with a product.
   */
  listByProduct is WorkspaceProductApiLinkOps.List<
    ProductApiLinkContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| apiId | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    },
    Response = ArmResponse<ProductApiLinkCollection>
  >;
}

@@maxLength(ProductApiLinkContract.name, 80);
@@minLength(ProductApiLinkContract.name, 1);
@@doc(ProductApiLinkContract.name,
  "Product-API link identifier. Must be unique in the current API Management service instance."
);
@@doc(ProductApiLinkContract.properties,
  "Product-API link entity contract properties."
);
@@doc(ProductApiLinkContracts.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
@@doc(WorkspaceProductApiLink.createOrUpdate::parameters.resource,
  "Create or update parameters."
);
