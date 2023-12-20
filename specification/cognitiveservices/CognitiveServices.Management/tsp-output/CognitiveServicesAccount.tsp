import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.CognitiveServices;
@doc("Cognitive Services account is an Azure resource representing the provisioned account, it's type, location and SKU.")
model CognitiveServicesAccount is TrackedResource<AccountProperties> {
  @doc("The name of Cognitive Services account.")
  @maxLength(64)
  @minLength(2)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface CognitiveServicesAccounts {
  @doc("Returns a Cognitive Services account specified by the parameters.")
  get is ArmResourceRead<CognitiveServicesAccount>;
  @doc("Create Cognitive Services Account. Accounts is a resource group wide resource type. It holds the keys for developer to access intelligent APIs. It's also the resource type for billing.")
  create is ArmResourceCreateOrUpdateAsync<CognitiveServicesAccount>;
  @doc("Updates a Cognitive Services account")
  update is ArmResourcePatchAsync<CognitiveServicesAccount, AccountProperties>;
  @doc("Deletes a Cognitive Services account from the resource group. ")
  delete is ArmResourceDeleteAsync<CognitiveServicesAccount>;
  @doc("Returns all the resources of a particular type belonging to a resource group")
  listByResourceGroup is ArmResourceListByParent<CognitiveServicesAccount>;
  @doc("Returns all the resources of a particular type belonging to a subscription.")
  list is ArmListBySubscription<CognitiveServicesAccount>;
  @doc("Lists the account keys for the specified Cognitive Services account.")
  listKeys is ArmResourceActionSync<CognitiveServicesAccount, void, ApiKeys>;
  @doc("Regenerates the specified account key for the specified Cognitive Services account.")
  regenerateKey is ArmResourceActionSync<
    CognitiveServicesAccount,
    RegenerateKeyParameters,
    ApiKeys
  >;
  @doc("List available SKUs for the requested Cognitive Services account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/skus")
  @get
  ListSkus is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of Cognitive Services account.")
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    AccountSkuListResult
  >;

  @doc("Get usages for the requested Cognitive Services account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/usages")
  @get
  ListUsages is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of Cognitive Services account.")
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).")
      @query("$filter")
      $filter?: string;
    },
    UsageListResult
  >;

  @doc("List available Models for the requested Cognitive Services account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/models")
  @get
  ListModels is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of Cognitive Services account.")
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    AccountModelListResult
  >;

  @doc("Gets the private link resources that need to be created for a Cognitive Services account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.CognitiveServices/accounts/{accountName}/privateLinkResources")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of Cognitive Services account.")
      @maxLength(64)
      @minLength(2)
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      accountName: string;

      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;
    },
    PrivateLinkResourceListResult
  >;
}
