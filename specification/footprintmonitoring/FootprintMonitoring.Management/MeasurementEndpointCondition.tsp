import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MeasurementEndpoint.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FootprintMonitoring;
/**
 * A model representing the Footprint measurement endpoint condition.
 */
@parentResource(MeasurementEndpoint)
model MeasurementEndpointCondition
  is Azure.ResourceManager.ProxyResource<MeasurementEndpointConditionProperties> {
  ...ResourceNameParameter<
    Resource = MeasurementEndpointCondition,
    KeyName = "conditionName",
    SegmentName = "conditions",
    NamePattern = "^[a-zA-Z0-9]"
  >;

  /**
   * The type of the resource.
   */
  // @visibility("read")
  // type?: string;
}

@armResourceOperations
interface MeasurementEndpointConditions {
  /**
   * Retrieves the information about a single measurement endpoint condition under a Footprint measurement endpoint.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Get a Footprint measurement endpoint condition (max).`: {
        $ref: "./examples/MeasurementEndpointConditions_Get_MaximumSet_Gen.json",
      },
    }
  )
  get is ArmResourceRead<MeasurementEndpointCondition>;

  /**
   * Creates or updates a measurement endpoint condition under a Footprint measurement with the specified properties.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Create or update a Footprint measurement endpoint condition (max).`: {
        $ref: "./examples/MeasurementEndpointConditions_CreateOrUpdate_MaximumSet_Gen.json",
      },
    }
  )
  createOrUpdate is ArmResourceCreateOrReplaceSync<MeasurementEndpointCondition>;

  /**
   * Deletes an existing measurement endpoint condition under a Footprint measurement.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a Footprint measurement endpoint condition (max).`: {
        $ref: "./examples/MeasurementEndpointConditions_Delete_MaximumSet_Gen.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a Footprint measurement endpoint condition (min).`: {
        $ref: "./examples/MeasurementEndpointConditions_Delete_MinimumSet_Gen.json",
      },
    }
  )
  delete is ArmResourceDeleteSync<MeasurementEndpointCondition>;

  /**
   * Retrieves the information about all measurement endpoint conditions under a Footprint measurement endpoint.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all Footprint measurement endpoint conditions (max).`: {
        $ref: "./examples/MeasurementEndpointConditions_ListByMeasurementEndpoint_MaximumSet_Gen.json",
      },
    }
  )
  listByMeasurementEndpoint is ArmResourceListByParent<MeasurementEndpointCondition>;
}

@@maxLength(MeasurementEndpointCondition.name, 64);
@@minLength(MeasurementEndpointCondition.name, 5);
@@doc(MeasurementEndpointCondition.name,
  "Name of the Footprint measurement endpoint condition resource."
);
@@doc(MeasurementEndpointConditions.createOrUpdate::parameters.resource,
  "Footprint measurement condition creation or update parameters."
);
