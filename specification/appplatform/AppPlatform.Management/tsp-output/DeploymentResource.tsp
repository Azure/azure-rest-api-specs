import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppPlatform;
/**
 * Deployment resource payload
 */
@parentResource(AppResource)
model DeploymentResource is ProxyResource<DeploymentResourceProperties> {
  /**
   * The name of the Deployment resource.
   */
  @path
  @key("deploymentName")
  @segment("deployments")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface DeploymentResources {
  /**
   * Get a Deployment and its properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Get")
  get is ArmResourceRead<DeploymentResource>;

  /**
   * Create a new Deployment or update an exiting Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<DeploymentResource>;

  /**
   * Operation to update an exiting Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Deployments_Update")
  update is ArmCustomPatchAsync<DeploymentResource, DeploymentResource>;

  /**
   * Operation to delete a Deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteAsync<DeploymentResource>;

  /**
   * Handles requests to list all resources in an App.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_List")
  list is ArmResourceListByParent<
    DeploymentResource,
    {
      ...BaseParameters<DeploymentResource>;

      /**
       * Version of the deployments to be listed
       */
      @query({
        name: "version",
        format: "multi",
      })
      version?: string[];
    }
  >;

  /**
   * Start the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Start")
  start is ArmResourceActionAsync<DeploymentResource, void, void>;

  /**
   * Stop the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Stop")
  stop is ArmResourceActionAsync<DeploymentResource, void, void>;

  /**
   * Restart the deployment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_Restart")
  restart is ArmResourceActionAsync<DeploymentResource, void, void>;

  /**
   * Enable remote debugging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_EnableRemoteDebugging")
  enableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    RemoteDebuggingPayload,
    RemoteDebugging
  >;

  /**
   * Disable remote debugging.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_DisableRemoteDebugging")
  disableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    void,
    RemoteDebugging
  >;

  /**
   * Get remote debugging config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_GetRemoteDebuggingConfig")
  getRemoteDebuggingConfig is ArmResourceActionSync<
    DeploymentResource,
    void,
    RemoteDebugging
  >;

  /**
   * Get deployment log file URL
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_GetLogFileUrl")
  getLogFileUrl is ArmResourceActionSync<
    DeploymentResource,
    void,
    LogFileUrlResponse
  >;

  /**
   * Generate Heap Dump
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_GenerateHeapDump")
  generateHeapDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;

  /**
   * Generate Thread Dump
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_GenerateThreadDump")
  generateThreadDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;

  /**
   * Start JFR
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Deployments_StartJFR")
  startJFR is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;
}

@@projectedName(DeploymentResources.createOrUpdate::parameters.resource,
  "json",
  "deploymentResource"
);
@@extension(DeploymentResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "deploymentResource"
);
@@doc(DeploymentResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
@@projectedName(DeploymentResources.update::parameters.properties,
  "json",
  "deploymentResource"
);
@@extension(DeploymentResources.update::parameters.properties,
  "x-ms-client-name",
  "deploymentResource"
);
@@doc(DeploymentResources.update::parameters.properties,
  "Parameters for the update operation"
);
@@projectedName(DeploymentResources.enableRemoteDebugging::parameters.body,
  "json",
  "remoteDebuggingPayload"
);
@@extension(DeploymentResources.enableRemoteDebugging::parameters.body,
  "x-ms-client-name",
  "remoteDebuggingPayload"
);
@@doc(DeploymentResources.enableRemoteDebugging::parameters.body,
  "Parameters for enable remote debugging"
);
@@projectedName(DeploymentResources.generateHeapDump::parameters.body,
  "json",
  "diagnosticParameters"
);
@@extension(DeploymentResources.generateHeapDump::parameters.body,
  "x-ms-client-name",
  "diagnosticParameters"
);
@@doc(DeploymentResources.generateHeapDump::parameters.body,
  "Parameters for the diagnostic operation"
);
@@projectedName(DeploymentResources.generateThreadDump::parameters.body,
  "json",
  "diagnosticParameters"
);
@@extension(DeploymentResources.generateThreadDump::parameters.body,
  "x-ms-client-name",
  "diagnosticParameters"
);
@@doc(DeploymentResources.generateThreadDump::parameters.body,
  "Parameters for the diagnostic operation"
);
@@projectedName(DeploymentResources.startJFR::parameters.body,
  "json",
  "diagnosticParameters"
);
@@extension(DeploymentResources.startJFR::parameters.body,
  "x-ms-client-name",
  "diagnosticParameters"
);
@@doc(DeploymentResources.startJFR::parameters.body,
  "Parameters for the diagnostic operation"
);
