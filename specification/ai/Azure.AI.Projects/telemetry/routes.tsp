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

namespace Azure.AI.Projects.Telemetry;

/*
 See https://learn.microsoft.com/en-us/rest/api/azureml/workspaces/get?view=rest-azureml-2024-07-01-preview
*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Gets the properties of the specified Application Insights resource")
@route("/{appInsightsResourceUrl}")
@get
op getAppInsights is Azure.Core.Foundations.Operation<
  {
    @doc("The AppInsights Azure resource Url. It should have the format: '/subscriptions/{subscription_id}/resourceGroups/{resource_group_name}/providers/microsoft.insights/components/{resourcename}'")
    appInsightsResourceUrl: string;
  },
  GetAppInsightsResponse
>;
