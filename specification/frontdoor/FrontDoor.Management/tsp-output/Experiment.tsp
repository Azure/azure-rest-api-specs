import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Network;
/**
 * Defines the properties of an Experiment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Profile)
@Azure.ResourceManager.Private.armResourceInternal(ExperimentProperties)
@includeInapplicableMetadataInPayload(false)
model Experiment extends FrontDoorResourceModel {
  /**
   * The Experiment identifier associated with the Experiment
   */
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  @path
  @key("experimentName")
  @segment("Experiments")
  name: string;

  /**
   * The properties of an Experiment
   */
  @extension("x-ms-client-flatten", true)
  properties?: ExperimentProperties;
}

@armResourceOperations
interface Experiments {
  /**
   * Gets an Experiment by ExperimentName
   */
  get is ArmResourceRead<Experiment>;

  /**
   * Creates or updates an Experiment
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Experiment>;

  /**
   * Updates an Experiment
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<Experiment, ExperimentUpdateModel>;

  /**
   * Deletes an Experiment
   */
  delete is ArmResourceDeleteAsync<Experiment>;

  /**
   * Gets a list of Experiments
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Experiments_ListByProfile")
  listByProfile is ArmResourceListByParent<Experiment>;

  /**
   * Gets a Latency Scorecard for a given Experiment
   */
  // FIXME: Reports_GetLatencyScorecards could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_GetLatencyScorecards")
  @summary("Gets a Latency Scorecard for a given Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/LatencyScorecard")
  @get
  getLatencyScorecards is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The Profile identifier associated with the Tenant and Partner
       */
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      profileName: string;

      /**
       * The Experiment identifier associated with the Experiment
       */
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      experimentName: string;

      /**
       * The end DateTime of the Latency Scorecard in UTC
       */
      @query("endDateTimeUTC")
      endOn?: utcDateTime;

      /**
       * The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
       */
      @query("country")
      country?: string;

      /**
       * The aggregation interval of the Latency Scorecard
       */
      @query("aggregationInterval")
      aggregationInterval: LatencyScorecardAggregationInterval;
    },
    LatencyScorecard
  >;

  /**
   * Gets a Timeseries for a given Experiment
   */
  // FIXME: Reports_GetTimeseries could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_GetTimeseries")
  @summary("Gets a Timeseries for a given Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/Timeseries")
  @get
  getTimeseries is Azure.Core.Foundations.Operation<
    {
      /**
       * The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the Resource group within the Azure subscription.
       */
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      resourceGroupName: string;

      /**
       * The Profile identifier associated with the Tenant and Partner
       */
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      profileName: string;

      /**
       * The Experiment identifier associated with the Experiment
       */
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      experimentName: string;

      /**
       * The start DateTime of the Timeseries in UTC
       */
      @query("startDateTimeUTC")
      startOn: utcDateTime;

      /**
       * The end DateTime of the Timeseries in UTC
       */
      @query("endDateTimeUTC")
      endOn: utcDateTime;

      /**
       * The aggregation interval of the Timeseries
       */
      @query("aggregationInterval")
      aggregationInterval: TimeseriesAggregationInterval;

      /**
       * The type of Timeseries
       */
      @query("timeseriesType")
      timeseriesType: TimeseriesType;

      /**
       * The specific endpoint
       */
      @query("endpoint")
      endpoint?: string;

      /**
       * The country associated with the Timeseries. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html
       */
      @query("country")
      country?: string;
    },
    Timeseries
  >;
}

@@projectedName(Experiments.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Experiments.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Experiments.createOrUpdate::parameters.resource,
  "The Experiment resource"
);
@@projectedName(Experiments.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Experiments.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Experiments.update::parameters.properties, "The Experiment Update Model");
