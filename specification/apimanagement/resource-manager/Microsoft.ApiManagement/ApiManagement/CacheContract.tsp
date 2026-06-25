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
 * Cache details.
 */
@parentResource(ApiManagementServiceResource)
model CacheContract
  is Azure.ResourceManager.ProxyResource<CacheContractProperties> {
  ...ResourceNameParameter<
    Resource = CacheContract,
    KeyName = "cacheId",
    SegmentName = "caches",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface CacheContractsOps
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
      },
      {
        /** Identifier of the Cache entity. Cache identifier (should be either 'default' or valid Azure region identifier). */
        @path
        @segment("caches")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        cacheId: string,
      },
      ResourceName = "ApiManagementCache"
    > {}

@armResourceOperations
interface CacheContracts {
  /**
   * Gets the details of the Cache specified by its identifier.
   */
  get is CacheContractsOps.Read<
    CacheContract,
    Response = ArmResponse<CacheContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the Cache specified by its identifier.
   */
  getEntityTag is CacheContractsOps.CheckExistence<
    CacheContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Creates or updates an External Cache to be used in Api Management instance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs(
    "https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-cache-external",
    "Use an external cache in Azure API Management"
  )
  createOrUpdate is CacheContractsOps.CreateOrUpdateSync<
    CacheContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response =
      | (ArmResponse<CacheContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
      | (ArmResourceCreatedSyncResponse<CacheContract> & {
          /**
           * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
           */
          @header("ETag")
          eTag: string;
        })
  >;

  /**
   * Updates the details of the cache specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is CacheContractsOps.CustomPatchSync<
    CacheContract,
    PatchModel = CacheUpdateParameters,
    Parameters = IfMatchHeaderParameter,
    Response = ArmResponse<CacheContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      eTag: string;
    }
  >;

  /**
   * Deletes specific Cache.
   */
  delete is CacheContractsOps.DeleteSync<
    CacheContract,
    Parameters = IfMatchHeaderParameter
  >;

  /**
   * Lists a collection of all external Caches in the specified service instance.
   */
  listByService is CacheContractsOps.List<
    CacheContract,
    Parameters = {
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
    Response = ArmResponse<CacheCollection>
  >;
}

@@maxLength(CacheContract.name, 80);
@@minLength(CacheContract.name, 1);
@@doc(
  CacheContract.name,
  "Identifier of the Cache entity. Cache identifier (should be either 'default' or valid Azure region identifier)."
);
@@doc(CacheContract.properties, "Cache properties details.");
@@doc(
  CacheContracts.createOrUpdate::parameters.resource,
  "Create or Update parameters."
);
@@doc(CacheContracts.update::parameters.properties, "Update parameters.");
