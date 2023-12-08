import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./AutomationPrivateEndpointConnection.tsp";
import "./AutomationAccountPython2Package.tsp";
import "./AutomationAccountModule.tsp";
import "./DscNode.tsp";
import "./DscNodeConfiguration.tsp";
import "./DscCompilationJob.tsp";
import "./AutomationSourceControl.tsp";
import "./AutomationAccount.tsp";
import "./AutomationCertificate.tsp";
import "./AutomationConnection.tsp";
import "./AutomationConnectionType.tsp";
import "./AutomationCredential.tsp";
import "./AutomationJobSchedule.tsp";
import "./AutomationSchedule.tsp";
import "./AutomationVariable.tsp";
import "./AutomationWatcher.tsp";
import "./DscConfiguration.tsp";
import "./AutomationJob.tsp";
import "./SoftwareUpdateConfiguration.tsp";
import "./AutomationRunbook.tsp";
import "./AutomationWebhook.tsp";
import "./HybridRunbookWorker.tsp";
import "./HybridRunbookWorkerGroup.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "AutomationClient",
})
@doc("Automation Client")
namespace Azure.ResourceManager.Automation;
