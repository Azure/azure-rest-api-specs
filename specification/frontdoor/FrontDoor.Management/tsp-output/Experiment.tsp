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
@doc("Defines the properties of an Experiment")
@parentResource(Profile)
model Experiment is TrackedResource<ExperimentProperties> {
  @doc("The Experiment identifier associated with the Experiment")
  @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
  @path
  @key("experimentName")
  @segment("Experiments")
  name: string;
}

@armResourceOperations
interface Experiments {
  @doc("Gets an Experiment by ExperimentName")
  get is ArmResourceRead<Experiment>;

  @doc("Creates or updates an Experiment")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<Experiment>;

  @doc("Updates an Experiment")
  update is ArmCustomPatchAsync<Experiment, ExperimentUpdateModel>;

  @doc("Deletes an Experiment")
  delete is ArmResourceDeleteAsync<Experiment>;

  @doc("Gets a list of Experiments")
  listByProfile is ArmResourceListByParent<Experiment>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_GetLatencyScorecards")
  @summary("Gets a Latency Scorecard for a given Experiment")
  @doc("Gets a Latency Scorecard for a given Experiment")
  // FIXME: Reports_GetLatencyScorecards could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/LatencyScorecard")
  @get
  getLatencyScorecards is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      experimentName: string;

      @doc("The end DateTime of the Latency Scorecard in UTC")
      @query("endDateTimeUTC")
      endOn?: utcDateTime;

      @doc("The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html")
      @query("country")
      country?: string;

      @doc("The aggregation interval of the Latency Scorecard")
      @query("aggregationInterval")
      aggregationInterval: LatencyScorecardAggregationInterval;
    },
    LatencyScorecard
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Reports_GetTimeseries")
  @summary("Gets a Timeseries for a given Experiment")
  @doc("Gets a Timeseries for a given Experiment")
  // FIXME: Reports_GetTimeseries could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/Timeseries")
  @get
  getTimeseries is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription credentials which uniquely identify the Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of the Resource group within the Azure subscription.")
      @maxLength(80)
      @minLength(1)
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("The Profile identifier associated with the Tenant and Partner")
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      profileName: string;

      @doc("The Experiment identifier associated with the Experiment")
      @pattern("^[a-zA-Z0-9_\\-\\(\\)\\.]*[^\\.]$")
      @path
      experimentName: string;

      @doc("The start DateTime of the Timeseries in UTC")
      @query("startDateTimeUTC")
      startOn: utcDateTime;

      @doc("The end DateTime of the Timeseries in UTC")
      @query("endDateTimeUTC")
      endOn: utcDateTime;

      @doc("The aggregation interval of the Timeseries")
      @query("aggregationInterval")
      aggregationInterval: TimeseriesAggregationInterval;

      @doc("The type of Timeseries")
      @query("timeseriesType")
      timeseriesType: TimeseriesType;

      @doc("The specific endpoint")
      @query("endpoint")
      endpoint?: string;

      @doc("The country associated with the Timeseries. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html")
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
