import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./CurrentUsagesBase.tsp";
import "./CurrentQuotaLimitBase.tsp";
import "./QuotaRequestDetails.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * Microsoft Azure Quota Resource Provider
 */
@armProviderNamespace
@service({
  title: "Azure Quota Extension API",
})
@versioned(Versions)
namespace Microsoft.Quota;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2023-02-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2023_02_01: "2023-02-01",
}
