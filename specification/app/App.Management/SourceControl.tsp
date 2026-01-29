import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ContainerApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Container App SourceControl.
 */
@parentResource(ContainerApp)
model SourceControl
  is Azure.ResourceManager.ProxyResource<SourceControlProperties> {
  ...ResourceNameParameter<
    Resource = SourceControl,
    KeyName = "sourceControlName",
    SegmentName = "sourcecontrols",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SourceControls {
  /**
   * Get a SourceControl of a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSourceControls_Get")
  get is ArmResourceRead<SourceControl>;

  /**
   * Create or update the SourceControl for a Container App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSourceControls_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SourceControl,
    Parameters = {
      /**
       * Github personal access token used for SourceControl.
       */
      @header
      `x-ms-github-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = SourceControl> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a Container App SourceControl.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("ContainerAppsSourceControls_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    SourceControl,
    Parameters = {
      /**
       * Github personal access token used for SourceControl.
       */
      @header
      `x-ms-github-auxiliary`?: string;

      /**
       * Ignore Workflow Deletion Failure.
       */
      @query("ignoreWorkflowDeletionFailure")
      ignoreWorkflowDeletionFailure?: boolean;

      /**
       * Delete workflow.
       */
      @query("deleteWorkflow")
      deleteWorkflow?: boolean;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get the Container App SourceControls in a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ContainerAppsSourceControls_ListByContainerApp")
  listByContainerApp is ArmResourceListByParent<
    SourceControl,
    Response = ArmResponse<SourceControlCollection>
  >;
}

@@doc(SourceControl.name, "Name of the Container App SourceControl.");
@@doc(SourceControl.properties, "SourceControl resource specific properties");
@@doc(SourceControls.createOrUpdate::parameters.resource,
  "Properties used to create a Container App SourceControl"
);
