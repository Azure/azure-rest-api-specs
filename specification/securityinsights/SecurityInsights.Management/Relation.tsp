import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Bookmark.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a relation between two resources
 */
@parentResource(Bookmark)
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

alias RelationOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.OperationalInsights";

    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Relation>;

    /** Bookmark ID */
    @path
    @segment("bookmarks")
    @key
    bookmarkId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Relation>;

    /** Bookmark ID */
    @path
    @segment("bookmarks")
    @key
    bookmarkId: string;

    /** Relation Name */
    @path
    @segment("relations")
    @key
    @pattern("^[a-zA-Z0-9-]{3,63}$")
    relationName: string;
  }
>;

@armResourceOperations
interface Relations {
  /**
   * Gets a bookmark relation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BookmarkRelations_Get")
  get is RelationOps.Read<Relation>;

  /**
   * Creates the bookmark relation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BookmarkRelations_CreateOrUpdate")
  createOrUpdate is RelationOps.CreateOrUpdateSync<Relation>;

  /**
   * Delete the bookmark relation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BookmarkRelations_Delete")
  delete is RelationOps.DeleteSync<Relation>;

  /**
   * Gets all bookmark relations.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BookmarkRelations_List")
  list is RelationOps.List<
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
    Response = ArmResponse<RelationList>
  >;
}
alias EntityRelationOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.OperationalInsights";

    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Relation>;

    /** entity ID */
    @path
    @segment("entities")
    @key
    entityId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Relation>;

    /** entity ID */
    @path
    @segment("entities")
    @key
    entityId: string;

    /** Relation Name */
    @path
    @segment("relations")
    @key
    @pattern("^[a-zA-Z0-9-]{3,63}$")
    relationName: string;
  }
>;

@armResourceOperations
interface EntityRelations {
  /**
   * Gets an entity relation.
   */
  getRelation is EntityRelationOps.Read<Relation>;

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
    Response = ArmResponse<RelationList>
  >;
}
alias IncidentRelationOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.OperationalInsights";

    /** The name of the workspace. */
    @path
    @segment("workspaces")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Relation>;

    /** Incident ID */
    @path
    @segment("incidents")
    @key
    incidentId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<Relation>;

    /** Incident ID */
    @path
    @segment("incidents")
    @key
    incidentId: string;

    /** Relation Name */
    @path
    @segment("relations")
    @key
    @pattern("^[a-zA-Z0-9-]{3,63}$")
    relationName: string;
  }
>;

@armResourceOperations
interface IncidentRelations {
  /**
   * Gets a relation for a given incident.
   */
  get is IncidentRelationOps.Read<Relation>;

  /**
   * Creates or updates the incident relation.
   */
  createOrUpdate is IncidentRelationOps.CreateOrUpdateSync<Relation>;

  /**
   * Deletes a relation for a given incident.
   */
  delete is IncidentRelationOps.DeleteSync<Relation>;

  /**
   * Gets all relations for a given incident.
   */
  list is IncidentRelationOps.List<
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
    Response = ArmResponse<RelationList>
  >;
}

@@maxLength(Relation.name, 63);
@@minLength(Relation.name, 3);
@@doc(Relation.name, "Relation Name");
@@doc(Relation.properties, "Relation properties");
@@doc(Relations.createOrUpdate::parameters.resource, "The relation model");
@@doc(IncidentRelations.createOrUpdate::parameters.resource,
  "The relation model"
);
