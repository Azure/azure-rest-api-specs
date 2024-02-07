import "@typespec/http";
import "@typespec/versioning";

@service({
  title: "Azure.Messaging.SystemEvents",
})
@doc("Azure Messaging EventGrid SystemEvents")
@versioned(ServiceApiVersions)
namespace Microsoft.EventGrid.SystemEvents {
  using TypeSpec.Versioning;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "https://github.com/Azure/typespec-azure/issues/3107"
  enum ServiceApiVersions {
    v2024_01_01: "2024-01-01",
  }
}
