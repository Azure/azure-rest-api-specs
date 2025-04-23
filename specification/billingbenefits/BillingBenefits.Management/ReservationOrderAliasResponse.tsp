import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Reservation order alias
 */
@tenantResource
model ReservationOrderAliasResponse
  is Azure.ResourceManager.ProxyResource<ReservationOrderAliasResponseProperties> {
  ...ResourceNameParameter<
    Resource = ReservationOrderAliasResponse,
    KeyName = "reservationOrderAliasName",
    SegmentName = "reservationOrderAliases",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * Reservation order SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: ResourceSku;

  /**
   * The Azure Region where the reserved resource lives.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface ReservationOrderAliasResponses {
  /**
   * Get a reservation order alias.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReservationOrderAlias_Get")
  get is ArmResourceRead<
    ReservationOrderAliasResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create a reservation order alias.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReservationOrderAlias_Create")
  @armResourceCreateOrUpdate(ReservationOrderAliasResponse)
  create is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      ReservationOrderAliasResponse,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<ReservationOrderAliasResponse>
    >,
    ReservationOrderAliasRequest,
    ReservationOrderAliasResponse | ArmResourceCreatedResponse<
      ReservationOrderAliasResponse,
      LroHeaders = ArmAsyncOperationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    ErrorResponse
  >;
}

@@doc(ReservationOrderAliasResponse.name,
  "Name of the reservation order alias"
);
@@doc(ReservationOrderAliasResponse.properties,
  "Reservation order alias response properties"
);
@@doc(ReservationOrderAliasResponses.create::parameters.resource,
  "Request body for creating a reservation order alias"
);
