import "./Quota/main.tsp";
import "./Reservations/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@client({
  name: "ReservationsClient",
  service: [Quota, Reservations],
})
namespace ReservationsClient;
