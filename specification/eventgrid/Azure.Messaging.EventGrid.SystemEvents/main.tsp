import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

@service({
  title: "Azure.Messaging.SystemEvents",
})
@server(
  "{endpoint}",
  "",
  {
    @doc("")
    endpoint: url,
  }
)
@doc("Azure Messaging EventGrid SystemEvents")
@versioned(ServiceApiVersions)
namespace Microsoft.EventGrid.SystemEvents {
  using TypeSpec.Http;
  using TypeSpec.Rest;
  using TypeSpec.Versioning;
  using Azure.Core;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
  enum ServiceApiVersions {
    @useDependency(Azure.Core.Versions.v1_0_Preview_2)
    v2024_01_01: "2024-01-01",
  }
}
