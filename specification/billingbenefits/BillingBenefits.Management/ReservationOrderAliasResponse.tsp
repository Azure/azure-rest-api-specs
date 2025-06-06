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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(
  ReservationOrderAliasResponseProperties
)
@TypeSpec.Http.Private.includeInapplicableMetadataInPayload(false)
@tenantResource
model ReservationOrderAliasResponse extends Foundations.ProxyResource {
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

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
  @doc("The resource-specific properties for this resource.")
  properties?: ReservationOrderAliasResponseProperties;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
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
      LroHeaders = ArmAsyncOperationHeader<FinalResult = ReservationOrderAliasResponse> &
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
