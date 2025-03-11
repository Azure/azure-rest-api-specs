import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Unified;

alias ConnectionServiceTraits = SupportsClientRequestId &
  SupportsRepeatableRequests &
  SupportsConditionalRequests;

alias ConnectionOperations = Azure.Core.ResourceOperations<ConnectionServiceTraits>;

interface Connections {
  @doc("Get a connection by name.")
  get is ConnectionOperations.ResourceRead<Connection>;

  @doc("Get connection with secrets by name.")
  getWithCredentials is ConnectionOperations.ResourceAction<
    Connection,
    {},
    Connection
  >;

  @doc("List all connections in the project")
  list is ConnectionOperations.ResourceList<
    Connection,
    ListQueryParametersTrait<{
      @doc("Specific type of connection to return in list")
      @query("$connectionCategory")
      connectionCategory?: ConnectionCategory;

      ...StandardListQueryParameters;
    }>
  >;
}
