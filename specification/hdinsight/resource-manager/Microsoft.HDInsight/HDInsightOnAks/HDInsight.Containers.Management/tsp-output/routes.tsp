import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.HDInsight;

interface LocationsOperations {
  @doc("Check the availability of the resource name.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/checkNameAvailability")
  @post
  checkNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;

      @doc("The name and type of the resource.")
      @body
      NameAvailabilityParameters: NameAvailabilityParameters;
    },
    NameAvailabilityResult
  >;
}

interface AvailableClusterPoolVersionsOperations {
  @doc("Returns a list of available cluster pool versions.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/availableClusterPoolVersions")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    ClusterPoolVersionsListResult
  >;
}

interface AvailableClusterVersionsOperations {
  @doc("Returns a list of available cluster versions.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.HDInsight/locations/{location}/availableClusterVersions")
  @get
  listByLocation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription. The value must be an UUID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure region.")
      @minLength(1)
      @path
      location: string;
    },
    ClusterVersionsListResult
  >;
}
