import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace ResourceGraphClient;

/**
 * Queries the resources managed by Azure Resource Manager for scopes specified in the request.
 */
@route("/providers/Microsoft.ResourceGraph/resources")
@post
op resources is Azure.Core.Foundations.Operation<QueryRequest, QueryResponse>;

/**
 * List all snapshots of a resource for a given time interval.
 */
@route("/providers/Microsoft.ResourceGraph/resourcesHistory")
@post
op resourcesHistory is Azure.Core.Foundations.Operation<
  ResourcesHistoryRequest,
  void
>;
