import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.NotificationHubs;

interface NotificationHubsOperations {
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

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
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

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
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

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SharedAccessAuthorizationRuleResource
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

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
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

      @doc("The connection string of the NotificationHub for the specified authorizationRule.")
      @path
      authorizationRuleName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
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

      @doc("The connection string of the NotificationHub for the specified authorizationRule.")
      @path
      authorizationRuleName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Parameters supplied to regenerate the NotificationHub Authorization Rule Key.")
      @body
      parameters: PolicykeyResource;
    },
    ResourceListKeys
  >;
}
