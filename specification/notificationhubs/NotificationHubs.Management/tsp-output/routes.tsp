import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace NotificationHubsManagementClient;

interface OperationsOperations {
  @doc("Lists all of the available NotificationHubs REST API operations.")
  @route("/providers/Microsoft.NotificationHubs/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface NamespacesOperations {
  @doc("""
Checks the availability of the given service namespace across all Azure
subscriptions. This is useful because the domain name is created based on the
service namespace name.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NotificationHubs/checkNamespaceAvailability")
  @post
  CheckAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The namespace name.")
      @body
      parameters: CheckAvailabilityParameters;
    },
    CheckAvailabilityResult
  >;

  @doc("""
Creates/Updates a service namespace. Once created, this namespace's resource
manifest is immutable. This operation is idempotent.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to create a Namespace Resource.")
      @body
      parameters: NamespaceCreateOrUpdateParameters;
    },
    NamespaceResource
  >;

  @doc("Patches the existing namespace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to patch a Namespace Resource.")
      @body
      parameters: NamespacePatchParameters;
    },
    NamespaceResource
  >;

  @doc("""
Deletes an existing namespace. This operation also removes all associated
notificationHubs under the namespace.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Returns the description for the specified namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NamespaceResource
  >;

  @doc("Creates an authorization rule for a namespace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("Authorization Rule Name.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: SharedAccessAuthorizationRuleCreateOrUpdateParameters;
    },
    SharedAccessAuthorizationRuleResource
  >;

  @doc("Deletes a namespace authorization rule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("Authorization Rule Name.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an authorization rule for a namespace by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("Authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SharedAccessAuthorizationRuleResource
  >;

  @doc("Lists the available namespaces within a resourceGroup.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group. If resourceGroupName value is null the method
lists all the namespaces within subscription
""")
      @path
      resourceGroupName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NamespaceListResult
  >;

  @doc("""
Lists all the available namespaces within the subscription irrespective of the
resourceGroups.
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.NotificationHubs/namespaces")
  @get
  ListAll is Azure.Core.Foundations.Operation<
    {
      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NamespaceListResult
  >;

  @doc("Gets the authorization rules for a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SharedAccessAuthorizationRuleListResult
  >;

  @doc("Gets the Primary and Secondary ConnectionStrings to the namespace ")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The connection string of the namespace for the specified authorizationRule.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ResourceListKeys
  >;

  @doc("Regenerates the Primary/Secondary Keys to the Namespace Authorization Rule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/AuthorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The connection string of the namespace for the specified authorizationRule.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the Namespace Authorization Rule Key.")
      @body
      parameters: PolicykeyResource;
    },
    ResourceListKeys
  >;
}

interface NotificationHubsOperations {
  @doc("Checks the availability of the given notificationHub in a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/checkNotificationHubAvailability")
  @post
  CheckNotificationHubAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The notificationHub name.")
      @body
      parameters: CheckAvailabilityParameters;
    },
    CheckAvailabilityResult
  >;

  @doc("Creates/Update a NotificationHub in a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to the create/update a NotificationHub Resource.")
      @body
      parameters: NotificationHubCreateOrUpdateParameters;
    },
    NotificationHubResource
  >;

  @doc("Patch a NotificationHub in a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}")
  @patch
  Patch is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to patch a NotificationHub Resource.")
      @body
      parameters: NotificationHubPatchParameters;
    },
    NotificationHubResource
  >;

  @doc("Deletes a notification hub associated with a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Lists the notification hubs associated with a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NotificationHubResource
  >;

  @doc("test send a push notification")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/debugsend")
  @post
  DebugSend is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Debug send parameters")
      @body
      parameters: unknown;
    },
    DebugSendResponse
  >;

  @doc("Creates/Updates an authorization rule for a NotificationHub")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}")
  @put
  CreateOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("Authorization Rule Name.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("The shared access authorization rule.")
      @body
      parameters: SharedAccessAuthorizationRuleCreateOrUpdateParameters;
    },
    SharedAccessAuthorizationRuleResource
  >;

  @doc("Deletes a notificationHub authorization rule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}")
  @delete
  DeleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("Authorization Rule Name.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets an authorization rule for a NotificationHub by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}")
  @get
  GetAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("authorization rule name.")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SharedAccessAuthorizationRuleResource
  >;

  @doc("Lists the notification hubs associated with a namespace.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    NotificationHubListResult
  >;

  @doc("Gets the authorization rules for a NotificationHub.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules")
  @get
  ListAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    SharedAccessAuthorizationRuleListResult
  >;

  @doc("Gets the Primary and Secondary ConnectionStrings to the NotificationHub ")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}/listKeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
The connection string of the NotificationHub for the specified
authorizationRule.
""")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    ResourceListKeys
  >;

  @doc("Regenerates the Primary/Secondary Keys to the NotificationHub Authorization Rule")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  RegenerateKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
The connection string of the NotificationHub for the specified
authorizationRule.
""")
      @path
      authorizationRuleName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the NotificationHub Authorization Rule Key.")
      @body
      parameters: PolicykeyResource;
    },
    ResourceListKeys
  >;

  @doc("Lists the PNS Credentials associated with a notification hub .")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/pnsCredentials")
  @post
  GetPnsCredentials is Azure.Core.Foundations.Operation<
    {
      @doc("The name of the resource group.")
      @path
      resourceGroupName: string;

      @doc("The namespace name.")
      @path
      namespaceName: string;

      @doc("The notification hub name.")
      @path
      notificationHubName: string;

      @doc("""
Gets subscription credentials which uniquely identify Microsoft Azure
subscription. The subscription ID forms part of the URI for every service call.
""")
      @path
      subscriptionId: string;
    },
    PnsCredentialsResource
  >;
}
