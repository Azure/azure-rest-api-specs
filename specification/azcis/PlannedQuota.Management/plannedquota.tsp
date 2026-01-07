import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.AzureCis;

@doc("plannedQuota properties")
model PlannedQuotaResourceProperties {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-property" "Duplicate property found in the resource envelope and resource properties."
  @doc("Name of the resource template")
  plannedQuotaName: string;

  @doc("Contact email for manual approval")
  contactEmail: string;

  @doc("Subscription Name in plan")
  subscriptionNameInPlan: string;

  @doc("Stage name")
  stage?: string;

  @doc("Blueprint name")
  @added(Versions.v2025_12_04_preview)
  blueprint?: string;

  @doc("Region name")
  @added(Versions.v2023_08_22)
  @removed(Versions.v2024_06_24_preview)
  region: string;

  @doc("The Azure location")
  @added(Versions.v2024_06_24_preview)
  azureLocation: azureLocation;

  @doc("Plan version")
  planVersion?: string;

  @doc("Property bindings")
  @Azure.ResourceManager.identifiers(#[])
  propertyBindings?: Array<PropertyBinding>;

  @doc("Skip unsupported silently")
  skipUnsupportedSilently?: boolean;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: PlannedQuotaProvisioningState;

  @added(Versions.v2024_06_24_preview)
  @doc("The planned quota request identifier; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  requestId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @added(Versions.v2024_06_24_preview)
  @doc("Fulfilled Plan details after fulfilling the quota of the plan; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  fulfilledPlan?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @added(Versions.v2024_06_24_preview)
  @doc("Dictionary of the SKUs with alternative assigned. The key is the original SKU and the value is the alternative; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  alternatives?: {};
}

@doc("plannedQuota Property Binding")
model PropertyBinding {
  @doc("Property binding placeholder")
  placeholder: string;

  @doc("Resource name of the property")
  resourceName: string;
}

@doc("plannedQuota Resource")
@subscriptionResource
model PlannedQuotaResource
  is ProxyResource<PlannedQuotaResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("plannedQuotas") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Delete operation is currently not supported by FRP."
@armResourceOperations
interface PlannedQuota {
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "Fix on next update"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PlannedQuotaResource,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  listBySubscription is ArmListBySubscription<PlannedQuotaResource>;
  get is ArmResourceRead<PlannedQuotaResource>;
}

@@visibility(PlannedQuotaResource.properties, Lifecycle.Read, Lifecycle.Create);
