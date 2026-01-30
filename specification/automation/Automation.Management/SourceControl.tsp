import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the source control.
 */
@parentResource(AutomationAccount)
model SourceControl
  is Azure.ResourceManager.ProxyResource<SourceControlProperties> {
  ...ResourceNameParameter<
    Resource = SourceControl,
    KeyName = "sourceControlName",
    SegmentName = "sourceControls",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SourceControls {
  /**
   * Retrieve the source control identified by source control name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontroloperations")
  get is ArmResourceRead<SourceControl>;

  /**
   * Create a source control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontroloperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    SourceControl,
    Request = SourceControlCreateOrUpdateParameters
  >;

  /**
   * Update a source control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontroloperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SourceControl,
    PatchModel = SourceControlUpdateParameters
  >;

  /**
   * Delete the source control.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontroloperations")
  delete is ArmResourceDeleteSync<SourceControl, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of source controls.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontroloperations")
  listByAutomationAccount is ArmResourceListByParent<
    SourceControl,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Creates the sync job for a source control.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontrolsyncjoboperations")
  @put
  create is ArmResourceRead<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SourceControl>,
    Response = ArmResourceCreatedSyncResponse<SourceControlSyncJob>,
    Parameters = {
      /**
       * The source control sync job id.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @path
      @segment("sourceControlSyncJobs")
      sourceControlSyncJobId: string;

      /**
       * The parameters supplied to the create source control sync job operation.
       */
      @body
      parameters: SourceControlSyncJobCreateParameters;
    }
  >;

  /**
   * Retrieve the source control sync job identified by job id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontrolsyncjoboperations")
  @get
  sourceControlSyncJobGet is ArmResourceRead<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SourceControl>,
    Response = ArmResponse<SourceControlSyncJobById>,
    Parameters = {
      /**
       * The source control sync job id.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @path
      @segment("sourceControlSyncJobs")
      sourceControlSyncJobId: string;
    }
  >;

  /**
   * Retrieve a list of source control sync jobs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontrolsyncjoboperations")
  @list
  @get
  @action("sourceControlSyncJobs")
  sourceControlSyncJobListByAutomationAccount is ArmResourceActionSync<
    SourceControl,
    void,
    ArmResponse<ResourceListResult<SourceControlSyncJob>>,
    Parameters = {
      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieve a list of sync job streams identified by sync job id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontrolsyncjoboperations")
  @list
  @get
  @action("streams")
  listBySyncJob is ArmResourceActionSync<
    SourceControl,
    void,
    ArmResponse<SourceControlSyncJobStreamsListBySyncJob>,
    Parameters = {
      /**
       * The source control sync job id.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @path
      @segment("sourceControlSyncJobs")
      sourceControlSyncJobId: string;

      /**
       * The filter to apply on the operation.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Retrieve a sync job stream identified by stream id.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/sourcecontrolsyncjoboperations")
  @get
  sourceControlSyncJobStreamsGet is ArmResourceRead<
    SourceControl,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<SourceControl>,
    Response = ArmResponse<SourceControlSyncJobStreamById>,
    Parameters = {
      /**
       * The source control sync job id.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @path
      @segment("sourceControlSyncJobs")
      sourceControlSyncJobId: string;

      /**
       * The id of the sync job stream.
       */
      @path
      @segment("streams")
      streamId: string;
    }
  >;
}

@@doc(SourceControl.name, "The name of source control.");
@@doc(SourceControl.properties, "The properties of the source control.");
@@doc(SourceControls.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update source control operation."
);
@@doc(SourceControls.update::parameters.properties,
  "The parameters supplied to the update source control operation."
);
