import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Workflow.tsp";
import "./WorkflowVersion.tsp";
import "./WorkflowTrigger.tsp";
import "./WorkflowTriggerHistory.tsp";
import "./WorkflowRun.tsp";
import "./WorkflowRun.tsp";
import "./WorkflowRunAction.tsp";
import "./WorkflowRunActionRepetitionDefinition.tsp";
import "./WorkflowRunActionRepetitionDefinition.tsp";
import "./RequestHistory.tsp";
import "./RequestHistory.tsp";
import "./IntegrationAccount.tsp";
import "./AssemblyDefinition.tsp";
import "./BatchConfiguration.tsp";
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
/**
 * REST API for Azure Logic Apps.
 */
@armProviderNamespace
@useAuth(AadOauth2Auth<["user_impersonation"]>)
@service({
  title: "LogicManagementClient",
})
@versioned(Versions)
namespace Microsoft.Logic;

/**
 * The available API versions.
 */
enum Versions {
  /**
   * The 2019-05-01 API version.
   */
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2019_05_01: "2019-05-01",
}
