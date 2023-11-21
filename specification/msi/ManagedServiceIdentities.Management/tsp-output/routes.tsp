import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace ManagedServiceIdentityClient;

interface SystemAssignedIdentitiesOperations {
  @doc("Gets the systemAssignedIdentity available under the specified RP scope.")
  @route("/{scope}/providers/Microsoft.ManagedIdentity/identities/default")
  @get
  GetByScope is Azure.Core.Foundations.Operation<
    {
      @doc("""
The resource provider scope of the resource. Parent resource being extended by
Managed Identities.
""")
      @path
      scope: string;
    },
    SystemAssignedIdentity
  >;
}

interface OperationsOperations {
  @doc("Lists available operations for the Microsoft.ManagedIdentity provider")
  @route("/providers/Microsoft.ManagedIdentity/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface UserAssignedIdentitiesOperations {
  @doc("Lists all the userAssignedIdentities available under the specified subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.ManagedIdentity/userAssignedIdentities")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;
    },
    UserAssignedIdentitiesListResult
  >;

  @doc("""
Lists all the userAssignedIdentities available under the specified
ResourceGroup.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the Resource Group to which the identity belongs.")
      @path
      resourceGroupName: string;
    },
    UserAssignedIdentitiesListResult
  >;

  @doc("Create or update an identity in the specified subscription and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the Resource Group to which the identity belongs.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;

      @doc("Parameters to create or update the identity")
      @body
      parameters: Identity;
    },
    Identity
  >;

  @doc("Update an identity in the specified subscription and resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the Resource Group to which the identity belongs.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;

      @doc("Parameters to update the identity")
      @body
      parameters: IdentityUpdate;
    },
    Identity
  >;

  @doc("Gets the identity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the Resource Group to which the identity belongs.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;
    },
    Identity
  >;

  @doc("Deletes the identity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the Resource Group to which the identity belongs.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;
    },
    void
  >;
}

interface FederatedIdentityCredentialsOperations {
  @doc("""
Lists all the federated identity credentials under the specified user assigned
identity.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;

      @doc("Number of records to return.")
      @query
      $top: int32;

      @doc("""
A skip token is used to continue retrieving items after an operation returns a
partial result. If a previous response contains a nextLink element, the value
of the nextLink element will include a skipToken parameter that specifies a
starting point to use for subsequent calls.
""")
      @query
      $skiptoken: string;
    },
    FederatedIdentityCredentialsListResult
  >;

  @doc("""
Create or update a federated identity credential under the specified user
assigned identity.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;

      @doc("The name of the federated identity credential resource.")
      @path
      federatedIdentityCredentialResourceName: string;

      @doc("Parameters to create or update the federated identity credential.")
      @body
      parameters: FederatedIdentityCredential;
    },
    FederatedIdentityCredential
  >;

  @doc("Gets the federated identity credential.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;

      @doc("The name of the federated identity credential resource.")
      @path
      federatedIdentityCredentialResourceName: string;
    },
    FederatedIdentityCredential
  >;

  @doc("Deletes the federated identity credential.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{resourceName}/federatedIdentityCredentials/{federatedIdentityCredentialResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The Id of the Subscription to which the identity belongs.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the identity resource.")
      @path
      resourceName: string;

      @doc("The name of the federated identity credential resource.")
      @path
      federatedIdentityCredentialResourceName: string;
    },
    void
  >;
}
