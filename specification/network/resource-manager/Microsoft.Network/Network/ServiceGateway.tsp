import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * ServiceGateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Http.Private.includeInapplicableMetadataInPayload(false)
model ServiceGateway extends CommonTrackedResource {
  properties?: ServiceGatewayPropertiesFormat;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  @path
  @key("serviceGatewayName")
  @segment("serviceGateways")
  @pattern("^[a-zA-Z0-9-]*$")
  name: string;

  /** A unique read-only string that changes whenever the resource is updated. */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The service gateway SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: ServiceGatewaySku;

  /** A list of availability zones denoting where the resource needs to come from. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  zones?: string[];
}

@armResourceOperations
interface ServiceGateways {
  /**
   * Gets the specified service gateway.
   */
  get is ArmResourceRead<ServiceGateway>;

  /**
   * Creates or updates a service gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ServiceGateway>;

  /**
   * Updates a service gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<ServiceGateway, PatchModel = TagsObject>;

  /**
   * Deletes the specified service gateway.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ServiceGateway>;

  /**
   * Gets all the service gateways in a resource group.
   */
  list is ArmResourceListByParent<ServiceGateway>;

  /**
   * Gets all the service gateways in a subscription.
   */
  listAll is ArmListBySubscription<ServiceGateway>;

  /**
   * Creates or updates address locations within the service gateway.
   *
   * The request supports both full and partial update modes at two levels: location and address.
   *
   * Full update replaces all existing data.
   *
   * Partial update modifies only the specified entries:
   *
   * For location-level partial updates, if no address is provided, the existing address will be deleted.
   *
   * For address-level partial updates, if no services are provided, the existing services will be considered for deletion.
   */
  updateAddressLocations is ArmResourceActionAsync<
    ServiceGateway,
    ServiceGatewayUpdateAddressLocationsRequest,
    NoContentResponse
  >;

  /**
   * Creates, updates, or deletes services within the service gateway.
   * The request supports both full and partial update modes at the service level.
   *
   * Full update replaces all existing services with the new list provided in the request.
   * Partial update modifies only the specified services.
   */
  updateServices is ArmResourceActionAsync<
    ServiceGateway,
    ServiceGatewayUpdateServicesRequest,
    NoContentResponse
  >;

  /**
   * Get address locations in service gateway.
   */
  @list
  @get
  @action("addressLocations")
  getAddressLocations is ArmResourceActionSync<
    ServiceGateway,
    void,
    ArmResponse<GetServiceGatewayAddressLocationsResult>
  >;

  /**
   * Get Services in service gateway.
   */
  @list
  @get
  @action("services")
  getServices is ArmResourceActionSync<
    ServiceGateway,
    void,
    ArmResponse<GetServiceGatewayServicesResult>
  >;
}

@@doc(ServiceGateway.name, "The name of the service gateway.");
@@doc(ServiceGateway.properties, "Properties of service gateway.");
@@doc(ServiceGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service gateway operation."
);
@@doc(ServiceGateways.updateTags::parameters.properties,
  "Parameters supplied to update service gateway tags."
);
@@doc(ServiceGateways.updateAddressLocations::parameters.body,
  "Parameters supplied to the create or updates address locations in service gateway operation."
);
@@doc(ServiceGateways.updateServices::parameters.body,
  "Parameters supplied to the create or updates services in service gateway operation."
);
