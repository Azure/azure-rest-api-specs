import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace AzureMapsManagementClient;

interface AccountsOperations {
  @doc("""
Create or update a Maps Account. A Maps Account holds the keys which allow
access to the Maps REST APIs.
""")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [MapsAccount]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The new or updated parameters for the Maps Account.")
      @body
      MapsAccount: MapsAccount;
    },
    MapsAccount
  >;

  @doc("""
Updates a Maps Account. Only a subset of the parameters may be updated after
creation, such as Sku, Tags, Properties.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The updated parameters for the Maps Account.")
      @body
      MapsAccountUpdateParameters: MapsAccountUpdateParameters;
    },
    MapsAccount
  >;

  @doc("Delete a Maps Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;
    },
    void
  >;

  @doc("Get a Maps Account.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;
    },
    MapsAccount
  >;

  @doc("Get all Maps Accounts in a Resource Group")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts")
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
    MapsAccounts
  >;

  @doc("Get all Maps Accounts in a Subscription")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maps/accounts")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    MapsAccounts
  >;

  @doc("""
Create and list an account shared access signature token. Use this SAS token
for authentication to Azure Maps REST APIs through various Azure Maps SDKs. As
prerequisite to create a SAS Token. 

Prerequisites:
1. Create or have an
existing User Assigned Managed Identity in the same Azure region as the
account. 
2. Create or update an Azure Map account with the same Azure region
as the User Assigned Managed Identity is placed.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/listSas")
  @post
  ListSas is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The updated parameters for the Maps Account.")
      @body
      MapsAccountSasParameters: AccountSasParameters;
    },
    MapsAccountSasToken
  >;

  @doc("""
Get the keys to use with the Maps APIs. A key is used to authenticate and
authorize access to the Maps REST APIs. Only one key is needed at a time; two
are given to provide seamless key regeneration.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;
    },
    MapsAccountKeys
  >;

  @doc("""
Regenerate either the primary or secondary key for use with the Maps APIs. The
old key will stop working immediately.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/regenerateKey")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("Which key to regenerate:  primary or secondary.")
      @body
      keySpecification: MapsKeySpecification;
    },
    MapsAccountKeys
  >;
}

interface MapsOperations {
  @doc("List operations available for the Maps Resource Provider")
  @route("/providers/Microsoft.Maps/operations")
  @get
  ListOperations is Azure.Core.Foundations.Operation<{}, MapsOperations>;

  @doc("List operations available for the Maps Resource Provider")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Maps/operations")
  @get
  ListSubscriptionOperations is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;
    },
    MapsOperations
  >;
}

interface CreatorsOperations {
  @doc("Get all Creator instances for an Azure Maps Account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/creators")
  @get
  ListByAccount is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;
    },
    CreatorList
  >;

  @doc("""
Create or update a Maps Creator resource. Creator resource will manage Azure
resources required to populate a custom set of mapping data. It requires an
account to exist before it can be created.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/creators/{creatorName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The name of the Maps Creator instance.")
      @path
      creatorName: string;

      @doc("The new or updated parameters for the Creator resource.")
      @body
      CreatorResource: Creator;
    },
    Creator
  >;

  @doc("""
Updates the Maps Creator resource. Only a subset of the parameters may be
updated after creation, such as Tags.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/creators/{creatorName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The name of the Maps Creator instance.")
      @path
      creatorName: string;

      @doc("The update parameters for Maps Creator.")
      @body
      CreatorUpdateParameters: CreatorUpdateParameters;
    },
    Creator
  >;

  @doc("Delete a Maps Creator resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/creators/{creatorName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The name of the Maps Creator instance.")
      @path
      creatorName: string;
    },
    void
  >;

  @doc("Get a Maps Creator resource.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Maps/accounts/{accountName}/creators/{creatorName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the Maps Account.")
      @path
      accountName: string;

      @doc("The name of the Maps Creator instance.")
      @path
      creatorName: string;
    },
    Creator
  >;
}
