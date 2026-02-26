import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;

@service({
  title: "Sample Widget Service",
})
@versioned(Versions)
namespace Microsoft.Widget;

/** Service API versions */
enum Versions {
  /** 2024-01-01 version */
  v2024_01_01: "2024-01-01",
}
