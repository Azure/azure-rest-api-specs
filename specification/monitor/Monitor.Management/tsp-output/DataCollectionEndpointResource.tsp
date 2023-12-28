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
model DataCollectionEndpointResource
  is TrackedResource<DataCollectionEndpointResourceProperties> {
  @doc("The name of the data collection endpoint. The name is case insensitive.")
  @key("dataCollectionEndpointName")
  @segment("dataCollectionEndpoints")
  name: string;

  @doc("Resource entity tag (ETag).")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataCollectionEndpoints {
  @doc("Returns the specified data collection endpoint.")
  get is ArmResourceRead<DataCollectionEndpointResource>;
  @doc("Creates or updates a data collection endpoint.")
  create is ArmResourceCreateOrReplaceSync<DataCollectionEndpointResource>;
  @doc("Updates part of a data collection endpoint.")
  update is ArmCustomPatchSync<
    DataCollectionEndpointResource,
    ResourceForUpdate
  >;
  @doc("Deletes a data collection endpoint.")
  delete is ArmResourceDeleteSync<DataCollectionEndpointResource>;
  @doc("Lists all data collection endpoints in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<DataCollectionEndpointResource>;
  @doc("Lists all data collection endpoints in the specified subscription")
  listBySubscription is ArmListBySubscription<DataCollectionEndpointResource>;
}

@armResourceOperations
interface DataCollectionRuleAssociations {
  @summary("Lists associations for the specified data collection endpoint.")
  @doc("Lists associations for the specified data collection endpoint.")
  // FIXME: DataCollectionRuleAssociations_ListByDataCollectionEndpoint could not be converted to a resource operation
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
    ResourceListResult<DataCollectionRuleAssociationProxyOnlyResource>
  >;
}
