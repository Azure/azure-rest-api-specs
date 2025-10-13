import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Incident.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;
/**
 * Represents an incident comment
 */
@parentResource(Incident)
model IncidentComment
  is Azure.ResourceManager.ProxyResource<IncidentCommentProperties> {
  ...ResourceNameParameter<
    Resource = IncidentComment,
    KeyName = "incidentCommentId",
    SegmentName = "comments",
    NamePattern = ""
  >;

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

@armResourceOperations
interface IncidentComments {
  /**
   * Gets a comment for a given incident.
   */
  get is Extension.Read<
    OperationalInsights,
    IncidentComment,
    Error = CloudError
  >;

  /**
   * Creates or updates a comment for a given incident.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    OperationalInsights,
    IncidentComment,
    Error = CloudError
  >;

  /**
   * Deletes a comment for a given incident.
   */
  delete is Extension.DeleteSync<
    OperationalInsights,
    IncidentComment,
    Error = CloudError
  >;

  /**
   * Gets all comments for a given incident.
   */
  list is Extension.ListByTarget<
    OperationalInsights,
    IncidentComment,
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
    Response = ArmResponse<IncidentCommentList>,
    Error = CloudError
  >;
}

@@doc(IncidentComment.name, "Incident comment ID");
@@doc(IncidentComment.properties, "Incident comment properties");
@@doc(IncidentComments.createOrUpdate::parameters.resource,
  "The incident comment"
);
