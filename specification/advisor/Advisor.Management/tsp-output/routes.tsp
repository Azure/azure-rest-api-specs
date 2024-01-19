import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Advisor;

interface ConfigurationsOperations {
  @summary("Retrieve Azure Advisor configurations.")
  @doc("Retrieve Azure Advisor configurations and also retrieve configurations of contained resource groups.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;
    },
    ConfigurationListResult
  >;

  @summary("Create/Overwrite Azure Advisor configuration.")
  @doc("Create/Overwrite Azure Advisor configuration and also delete all configurations of contained resource groups.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}")
  @put
  createInSubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Advisor configuration name. Value must be 'default'")
      @path
      configurationName: ConfigurationName;

      @doc("The Azure Advisor configuration data structure.")
      @body
      configContract: ConfigData;
    },
    ConfigData
  >;

  @summary("Retrieve Azure Advisor configurations.")
  @doc("Retrieve Azure Advisor configurations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations")
  @get
  listByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("The name of the Azure resource group.")
      @path
      resourceGroup: string;
    },
    ConfigurationListResult
  >;

  @summary("Create/Overwrite Azure Advisor configuration.")
  @doc("Create/Overwrite Azure Advisor configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations/{configurationName}")
  @put
  createInResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The Azure subscription ID.")
      @path
      subscriptionId: string;

      @doc("Advisor configuration name. Value must be 'default'")
      @path
      configurationName: ConfigurationName;

      @doc("The name of the Azure resource group.")
      @path
      resourceGroup: string;

      @doc("The Azure Advisor configuration data structure.")
      @body
      configContract: ConfigData;
    },
    ConfigData
  >;
}
