import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Incident.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a relation between two resources
 */
@parentResource(Incident)
model Relation is Azure.ResourceManager.ProxyResource<RelationProperties> {
  ...ResourceNameParameter<
    Resource = Relation,
    KeyName = "relationName",
    SegmentName = "relations",
    NamePattern = "^[a-zA-Z0-9-]{3,63}$"
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface Relations {
  /**
   * Gets a relation for a given incident.
   */
  get is Extension.Read<OperationalInsights, Relation, Error = CloudError>;

  /**
   * Creates or updates a relation for a given incident.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    Relation,
    Error = CloudError
  >;

  /**
   * Deletes a relation for a given incident.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    Relation,
    Error = CloudError
  >;

  /**
   * Gets all relations for a given incident.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    Relation,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<RelationList>,
    Error = CloudError
  >;
}

@armResourceOperations
interface BookmarkRelationsOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.OperationalInsights",

        /** The name of the workspace. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
        workspaceName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Relation>,

        /** Bookmark ID */
        @path
        @segment("bookmarks")
        @key
        bookmarkId: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Relation>,

        /** Bookmark ID */
        @path
        @segment("bookmarks")
        @key
        bookmarkId: string,

        /** Relation Name */
        @path
        @segment("relations")
        @key
        @pattern("^[a-zA-Z0-9-]{3,63}$")
        relationName: string,
      }
    > {}

@armResourceOperations
interface BookmarkRelations {
  /**
   * Gets a bookmark relation.
   */
  get is BookmarkRelationsOps.Read<Relation, ErrorType = CloudError>;

  /**
   * Creates the bookmark relation.
   */
  createOrUpdate is BookmarkRelationsOps.CreateOrUpdateSync<
    Relation,
    Request = void,
    ErrorType = CloudError
  >;

  /**
   * Delete the bookmark relation.
   */
  delete is BookmarkRelationsOps.DeleteSync<Relation, ErrorType = CloudError>;

  /**
   * Gets all bookmark relations.
   */
  list is BookmarkRelationsOps.List<
    Relation,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<RelationList>,
    ErrorType = CloudError
  >;
}

@armResourceOperations
interface EntityRelationOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.OperationalInsights",

        /** The name of the workspace. */
        @path
        @segment("workspaces")
        @key
        @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
        workspaceName: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Relation>,

        /** entity ID */
        @path
        @segment("entities")
        @key
        entityId: string,
      },
      {
        ...Extension.ExtensionProviderNamespace<Relation>,

        /** entity ID */
        @path
        @segment("entities")
        @key
        entityId: string,

        /** Relation Name */
        @path
        @segment("relations")
        @key
        @pattern("^[a-zA-Z0-9-]{3,63}$")
        relationName: string,
      }
    > {}

@armResourceOperations
interface EntityRelations {
  /**
   * Gets an entity relation.
   */
  getRelation is EntityRelationOps.Read<Relation, ErrorType = CloudError>;

  /**
   * Gets all relations of an entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EntitiesRelations_List")
  list is EntityRelationOps.List<
    Relation,
    Parameters = {
      /**
       * Filters the results, based on a Boolean condition. Optional.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<RelationList>,
    ErrorType = CloudError
  >;
}

@@maxLength(Relation.name, 63);
@@minLength(Relation.name, 3);
@@doc(Relation.name, "Relation Name");
@@doc(Relation.properties, "Relation properties");
@@doc(Relations.createOrUpdate::parameters.resource, "The relation model");
