import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

@service({
  title: "Azure.Messaging.SystemEvents",
})
@server(
  "{endpoint}",
  "The host name of the namespace",
  {
    @doc("The host name of the namespace, e.g. namespaceName1.westus-1.eventgrid.azure.net")
    endpoint: url,
  }
)
@doc("Azure Messaging EventGrid Client")
@versioned(ServiceApiVersions)
namespace Microsoft.EventGrid {
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;
  using Azure.Core.Foundations;
  using Azure;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2018_01_01: "2018-01-01",
  }

  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"  "dummy operation"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"  "dummy operation"
  @doc("void")
  op dummyOperation(): void;
}
