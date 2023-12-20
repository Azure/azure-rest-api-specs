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
model DataCollectionRule
  is TrackedResource<DataCollectionRuleResourceProperties> {
  @doc("The name of the data collection rule. The name is case insensitive.")
  @path
  @key("dataCollectionRuleName")
  @segment("dataCollectionRules")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataCollectionRules {
  @doc("Returns the specified data collection rule.")
  get is ArmResourceRead<DataCollectionRule>;
  @doc("Creates or updates a data collection rule.")
  create is ArmResourceCreateOrReplaceSync<DataCollectionRule>;
  @doc("Updates part of a data collection rule.")
  update is ArmTagsPatchSync<DataCollectionRule>;
  @doc("Deletes a data collection rule.")
  delete is ArmResourceDeleteSync<DataCollectionRule>;
  @doc("Lists all data collection rules in the specified resource group.")
  listByResourceGroup is ArmResourceListByParent<DataCollectionRule>;
  @doc("Lists all data collection rules in the specified subscription.")
  listBySubscription is ArmListBySubscription<DataCollectionRule>;
  @summary("Lists associations for the specified data collection rule.")
  @doc("Lists associations for the specified data collection rule.")
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
    DataCollectionRuleAssociationProxyOnlyResourceListResult
  >;
}
