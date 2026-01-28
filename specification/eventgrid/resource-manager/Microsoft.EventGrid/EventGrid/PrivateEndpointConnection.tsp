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

model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = ""
  >;
}
@armResourceOperations
interface PrivateEndpointConnectionOps
  extends Azure.ResourceManager.Legacy.RoutedOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,

        /**
         * The type of the parent resource. This can be either \\'topics\\', \\'domains\\', or \\'partnerNamespaces\\' or \\'namespaces\\'.
         */
        @path
        parentType: PrivateEndpointConnectionsParentType,

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
interface PrivateEndpointConnections {
  /**
   * Get a specific private endpoint connection under a topic, domain, or partner namespace or namespace.
   */
  @summary("Get a specific private endpoint connection.")
  @get
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{parentType}/{parentName}/privateEndpointConnections/{privateEndpointConnectionName}")
  get is PrivateEndpointConnectionOps.ActionSync<
    PrivateEndpointConnection,
    Request = void,
    Response = ArmResponse<PrivateEndpointConnection>,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      privateEndpointConnectionName: string;
    }
  >;

  /**
   * Update a specific private endpoint connection under a topic, domain or partner namespace.
   */
  @put
  @summary("Update a specific private endpoint connection.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{parentType}/{parentName}/privateEndpointConnections/{privateEndpointConnectionName}")
  update is PrivateEndpointConnectionOps.ActionAsync<
    PrivateEndpointConnection,
    Request = PrivateEndpointConnection,
    Result = void,
    Response = ArmResponse<PrivateEndpointConnection> | ArmResourceCreatedResponse<
      PrivateEndpointConnection,
      LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      privateEndpointConnectionName: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a specific private endpoint connection under a topic, domain, or partner namespace or namespace.
   */
  @summary("Delete a specific private endpoint connection.")
  @delete
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.EventGrid/{parentType}/{parentName}/privateEndpointConnections/{privateEndpointConnectionName}")
  delete is PrivateEndpointConnectionOps.ActionAsync<
    PrivateEndpointConnection,
    Request = void,
    Result = void,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      privateEndpointConnectionName: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get all private endpoint connections under a topic, domain, or partner namespace or namespace.
   */
  @summary("Lists all private endpoint connections under a resource.")
  @get
  @list
  listByResource is ArmResourceListByParent<
    PrivateEndpointConnection,
    Response = ArmResponse<PrivateEndpointConnectionListResult>,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \\'topics\\', \\'domains\\', or \\'partnerNamespaces\\' or \\'namespaces\\'.
       */
      @path
      parentType: PrivateEndpointConnectionsParentType;

      /**
       * The name of the parent resource (namely, either, the topic name, domain name, or partner namespace name or namespace name).
       */
      @path
      parentName: string;

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
    }
  >;
}

@@doc(PrivateEndpointConnection.name,
  "The name of the private endpoint connection connection."
);
@@doc(PrivateEndpointConnection.properties,
  "Properties of the PrivateEndpointConnection."
);
@@doc(PrivateEndpointConnections.update::parameters.body,
  "The private endpoint connection object to update."
);
