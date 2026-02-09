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
interface ContainerAppsSourceControls {
  /**
   * Get a SourceControl of a Container App.
   */
  @summary("Get a SourceControl of a Container App.")
  get is ArmResourceRead<SourceControl, Error = DefaultErrorResponse>;

  /**
   * Create or update the SourceControl for a Container App.
   */
  @summary("Create or update the SourceControl for a Container App.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SourceControl,
    Parameters = {
      /**
       * Github personal access token used for SourceControl.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" ""
      @header
      `x-ms-github-auxiliary`?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = SourceControl> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = DefaultErrorResponse
  >;

  /**
   * Delete a Container App SourceControl.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @summary("Delete a Container App SourceControl.")
  delete is ArmResourceDeleteWithoutOkAsync<
    SourceControl,
    Parameters = {
      /**
       * Github personal access token used for SourceControl.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" ""
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
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = DefaultErrorResponse
  >;

  /**
   * Get the Container App SourceControls in a given resource group.
   */
  @summary("Get the Container App SourceControls in a given resource group.")
  listByContainerApp is ArmResourceListByParent<
    SourceControl,
    Response = ArmResponse<SourceControlCollection>,
    Error = DefaultErrorResponse
  >;
}

@@doc(SourceControl.name, "Name of the Container App SourceControl.");
@@doc(SourceControl.properties, "SourceControl resource specific properties");
@@doc(ContainerAppsSourceControls.createOrUpdate::parameters.resource,
  "Properties used to create a Container App SourceControl"
);
