import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the automation account type.")
model AutomationAccount is TrackedResource<AutomationAccountProperties> {
  @doc("The name of the automation account.")
  @key("automationAccountName")
  @segment("automationAccounts")
  name: string;

  @doc("Gets or sets the etag of the resource.")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface AutomationAccount {
  @doc("Get information about an Automation Account.")
  get is ArmResourceRead<AutomationAccount>;
  @doc("Create or update automation account.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationAccount>;
  @doc("Update an automation account.")
  update is ArmCustomPatchSync<
    AutomationAccount,
    AutomationAccountUpdateParameters
  >;
  @doc("Delete an automation account.")
  delete is ArmResourceDeleteSync<AutomationAccount>;
  @doc("Retrieve a list of accounts within a given resource group.")
  listByResourceGroup is ArmResourceListByParent<AutomationAccount>;
  @doc("Retrieve a list of accounts within a given subscription.")
  list is ArmListBySubscription<AutomationAccount>;
}

@armResourceOperations
interface AgentRegistrationInformation {
  @doc("Regenerate a primary or secondary agent registration key")
  regenerateKey is ArmResourceActionSync<
    AutomationAccount,
    AgentRegistrationRegenerateKeyParameter,
    AgentRegistration
  >;
  @doc("Retrieve the automation agent registration information.")
  // FIXME: AgentRegistrationInformation_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/agentRegistrationInformation")
  @get
  Get is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface Keys {
  @doc("Retrieve the automation keys for an account.")
  listByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    KeyListResult
  >;
}

@armResourceOperations
interface AutomationAccounts {
  @doc("Post operation to serialize or deserialize GraphRunbookContent")
  convertGraphRunbookContent is ArmResourceActionSync<
    AutomationAccount,
    GraphicalRunbookContent,
    GraphicalRunbookContent
  >;
}

@armResourceOperations
interface Webhook {
  @doc("Generates a Uri for use in creating a webhook.")
  generateUri is ArmResourceActionSync<AutomationAccount, void, string>;
}

@armResourceOperations
interface PrivateLinkResources {
  @doc("Gets the private link resources that need to be created for Automation account.")
  // FIXME: PrivateLinkResources_Automation could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/privateLinkResources")
  @get
  Automation is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface DscCompilationJob {
  @doc("Retrieve the job stream identified by job stream id.")
  // FIXME: DscCompilationJob_GetStream could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{jobId}/streams/{jobStreamId}")
  @get
  GetStream is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface DscCompilationJobStream {
  @doc("Retrieve all the job streams for the compilation Job.")
  // FIXME: DscCompilationJobStream_ListByJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/compilationjobs/{jobId}/streams")
  @get
  ListByJob is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface NodeCountInformation {
  @doc("Retrieve counts for Dsc Nodes.")
  // FIXME: NodeCountInformation_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/nodecounts/{countType}")
  @get
  Get is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface Statistics {
  @doc("Retrieve the statistics for the account.")
  // FIXME: Statistics_ListByAutomationAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/statistics")
  @get
  ListByAutomationAccount is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface Usages {
  @doc("Retrieve the usage for the account id.")
  // FIXME: Usages_ListByAutomationAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/usages")
  @get
  ListByAutomationAccount is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface LinkedWorkspace {
  @doc("Retrieve the linked workspace for the account id.")
  // FIXME: LinkedWorkspace_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/linkedWorkspace")
  @get
  Get is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface ObjectDataTypes {
  @doc("Retrieve a list of fields of a given type across all accessible modules.")
  // FIXME: ObjectDataTypes_ListFieldsByType could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/objectDataTypes/{typeName}/fields")
  @get
  ListFieldsByType is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface SoftwareUpdateConfigurationRuns {
  @doc("Get a single software update configuration Run by Id.")
  // FIXME: SoftwareUpdateConfigurationRuns_GetById could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationRuns/{softwareUpdateConfigurationRunId}")
  @get
  GetById is Azure.Core.Foundations.Operation<
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

  @doc("Return list of software update configuration runs")
  // FIXME: SoftwareUpdateConfigurationRuns_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationRuns")
  @get
  List is Azure.Core.Foundations.Operation<
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
}

@armResourceOperations
interface SoftwareUpdateConfigurationMachineRuns {
  @doc("Get a single software update configuration machine run by Id.")
  // FIXME: SoftwareUpdateConfigurationMachineRuns_GetById could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns/{softwareUpdateConfigurationMachineRunId}")
  @get
  GetById is Azure.Core.Foundations.Operation<
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

  @doc("Return list of software update configuration machine runs")
  // FIXME: SoftwareUpdateConfigurationMachineRuns_List could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/softwareUpdateConfigurationMachineRuns")
  @get
  List is Azure.Core.Foundations.Operation<
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
