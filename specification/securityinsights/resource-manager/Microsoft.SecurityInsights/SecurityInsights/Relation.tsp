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

@@maxLength(Relation.name, 63);
@@minLength(Relation.name, 3);
@@doc(Relation.name, "Relation Name");
@@doc(Relation.properties, "Relation properties");
@@doc(Relations.createOrUpdate::parameters.resource, "The relation model");
