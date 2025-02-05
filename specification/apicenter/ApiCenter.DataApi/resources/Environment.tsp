import "@typespec/rest";
import "../models/models.tsp";
import "../models/environment.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

interface Environments {
  @doc("List a collection of environments.")
  list is Operations.ResourceList<
    Environment,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Cannot model with standard operations"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Legacy name"
  @doc("List a collection of environments across workspaces.")
  @route("/environments")
  listAll is Azure.Core.Foundations.Operation<
    StandardListQueryParameters,
    PagedEnvironmentAll
  >;

  @doc("Get an environment.")
  get is Operations.ResourceRead<Environment>;
}
