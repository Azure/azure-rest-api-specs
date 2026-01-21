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
 * GraphQL API Resolver details.
 */
@parentResource(ApiContract)
model ResolverContract
  is Azure.ResourceManager.ProxyResource<ResolverEntityBaseContract> {
  ...ResourceNameParameter<
    Resource = ResolverContract,
    KeyName = "resolverId",
    SegmentName = "resolvers",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ResolverContracts {
  /**
   * Gets the details of the GraphQL API Resolver specified by its identifier.
   */
  get is ArmResourceRead<
    ResolverContract,
    Response = ArmResponse<ResolverContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Gets the entity state (Etag) version of the GraphQL API resolver specified by its identifier.
   */
  getEntityTag is ArmResourceCheckExistence<
    ResolverContract,
    Response = OkResponse & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Creates a new resolver in the GraphQL API or updates an existing one.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    ResolverContract,
    Parameters = {
      /**
       * ETag of the Entity. Not required when creating an entity, but required when updating an entity.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`?: string;
    },
    Response = (ArmResponse<ResolverContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }) | (ArmResourceCreatedSyncResponse<ResolverContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    })
  >;

  /**
   * Updates the details of the resolver in the GraphQL API specified by its identifier.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    ResolverContract,
    PatchModel = ResolverUpdateContract,
    Parameters = {
      /**
       * ETag of the Entity. ETag should match the current entity state from the header response of the GET request or it should be * for unconditional update.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header("If-Match")
      `If-Match`: string;
    },
    Response = ArmResponse<ResolverContract> & {
      /**
       * Current entity state version. Should be treated as opaque and used to make conditional HTTP requests.
       */
      @header("ETag")
      etag: string;
    }
  >;

  /**
   * Deletes the specified resolver in the GraphQL API.
   */
  delete is ArmResourceDeleteSync<
    ResolverContract,
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
   * Lists a collection of the resolvers for the specified GraphQL API.
   */
  listByApi is ArmResourceListByParent<
    ResolverContract,
    Parameters = {
      /**
       * |     Field     |     Usage     |     Supported operators     |     Supported functions     |</br>|-------------|-------------|-------------|-------------|</br>| name | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| displayName | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| description | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>| path | filter | ge, le, eq, ne, gt, lt | substringof, contains, startswith, endswith |</br>
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
    Response = ArmResponse<ResolverCollection>
  >;
}

@@maxLength(ResolverContract.name, 80);
@@minLength(ResolverContract.name, 1);
@@doc(ResolverContract.name,
  "Resolver identifier within a GraphQL API. Must be unique in the current API Management service instance."
);
@@doc(ResolverContract.properties, "Properties of the Resolver Contract.");
@@doc(ResolverContracts.createOrUpdate::parameters.resource,
  "Create parameters."
);
@@doc(ResolverContracts.update::parameters.properties,
  "GraphQL API Resolver Update parameters."
);
