import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./model.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace Azure.AI.Client.Endpoints;

/*
 See https://learn.microsoft.com/rest/api/azureml/workspace-connections/list
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
#suppress "@azure-tools/typespec-azure-core/use-standard-names"
@doc("List the details of all the connections (not including their credentials)")
@route("connections")
@get
op list is Azure.Core.Foundations.Operation<{}, ConnectionsListResponse>;