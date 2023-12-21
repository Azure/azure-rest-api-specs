import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.BillingBenefits;
@doc("Reservation order alias")
@tenantResource
model ReservationOrderAliasResponse
  is ProxyResource<ReservationOrderAliasResponseProperties> {
  @doc("Name of the reservation order alias")
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("reservationOrderAliasName")
  @segment("reservationOrderAliases")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ReservationOrderAlias {
  @doc("Get a reservation order alias.")
  get is ArmResourceRead<ReservationOrderAliasResponse>;
  @doc("Create a reservation order alias.")
  create is ArmResourceCreateOrUpdateAsync<ReservationOrderAliasResponse>;
}
