import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./ReservationDetail.tsp";
import "./ReservationOrder.tsp";
import "./ReservationQuota.tsp";
import "./QuotaRequestDetail.tsp";
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
@doc("This API describe Azure Reservation")
namespace Azure.ResourceManager.Reservations;
