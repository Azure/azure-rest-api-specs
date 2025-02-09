import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Server communication link.
 */
@parentResource(Server)
model ServerCommunicationLink
  is ProxyResource<ServerCommunicationLinkProperties> {
  /**
   * The name of the server communication link.
   */
  @path
  @key("communicationLinkName")
  @segment("communicationLinks")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface ServerCommunicationLinks {
  /**
   * Returns a server communication link.
   */
  get is ArmResourceRead<ServerCommunicationLink>;

  /**
   * Creates a server communication link.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServerCommunicationLink>;

  /**
   * Deletes a server communication link.
   */
  delete is ArmResourceDeleteSync<ServerCommunicationLink>;

  /**
   * Gets a list of server communication links.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ServerCommunicationLinks_ListByServer")
  listByServer is ArmResourceListByParent<ServerCommunicationLink>;
}

@@projectedName(ServerCommunicationLinks.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ServerCommunicationLinks.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ServerCommunicationLinks.createOrUpdate::parameters.resource,
  "The required parameters for creating a server communication link."
);
