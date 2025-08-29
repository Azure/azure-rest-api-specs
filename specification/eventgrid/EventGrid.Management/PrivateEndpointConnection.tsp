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
interface PrivateEndpointConnections {
  /**
   * Get a specific private endpoint connection under a topic, domain, or partner namespace or namespace.
   */
  get is ArmResourceRead<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      parentType: PrivateEndpointConnectionsParentType;
    }
  >;

  /**
   * Update a specific private endpoint connection under a topic, domain or partner namespace.
   */
  update is ArmResourceCreateOrReplaceAsync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      parentType: PrivateEndpointConnectionsParentType;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = PrivateEndpointConnection> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a specific private endpoint connection under a topic, domain, or partner namespace or namespace.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      parentType: PrivateEndpointConnectionsParentType;
    }
  >;

  /**
   * Get all private endpoint connections under a topic, domain, or partner namespace or namespace.
   */
  listByResource is ArmResourceListByParent<
    PrivateEndpointConnection,
    Parameters = {
      /**
       * The type of the parent resource. This can be either \'topics\', \'domains\', or \'partnerNamespaces\' or \'namespaces\'.
       */
      @path
      parentType: PrivateEndpointConnectionsParentType;

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
@@doc(PrivateEndpointConnections.update::parameters.resource,
  "The private endpoint connection object to update."
);
