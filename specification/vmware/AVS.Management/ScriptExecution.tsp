import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AVS;
@doc("An instance of a script executed by a user - custom or AVS")
@parentResource(PrivateCloud)
model ScriptExecution is ProxyResource<ScriptExecutionProperties> {
  @doc("Name of the user-invoked script execution resource")
  @pattern("^[-\\w\\._]+$")
  @path
  @key("scriptExecutionName")
  @segment("scriptExecutions")
  name: string;
}

@armResourceOperations
interface ScriptExecutions {
  @doc("Get an script execution by name in a private cloud")
  get is ArmResourceRead<ScriptExecution>;
  @doc("Create or update a script execution in a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<ScriptExecution>;
  @doc("Cancel a ScriptExecution in a private cloud")
  delete is ArmResourceDeleteAsync<ScriptExecution>;
  @doc("List script executions in a private cloud")
  list is ArmResourceListByParent<ScriptExecution>;
  @doc("Return the logs for a script execution resource")
  getExecutionLogs is ArmResourceActionSync<
    ScriptExecution,
    ScriptOutputStreamType[],
    ScriptExecution
  >;
}
