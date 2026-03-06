import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Namespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.EventGrid;
/**
 * The Client resource.
 */
@parentResource(Namespace)
model Client is Azure.ResourceManager.ProxyResource<ClientProperties> {
  ...ResourceNameParameter<
    Resource = Client,
    KeyName = "clientName",
    SegmentName = "clients",
    NamePattern = "^[-a-zA-Z0-9:\\._]*$"
  >;
}

@armResourceOperations
interface Clients {
  /**
   * Get properties of a client.
   */
  @summary("Get a client.")
  get is ArmResourceRead<Client>;

  /**
   * Create or update a client with the specified parameters.
   */
  @summary("Create or update a client.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Client>;

  /**
   * Delete an existing client.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a client.")
  delete is ArmResourceDeleteWithoutOkAsync<
    Client,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the permission bindings under a namespace.
   */
  @summary("List all permission bindings under a namespace.")
  listByNamespace is ArmResourceListByParent<
    Client,
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
    Response = ArmResponse<ClientsListResult>
  >;
}

@@maxLength(Client.name, 128);
@@minLength(Client.name, 1);
@@doc(Client.name, "Name of the client.");
@@doc(Client.properties, "The properties of client.");
@@doc(Clients.createOrUpdate::parameters.resource, "Client information.");

@@clientName(TlsVersion.`1.0`, "One0", "go");
@@clientName(TlsVersion.`1.1`, "One1", "go");
@@clientName(TlsVersion.`1.2`, "One2", "go");

@@clientName(WebHookEventSubscriptionDestinationProperties,
  "WebhookEventSubscriptionDestinationProperties",
  "java"
);

@@clientName(WebHookEventSubscriptionDestination,
  "WebhookEventSubscriptionDestination",
  "java"
);
