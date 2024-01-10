import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Insights;
@doc("Definition of ARM tracked top level resource.")
model DataCollectionRuleResource
  is TrackedResource<DataCollectionRuleResourceProperties> {
  @doc("The name of the data collection rule. The name is case insensitive.")
  @key("dataCollectionRuleName")
  @segment("dataCollectionRules")
  name: string;

  @doc("Resource entity tag (ETag).")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
@projectedName("client", "DataCollectionRules")
interface DataCollectionRuleResources_DataCollectionRules {
  @doc("Returns the specified data collection rule.")
  get is ArmResourceRead<DataCollectionRuleResource>;

  @doc("Creates or updates a data collection rule.")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRuleResource>;

  @doc("Updates part of a data collection rule.")
  update is ArmCustomPatchSync<DataCollectionRuleResource, ResourceForUpdate>;

  @doc("Deletes a data collection rule.")
  delete is ArmResourceDeleteSync<DataCollectionRuleResource>;

  @doc("Lists all data collection rules in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<DataCollectionRuleResource>;

  @doc("Lists all data collection rules in the specified subscription.")
  listBySubscription is ArmListBySubscription<DataCollectionRuleResource>;
}

@armResourceOperations
@projectedName("client", "DataCollectionRuleAssociations")
interface DataCollectionRuleResources_DataCollectionRuleAssociations {
  @summary("Lists associations for the specified data collection rule.")
  @doc("Lists associations for the specified data collection rule.")
  // FIXME: DataCollectionRuleAssociations_ListByRule could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Insights/dataCollectionRules/{dataCollectionRuleName}/associations")
  @get
  ListByRule is Azure.Core.Foundations.Operation<
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

      @doc("The name of the data collection rule. The name is case insensitive.")
      @path
      dataCollectionRuleName: string;
    },
    ResourceListResult<DataCollectionRuleAssociationProxyOnlyResource>
  >;
}
