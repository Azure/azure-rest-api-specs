import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias ConnectionOperations = FoundryAzureOperations<{}>;

@tag("Connections")
interface Connections {
  /** Retrieves the specified connection and its configuration details without including credential values. */
  @summary("Get a connection")
  get is ConnectionOperations.ResourceRead<Connection>;

  /** Retrieves the specified connection together with its credential values. */
  @summary("Get a connection with credentials")
  @TypeSpec.Http.post
  @Rest.actionSeparator("/")
  @Rest.action("getConnectionWithCredentials")
  getWithCredentials is ConnectionOperations.ResourceAction<
    Connection,
    {},
    Connection
  >;

  /** Returns the connections available in the current project, optionally filtered by type or default status. */
  @summary("List connections")
  list is ConnectionOperations.ResourceList<
    Connection,
    ListQueryParametersTrait<{
      @doc("Lists connections of this specific type")
      @query("connectionType")
      connectionType?: ConnectionType;

      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing list.defaultConnection has a boolean wire value; preserve the published property contract."
      @doc("Lists connections that are default connections")
      @query("defaultConnection")
      defaultConnection?: boolean;
    }>
  >;
}
