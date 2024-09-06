import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

/** Microsoft.Resilience Resource Provider management API. */
@armProviderNamespace(ProviderName)
@service({
  title: ProviderName,
})
@armCommonTypesVersion(CommonTypes.Versions.v5)
@versioned(Versions)
namespace Microsoft.Resilience;

@doc("The available API versions for Microsoft.Resilience")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-06-01-preview")
  v2024_06_01_preview: "2024-06-01-preview",
}

alias ProviderName = "Microsoft.Resilience";

// Regex for all our resource name validations. Must be between 3 and 26 characters long and can contain alphanumeric and hyphens, must start and end with an alphanumeric character
alias resourceNameRegex = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,24}[a-zA-Z0-9]$";

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Resilience Resource")
model ResilienceResource is ExtensionResource<ResilienceProperties> {
  @doc("The resilience resource name")
  @segment("resilienceStates")
  @key("resilienceState")
  @visibility("read")
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@doc("Resilience Properties")
model ResilienceProperties {
  @doc("Type of event that triggered the resilience evaluation.")
  @visibility("read")
  eventType: ArnEventType;

  @doc("Resilience evaluation for the resource and its dependencies.")
  @visibility("read")
  resilienceProfiles: ResourceResilienceProfile[];

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ResourceProvisioningState;
}

@doc("Resilience Profile for a resource.")
model ResourceResilienceProfile {
  // https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#modeling-arrays-of-complex-types
  @doc("Azure Resource ID of the resource being evaluated.")
  id: armResourceIdentifier<[]>;

  @doc("Resource Type of the resource being evaluated.")
  type: string;

  @doc("Location of the resource being evaluated.")
  location: string;

  @doc("Zones where the resource being evaluated is deployed.")
  zones: string[];

  @doc("SKU of the resource being evaluated.")
  sku: Azure.ResourceManager.Foundations.Sku;

  @doc("Classification assigned to the resource being evaluated.")
  azoresClassification: AzoresClassification;

  @doc("UTC Date and time when the resource was created.")
  creationDate: utcDateTime;

  @doc("Resilience Rules for the resource and their evaluation results.")
  resilienceEvaluations: ResilienceRuleEvaluation[];

  @doc("Resilience State of the resource.")
  resilienceState: ResilienceState;
}

@doc("Azores Classification tags applied for resource exclusion/assertion.")
model AzoresClassification {
  @doc("Classification of the resource. e.g. 'Non-Service Critical'.")
  classification: string;

  @doc("Categorization of the resource. e.g. 'DataPlane'.")
  categorization: string;

  @doc("Usage of the resource.")
  usage: string;
}

@doc("Resilience Rule Evaluation.")
model ResilienceRuleEvaluation {
  @doc("Resilience Rule ID (GUID).")
  id: string;

  @doc("Resilience State that the rule is targeting.")
  targetState: ResilienceState;

  @doc("Evaluation result of the rule.")
  result: EvaluationResult;
}

@doc("Azure Resource Notification Event Types.")
union ArnEventType {
  @doc("Snapshot event.")
  Snapshot: "Snapshot",

  @doc("Resource delete event.")
  Delete: "Delete",

  @doc("Resource move event.")
  Move: "Move",

  @doc("Resource write event.")
  Write: "Write",

  string,
}

@doc("Evaluation Results.")
union EvaluationResult {
  @doc("No evaluation results available.")
  None: "None",

  @doc("Evaluation Failed.")
  Failed: "Failed",

  @doc("Evaluation Succeeded.")
  Succeeded: "Succeeded",

  string,
}

@doc("Resilience states")
union ResilienceState {
  @doc("Not Applicable state.")
  NotApplicable: "NotApplicable",

  @doc("Non-resilient state.")
  NonResilient: "NonResilient",

  @doc("Zone Aligned state.")
  ZoneAligned: "ZoneAligned",

  @doc("Zone Redundant state.")
  ZoneRedundant: "ZoneRedundant",

  @doc("Always Available state.")
  AlwaysAvailable: "AlwaysAvailable",

  string,
}

@armResourceOperations
interface Resilience {
  get is ArmResourceRead<ResilienceResource>;
  list is ArmResourceListByParent<ResilienceResource>;
}
