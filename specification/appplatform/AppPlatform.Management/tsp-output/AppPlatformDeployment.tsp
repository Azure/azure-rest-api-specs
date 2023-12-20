import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppPlatformApp.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppPlatform;
@doc("Deployment resource payload")
@parentResource(AppPlatformApp)
model AppPlatformDeployment is ProxyResource<DeploymentResourceProperties> {
  @doc("The name of the Deployment resource.")
  @path
  @key("deploymentName")
  @segment("deployments")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface AppPlatformDeployments {
  @doc("Get a Deployment and its properties.")
  get is ArmResourceRead<AppPlatformDeployment>;
  @doc("Create a new Deployment or update an exiting Deployment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AppPlatformDeployment>;
  @doc("Operation to update an exiting Deployment.")
  update is ArmResourcePatchAsync<
    AppPlatformDeployment,
    DeploymentResourceProperties
  >;
  @doc("Operation to delete a Deployment.")
  delete is ArmResourceDeleteAsync<AppPlatformDeployment>;
  @doc("Handles requests to list all resources in an App.")
  list is ArmResourceListByParent<
    AppPlatformDeployment,
    {
      ...BaseParameters<AppPlatformDeployment>;

      @doc("Version of the deployments to be listed")
      @query({
        name: "version",
        format: "multi",
      })
      version?: string[];
    }
  >;
  @doc("Start the deployment.")
  start is ArmResourceActionAsync<AppPlatformDeployment, void, void>;
  @doc("Stop the deployment.")
  stop is ArmResourceActionAsync<AppPlatformDeployment, void, void>;
  @doc("Restart the deployment.")
  restart is ArmResourceActionAsync<AppPlatformDeployment, void, void>;
  @doc("Enable remote debugging.")
  enableRemoteDebugging is ArmResourceActionAsync<
    AppPlatformDeployment,
    RemoteDebuggingPayload,
    RemoteDebugging
  >;
  @doc("Disable remote debugging.")
  disableRemoteDebugging is ArmResourceActionAsync<
    AppPlatformDeployment,
    void,
    RemoteDebugging
  >;
  @doc("Get remote debugging config.")
  getRemoteDebuggingConfig is ArmResourceActionSync<
    AppPlatformDeployment,
    void,
    RemoteDebugging
  >;
  @doc("Get deployment log file URL")
  getLogFileUrl is ArmResourceActionSync<
    AppPlatformDeployment,
    void,
    LogFileUrlResponse
  >;
  @doc("Generate Heap Dump")
  generateHeapDump is ArmResourceActionAsync<
    AppPlatformDeployment,
    DiagnosticParameters,
    void
  >;
  @doc("Generate Thread Dump")
  generateThreadDump is ArmResourceActionAsync<
    AppPlatformDeployment,
    DiagnosticParameters,
    void
  >;
  @doc("Start JFR")
  startJFR is ArmResourceActionAsync<
    AppPlatformDeployment,
    DiagnosticParameters,
    void
  >;
}
