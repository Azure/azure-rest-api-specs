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
/**
* An instance of a script executed by a user - custom or AVS
*/
@parentResource(PrivateCloud)
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ScriptExecutionProperties)
model ScriptExecution extends ProxyResourceBase {
/**
* Name of the user-invoked script execution resource
*/
@pattern("^[-\\w\\._]+$")
@path
@key("scriptExecutionName")
@segment("scriptExecutions")
@visibility("read")
"name": string;
/**
* The properties of a script execution resource
*/
@extension("x-ms-client-flatten", true)
properties?: ScriptExecutionProperties
}



@armResourceOperations
interface ScriptExecutions {
/**
* Get an script execution by name in a private cloud
*/
get is ArmResourceRead<ScriptExecution>;

/**
* Create or update a script execution in a private cloud
*/
createOrUpdate is ArmResourceCreateOrReplaceAsync<ScriptExecution>;

/**
* Cancel a ScriptExecution in a private cloud
*/
delete is ArmResourceDeleteAsync<ScriptExecution>;

/**
* List script executions in a private cloud
*/
@operationId("ScriptExecutions_List")
#suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
list is ArmResourceListByParent<ScriptExecution>;

/**
* Return the logs for a script execution resource
*/
// getExecutionLogs is ArmResourceActionSync<ScriptExecution,paths·hl4gv6·subscriptions-subscriptionid-resourcegroups-resourcegroupname-providers-microsoft-avs-privateclouds-privatecloudname-scriptexecutions-scriptexecutionname-getexecutionlogs·post·requestbody·content·application-json·schema,ScriptExecution>
getExecutionLogs is ArmResourceActionSync<ScriptExecution, void, ScriptExecution>
}



@@projectedName(ScriptExecutions.`createOrUpdate`::parameters.resource, "json", "scriptExecution");
@@extension(ScriptExecutions.`createOrUpdate`::parameters.resource, "x-ms-client-name", "scriptExecution");
@@doc(ScriptExecutions.`createOrUpdate`::parameters.resource, "A script running in the private cloud");
@@projectedName(ScriptExecutions.`getExecutionLogs`::parameters.body, "json", "scriptOutputStreamType");
@@extension(ScriptExecutions.`getExecutionLogs`::parameters.body, "x-ms-client-name", "scriptOutputStreamType");
@@doc(ScriptExecutions.`getExecutionLogs`::parameters.body, "Name of the desired output stream to return. If not provided, will return all. An empty array will return nothing");