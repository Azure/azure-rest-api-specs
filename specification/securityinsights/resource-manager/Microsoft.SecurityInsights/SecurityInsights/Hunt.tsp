import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * Represents a Hunt in Azure Security Insights.
 */
model Hunt is Azure.ResourceManager.ProxyResource<HuntProperties> {
  ...ResourceNameParameter<
    Resource = Hunt,
    KeyName = "huntId",
    SegmentName = "hunts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Hunts {
  /**
   * Gets a hunt, without relations and comments.
   */
  get is Extension.Read<workspaceExternalResource, Hunt, Error = CloudError>;

  /**
   * Create or update a hunt
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    Hunt,
    Error = CloudError
  >;

  /**
   * Delete a hunt.
   */
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    Hunt,
    Error = CloudError
  >;

  /**
   * Gets all hunts, without relations and comments.
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    Hunt,
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
    Response = ArmResponse<HuntList>,
    Error = CloudError
  >;
}

@@doc(Hunt.name, "The hunt id (GUID)");
@@doc(Hunt.properties, "Hunt properties");
@@doc(Hunts.createOrUpdate::parameters.resource, "The hunt");
