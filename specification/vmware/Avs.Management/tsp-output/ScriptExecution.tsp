import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";


using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;


namespace Microsoft.AVS;
@doc("An instance of a script executed by a user - custom or AVS")
@parentResource(PrivateCloud)
model ScriptExecution is ProxyResource<ScriptExecutionProperties> {
@doc("Name of the user-invoked script execution resource")
@path
@key("scriptExecutionName")
@segment("scriptExecutions")
"name": string;
}



@armResourceOperations
interface ScriptExecutions {
@doc("Get an script execution by name in a private cloud")
get is ArmResourceRead<ScriptExecution>

@doc("Create or update a script execution in a private cloud")
createOrUpdate is ArmResourceCreateOrUpdateAsync<ScriptExecution>

@doc("Cancel a ScriptExecution in a private cloud")
delete is ArmResourceDeleteAsync<ScriptExecution>

@doc("List script executions in a private cloud")
list is ArmResourceListByParent<ScriptExecution>

@doc("Return the logs for a script execution resource")
getExecutionLogs is ArmResourceActionSync<ScriptExecution,paths·hl4gv6·subscriptions-subscriptionid-resourcegroups-resourcegroupname-providers-microsoft-avs-privateclouds-privatecloudname-scriptexecutions-scriptexecutionname-getexecutionlogs·post·requestbody·content·application-json·schema,ScriptExecution>

}



@@projectedName(ScriptExecutions.createOrUpdate::parameters.resource, "json", "scriptExecution");
@@extension(ScriptExecutions.createOrUpdate::parameters.resource, "x-ms-client-name", "scriptExecution");
@@doc(ScriptExecutions.createOrUpdate::parameters.resource, "A script running in the private cloud");
@@projectedName(ScriptExecutions.getExecutionLogs::parameters.body, "json", "scriptOutputStreamType");
@@extension(ScriptExecutions.getExecutionLogs::parameters.body, "x-ms-client-name", "scriptOutputStreamType");
@@doc(ScriptExecutions.getExecutionLogs::parameters.body, "Name of the desired output stream to return. If not provided, will return all. An empty array will return nothing");