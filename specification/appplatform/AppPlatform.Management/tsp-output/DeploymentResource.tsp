import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppPlatform;
@doc("Deployment resource payload")
@parentResource(AppResource)
model DeploymentResource is ProxyResource<DeploymentResourceProperties> {
  @doc("The name of the Deployment resource.")
  @key("deploymentName")
  @segment("deployments")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "Deployments")
interface DeploymentResources_Deployments {
  @doc("Get a Deployment and its properties.")
  get is ArmResourceRead<DeploymentResource>;

  @doc("Create a new Deployment or update an exiting Deployment.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<DeploymentResource>;

  @doc("Operation to update an exiting Deployment.")
  update is ArmCustomPatchAsync<DeploymentResource, DeploymentResource>;

  @doc("Operation to delete a Deployment.")
  delete is ArmResourceDeleteAsync<DeploymentResource>;

  @doc("Handles requests to list all resources in an App.")
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

  @doc("Start the deployment.")
  start is ArmResourceActionAsync<DeploymentResource, void, void>;

  @doc("Stop the deployment.")
  stop is ArmResourceActionAsync<DeploymentResource, void, void>;

  @doc("Restart the deployment.")
  restart is ArmResourceActionAsync<DeploymentResource, void, void>;

  @doc("Enable remote debugging.")
  enableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    RemoteDebuggingPayload,
    RemoteDebugging
  >;

  @doc("Disable remote debugging.")
  disableRemoteDebugging is ArmResourceActionAsync<
    DeploymentResource,
    void,
    RemoteDebugging
  >;

  @doc("Get remote debugging config.")
  getRemoteDebuggingConfig is ArmResourceActionSync<
    DeploymentResource,
    void,
    RemoteDebugging
  >;

  @doc("Get deployment log file URL")
  getLogFileUrl is ArmResourceActionSync<
    DeploymentResource,
    void,
    LogFileUrlResponse
  >;

  @doc("Generate Heap Dump")
  generateHeapDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;

  @doc("Generate Thread Dump")
  generateThreadDump is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;

  @doc("Start JFR")
  startJFR is ArmResourceActionAsync<
    DeploymentResource,
    DiagnosticParameters,
    void
  >;
}
