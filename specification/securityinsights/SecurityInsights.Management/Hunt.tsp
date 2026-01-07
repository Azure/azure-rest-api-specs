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

  /**
   * Etag of the azure resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;
}

alias workspaceExternalResource = Extension.ExternalResource<
  "Microsoft.OperationalInsights",
  "workspaces",
  "{workspaceName}"
>;

@armResourceOperations
interface Hunts {
  /**
   * Gets a hunt, without relations and comments.
   */
  get is ArmResourceRead<Hunt>;

  /**
   * Create or update a hunt
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Hunt>;

  /**
   * Delete a hunt.
   */
  delete is ArmResourceDeleteSync<Hunt>;

  /**
   * Gets all hunts, without relations and comments.
   */
  list is ArmResourceListByParent<
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
    Response = ArmResponse<HuntList>
  >;
}

@@doc(Hunt.name, "The hunt id (GUID)");
@@doc(Hunt.properties, "Hunt properties");
@@doc(Hunts.createOrUpdate::parameters.resource, "The hunt");
