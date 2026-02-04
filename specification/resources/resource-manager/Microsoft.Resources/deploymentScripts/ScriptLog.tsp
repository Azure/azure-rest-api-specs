import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
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

@@doc(ScriptLog.name, "");
@@doc(ScriptLog.properties, "Script log properties.");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy flatten for SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(ScriptLog.properties);
