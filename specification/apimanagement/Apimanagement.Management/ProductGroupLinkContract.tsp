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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProductContract,
          KeyName = "productId",
          SegmentName = "products",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProductGroupLinkContract,
        KeyName = "groupLinkId",
        SegmentName = "groupLinks",
        NamePattern = "^[^*#&+:<>?]+$"
      >>
    > {}

@armResourceOperations
interface ProductGroupLinkContracts {
  /**
   * Gets the group link for the product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroupLink_Get")
  get is ProductGroupLinkContractOps.Read<ProductGroupLinkContract>;

  /**
   * Adds a group to the specified product via link.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroupLink_CreateOrUpdate")
  createOrUpdate is ProductGroupLinkContractOps.CreateOrUpdateSync<ProductGroupLinkContract>;

  /**
   * Deletes the specified group from the specified product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroupLink_Delete")
  delete is ProductGroupLinkContractOps.DeleteSync<ProductGroupLinkContract>;

  /**
   * Lists a collection of the group links associated with a product.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ProductGroupLink_ListByProduct")
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
        ...KeysOf<ResourceNameParameter<
          Resource = ApiManagementServiceResource,
          KeyName = "serviceName",
          SegmentName = "service",
          NamePattern = "^[a-zA-Z](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = WorkspaceContract,
          KeyName = "workspaceId",
          SegmentName = "workspaces",
          NamePattern = "^[^*#&+:<>?]+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = ProductContract,
          KeyName = "productId",
          SegmentName = "products",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ProductGroupLinkContract,
        KeyName = "groupLinkId",
        SegmentName = "groupLinks",
        NamePattern = "^[^*#&+:<>?]+$"
      >>
    > {}

@armResourceOperations
interface WorkspaceProductGroupLink {
  /**
   * Gets the group link for the product.
   */
  get is WorkspaceProductGroupLinkOps.Read<ProductGroupLinkContract>;

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
