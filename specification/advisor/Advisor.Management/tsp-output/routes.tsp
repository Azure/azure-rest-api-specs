import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Advisor;

interface ConfigurationsOperations {
  /**
   * Retrieve Azure Advisor configurations and also retrieve configurations of contained resource groups.
   */
  @summary("Retrieve Azure Advisor configurations.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;
    },
    ConfigurationListResult
  >;

  /**
   * Create/Overwrite Azure Advisor configuration and also delete all configurations of contained resource groups.
   */
  @summary("Create/Overwrite Azure Advisor configuration.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}")
  @put
  createInSubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Advisor configuration name. Value must be 'default'
       */
      @path
      configurationName: ConfigurationName;

      /**
       * The Azure Advisor configuration data structure.
       */
      @body
      configContract: ConfigData;
    },
    ConfigData
  >;

  /**
   * Retrieve Azure Advisor configurations.
   */
  @summary("Retrieve Azure Advisor configurations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the Azure resource group.
       */
      @path
      resourceGroup: string;
    },
    ConfigurationListResult
  >;

  /**
   * Create/Overwrite Azure Advisor configuration.
   */
  @summary("Create/Overwrite Azure Advisor configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations/{configurationName}")
  @put
  createInResourceGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * The Azure subscription ID.
       */
      @path
      subscriptionId: string;

      /**
       * Advisor configuration name. Value must be 'default'
       */
      @path
      configurationName: ConfigurationName;

      /**
       * The name of the Azure resource group.
       */
      @path
      resourceGroup: string;

      /**
       * The Azure Advisor configuration data structure.
       */
      @body
      configContract: ConfigData;
    },
    ConfigData
  >;
}
