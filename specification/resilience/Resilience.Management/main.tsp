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
@service(#{ title: ProviderName })
@armCommonTypesVersion(CommonTypes.Versions.v6)
@versioned(Versions)
namespace Microsoft.Resilience;

@doc("The available API versions for Microsoft.Resilience")
enum Versions {
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-06-01-preview")
  v2024_06_01_preview: "2024-06-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2024-11-01-preview")
  v2024_11_01_preview: "2024-11-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-01-01-preview")
  v2025_01_01_preview: "2025-01-01-preview",

  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  @doc("2025-03-01-preview")
  v2025_03_01_preview: "2025-03-01-preview",
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
  @visibility(Lifecycle.Read)
  @path
  @pattern(resourceNameRegex)
  name: string;
}

@doc("Resilience Properties")
model ResilienceProperties {
  @doc("Type of event that triggered the resilience evaluation.")
  @visibility(Lifecycle.Read)
  eventType: ArnEventType;

  @added(Versions.v2024_11_01_preview)
  @doc("Tenant ID of the resource(s) being evaluated.")
  @visibility(Lifecycle.Read)
  tenantId: string;

  @added(Versions.v2024_11_01_preview)
  @doc("Resilience state of the resource after evaluating all its related resources' resilience states.")
  @visibility(Lifecycle.Read)
  resilienceState: ResilienceState;

  @doc("Resilience evaluation for the resource and all its related resources.")
  @visibility(Lifecycle.Read)
  resilienceProfiles: ResourceResilienceProfile[];

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;
}

@doc("Resilience Profile for a resource.")
model ResourceResilienceProfile {
  // https://azure.github.io/typespec-azure/docs/howtos/ARM/resource-type#modeling-arrays-of-complex-types
  @doc("Azure Resource ID of the resource being evaluated.")
  id: armResourceIdentifier<[]>;

  @doc("Resource Type of the resource being evaluated.")
  type: string;

  @added(Versions.v2025_03_01_preview)
  @doc("Subscription ID of the resource(s) being evaluated.")
  subscriptionId: string;

  @added(Versions.v2025_03_01_preview)
  @doc("Resource Group Name of the resource(s) being evaluated.")
  resourceGroupName: string;

  @visibility(Lifecycle.Read, Lifecycle.Create)
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

  @added(Versions.v2025_01_01_preview)
  @doc("Reasons for the resilience state of the resource.")
  resilienceStateReasons: ResilienceStateReason[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Dynamic properties for extensibility"
  @added(Versions.v2025_03_01_preview)
  @visibility(Lifecycle.Read)
  @doc("Optional property for extended metadata.")
  extendedMetadata?: Record<string>;
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
  @added(Versions.v2025_01_01_preview)
  @doc("Undefined state.")
  Undefined: "Undefined",

  @doc("Not Applicable state.")
  NotApplicable: "NotApplicable",

  @added(Versions.v2025_01_01_preview)
  @doc("Non-zone-resilient state.")
  NonZoneResilient: "NonZoneResilient",

  @removed(Versions.v2025_01_01_preview)
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

@added(Versions.v2025_01_01_preview)
@doc("Resilience state reasons")
union ResilienceStateReason {
  @doc("Platform Error.")
  PlatformError: "PlatformError",

  @doc("Related resource evaluation Failed.")
  RelatedResourceEvaluationFailed: "RelatedResourceEvaluationFailed",

  @doc("SKU doesn't support Availability Zones.")
  SkuNonAZ: "SkuNonAZ",

  @doc("Sku capacity is not configured to support zone resilient deployment.")
  SkuCapacityLessThanThree: "SkuCapacityLessThanThree",

  @doc("Region doesn't support Availability Zones.")
  RegionNonAZ: "RegionNonAZ",

  @doc("Zones count is not one.")
  ZonesCountNotOne: "ZonesCountNotOne",

  @doc("Zones count is less than two.")
  ZonesCountLessThanTwo: "ZonesCountLessThanTwo",

  @doc("Zones count is less than three.")
  ZonesCountLessThanThree: "ZonesCountLessThanThree",

  @doc("Zones flag is not set.")
  ZonesFlagNotSet: "ZonesFlagNotSet",

  @doc("Zones not aligned.")
  ZonesNotAligned: "ZonesNotAligned",

  string,
}

@armResourceOperations
interface Resilience {
  get is ArmResourceRead<ResilienceResource>;
  list is ArmResourceListByParent<ResilienceResource>;
}
