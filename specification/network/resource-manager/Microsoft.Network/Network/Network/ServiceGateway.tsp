import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Common;
using Azure.ClientGenerator.Core;

namespace Microsoft.Network;
/**
 * ServiceGateway resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "ServiceGateway uses Http.Private.includeInapplicableMetadataInPayload to suppress irrelevant ARM envelope properties from the response payload, which is required for correct wire format compatibility."
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "ServiceGateway extends SecurityPerimeterTrackedResource, a shared base type defined in the Common namespace that captures the standard NSP-linked tracked resource shape. Refactoring to a standard ARM resource would require breaking changes to the existing API surface."
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "ServiceGateway inherits from SecurityPerimeterTrackedResource to share common NSP envelope properties (identity, kind, etag) across all security perimeter resource types. Composition would duplicate these definitions across the codebase."
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "ServiceGateway uses Azure.ResourceManager.Legacy.feature gating to align with the NSP feature flag pattern used across all perimeter-linked resources in this namespace."
@Azure.ResourceManager.Legacy.feature(Features.serviceGateway)
@Http.Private.includeInapplicableMetadataInPayload(false)
model ServiceGateway extends SecurityPerimeterTrackedResource {
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

  /** A list of availability zones denoting the zone in which service gateway should be deployed.
   *
   * - The zone values must be provided as strings representing numeric identifiers like "1", "2", "3" etc. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "The zones property is a top-level envelope field required for availability zone deployment configuration. It is consistent with the existing pattern used by other zonal resources in this namespace (e.g. NatGateway, PublicIPAddress) and must remain in the envelope for backward compatibility."
  zones?: string[];
}

@doc("Empty success response.")
model ServiceGatewayActionOkResponseBody {
  /** The status of the operation. */
  @visibility(Lifecycle.Read)
  status?: string;
}

/** Status-only success response for synchronous service gateway update actions. */
model ServiceGatewayActionOkResponse {
  /** HTTP status code for successful request processing. */
  @statusCode
  statusCode: 200;

  /** Empty response body for successful synchronous service gateway update actions. */
  @body
  body: ServiceGatewayActionOkResponseBody;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "ServiceGateways interface uses Azure.ResourceManager.Legacy.feature gating to conditionally expose operations only when the serviceGateway feature flag is enabled, consistent with the feature-gating pattern used across all NSP-linked resource operations in this namespace."
@Azure.ResourceManager.Legacy.feature(Features.serviceGateway)
@armResourceOperations
interface ServiceGateways {
  /**
   * Gets the specified service gateway.
   */
  get is ArmResourceRead<ServiceGateway, Error = CloudError>;

  /**
   * Creates or updates a service gateway.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServiceGateway,
    Error = CloudError
  >;

  /**
   * Updates a service gateway tags.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    ServiceGateway,
    PatchModel = TagsObject,
    Error = CloudError
  >;

  /**
   * Deletes the specified service gateway.
   */
  delete is ArmResourceDeleteWithoutOkAsync<ServiceGateway, Error = CloudError>;

  /**
   * Gets all the service gateways in a resource group.
   */
  list is ArmResourceListByParent<ServiceGateway, Error = CloudError>;

  /**
   * Gets all the service gateways in a subscription.
   */
  listAll is ArmListBySubscription<ServiceGateway, Error = CloudError>;

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
  @removed(Versions.v2025_09_01)
  updateAddressLocationsLro is ArmResourceActionAsync<
    ServiceGateway,
    ServiceGatewayUpdateAddressLocationsRequest,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

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
  @added(Versions.v2025_09_01)
  updateAddressLocations is ArmResourceActionSync<
    ServiceGateway,
    ServiceGatewayUpdateAddressLocationsRequest,
    ServiceGatewayActionOkResponse,
    Error = CloudError
  >;

  /**
   * Creates, updates, or deletes services within the service gateway.
   * The request supports both full and partial update modes at the service level.
   *
   * Full update replaces all existing services with the new list provided in the request.
   * Partial update modifies only the specified services.
   */
  @removed(Versions.v2025_09_01)
  updateServicesLro is ArmResourceActionAsync<
    ServiceGateway,
    ServiceGatewayUpdateServicesRequest,
    NoContentResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Creates, updates, or deletes services within the service gateway.
   * The request supports both full and partial update modes at the service level.
   *
   * Full update replaces all existing services with the new list provided in the request.
   * Partial update modifies only the specified services.
   */
  @added(Versions.v2025_09_01)
  updateServices is ArmResourceActionSync<
    ServiceGateway,
    ServiceGatewayUpdateServicesRequest,
    ServiceGatewayActionOkResponse,
    Error = CloudError
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
    ArmResponse<GetServiceGatewayAddressLocationsResult>,
    Error = CloudError
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
    ArmResponse<GetServiceGatewayServicesResult>,
    Error = CloudError
  >;
}

@@doc(ServiceGateway.name, "The name of the service gateway.");
@@doc(ServiceGateway.properties, "Properties of service gateway.");
@@doc(
  ServiceGateways.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update service gateway operation."
);
@@doc(
  ServiceGateways.updateTags::parameters.properties,
  "Parameters supplied to update service gateway tags."
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "The LRO variant uses a different TypeSpec member name to enable versioning, but must preserve the original operationId for wire backward compatibility with 2025-05-01 and 2025-07-01."
@@operationId(
  ServiceGateways.updateAddressLocationsLro,
  "ServiceGateways_UpdateAddressLocations"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "The LRO variant uses a different TypeSpec member name to enable versioning, but must preserve the original operationId for wire backward compatibility with 2025-05-01 and 2025-07-01."
@@operationId(
  ServiceGateways.updateServicesLro,
  "ServiceGateways_UpdateServices"
);
@@doc(
  ServiceGateways.updateAddressLocationsLro::parameters.body,
  "Parameters supplied to create or update address locations in service gateway operation."
);
@@doc(
  ServiceGateways.updateAddressLocations::parameters.body,
  "Parameters supplied to create or update address locations in service gateway operation."
);
@@doc(
  ServiceGateways.updateServicesLro::parameters.body,
  "Parameters supplied to create or update services in service gateway operation."
);
@@doc(
  ServiceGateways.updateServices::parameters.body,
  "Parameters supplied to create or update services in service gateway operation."
);
@@clientName(ServiceGateways.createOrUpdate::parameters.resource, "parameters");
@@clientName(ServiceGateways.updateTags::parameters.properties, "parameters");
@@clientName(
  ServiceGateways.updateAddressLocationsLro::parameters.body,
  "parameters"
);
@@clientName(
  ServiceGateways.updateAddressLocations::parameters.body,
  "parameters"
);
@@clientName(ServiceGateways.updateServicesLro::parameters.body, "parameters");
@@clientName(ServiceGateways.updateServices::parameters.body, "parameters");
