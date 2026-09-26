import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

alias ConnectionServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests;

alias ConnectionOperations = Azure.Core.ResourceOperations<ConnectionServiceTraits>;

@added(Versions.v2025_05_01)
interface Connections {
  @doc("Get a connection by name, without populating connection credentials")
  get is ConnectionOperations.ResourceRead<Connection>;

  @doc("Get a connection by name, with its connection credentials")
  @TypeSpec.Http.post
  @Rest.actionSeparator("/")
  @Rest.action("getConnectionWithCredentials")
  getWithCredentials is ConnectionOperations.ResourceAction<
    Connection,
    {},
    Connection
  >;

  @doc("List all connections in the project, without populating connection credentials")
  list is ConnectionOperations.ResourceList<
    Connection,
    ListQueryParametersTrait<{
      @doc("List connections of this specific type")
      @query("connectionType")
      connectionType?: ConnectionType;

      @doc("List connections that are default connections")
      @query("defaultConnection")
      defaultConnection?: boolean;
    }>
  >;
}
