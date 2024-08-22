import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FootprintMonitoring;
/**
 * A model representing a Footprint measurement endpoint.
 */
@parentResource(Profile)
model MeasurementEndpoint
  is Azure.ResourceManager.ProxyResource<MeasurementEndpointProperties> {
  ...ResourceNameParameter<
    Resource = MeasurementEndpoint,
    KeyName = "measurementEndpointName",
    SegmentName = "measurementEndpoints",
    NamePattern = "^[a-zA-Z0-9]"
  >;

  /**
   * The type of the resource.
   */
  // @visibility("read")
  // type?: string;
}

@armResourceOperations
interface MeasurementEndpoints {
  /**
   * Retrieves the information about a single measurement endpoint under a Footprint profile.
   */
  get is ArmResourceRead<MeasurementEndpoint>;

  /**
   * Creates or updates a single measurement endpoint under a Footprint profile with the specified properties.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<MeasurementEndpoint>;

  /**
   * Deletes an existing measurement endpoint under a Footprint profile.
   */
  delete is ArmResourceDeleteSync<MeasurementEndpoint>;

  /**
   * Retrieves the information about all measurement endpoints under a Footprint profile.
   */
  listByProfile is ArmResourceListByParent<MeasurementEndpoint>;
}

@@maxLength(MeasurementEndpoint.name, 64);
@@minLength(MeasurementEndpoint.name, 5);
@@doc(MeasurementEndpoint.name,
  "Name of the Footprint measurement endpoint resource."
);
@@doc(MeasurementEndpoints.createOrUpdate::parameters.resource,
  "Footprint measurement endpoint creation or update parameters."
);
