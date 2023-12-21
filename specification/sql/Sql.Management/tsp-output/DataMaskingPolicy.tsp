import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("Represents a database data masking policy.")
@singleton("Default")
@parentResource(Database)
model DataMaskingPolicy is ProxyResource<DataMaskingPolicyProperties> {
  @key("dataMaskingPolicyName")
  @segment("dataMaskingPolicies")
  name: string;

  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface DataMaskingPolicies {
  @doc("Gets a database data masking policy.")
  get is ArmResourceRead<
    DataMaskingPolicy,
    {
      ...BaseParameters<DataMaskingPolicy>;

      @doc("The name of the database for which the data masking rule applies.")
      @path
      dataMaskingPolicyName: "Default";
    }
  >;
  @doc("Creates or updates a database data masking policy")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    DataMaskingPolicy,
    {
      ...BaseParameters<DataMaskingPolicy>;

      @doc("The name of the database for which the data masking rule applies.")
      @path
      dataMaskingPolicyName: "Default";
    }
  >;
}

@armResourceOperations
interface DataMaskingRules {
  @doc("Gets a list of database data masking rules.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Sql/servers/{serverName}/databases/{databaseName}/dataMaskingPolicies/{dataMaskingPolicyName}/rules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription ID that identifies an Azure subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the resource. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the server.")
      @path
      serverName: string;

      @doc("The name of the database.")
      @path
      databaseName: string;

      @doc("The name of the database for which the data masking rule applies.")
      @path
      dataMaskingPolicyName: "Default";
    },
    DataMaskingRuleListResult
  >;
}
