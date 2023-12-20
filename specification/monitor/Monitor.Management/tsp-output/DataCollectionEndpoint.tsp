import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Monitor;
@doc("Definition of ARM tracked top level resource.")
model DataCollectionEndpoint
  is TrackedResource<DataCollectionEndpointResourceProperties> {
  @doc("The name of the data collection endpoint. The name is case insensitive.")
  @path
  @key("dataCollectionEndpointName")
  @segment("dataCollectionEndpoints")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataCollectionEndpoints {
  @doc("Returns the specified data collection endpoint.")
  get is ArmResourceRead<DataCollectionEndpoint>;
  @doc("Creates or updates a data collection endpoint.")
  create is ArmResourceCreateOrReplaceSync<DataCollectionEndpoint>;
  @doc("Updates part of a data collection endpoint.")
  update is ArmTagsPatchSync<DataCollectionEndpoint>;
  @doc("Deletes a data collection endpoint.")
  delete is ArmResourceDeleteSync<DataCollectionEndpoint>;
  @doc("Lists all data collection endpoints in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<DataCollectionEndpoint>;
  @doc("Lists all data collection endpoints in the specified subscription")
  listBySubscription is ArmListBySubscription<DataCollectionEndpoint>;
  @summary("Lists associations for the specified data collection endpoint.")
  @doc("Lists associations for the specified data collection endpoint.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionEndpoints/{dataCollectionEndpointName}/associations")
  @get
  ListByDataCollectionEndpoint is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the data collection endpoint. The name is case insensitive.")
      @path
      dataCollectionEndpointName: string;
    },
    DataCollectionRuleAssociationProxyOnlyResourceListResult
  >;
}
