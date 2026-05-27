import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias ConnectionOperations = FoundryAzureOperations<{}>;

@tag("Connections")
interface Connections {
  @summary("Get a connection")
  @doc("Gets a connection by name, without populating connection credentials")
  get is ConnectionOperations.ResourceRead<Connection>;

  @summary("Get a connection with credentials")
  @doc("Gets a connection by name, with its connection credentials")
  @TypeSpec.Http.post
  @Rest.actionSeparator("/")
  @Rest.action("getConnectionWithCredentials")
  getWithCredentials is ConnectionOperations.ResourceAction<
    Connection,
    {},
    Connection
  >;

  @summary("List all connections")
  @doc("Lists all connections in the project, without populating connection credentials")
  list is ConnectionOperations.ResourceList<
    Connection,
    ListQueryParametersTrait<{
      @doc("Lists connections of this specific type")
      @query("connectionType")
      connectionType?: ConnectionType;

      @doc("Lists connections that are default connections")
      @query("defaultConnection")
      defaultConnection?: boolean;
    }>
  >;
}
