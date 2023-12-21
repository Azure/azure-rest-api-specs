import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./WebSiteInstanceStatus.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppService;
@doc("Process Information.")
@parentResource(WebSiteInstanceStatus)
model ProcessInfo is ProxyResource<ProcessInfoProperties> {
  @doc("PID.")
  @path
  @key("processId")
  @segment("processes")
  name: string;
}

@armResourceOperations
interface WebApps {
  @doc("Description for Get process information by its ID for a specific scaled-out instance in a web site.")
  getInstanceProcess is ArmResourceRead<ProcessInfo>;
  @doc("Description for Terminate a process by its ID for a web site, or a deployment slot, or specific scaled-out instance in a web site.")
  deleteInstanceProcess is ArmResourceDeleteSync<ProcessInfo>;
  @doc("Description for Get list of processes for a web site, or a deployment slot, or for a specific scaled-out instance in a web site.")
  listInstanceProcesses is ArmResourceListByParent<ProcessInfo>;
  @summary("Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for Get a memory dump of a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/processes/{processId}/dump")
  @get
  GetInstanceProcessDump is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    void
  >;

  @summary("List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @doc("Description for List the threads in a process by its ID for a specific scaled-out instance in a web site.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Web/sites/{name}/instances/{instanceId}/processes/{processId}/threads")
  @get
  ListInstanceProcessThreads is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the resource group to which the resource belongs.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[-\\w\\._\\(\\)]+[^\\.]$")
      @path
      resourceGroupName: string;

      @doc("Site name.")
      @path
      name: string;

      @doc("PID.")
      @path
      processId: string;

      @doc("ID of a specific scaled-out instance. This is the value of the name property in the JSON response from \"GET api/sites/{siteName}/instances\".")
      @path
      instanceId: string;

      @doc("Your Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000).")
      @path
      subscriptionId: string;
    },
    ProcessThreadInfoCollection
  >;
}
