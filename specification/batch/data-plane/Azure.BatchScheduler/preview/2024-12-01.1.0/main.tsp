import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using TypeSpec.Versioning;

@useAuth(
  OAuth2Auth<[
    {
      @doc("implicit flow")
      type: OAuth2FlowType.implicit,

      @doc("the authorization URL")
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",

      @doc("list of scopes for the credential")
      scopes: ["https://batch.microsoft.com/.default"],
    }
  ]>
)
@versioned(Azure.BatchScheduler.Versions)
@service({
  title: "The Batch Scheduler Service",
})
@server(
  "{batchUrl}",
  "A client for issuing REST requests to the Azure Batch Scheduler service.",
  {
    @doc("The endpoint hosting the requested resource. For example, https://{account}.{region}.batchscheduler.microsoft.com/jobs/{jobId}")
    batchUrl: string,
  }
)
@doc("The batch service vNext scheduler service.")
namespace Azure.BatchScheduler;
@doc("The batch scheduler version.")
enum Versions {
  @doc("Version 2024-12-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_12_01_Preview: "2024-12-01-preview",
}
