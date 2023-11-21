import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace GraphServices;

interface AccountsOperations {
  @doc("Returns list of accounts apps.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.GraphServices/accounts")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;
    },
    AccountResourceList
  >;

  @doc("Returns list of accounts belonging to a subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.GraphServices/accounts")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    AccountResourceList
  >;

  @doc("Returns account resource for a given name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.GraphServices/accounts/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    AccountResource
  >;

  @doc("Create or update account resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.GraphServices/accounts/{resourceName}")
  @put
  CreateAndUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Account details.")
      @body
      accountResource: AccountResource;
    },
    AccountResource
  >;

  @doc("Update account details.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.GraphServices/accounts/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;

      @doc("Account patch details.")
      @body
      accountResource: AccountPatchResource;
    },
    AccountResource
  >;

  @doc("Deletes a account resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.GraphServices/accounts/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the resource.")
      @path
      resourceName: string;
    },
    void
  >;
}

interface OperationsOperations {
  @doc("Returns list of operations.")
  @route("/providers/Microsoft.GraphServices/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
