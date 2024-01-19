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
@doc("Definition of the automation account type.")
model AutomationAccount is TrackedResource<AutomationAccountProperties> {
  @doc("The name of the automation account.")
  @path
  @key("automationAccountName")
  @segment("automationAccounts")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface AutomationAccounts {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get information about an Automation Account.")
  @operationId("AutomationAccount_Get")
  get is ArmResourceRead<AutomationAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update automation account.")
  @operationId("AutomationAccount_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update an automation account.")
  @operationId("AutomationAccount_Update")
  update is ArmCustomPatchSync<
    AutomationAccount,
    AutomationAccountUpdateParameters
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an automation account.")
  @operationId("AutomationAccount_Delete")
  delete is ArmResourceDeleteSync<AutomationAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of accounts within a given resource group.")
  @operationId("AutomationAccount_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AutomationAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of accounts within a given subscription.")
  @operationId("AutomationAccount_List")
  list is ArmListBySubscription<AutomationAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerate a primary or secondary agent registration key")
  @operationId("AgentRegistrationInformation_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    AutomationAccount,
    AgentRegistrationRegenerateKeyParameter,
    AgentRegistration
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the automation keys for an account.")
  @operationId("Keys_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    KeyListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Post operation to serialize or deserialize GraphRunbookContent")
  @operationId("convertGraphRunbookContent")
  convertGraphRunbookContent is ArmResourceActionSync<
    AutomationAccount,
    GraphicalRunbookContent,
    GraphicalRunbookContent
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generates a Uri for use in creating a webhook.")
  @operationId("Webhook_GenerateUri")
  generateUri is ArmResourceActionSync<AutomationAccount, void, string>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_Automation")
  @doc("Gets the private link resources that need to be created for Automation account.")
  // FIXME: PrivateLinkResources_Automation could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/privateLinkResources")
  @get
  automation is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;
    },
    PrivateLinkResourceListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AgentRegistrationInformation_Get")
  @doc("Retrieve the automation agent registration information.")
  // FIXME: AgentRegistrationInformation_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/agentRegistrationInformation")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;
    },
    AgentRegistration
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJob_GetStream")
  @doc("Retrieve the job stream identified by job stream id.")
  // FIXME: DscCompilationJob_GetStream could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{jobId}/streams/{jobStreamId}")
  @get
  getStream is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The job id.")
      @path
      jobId: string;

      @doc("The job stream id.")
      @path
      jobStreamId: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    JobStream
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DscCompilationJobStream_ListByJob")
  @doc("Retrieve all the job streams for the compilation Job.")
  // FIXME: DscCompilationJobStream_ListByJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{jobId}/streams")
  @get
  listByJob is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The job id.")
      @path
      jobId: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    JobStreamListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("NodeCountInformation_Get")
  @doc("Retrieve counts for Dsc Nodes.")
  // FIXME: NodeCountInformation_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodecounts/{countType}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The type of counts to retrieve")
      @path
      countType: CountType;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    NodeCounts
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Statistics_ListByAutomationAccount")
  @doc("Retrieve the statistics for the account.")
  // FIXME: Statistics_ListByAutomationAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/statistics")
  @get
  listByAutomationAccount is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    StatisticsListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Usages_ListByAutomationAccount")
  @doc("Retrieve the usage for the account id.")
  // FIXME: Usages_ListByAutomationAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/usages")
  @get
  listByAutomationAccount is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    UsageListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("LinkedWorkspace_Get")
  @doc("Retrieve the linked workspace for the account id.")
  // FIXME: LinkedWorkspace_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/linkedWorkspace")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    LinkedWorkspace
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ObjectDataTypes_ListFieldsByType")
  @doc("Retrieve a list of fields of a given type across all accessible modules.")
  // FIXME: ObjectDataTypes_ListFieldsByType could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/objectDataTypes/{typeName}/fields")
  @get
  listFieldsByType is Azure.Core.Foundations.Operation<
    {
      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The name of type.")
      @path
      typeName: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    TypeFieldListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationRuns_GetById")
  @doc("Get a single software update configuration Run by Id.")
  // FIXME: SoftwareUpdateConfigurationRuns_GetById could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationRuns/{softwareUpdateConfigurationRunId}")
  @get
  getById is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The Id of the software update configuration run.")
      @path
      softwareUpdateConfigurationRunId: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    },
    SoftwareUpdateConfigurationRun
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationRuns_List")
  @doc("Return list of software update configuration runs")
  // FIXME: SoftwareUpdateConfigurationRuns_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationRuns")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;

      @doc("The filter to apply on the operation. You can use the following filters: 'properties/osType', 'properties/status', 'properties/startTime', and 'properties/softwareUpdateConfiguration/name'")
      @query("$filter")
      $filter?: string;

      @doc("Number of entries you skip before returning results")
      @query("$skip")
      $skip?: string;

      @doc("Maximum number of entries returned in the results collection")
      @query("$top")
      $top?: string;
    },
    SoftwareUpdateConfigurationRunListResult
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationMachineRuns_GetById")
  @doc("Get a single software update configuration machine run by Id.")
  // FIXME: SoftwareUpdateConfigurationMachineRuns_GetById could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns/{softwareUpdateConfigurationMachineRunId}")
  @get
  getById is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("The Id of the software update configuration machine run.")
      @path
      softwareUpdateConfigurationMachineRunId: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;
    },
    SoftwareUpdateConfigurationMachineRun
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SoftwareUpdateConfigurationMachineRuns_List")
  @doc("Return list of software update configuration machine runs")
  // FIXME: SoftwareUpdateConfigurationMachineRuns_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;

      @doc("Name of an Azure Resource group.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._]+$")
      @path
      resourceGroupName: string;

      @doc("The name of the automation account.")
      @path
      automationAccountName: string;

      @doc("Identifies this specific client request.")
      @header
      clientRequestId?: string;

      @doc("The filter to apply on the operation. You can use the following filters: 'properties/osType', 'properties/status', 'properties/startTime', and 'properties/softwareUpdateConfiguration/name'")
      @query("$filter")
      $filter?: string;

      @doc("number of entries you skip before returning results")
      @query("$skip")
      $skip?: string;

      @doc("Maximum number of entries returned in the results collection")
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
