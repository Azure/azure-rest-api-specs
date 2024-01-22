import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ReservationResponse.tsp";
import "./ReservationOrderResponse.tsp";
import "./CurrentQuotaLimitBase.tsp";
import "./QuotaRequestDetails.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
/**
 * This API describe Azure Reservation
 */
@armProviderNamespace
@service({
  title: "Azure Reservation API",
})
@versioned(Versions)
// FIXME: Common type version v1 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v1)
namespace Microsoft.Capacity;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2022-11-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2022_11_01: "2022-11-01",

  /**
   * The 2020-10-25 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2020_10_25: "2020-10-25",
}
