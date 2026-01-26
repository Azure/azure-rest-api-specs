import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Information of the private link resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateLinkResource extends ProxyResource {
  /**
   * Properties of the private link resource.
   */
  properties?: PrivateLinkResourceProperties;
}

@armResourceOperations
interface PrivateLinkResourceOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * The type of the parent resource. This can be either \\'topics\\', \\'domains\\', or \\'partnerNamespaces\\' or \\'namespaces\\'.
         */
        @path
        parentType: string,

        /**
         * The name of the parent resource (namely, either, the topic name, domain name, or partner namespace name or namespace name).
         */
        @path
        parentName: string,
      },
      {},
      ResourceRoute = #{
        route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{parentType}/{parentName}",
      }
    > {}

@armResourceOperations(#{ allowStaticRoutes: true })
interface PrivateLinkResources {
  /**
   * Get properties of a private link resource.
   */
  @summary("Get a private link resource.")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{parentType}/{parentName}/privateLinkResources/{privateLinkResourceName}")
  get is PrivateLinkResourceOps.ActionSync<
    PrivateLinkResource,
    Request = void,
    Parameters = {
      /**
       * The name of private link resource will be either topic, domain, partnerNamespace or namespace.
       */
      @path
      privateLinkResourceName: string;
    },
    Response = ArmResponse<PrivateLinkResource>
  >;

  /**
   * List all the private link resources under a topic, domain, or partner namespace or namespace.
   */
  @get
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{parentType}/{parentName}/privateLinkResources")
  @summary("List private link resources under specific topic, domain, or partner namespace or namespace.")
  listByResource is PrivateLinkResourceOps.ActionSync<
    PrivateLinkResource,
    Request = void,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<PrivateLinkResourcesListResult>
  >;
}

@@doc(PrivateLinkResource.name,
  "The name of private link resource will be either topic, domain, partnerNamespace or namespace."
);
@@doc(PrivateLinkResource.properties,
  "Properties of the private link resource."
);
