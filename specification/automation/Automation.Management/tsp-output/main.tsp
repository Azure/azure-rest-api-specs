import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./PrivateEndpointConnection.tsp";
import "./Module.tsp";
import "./Module.tsp";
import "./DscNode.tsp";
import "./DscNodeConfiguration.tsp";
import "./DscCompilationJob.tsp";
import "./SourceControl.tsp";
import "./AutomationAccount.tsp";
import "./Certificate.tsp";
import "./Connection.tsp";
import "./ConnectionType.tsp";
import "./Credential.tsp";
import "./JobSchedule.tsp";
import "./Schedule.tsp";
import "./Variable.tsp";
import "./Watcher.tsp";
import "./DscConfiguration.tsp";
import "./Job.tsp";
import "./SoftwareUpdateConfiguration.tsp";
import "./Runbook.tsp";
import "./Webhook.tsp";
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
// FIXME: Common type version v2 is not supportted for now.
// @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v2)
@doc("Automation Client")
namespace Azure.ResourceManager.Automation;
