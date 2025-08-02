import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DeploymentScript.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace DeploymentScriptsClient;
/**
 * Script execution log object.
 */
@singleton("default")
@parentResource(DeploymentScript)
model ScriptLog is ProxyResource<LogProperties> {
  ...ResourceNameParameter<
    Resource = ScriptLog,
    KeyName = "log",
    SegmentName = "logs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ScriptLogs {
  /**
   * Gets deployment script logs for a given deployment script name.
   */
  getLogsDefault is ArmResourceRead<
    ScriptLog,
    Parameters = {
      /**
       * The number of lines to show from the tail of the deployment script log. Valid value is a positive number up to 1000. If 'tail' is not provided, all available logs are shown up to container instance log capacity of 4mb.
       */
      @query("tail")
      tail?: int32;
    }
  >;

  /**
   * Gets deployment script logs for a given deployment script name.
   */
  getLogs is ArmResourceListByParent<
    ScriptLog,
    Response = ArmResponse<ScriptLogsList>
  >;
}

@@doc(ScriptLog.name, "");
@@doc(ScriptLog.properties, "Script log properties.");
