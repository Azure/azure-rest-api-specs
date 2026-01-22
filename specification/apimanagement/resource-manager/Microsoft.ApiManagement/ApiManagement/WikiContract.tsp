import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApiContract.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ApiManagement;
/**
 * Wiki properties
 */
@singleton("default")
@parentResource(ApiContract)
model WikiContract
  is Azure.ResourceManager.ProxyResource<WikiContractProperties> {
  ...ResourceNameParameter<
    Resource = WikiContract,
    KeyName = "wiki",
    SegmentName = "wikis",
    NamePattern = ""
  >;
}

@armResourceOperations
interface WikiContractOps
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

        /** API identifier. Must be unique in the current API Management service instance. */
        @path
        @segment("apis")
        @key
        @minLength(1)
        @maxLength(80)
        apiId: string,
      },
      {
        /** undefined */
        @path
        @segment("wikis")
        @key
        default: "default",
      }
    > {}

@armResourceOperations
interface WikiContracts {
  /**
   * Gets the details of the Wiki for an API specified by its identifier.
   */
  get is WikiContractOps.Read<
    WikiContract,
    Response = ArmResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Wiki for an API specified by its identifier.
   */
  getEntityTag is WikiContractOps.CheckExistence<
    WikiContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates a new Wiki for an API or updates an existing one.
   */
  createOrUpdate is WikiContractOps.CreateOrUpdateSync<
    WikiContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }) | (ArmCreatedResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    })
  >;

  /**
   * Updates the details of the Wiki for an API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is WikiContractOps.CustomPatchSync<
    WikiContract,
    PatchModel = WikiUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Deletes the specified Wiki from an API.
   */
  delete is WikiContractOps.DeleteSync<
    WikiContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = OkResponse | NoContentResponse
  >;

  /**
   * Gets the wikis for an API specified by its identifier.
   */
  list is WikiContractOps.List<
    WikiContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | eq |  contains |</br>
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
    Response = ArmResponse<WikiCollection>
  >;
}
@armResourceOperations
interface ProductWikiOps
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
        /** undefined */
        @path
        @segment("wikis")
        @key
        default: "default",
      }
    > {}

@armResourceOperations
interface ProductWiki {
  /**
   * Gets the details of the Wiki for a Product specified by its identifier.
   */
  get is ProductWikiOps.Read<
    WikiContract,
    Response = ArmResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Wiki for a Product specified by its identifier.
   */
  getEntityTag is ProductWikiOps.CheckExistence<
    WikiContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates a new Wiki for a Product or updates an existing one.
   */
  createOrUpdate is ProductWikiOps.CreateOrUpdateSync<
    WikiContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }) | (ArmCreatedResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    })
  >;

  /**
   * Updates the details of the Wiki for a Product specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ProductWikiOps.CustomPatchSync<
    WikiContract,
    PatchModel = WikiUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<WikiContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Deletes the specified Wiki from a Product.
   */
  delete is ProductWikiOps.DeleteSync<
    WikiContract,
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
   * Gets the details of the Wiki for a Product specified by its identifier.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("ProductWikis_list")
  list is ProductWikiOps.List<
    WikiContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | eq |  contains |</br>
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
    Response = ArmResponse<WikiCollection> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;
}

@@doc(WikiContract.name, "");
@@doc(WikiContract.properties, "Wiki details.");
@@doc(WikiContracts.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(WikiContracts.update::parameters.properties, "Wiki Update parameters.");
@@doc(ProductWiki.createOrUpdate::parameters.resource, "Create parameters.");
@@doc(ProductWiki.update::parameters.properties, "Wiki Update parameters.");
