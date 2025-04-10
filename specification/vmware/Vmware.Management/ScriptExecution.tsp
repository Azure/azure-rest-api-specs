import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./PrivateCloud.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
/**
 * An instance of a script executed by a user - custom or AVS
 */
@parentResource(PrivateCloud)
model ScriptExecution
  is Azure.ResourceManager.ProxyResource<ScriptExecutionProperties> {
  ...ResourceNameParameter<
    Resource = ScriptExecution,
    KeyName = "scriptExecutionName",
    SegmentName = "scriptExecutions",
    NamePattern = "^[-\\w\\._]+$"
  >;
}

@armResourceOperations
interface ScriptExecutions {
  /**
   * Get a ScriptExecution
   */
  get is ArmResourceRead<ScriptExecution>;

  /**
   * Create a ScriptExecution
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ScriptExecution>;

  /**
   * Delete a ScriptExecution
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ScriptExecution,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List ScriptExecution resources by PrivateCloud
   */
  list is ArmResourceListByParent<
    ScriptExecution,
    Response = ArmResponse<ScriptExecutionsList>
  >;

  /**
   * Return the logs for a script execution resource
   */
  getExecutionLogs is ArmResourceActionSync<
    ScriptExecution,
    {
      /**
       * Name of the desired output stream to return. If not provided, will return all. An empty array will return nothing.
       */
      @bodyRoot
      scriptOutputStreamType?: ScriptOutputStreamType[];
    },
    ArmResponse<ScriptExecution>
  >;
}

@@doc(ScriptExecution.name, "Name of the script cmdlet.");
@@doc(ScriptExecution.properties,
  "The resource-specific properties for this resource."
);
