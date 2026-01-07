import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("The Service level resource model")
model ServiceLevelResource {
  @doc("The arm id of the service level indicator resource")
  serviceLevelIndicatorResourceId: armResourceIdentifier;

  @doc("The arm id of the service level object resource")
  serviceLevelObjectiveResourceId: armResourceIdentifier;
}

// Define the main model
@doc("Definition of goal assignment property.")
model GoalAssignmentProperties {
  @doc("Arm id of the goal template.")
  goalTemplateId: armResourceIdentifier;

  @doc("The type of goal assignment.")
  goalAssignmentType: GoalAssignmentType;

  @doc("List of service level resources.")
  @identifiers(#[])
  serviceLevelResources?: ServiceLevelResource[];

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @visibility(Lifecycle.Read)
  @doc("Details of any errors encountered during the operation.")
  errorDetails?: CommonTypes.ErrorDetail;
}

@tenantResource
@doc("Goal assignment a AzureResilienceProviderHub resource")
model GoalAssignment is ProxyResource<GoalAssignmentProperties> {
  @doc("The name of the GoalAssignment")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("goalAssignmentName")
  @segment("goalAssignments")
  @path
  name: string;

  // Adding suppressions because in-build ManagedServiceIdentityProperty has used Record which need suppression.
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  ...ManagedServiceIdentityProperty;
}
