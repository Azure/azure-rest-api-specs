import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./LogicWorkflow.tsp";
import "./LogicWorkflowVersion.tsp";
import "./LogicWorkflowTrigger.tsp";
import "./LogicWorkflowTriggerHistory.tsp";
import "./LogicWorkflowRun.tsp";
import "./LogicWorkflowRunOperation.tsp";
import "./LogicWorkflowRunAction.tsp";
import "./LogicWorkflowRunActionRepetition.tsp";
import "./LogicWorkflowRunActionScopeRepetition.tsp";
import "./LogicWorkflowRunActionRepetitionRequestHistory.tsp";
import "./LogicWorkflowRunActionRequestHistory.tsp";
import "./IntegrationAccount.tsp";
import "./IntegrationAccountAssemblyDefinition.tsp";
import "./IntegrationAccountBatchConfiguration.tsp";
import "./IntegrationAccountSchema.tsp";
import "./IntegrationAccountMap.tsp";
import "./IntegrationAccountPartner.tsp";
import "./IntegrationAccountAgreement.tsp";
import "./IntegrationAccountCertificate.tsp";
import "./IntegrationAccountSession.tsp";
import "./IntegrationServiceEnvironment.tsp";
import "./IntegrationServiceEnvironmentManagedApi.tsp";
import "./routes.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager.Foundations;
using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;
@armProviderNamespace
@service({
  title: "LogicManagementClient",
})
@versioned(Versions)
@doc("REST API for Azure Logic Apps.")
namespace Azure.ResourceManager.Logic;

@doc("The available API versions.")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_05_01: "2019-05-01",
}
