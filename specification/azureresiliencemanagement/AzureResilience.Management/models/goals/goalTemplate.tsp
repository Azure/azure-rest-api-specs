import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "../../main.tsp";
import "./enum.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Definition of goal template property.")
model GoalTemplateProperties {
  @doc("Description string provided by customer.")
  description?: string;

  @doc("Option specified by customer under high availability section of goal template")
  requireHighAvailability?: RequirementSelected;

  @doc("Option specified by customer under disaster recovery section of goal template")
  requireDisasterRecovery?: RequirementSelected;

  @doc("Regional recovery point objective specified by customer. eg, PT15M for 15 minutes")
  regionalRecoveryPointObjective?: string;

  @doc("Regional recovery time objective specified by customer. eg, PT15M for 15 minutes")
  regionalRecoveryTimeObjective?: string;

  @doc("Type of Goal Template created by customer")
  goalType: GoalType;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Details of any errors encountered during the operation.")
  errorDetails?: CommonTypes.ErrorDetail;
}

@tenantResource
@doc("Goal template a AzureResilienceProviderHub resource")
model GoalTemplate
  is Azure.ResourceManager.ProxyResource<GoalTemplateProperties> {
  @doc("The name of the goalTemplate")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("goalTemplateName")
  @segment("goalTemplates")
  @path
  name: string;
}
