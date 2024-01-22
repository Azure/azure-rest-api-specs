import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the automation account type.
 */
model AutomationAccount is TrackedResource<AutomationAccountProperties> {
  /**
   * The name of the automation account.
   */
  @path
  @key("automationAccountName")
  @segment("automationAccounts")
  name: string;

  /**
   * Gets or sets the etag of the resource.
   */
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface AutomationAccounts {
  /**
   * Get information about an Automation Account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutomationAccount_Get")
  get is ArmResourceRead<AutomationAccount>;

  /**
   * Create or update automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutomationAccount_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationAccount>;

  /**
   * Update an automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("AutomationAccount_Update")
  update is ArmCustomPatchSync<
    AutomationAccount,
    AutomationAccountUpdateParameters
  >;

  /**
   * Delete an automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutomationAccount_Delete")
  delete is ArmResourceDeleteSync<AutomationAccount>;

  /**
   * Retrieve a list of accounts within a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutomationAccount_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AutomationAccount>;

  /**
   * Retrieve a list of accounts within a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AutomationAccount_List")
  list is ArmListBySubscription<AutomationAccount>;

  /**
   * Regenerate a primary or secondary agent registration key
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentRegistrationInformation_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    AutomationAccount,
    AgentRegistrationRegenerateKeyParameter,
    AgentRegistration
  >;

  /**
   * Retrieve the automation keys for an account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Keys_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    KeyListResult
  >;

  /**
   * Post operation to serialize or deserialize GraphRunbookContent
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("convertGraphRunbookContent")
  convertGraphRunbookContent is ArmResourceActionSync<
    AutomationAccount,
    GraphicalRunbookContent,
    GraphicalRunbookContent
  >;

  /**
   * Generates a Uri for use in creating a webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Webhook_GenerateUri")
  generateUri is ArmResourceActionSync<AutomationAccount, void, string>;

  /**
   * Gets the private link resources that need to be created for Automation account.
   */
  // FIXME: PrivateLinkResources_Automation could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Automation")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/privateLinkResources")
  @get
  automation is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

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
    },
    PrivateLinkResourceListResult
  >;

  /**
   * Retrieve the automation agent registration information.
   */
  // FIXME: AgentRegistrationInformation_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentRegistrationInformation_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/agentRegistrationInformation")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

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
    },
    AgentRegistration
  >;

  /**
   * Retrieve the job stream identified by job stream id.
   */
  // FIXME: DscCompilationJob_GetStream could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJob_GetStream")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{jobId}/streams/{jobStreamId}")
  @get
  getStream is Azure.Core.Foundations.Operation<
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
       * The job id.
       */
      @path
      jobId: string;

      /**
       * The job stream id.
       */
      @path
      jobStreamId: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    JobStream
  >;

  /**
   * Retrieve all the job streams for the compilation Job.
   */
  // FIXME: DscCompilationJobStream_ListByJob could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJobStream_ListByJob")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{jobId}/streams")
  @get
  listByJob is Azure.Core.Foundations.Operation<
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
       * The job id.
       */
      @path
      jobId: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    JobStreamListResult
  >;

  /**
   * Retrieve counts for Dsc Nodes.
   */
  // FIXME: NodeCountInformation_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeCountInformation_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodecounts/{countType}")
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
       * The type of counts to retrieve
       */
      @path
      countType: CountType;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    NodeCounts
  >;

  /**
   * Retrieve the statistics for the account.
   */
  // FIXME: Statistics_ListByAutomationAccount could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Statistics_ListByAutomationAccount")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/statistics")
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
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    StatisticsListResult
  >;

  /**
   * Retrieve the usage for the account id.
   */
  // FIXME: Usages_ListByAutomationAccount could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Usages_ListByAutomationAccount")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/usages")
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
    UsageListResult
  >;

  /**
   * Retrieve the linked workspace for the account id.
   */
  // FIXME: LinkedWorkspace_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LinkedWorkspace_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/linkedWorkspace")
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
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    LinkedWorkspace
  >;

  /**
   * Retrieve a list of fields of a given type across all accessible modules.
   */
  // FIXME: ObjectDataTypes_ListFieldsByType could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ObjectDataTypes_ListFieldsByType")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/objectDataTypes/{typeName}/fields")
  @get
  listFieldsByType is Azure.Core.Foundations.Operation<
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

  /**
   * Get a single software update configuration Run by Id.
   */
  // FIXME: SoftwareUpdateConfigurationRuns_GetById could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationRuns_GetById")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationRuns/{softwareUpdateConfigurationRunId}")
  @get
  getById is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

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
       * The Id of the software update configuration run.
       */
      @path
      softwareUpdateConfigurationRunId: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    },
    SoftwareUpdateConfigurationRun
  >;

  /**
   * Return list of software update configuration runs
   */
  // FIXME: SoftwareUpdateConfigurationRuns_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationRuns_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationRuns")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

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
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;

      /**
       * The filter to apply on the operation. You can use the following filters: 'properties/osType', 'properties/status', 'properties/startTime', and 'properties/softwareUpdateConfiguration/name'
       */
      @query("$filter")
      $filter?: string;

      /**
       * Number of entries you skip before returning results
       */
      @query("$skip")
      $skip?: string;

      /**
       * Maximum number of entries returned in the results collection
       */
      @query("$top")
      $top?: string;
    },
    SoftwareUpdateConfigurationRunListResult
  >;

  /**
   * Get a single software update configuration machine run by Id.
   */
  // FIXME: SoftwareUpdateConfigurationMachineRuns_GetById could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationMachineRuns_GetById")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns/{softwareUpdateConfigurationMachineRunId}")
  @get
  getById is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

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
       * The Id of the software update configuration machine run.
       */
      @path
      softwareUpdateConfigurationMachineRunId: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    },
    SoftwareUpdateConfigurationMachineRun
  >;

  /**
   * Return list of software update configuration machine runs
   */
  // FIXME: SoftwareUpdateConfigurationMachineRuns_List could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationMachineRuns_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

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
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;

      /**
       * The filter to apply on the operation. You can use the following filters: 'properties/osType', 'properties/status', 'properties/startTime', and 'properties/softwareUpdateConfiguration/name'
       */
      @query("$filter")
      $filter?: string;

      /**
       * number of entries you skip before returning results
       */
      @query("$skip")
      $skip?: string;

      /**
       * Maximum number of entries returned in the results collection
       */
      @query("$top")
      $top?: string;
    },
    SoftwareUpdateConfigurationMachineRunListResult
  >;
}

@@projectedName(AutomationAccounts.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(AutomationAccounts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(AutomationAccounts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update automation account."
);
@@projectedName(AutomationAccounts.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(AutomationAccounts.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(AutomationAccounts.update::parameters.properties,
  "Parameters supplied to the update automation account."
);
@@projectedName(AutomationAccounts.regenerateKey::parameters.body,
  "json",
  "parameters"
);
@@extension(AutomationAccounts.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(AutomationAccounts.regenerateKey::parameters.body,
  "The name of the agent registration key to be regenerated"
);
@@projectedName(AutomationAccounts.convertGraphRunbookContent::parameters.body,
  "json",
  "parameters"
);
@@extension(AutomationAccounts.convertGraphRunbookContent::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(AutomationAccounts.convertGraphRunbookContent::parameters.body,
  "Input data describing the graphical runbook."
);
