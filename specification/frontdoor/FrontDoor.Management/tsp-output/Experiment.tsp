import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

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
  update is ArmResourcePatchAsync<Experiment, ExperimentProperties>;
  @doc("Deletes an Experiment")
  delete is ArmResourceDeleteAsync<Experiment>;
  @doc("Gets a list of Experiments")
  listByProfile is ArmResourceListByParent<Experiment>;
  @summary("Gets a Latency Scorecard for a given Experiment")
  @doc("Gets a Latency Scorecard for a given Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/LatencyScorecard")
  @get
  GetLatencyScorecards is Azure.Core.Foundations.Operation<
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
      endDateTimeUTC?: string;

      @doc("The country associated with the Latency Scorecard. Values are country ISO codes as specified here- https://www.iso.org/iso-3166-country-codes.html")
      @query("country")
      country?: string;

      @doc("The aggregation interval of the Latency Scorecard")
      @query("aggregationInterval")
      aggregationInterval: LatencyScorecardAggregationInterval;
    },
    LatencyScorecard
  >;

  @summary("Gets a Timeseries for a given Experiment")
  @doc("Gets a Timeseries for a given Experiment")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Network/NetworkExperimentProfiles/{profileName}/Experiments/{experimentName}/Timeseries")
  @get
  GetTimeseries is Azure.Core.Foundations.Operation<
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
      startDateTimeUTC: utcDateTime;

      @doc("The end DateTime of the Timeseries in UTC")
      @query("endDateTimeUTC")
      endDateTimeUTC: utcDateTime;

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
