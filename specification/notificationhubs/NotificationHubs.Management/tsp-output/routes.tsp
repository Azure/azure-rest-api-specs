import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.NotificationHubs;

interface NotificationHubsOperations {
  /**
   * Creates/Updates an authorization rule for a NotificationHub
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}")
  @put
  createOrUpdateAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace name.
       */
      @path
      namespaceName: string;

      /**
       * The notification hub name.
       */
      @path
      notificationHubName: string;

      /**
       * Authorization Rule Name.
       */
      @path
      authorizationRuleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The shared access authorization rule.
       */
      @body
      parameters: SharedAccessAuthorizationRuleCreateOrUpdateParameters;
    },
    SharedAccessAuthorizationRuleResource
  >;

  /**
   * Deletes a notificationHub authorization rule
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}")
  @delete
  deleteAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace name.
       */
      @path
      namespaceName: string;

      /**
       * The notification hub name.
       */
      @path
      notificationHubName: string;

      /**
       * Authorization Rule Name.
       */
      @path
      authorizationRuleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Gets an authorization rule for a NotificationHub by name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}")
  @get
  getAuthorizationRule is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @path
      namespaceName: string;

      /**
       * The notification hub name.
       */
      @path
      notificationHubName: string;

      /**
       * authorization rule name.
       */
      @path
      authorizationRuleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    SharedAccessAuthorizationRuleResource
  >;

  /**
   * Gets the authorization rules for a NotificationHub.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules")
  @get
  listAuthorizationRules is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace name
       */
      @path
      namespaceName: string;

      /**
       * The notification hub name.
       */
      @path
      notificationHubName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<SharedAccessAuthorizationRuleResource>
  >;

  /**
   * Gets the Primary and Secondary ConnectionStrings to the NotificationHub
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}/listKeys")
  @post
  listKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace name.
       */
      @path
      namespaceName: string;

      /**
       * The notification hub name.
       */
      @path
      notificationHubName: string;

      /**
       * The connection string of the NotificationHub for the specified authorizationRule.
       */
      @path
      authorizationRuleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListKeys
  >;

  /**
   * Regenerates the Primary/Secondary Keys to the NotificationHub Authorization Rule
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NotificationHubs/namespaces/{namespaceName}/notificationHubs/{notificationHubName}/AuthorizationRules/{authorizationRuleName}/regenerateKeys")
  @post
  regenerateKeys is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group.
       */
      @path
      resourceGroupName: string;

      /**
       * The namespace name.
       */
      @path
      namespaceName: string;

      /**
       * The notification hub name.
       */
      @path
      notificationHubName: string;

      /**
       * The connection string of the NotificationHub for the specified authorizationRule.
       */
      @path
      authorizationRuleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Parameters supplied to regenerate the NotificationHub Authorization Rule Key.
       */
      @body
      parameters: PolicykeyResource;
    },
    ResourceListKeys
  >;
}
