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
/**
 * Definition of the source control.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@Azure.ResourceManager.Private.armResourceInternal(SourceControlProperties)
@includeInapplicableMetadataInPayload(false)
model SourceControl extends ProxyResourceBase {
  /**
   * The name of source control.
   */
  @path
  @key("sourceControlName")
  @segment("sourceControls")
  name: string;

  /**
   * The properties of the source control.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SourceControlProperties;
}

@armResourceOperations
interface SourceControls {
  /**
   * Retrieve the source control identified by source control name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControl_Get")
  get is ArmResourceRead<SourceControl>;

  /**
   * Create a source control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControl_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SourceControl>;

  /**
   * Update a source control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SourceControl_Update")
  update is ArmCustomPatchSync<SourceControl, SourceControlUpdateParameters>;

  /**
   * Delete the source control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControl_Delete")
  delete is ArmResourceDeleteSync<SourceControl>;

  /**
   * Retrieve a list of source controls.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControl_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<
    SourceControl,
    {
      ...BaseParameters<SourceControl>;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieve the source control sync job identified by job id.
   */
  // FIXME: SourceControlSyncJob_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJob_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}")
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
       * The source control name.
       */
      @path
      sourceControlName: string;

      /**
       * The source control sync job id.
       */
      @path
      sourceControlSyncJobId: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;
    },
    SourceControlSyncJobById
  >;

  /**
   * Retrieve a list of source control sync jobs.
   */
  // FIXME: SourceControlSyncJob_ListByAutomationAccount could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJob_ListByAutomationAccount")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs")
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
       * The source control name.
       */
      @path
      sourceControlName: string;

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
    SourceControlSyncJobListResult
  >;

  /**
   * Retrieve a list of sync job streams identified by sync job id.
   */
  // FIXME: SourceControlSyncJobStreams_ListBySyncJob could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJobStreams_ListBySyncJob")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}/streams")
  @get
  listBySyncJob is Azure.Core.Foundations.Operation<
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
       * The source control name.
       */
      @path
      sourceControlName: string;

      /**
       * The source control sync job id.
       */
      @path
      sourceControlSyncJobId: string;

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
    SourceControlSyncJobStreamsListBySyncJob
  >;

  /**
   * Retrieve a sync job stream identified by stream id.
   */
  // FIXME: SourceControlSyncJobStreams_Get could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SourceControlSyncJobStreams_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Automation/automationAccounts/{automationAccountName}/sourceControls/{sourceControlName}/sourceControlSyncJobs/{sourceControlSyncJobId}/streams/{streamId}")
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
       * The source control name.
       */
      @path
      sourceControlName: string;

      /**
       * The source control sync job id.
       */
      @path
      sourceControlSyncJobId: string;

      /**
       * The id of the sync job stream.
       */
      @path
      streamId: string;

      /**
       * Gets subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
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
