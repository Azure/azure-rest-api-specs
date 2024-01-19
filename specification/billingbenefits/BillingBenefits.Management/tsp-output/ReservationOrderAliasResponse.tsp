import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
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
interface ReservationOrderAliasResponses {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a reservation order alias.")
  @operationId("ReservationOrderAlias_Get")
  get is ArmResourceRead<ReservationOrderAliasResponse>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a reservation order alias.")
  @operationId("ReservationOrderAlias_Create")
  create is ArmResourceCreateOrUpdateAsync<
    ReservationOrderAliasResponse,
    BaseParameters<ReservationOrderAliasResponse>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(ReservationOrderAliasResponses.create::parameters.resource,
  "json",
  "body"
);
@@extension(ReservationOrderAliasResponses.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(ReservationOrderAliasResponses.create::parameters.resource,
  "Request body for creating a reservation order alias"
);
