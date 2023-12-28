import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Azure.ResourceManager.ResourceGraph;

@doc("Queries the resources managed by Azure Resource Manager for scopes specified in the request.")
@route("/providers/Microsoft.ResourceGraph/resources")
@post
op Resources is Azure.Core.Foundations.Operation<QueryRequest, QueryResponse>;

@doc("List all snapshots of a resource for a given time interval.")
@route("/providers/Microsoft.ResourceGraph/resourcesHistory")
@post
op ResourcesHistory is Azure.Core.Foundations.Operation<
  ResourcesHistoryRequest,
  void
>;
