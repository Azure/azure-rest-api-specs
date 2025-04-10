import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Deployment resource payload
 */
@parentResource(AppResource)
model DeploymentResource
  is Azure.ResourceManager.ProxyResource<DeploymentResourceProperties> {
  ...ResourceNameParameter<
    Resource = DeploymentResource,
    KeyName = "deploymentName",
    SegmentName = "deployments",
    NamePattern = ""
  >;

  /**
   * Sku of the Deployment resource
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;
}

@armResourceOperations
interface DeploymentResources {
  /**
   * Get a Deployment and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Get")
  get is ArmResourceRead<DeploymentResource>;

  /**
   * Create a new Deployment or update an exiting Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DeploymentResource,
    Response = ArmResourceUpdatedResponse<DeploymentResource> | ArmResourceCreatedResponse<
      DeploymentResource,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DeploymentResource;
    })
  >;

  /**
   * Operation to update an exiting Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("Deployments_Update")
  update is ArmCustomPatchAsync<
    DeploymentResource,
    PatchModel = DeploymentResource,
    Response = ArmResponse<DeploymentResource> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DeploymentResource;
    })
  >;

  /**
   * Operation to delete a Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DeploymentResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Handles requests to list all resources in an App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_List")
  list is ArmResourceListByParent<
    DeploymentResource,
    Parameters = {
      /**
       * Version of the deployments to be listed
       */
      #suppress "@azure-tools/typespec-azure-core/no-query-explode" "For backward compatibility"
      @query(#{ name: "version", explode: true })
      version?: string[];

      /**
       * The expand expression to apply on the operation.
       */
      @query("$expand")
      $expand?: string;
    },
    Response = ArmResponse<DeploymentResourceCollection>
  >;

  /**
   * Start the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Start")
  start is ArmResourceActionAsync<DeploymentResource, void, OkResponse>;

  /**
   * Stop the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Stop")
  stop is ArmResourceActionAsync<DeploymentResource, void, OkResponse>;

  /**
   * Restart the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_Restart")
  restart is ArmResourceActionAsync<DeploymentResource, void, OkResponse>;

  /**
   * Enable remote debugging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_EnableRemoteDebugging")
  enableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    {
      /**
       * Parameters for enable remote debugging
       */
      @bodyRoot
      remoteDebuggingPayload?: RemoteDebuggingPayload;
    },
    ArmResponse<RemoteDebugging>
  >;

  /**
   * Disable remote debugging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_DisableRemoteDebugging")
  disableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    void,
    ArmResponse<RemoteDebugging>
  >;

  /**
   * Get remote debugging config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetRemoteDebuggingConfig")
  getRemoteDebuggingConfig is ArmResourceActionSync<
    DeploymentResource,
    void,
    ArmResponse<RemoteDebugging>
  >;

  /**
   * Get deployment log file URL
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GetLogFileUrl")
  getLogFileUrl is ArmResourceActionSync<
    DeploymentResource,
    void,
    ArmResponse<LogFileUrlResponse> | NoContentResponse
  >;

  /**
   * Generate Heap Dump
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GenerateHeapDump")
  generateHeapDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    OkResponse
  >;

  /**
   * Generate Thread Dump
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_GenerateThreadDump")
  generateThreadDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    OkResponse
  >;

  /**
   * Start JFR
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Deployments_StartJFR")
  startJFR is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    OkResponse
  >;
}

@@doc(DeploymentResource.name, "The name of the Deployment resource.");
@@doc(DeploymentResource.properties, "Properties of the Deployment resource");
@@doc(DeploymentResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@doc(DeploymentResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@doc(DeploymentResources.generateHeapDump::parameters.body,
  "Parameters for the diagnostic operation"
);
@@doc(DeploymentResources.generateThreadDump::parameters.body,
  "Parameters for the diagnostic operation"
);
@@doc(DeploymentResources.startJFR::parameters.body,
  "Parameters for the diagnostic operation"
);
