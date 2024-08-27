import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.FootprintMonitoring;

interface Operations {
  @tag("Operations")
  @autoRoute
  @doc("List the operations for the provider")
  @segment("operations")
  @armResourceRead(Azure.ResourceManager.Foundations.OperationListResult)
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all operations (maximum).`: {
        $ref: "./examples/Operations_List_MaximumSet_Gen.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all operations (maximum).`: {
        $ref: "./examples/Operations_List_MinimumSet_Gen.json",
      },
    }
  )
  @get
  list(
    ...ApiVersionParameter,

    @path
    @segment("providers")
    @doc("The provider namespace (this parameter will not show up in operations).")
    provider: "Microsoft.ThisWillBeReplaced",
  ): ArmResponse<Azure.ResourceManager.Foundations.OperationListResult> | ErrorResponse;
}
/**
 * The provisioned state of the resource.
 */
union ProvisioningState {
  string,

  /** Succeeded state */
  Succeeded: "Succeeded",

  /** Failed state */
  Failed: "Failed",

  /** Canceled state */
  Canceled: "Canceled",

  /** Updating state */
  Updating: "Updating",

  /** Deleting state */
  Deleting: "Deleting",
}

/**
 * The type of a Footprint measurement endpoint condition.
 */
union Type {
  string,

  /** RequestHeader type */
  RequestHeader: "RequestHeader",
}

/**
 * The operator of a Footprint measurement endpoint condition.
 */
union Operator {
  string,

  /** IsExactValue operator */
  IsExactValue: "IsExactValue",

  /** IsExactValueIgnoreCasing operator */
  MatchValueIgnoreCasing: "MatchValueIgnoreCasing",

  /** ContainsValue operator */
  ContainsValue: "ContainsValue",

  /** ContainsValueIgnoreCasing operator */
  ContainsValueIgnoreCasing: "ContainsValueIgnoreCasing",

  /** DoesNotContainValue operator */
  DoesNotContainValue: "DoesNotContainValue",

  /** DoesNotContainValueIgnoreCasing operator */
  DoesNotContainValueIgnoreCasing: "DoesNotContainValueIgnoreCasing",
}

/**
 * Describes the Resource Provider Operation.
 */
model ResourceProviderOperationDefinition {
  /**
   * Resource provider operation name.
   */
  name?: string;

  /**
   * Resource provider display properties.
   */
  display?: ResourceProviderOperationDisplay;
}

/**
 * Describes the properties of the Operation.
 */
model ResourceProviderOperationDisplay {
  /**
   * Name of the resource provider.
   */
  provider?: string;

  /**
   * Name of the resource type.
   */
  resource?: string;

  /**
   * Name of the resource provider operation.
   */
  operation?: string;

  /**
   * Description of the resource provider operation.
   */
  description?: string;
}

/**
 * The base response with an error.
 */
@error
model DefaultErrorResponse {
  /**
   * The error details, if any.
   */
  error?: ErrorDefinition;
}

/**
 * The details of an error.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;
}

/**
 * A model representing the Footprint profile resource.
 */
model ProfileProperties {
  /**
   * The provisioned state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;

  /**
   * The id of the Footprint profile.
   */
  @visibility("read")
  profileId?: string;

  /**
   * The description of the Footprint profile.
   */
  description?: string;

  /**
   * The delay in milliseconds that the clients should wait for until they start performing measurements.
   */
  @maxValue(3600000)
  startDelayMilliseconds: int32;

  /**
   * The URL where the script for the Footprint profile.
   */
  @visibility("read")
  scriptUri?: string;

  /**
   * The number of measurements to perform.
   */
  measurementCount: int32;

  /**
   * The default sampling percentage for cold path measurement storage.
   */
  @maxValue(100)
  coldPathSamplingPercentageRate?: float32;

  /**
   * The endpoints which to perform measurements to.
   */
  @visibility("read")
  measurementEndpoints?: SubResource[];

  /**
   * The endpoints which to upload measurements to.
   */
  reportingEndpoints?: string[];

  /**
   * The experiments currently associated to this Footprint profile.
   */
  @visibility("read")
  experiments?: SubResource[];
}

/**
 * An Azure resource that is child to another Azure resource.
 */
model SubResource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility("read")
  id?: string;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * Fully qualified resource Id for the resource.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Tags for the resource.
   */
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * Region where the Azure resource is located.
   */
  @visibility("read", "create")
  location?: string;
}

/**
 * The model for patches on Footprint profile resources.
 */
model ProfilePatch {
  /**
   * The tags for this resource.
   */
  tags?: Record<string>;
}

/**
 * A model representing the Footprint Measurement Endpoint resource.
 */
model MeasurementEndpointProperties {
  /**
   * The id of a measurement endpoint.
   */
  @visibility("read")
  @maxLength(32)
  @minLength(32)
  @pattern("[a-f0-9]{32}")
  endpointId?: string;

  /**
   * The description of a measurement endpoint.
   */
  description?: string;

  /**
   * The value of a measurement endpoint.
   */
  @maxLength(1024)
  @pattern("^[a-z0-9\\*]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?$")
  endpoint: string;

  /**
   * The type of a measurement endpoint.
   */
  measurementType: int32;

  /**
   * The weight of a measurement endpoint, higher weight means higher priority.
   */
  @maxValue(2147483647)
  weight: int32;

  /**
   * The id of an experiment that a measurement endpoint is part of.
   */
  @maxLength(32)
  @minLength(32)
  @pattern("[a-f0-9]{32}")
  experimentId?: string;

  /**
   * The path of the object that a measurement endpoint points to.
   */
  @maxLength(1024)
  @pattern("^/[a-zA-Z0-9-._~%!$&()*+,;=@/]*$")
  objectPath?: string;

  /**
   * The conditions of a measurement endpoint.
   */
  @visibility("read")
  conditions?: SubResource[];

  /**
   * The start time that a measurement endpoint should be served.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  startTimeUTC?: utcDateTime;

  /**
   * The end time that a measurement endpoint should be served.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  #suppress "@azure-tools/typespec-azure-core/casing-style" ""
  endTimeUTC?: utcDateTime;

  /**
   * The sample rate, in percent, for the hot path logging of a measurement endpoint.
   */
  @maxValue(100)
  hotPathSamplingPercentageRate?: float32;

  /**
   * The sample rate, in percent, for the warm path logging of a measurement endpoint.
   */
  @maxValue(100)
  warmPathSamplingPercentageRate?: float32;

  /**
   * The sample rate, in percent, for the cold path logging of a measurement endpoint.
   */
  @maxValue(100)
  coldPathSamplingPercentageRateOverride?: float32;

  /**
   * The metadata of a measurement endpoint.
   */
  metadata?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A model representing the Footprint Measurement Endpoint Condition resource.
 */
model MeasurementEndpointConditionProperties {
  /**
   * The id of a Footprint measurement endpoint condition.
   */
  @visibility("read")
  @maxLength(32)
  @minLength(32)
  @pattern("[a-f0-9]{32}")
  conditionId?: string;

  /**
   * The type of a Footprint measurement endpoint condition.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" ""
  type: Type;

  /**
   * The variable of a Footprint measurement endpoint condition.
   */
  variable: string;

  /**
   * The operator of a Footprint measurement endpoint condition.
   */
  operator: Operator;

  /**
   * The constant of a Footprint measurement endpoint condition.
   */
  constant: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A model representing the Footprint Experiment resource.
 */
model ExperimentProperties {
  /**
   * The id of a Footprint experiment.
   */
  @visibility("read")
  @maxLength(32)
  @minLength(32)
  @pattern("[a-f0-9]{32}")
  experimentId?: string;

  /**
   * The description of a Footprint experiment.
   */
  description?: string;

  /**
   * The status of a Footprint experiment.
   */
  @visibility("read")
  status?: string;

  /**
   * The provisioned state of the resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}
