import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Automation;

interface ActivityOperations {
  /**
   * Retrieve the activity in the module identified by module name and activity name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}/activities/{activityName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of module.
       */
      @path
      moduleName: string;

      /**
       * The name of activity.
       */
      @path
      activityName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    Activity
  >;

  /**
   * Retrieve a list of activities in the module identified by module name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}/activities")
  @get
  listByModule is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of module.
       */
      @path
      moduleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ActivityListResult
  >;
}

interface ModuleOperations {
  /**
   * Delete the module by name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The module name.
       */
      @path
      moduleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    void
  >;

  /**
   * Retrieve the module identified by module name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The module name.
       */
      @path
      moduleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    Module
  >;

  /**
   * Create or Update the module identified by module name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of module.
       */
      @path
      moduleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The create or update parameters for module.
       */
      @body
      parameters: ModuleCreateOrUpdateParameters;
    },
    Module
  >;

  /**
   * Update the module identified by module name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}")
  @patch
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of module.
       */
      @path
      moduleName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * The update parameters for module.
       */
      @body
      parameters: ModuleUpdateParameters;
    },
    Module
  >;

  /**
   * Retrieve a list of modules.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules")
  @get
  listByAutomationAccount is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    ResourceListResult<Module>
  >;
}

interface ObjectDataTypesOperations {
  /**
   * Retrieve a list of fields of a given type identified by module name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}/objectDataTypes/{typeName}/fields")
  @get
  listFieldsByModuleAndType is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of module.
       */
      @path
      moduleName: string;

      /**
       * The name of type.
       */
      @path
      typeName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    TypeFieldListResult
  >;
}

interface FieldsOperations {
  /**
   * Retrieve a list of fields of a given type identified by module name.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/modules/{moduleName}/types/{typeName}/fields")
  @get
  listByType is Azure.Core.Foundations.Operation<
    {
      /**
       * Name of an Azure Resource group.
       */
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      /**
       * The name of the automation account.
       */
      @path
      automationAccountName: string;

      /**
       * The name of module.
       */
      @path
      moduleName: string;

      /**
       * The name of type.
       */
      @path
      typeName: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    TypeFieldListResult
  >;
}

interface deletedAutomationAccountsOperations {
  /**
   * Retrieve deleted automation account.
   */
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Automation/deletedAutomationAccounts")
  @get
  listBySubscription is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    DeletedAutomationAccountListResult
  >;
}
