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
 * Contract details.
 */
@parentResource(ApiContract)
model TagDescriptionContract
  is Azure.ResourceManager.ProxyResource<TagDescriptionContractProperties> {
  ...ResourceNameParameter<
    Resource = TagDescriptionContract,
    KeyName = "tagDescriptionId",
    SegmentName = "tagDescriptions",
    NamePattern = "^[^*#&+:<>?]+$"
  >;
}

@armResourceOperations
interface TagDescriptionContractsOps
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

        /**
         * API revision identifier. Must be unique in the current API Management service instance. Non-current revision has ;rev=n as a suffix where n is the revision number.
         */
        @path
        @segment("apis")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(256)
        apiId: string,
      },
      {
        /** Tag description identifier. Used when creating tagDescription for API/Tag association. Based on API and Tag names. */
        @path
        @segment("tagDescriptions")
        @key
        @pattern("^[^*#&+:<>?]+$")
        @minLength(1)
        @maxLength(80)
        tagDescriptionId: string,
      }
    > {}

@armResourceOperations
interface TagDescriptionContracts {
  /**
   * Get Tag description in scope of API
   */
  get is ArmResourceRead<
    TagDescriptionContract,
    Response = ArmResponse<TagDescriptionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state version of the tag specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    TagDescriptionContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Create/Update tag description in scope of the Api.
   */
  createOrUpdate is TagDescriptionContractsOps.CreateOrUpdateSync<
    TagDescriptionContract,
    Request = TagDescriptionCreateParameters,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<TagDescriptionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmCreatedResponse<TagDescriptionContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Delete tag description for the Api.
   */
  delete is ArmResourceDeleteSync<
    TagDescriptionContract,
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
   * Lists all Tags descriptions in scope of API. Model similar to swagger - tagDescription is defined on API level but tag may be assigned to the Operations
   */
  listByService is ArmResourceListByParent<
    TagDescriptionContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<TagDescriptionCollection>
  >;
}

@@maxLength(TagDescriptionContract.name, 80);
@@minLength(TagDescriptionContract.name, 1);
@@doc(TagDescriptionContract.name,
  "Tag description identifier. Used when creating tagDescription for API/Tag association. Based on API and Tag names."
);
@@doc(TagDescriptionContract.properties,
  "TagDescription entity contract properties."
);
@@doc(TagDescriptionContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
