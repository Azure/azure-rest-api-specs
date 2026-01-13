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

namespace Microsoft.Network;
/**
 * Defines the properties of an Experiment
 */
@parentResource(Profile)
model Experiment is Azure.ResourceManager.ProxyResource<ExperimentProperties> {
  ...ResourceNameParameter<
    Resource = Experiment,
    KeyName = "experimentName",
    SegmentName = "Experiments",
    NamePattern = "^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$"
  >;

  /** Resource tags. */
  tags?: Record<string>;

  /**
   * Resource location.
   */
  location?: string;
}

@armResourceOperations
interface Experiments {
  /**
   * Gets an Experiment by ExperimentName
   */
  get is ArmResourceRead<Experiment, Error = ErrorResponse>;

  /**
   * Creates or updates an Experiment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @summary("Creates or updates an Experiment")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Experiment,
    Response = ArmResourceUpdatedResponse<Experiment> | ArmResourceCreatedResponse<
      Experiment,
      ArmLroLocationHeader<FinalResult = Experiment> &
        Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Experiment;
    }),
    Error = ErrorResponse
  >;

  /**
   * Updates an Experiment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @summary("Updates an Experiment by Experiment id")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Experiment,
    PatchModel = ExperimentUpdateModel,
    Response = ArmResponse<Experiment> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Experiment;
    }),
    Error = ErrorResponse
  >;

  /**
   * Deletes an Experiment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Deletes an Experiment")
  delete is ArmResourceDeleteWithoutOkAsync<
    Experiment,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets a list of Experiments
   */
  @summary("Gets a list of Experiments")
  listByProfile is ArmResourceListByParent<
    Experiment,
    Response = ArmResponse<ExperimentList>,
    Error = ErrorResponse
  >;

  /**
   * Gets a Latency Scorecard for a given Experiment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Reports_GetLatencyScorecards")
  @get
  @action("LatencyScorecard")
  @summary("Gets a Latency Scorecard for a given Experiment")
  getLatencyScorecards is ArmResourceActionSync<
    Experiment,
    void,
    ArmResponse<LatencyScorecard>,
    Parameters = {
      /**
       * The end DateTime of the Latency Scorecard in UTC
       */
      @query("endDateTimeUTC")
      endDateTimeUTC?: string;

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
    Error = ErrorResponse
  >;

  /**
   * Gets a Timeseries for a given Experiment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Gets a Timeseries for a given Experiment")
  @operationId("Reports_GetTimeseries")
  @get
  @action("Timeseries")
  getTimeseries is ArmResourceActionSync<
    Experiment,
    void,
    ArmResponse<Timeseries>,
    Parameters = {
      /**
       * The start DateTime of the Timeseries in UTC
       */
      @query("startDateTimeUTC")
      startDateTimeUTC: utcDateTime;

      /**
       * The end DateTime of the Timeseries in UTC
       */
      @query("endDateTimeUTC")
      endDateTimeUTC: utcDateTime;

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
    Error = ErrorResponse
  >;
}

@@doc(Experiment.name,
  "The Experiment identifier associated with the Experiment"
);
@@doc(Experiment.properties, "The properties of an Experiment");
@@doc(Experiments.createOrUpdate::parameters.resource,
  "The Experiment resource"
);
@@doc(Experiments.update::parameters.properties, "The Experiment Update Model");
