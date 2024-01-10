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
@armProviderNamespace
@service({
  title: "Azure Reservation API",
})
// FIXME: Common type version v1 is not supported for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v1)
@doc("This API describe Azure Reservation")
namespace Microsoft.Capacity;
