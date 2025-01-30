import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Edge;

@doc("Solution Instance State")
union State {
  @doc("Solution Instance is in review")
  InReview: "InReview",

  @doc("Solution Instance is ready to deploy")
  ReadyToDeploy: "ReadyToDeploy",

  @doc("Solution Instance is deploying")
  Deploying: "Deploying",

  @doc("Solution Instance is deployed")
  Deployed: "Deployed",

  @doc("Solution Instance failed to deploy")
  Failed: "Failed",

  string,
}
