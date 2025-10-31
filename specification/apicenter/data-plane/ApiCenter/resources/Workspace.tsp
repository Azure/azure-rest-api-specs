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

alias WorkSpaceIdParameter = {
  @doc("Workspace identifier.")
  @maxLength(50)
  @path
  workspaceName: string;
};
