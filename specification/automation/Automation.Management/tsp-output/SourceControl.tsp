import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Automation;
@doc("Definition of the source control.")
@parentResource(AutomationAccount)
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("The name of source control.")
  @key("sourceControlName")
  @segment("sourceControls")
  name: string;
}

@armResourceOperations
@projectedName("client", "SourceControl")
interface SourceControls_SourceControl {
  @doc("Retrieve the source control identified by source control name.")
  get is ArmResourceRead<SourceControl>;

  @doc("Create a source control.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SourceControl>;

  @doc("Update a source control.")
  update is ArmCustomPatchSync<SourceControl, SourceControlUpdateParameters>;

  @doc("Delete the source control.")
  delete is ArmResourceDeleteSync<SourceControl>;

  @doc("Retrieve a list of source controls.")
  listByAutomationAccount is ArmResourceListByParent<
    SourceControl,
    {
      ...BaseParameters<SourceControl>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;
}

@armResourceOperations
@projectedName("client", "SourceControlSyncJob")
interface SourceControls_SourceControlSyncJob {
  @doc("Retrieve the source control sync job identified by job id.")
  // FIXME: SourceControlSyncJob_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}")
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

      @doc("The source control name.")
      @path
      sourceControlName: string;

      @doc("The source control sync job id.")
      @path
      sourceControlSyncJobId: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SourceControlSyncJobById
  >;

  @doc("Retrieve a list of source control sync jobs.")
  // FIXME: SourceControlSyncJob_ListByAutomationAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs")
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

      @doc("The source control name.")
      @path
      sourceControlName: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SourceControlSyncJobListResult
  >;
}

@armResourceOperations
@projectedName("client", "SourceControlSyncJobStreams")
interface SourceControls_SourceControlSyncJobStreams {
  @doc("Retrieve a list of sync job streams identified by sync job id.")
  // FIXME: SourceControlSyncJobStreams_ListBySyncJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}/streams")
  @get
  ListBySyncJob is Azure.Core.Foundations.Operation<
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

      @doc("The source control name.")
      @path
      sourceControlName: string;

      @doc("The source control sync job id.")
      @path
      sourceControlSyncJobId: string;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SourceControlSyncJobStreamsListBySyncJob
  >;

  @doc("Retrieve a sync job stream identified by stream id.")
  // FIXME: SourceControlSyncJobStreams_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}/streams/{streamId}")
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

      @doc("The source control name.")
      @path
      sourceControlName: string;

      @doc("The source control sync job id.")
      @path
      sourceControlSyncJobId: string;

      @doc("The id of the sync job stream.")
      @path
      streamId: string;

      @doc("Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.")
      @path
      subscriptionId: string;
    },
    SourceControlSyncJobStreamById
  >;
}
