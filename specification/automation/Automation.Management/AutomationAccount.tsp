import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the automation account type.
 */
model AutomationAccount
  is Azure.ResourceManager.TrackedResource<AutomationAccountProperties> {
  ...ResourceNameParameter<
    Resource = AutomationAccount,
    KeyName = "automationAccountName",
    SegmentName = "automationAccounts",
    NamePattern = ""
  >;

  /**
   * Gets or sets the etag of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  etag?: string;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface AutomationAccounts {
  /**
   * Get information about an Automation Account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/automationaccountoperations")
  get is ArmResourceRead<AutomationAccount>;

  /**
   * Create or update automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/automationaccountoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    AutomationAccount,
    Request = AutomationAccountCreateOrUpdateParameters
  >;

  /**
   * Update an automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_Update")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/automationaccountoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AutomationAccount,
    PatchModel = AutomationAccountUpdateParameters
  >;

  /**
   * Delete an automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/automationaccountoperations")
  delete is ArmResourceDeleteSync<AutomationAccount>;

  /**
   * Retrieve a list of accounts within a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_ListByResourceGroup")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/automationaccountoperations")
  listByResourceGroup is ArmResourceListByParent<AutomationAccount>;

  /**
   * Retrieve a list of accounts within a given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_List")
  @summary("Lists the Automation Accounts within an Azure subscription.")
  list is ArmListBySubscription<AutomationAccount>;

  /**
   * Retrieve counts for Dsc Nodes.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NodeCountInformation_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/nodecounts")
  @list
  @get
  nodeCountInformationGet is ArmResourceRead<
    AutomationAccount,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AutomationAccount>,
    Response = ArmResponse<NodeCounts>,
    Parameters = {
      /**
       * The type of counts to retrieve
       */
      @path
      @segment("nodecounts")
      countType: CountType;
    }
  >;

  /**
   * Get all software update configurations for the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SoftwareUpdateConfigurations_List")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  @list
  @get
  @action("softwareUpdateConfigurations")
  softwareUpdateConfigurationsList is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<softwareUpdateConfigurationListResult>,
    Parameters = {
      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets the private link resources that need to be created for Automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_Automation")
  @list
  @get
  @action("privateLinkResources")
  automation is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;

  /**
   * Retrieve the automation agent registration information.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentRegistrationInformation_Get")
  @get
  @action("agentRegistrationInformation")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/agentregistrationoperations")
  agentRegistrationInformationGet is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<AgentRegistration>
  >;

  /**
   * Regenerate a primary or secondary agent registration key
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AgentRegistrationInformation_RegenerateKey")
  @action("agentRegistrationInformation/regenerateKey")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/agentregistrationoperations")
  regenerateKey is ArmResourceActionSync<
    AutomationAccount,
    AgentRegistrationRegenerateKeyParameter,
    ArmResponse<AgentRegistration>
  >;

  /**
   * Retrieve the deleted runbooks for an automation account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AutomationAccount_ListDeletedRunbooks")
  @list
  listDeletedRunbooks is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<DeletedRunbookListResult>
  >;

  /**
   * Retrieve the statistics for the account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Statistics_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/statisticsoperations")
  @list
  @get
  @action("statistics")
  listByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<StatisticsListResult>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieve the usage for the account id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Usages_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/usageoperations")
  @list
  @get
  @action("usages")
  usagesListByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<UsageListResult>
  >;

  /**
   * Retrieve the automation keys for an account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Keys_ListByAutomationAccount")
  @action("listKeys")
  keysListByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<KeyListResult>
  >;

  /**
   * Retrieve a list of jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Job_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/joboperations")
  @list
  @get
  @action("jobs")
  jobListByAutomationAccount is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<JobListResultV2>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Retrieve the linked workspace for the account id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LinkedWorkspace_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/linkedworkspaceoperations")
  @get
  @action("linkedWorkspace")
  linkedWorkspaceGet is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<LinkedWorkspace>
  >;

  /**
   * Retrieve a list of fields of a given type across all accessible modules.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ObjectDataTypes_ListFieldsByType")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/objectdatatypeoperations")
  @list
  @get
  @action("fields")
  listFieldsByType is ArmResourceRead<
    AutomationAccount,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AutomationAccount>,
    Response = ArmResponse<TypeFieldListResult>,
    Parameters = {
      /**
       * The name of type.
       */
      @path
      @segment("objectDataTypes")
      typeName: string;
    }
  >;

  /**
   * Post operation to serialize or deserialize GraphRunbookContent
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("convertGraphRunbookContent")
  convertGraphRunbookContent is ArmResourceActionSync<
    AutomationAccount,
    GraphicalRunbookContent,
    ArmResponse<GraphicalRunbookContent>
  >;

  /**
   * Get a single software update configuration machine run by Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SoftwareUpdateConfigurationMachineRuns_GetById")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  @get
  getById is ArmResourceRead<
    AutomationAccount,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AutomationAccount>,
    Response = ArmResponse<softwareUpdateConfigurationMachineRun>,
    Parameters = {
      /**
       * The Id of the software update configuration machine run.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @path
      @segment("softwareUpdateConfigurationMachineRuns")
      softwareUpdateConfigurationMachineRunId: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Return list of software update configuration machine runs
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SoftwareUpdateConfigurationMachineRuns_List")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  @get
  @action("softwareUpdateConfigurationMachineRuns")
  softwareUpdateConfigurationMachineRunsList is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<softwareUpdateConfigurationMachineRunListResult>,
    Parameters = {
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
    }
  >;

  /**
   * Get a single software update configuration Run by Id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SoftwareUpdateConfigurationRuns_GetById")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationrunoperations")
  @get
  softwareUpdateConfigurationRunsGetById is ArmResourceRead<
    AutomationAccount,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<AutomationAccount>,
    Response = ArmResponse<softwareUpdateConfigurationRun>,
    Parameters = {
      /**
       * The Id of the software update configuration run.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @path
      @segment("softwareUpdateConfigurationRuns")
      softwareUpdateConfigurationRunId: string;

      /**
       * Identifies this specific client request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Return list of software update configuration runs
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SoftwareUpdateConfigurationRuns_List")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/softwareupdateconfigurationoperations")
  @get
  @action("softwareUpdateConfigurationRuns")
  softwareUpdateConfigurationRunsList is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<softwareUpdateConfigurationRunListResult>,
    Parameters = {
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
    }
  >;

  /**
   * Generates a Uri for use in creating a webhook.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Webhook_GenerateUri")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/webhookoperations")
  @action("webhooks/generateUri")
  generateUri is ArmResourceActionSync<
    AutomationAccount,
    void,
    ArmResponse<string>
  >;
}

@@doc(AutomationAccount.name, "The name of the automation account.");
@@doc(AutomationAccount.properties,
  "Gets or sets the automation account properties."
);
@@doc(AutomationAccounts.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update automation account."
);
@@doc(AutomationAccounts.update::parameters.properties,
  "Parameters supplied to the update automation account."
);
@@doc(AutomationAccounts.regenerateKey::parameters.body,
  "The name of the agent registration key to be regenerated"
);
@@doc(AutomationAccounts.convertGraphRunbookContent::parameters.body,
  "Input data describing the graphical runbook."
);
