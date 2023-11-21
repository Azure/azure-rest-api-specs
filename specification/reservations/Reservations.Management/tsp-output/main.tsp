import "@typespec/rest";
import "@typespec/http";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
@service({
  title: "Azure Reservation API",
})
@server(
  "{$host}",
  "This API describe Azure Reservation",
  {
    $host: string,
  }
)
@doc("This API describe Azure Reservation")
namespace AzureReservationAPI;
