import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
@doc("Definition of the source control.")
@parentResource(AutomationAccount)
model SourceControl is ProxyResource<SourceControlProperties> {
  @doc("The name of source control.")
  @path
  @key("sourceControlName")
  @segment("sourceControls")
  name: string;
}

@armResourceOperations
interface SourceControls {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the source control identified by source control name.")
  @operationId("SourceControl_Get")
  get is ArmResourceRead<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a source control.")
  @operationId("SourceControl_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a source control.")
  @operationId("SourceControl_Update")
  update is ArmCustomPatchSync<SourceControl, SourceControlUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the source control.")
  @operationId("SourceControl_Delete")
  delete is ArmResourceDeleteSync<SourceControl>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of source controls.")
  @operationId("SourceControl_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    SourceControl,
    {
      ...BaseParameters<SourceControl>;

      @doc("The filter to apply on the operation.")
      @query("$filter")
      $filter?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJob_Get")
  @doc("Retrieve the source control sync job identified by job id.")
  // FIXME: SourceControlSyncJob_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJob_ListByAutomationAccount")
  @doc("Retrieve a list of source control sync jobs.")
  // FIXME: SourceControlSyncJob_ListByAutomationAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs")
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJobStreams_ListBySyncJob")
  @doc("Retrieve a list of sync job streams identified by sync job id.")
  // FIXME: SourceControlSyncJobStreams_ListBySyncJob could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}/streams")
  @get
  listBySyncJob is Azure.Core.Foundations.Operation<
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

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJobStreams_Get")
  @doc("Retrieve a sync job stream identified by stream id.")
  // FIXME: SourceControlSyncJobStreams_Get could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}/streams/{streamId}")
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

@@projectedName(SourceControls.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SourceControls.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SourceControls.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update source control operation."
);
@@projectedName(SourceControls.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(SourceControls.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SourceControls.update::parameters.properties,
  "The parameters supplied to the update source control operation."
);
