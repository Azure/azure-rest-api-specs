import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "../models/api.tsp";
import "../models/models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using ApiCenter.DataApi;

@versioned(ApiCenter.DataApi.Versions)
namespace ApiCenter.DataApi;

interface Apis {
  @doc("List a collection of APIs.")
  list is Operations.ResourceList<
    Api,
    ListQueryParametersTrait<StandardListQueryParameters>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Cannot model with standard operations"
  @doc("List a collection of APIs across workspaces.")
  @route("/apis")
  listAll is Azure.Core.Foundations.Operation<
    StandardListQueryParameters,
    PagedApiAll
  >;

  @doc("Get an API.")
  get is Operations.ResourceRead<Api>;
}
