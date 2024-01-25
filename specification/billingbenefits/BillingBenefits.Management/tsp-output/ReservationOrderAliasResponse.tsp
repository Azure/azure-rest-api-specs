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
/**
 * Reservation order alias
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  ReservationOrderAliasResponseProperties
)
model ReservationOrderAliasResponse extends ProxyResourceBase {
  /**
   * Name of the reservation order alias
   */
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("reservationOrderAliasName")
  @segment("reservationOrderAliases")
  @visibility("read")
  name: string;

  /**
   * Reservation order alias response properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ReservationOrderAliasResponseProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ReservationOrderAliasResponses {
  /**
   * Get a reservation order alias.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReservationOrderAlias_Get")
  get is ArmResourceRead<ReservationOrderAliasResponse>;

  /**
   * Create a reservation order alias.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ReservationOrderAlias_Create")
  create is ArmResourceCreateOrReplaceAsync<
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
