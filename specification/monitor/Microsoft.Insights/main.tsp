import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(AadOauth2Auth<["https://metrics.monitor.azure.com/.default"]>)
@service({
  title: "Azure Monitor Metric Batch",
})
@versioned(Microsoft.Insights.Versions)
namespace Microsoft.Insights;

@doc("Versions info.")
enum Versions {
  @doc("The 2023-08-04-preview version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2023_08_04_Preview: "2023-08-04-preview",
}

alias OperationTemplates = Azure.Core.StandardResourceOperations;

@TypeSpec.Rest.resource("subscriptions")
@doc("d")
model Subscription {
  @key
  @visibility("read")
  @doc("s")
  subscriptionId: string;
}

@TypeSpec.Rest.actionSeparator("/")
@TypeSpec.Rest.action("metrics:getBatch")
op getBatch is OperationTemplates.ResourceAction<Subscription, {}, {}>;
