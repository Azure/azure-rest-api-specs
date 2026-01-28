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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Profile)
@Http.Private.includeInapplicableMetadataInPayload(false)
model Experiment extends Resource {
  properties?: ExperimentProperties;

  @visibility(Lifecycle.Read)
  @path
  @key("experimentName")
  @segment("Experiments")
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  name: string;
}

@armResourceOperations
interface Experiments {
  /**
   * Gets an Experiment by ExperimentName
   */
  @summary("Gets an Experiment by ExperimentName")
  get is ArmResourceRead<Experiment, Error = ErrorResponse>;

  /**
   * Creates or updates an Experiment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates an Experiment by Experiment id")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Experiment,
    PatchModel = ExperimentUpdateModel,
    Response = ArmResponse<Experiment> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Experiment> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Experiment;
    }),
    Error = ErrorResponse
  >;

  /**
   * Deletes an Experiment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Reports_GetLatencyScorecards")
  @get
  @action("LatencyScorecard")
  @summary("Gets a Latency Scorecard for a given Experiment")
  getLatencyScorecards is ArmResourceActionSync<
    Experiment,
    void,
    ArmResponse<LatencyScorecard>,
    Parameters = GetLatencyScorecardsParameters,
    Error = ErrorResponse
  >;

  /**
   * Gets a Timeseries for a given Experiment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets a Timeseries for a given Experiment")
  @operationId("Reports_GetTimeseries")
  @get
  @action("Timeseries")
  getTimeseries is ArmResourceActionSync<
    Experiment,
    void,
    ArmResponse<Timeseries>,
    Parameters = GetTimeseriesParameters,
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
