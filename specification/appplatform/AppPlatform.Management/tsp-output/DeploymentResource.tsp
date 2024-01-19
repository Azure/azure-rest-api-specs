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
@doc("Deployment resource payload")
@parentResource(AppResource)
model DeploymentResource is ProxyResource<DeploymentResourceProperties> {
  @doc("The name of the Deployment resource.")
  @path
  @key("deploymentName")
  @segment("deployments")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface DeploymentResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a Deployment and its properties.")
  @operationId("Deployments_Get")
  get is ArmResourceRead<DeploymentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a new Deployment or update an exiting Deployment.")
  @operationId("Deployments_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeploymentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to update an exiting Deployment.")
  @operationId("Deployments_Update")
  update is ArmCustomPatchAsync<DeploymentResource, DeploymentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a Deployment.")
  @operationId("Deployments_Delete")
  delete is ArmResourceDeleteAsync<DeploymentResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Handles requests to list all resources in an App.")
  @operationId("Deployments_List")
  list is ArmResourceListByParent<
    DeploymentResource,
    {
      ...BaseParameters<DeploymentResource>;

      @doc("Version of the deployments to be listed")
      @query({
        name: "version",
        format: "multi",
      })
      version?: string[];
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Start the deployment.")
  @operationId("Deployments_Start")
  start is ArmResourceActionAsync<DeploymentResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Stop the deployment.")
  @operationId("Deployments_Stop")
  stop is ArmResourceActionAsync<DeploymentResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Restart the deployment.")
  @operationId("Deployments_Restart")
  restart is ArmResourceActionAsync<DeploymentResource, void, void>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Enable remote debugging.")
  @operationId("Deployments_EnableRemoteDebugging")
  enableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    RemoteDebuggingPayload,
    RemoteDebugging
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Disable remote debugging.")
  @operationId("Deployments_DisableRemoteDebugging")
  disableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    void,
    RemoteDebugging
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get remote debugging config.")
  @operationId("Deployments_GetRemoteDebuggingConfig")
  getRemoteDebuggingConfig is ArmResourceActionSync<
    DeploymentResource,
    void,
    RemoteDebugging
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get deployment log file URL")
  @operationId("Deployments_GetLogFileUrl")
  getLogFileUrl is ArmResourceActionSync<
    DeploymentResource,
    void,
    LogFileUrlResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generate Heap Dump")
  @operationId("Deployments_GenerateHeapDump")
  generateHeapDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generate Thread Dump")
  @operationId("Deployments_GenerateThreadDump")
  generateThreadDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Start JFR")
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
