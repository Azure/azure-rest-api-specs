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

namespace Microsoft.Lionrock;

@doc("plannedQuota properties")
model PlannedQuotaResourceProperties {
  @doc("Name of the Planned Quota.")
  plannedQuotaName: string;

  @doc("Contact email address, which receives notifications about the request progress.")
  contactEmail: string;

  @doc("The name of the subscription definition in the plan to bind the subscription ID to.")
  @madeOptional(Versions.v2025_12_04_preview)
  subscriptionNameInPlan?: string;

  @doc("Stage name.")
  @removed(Versions.v2025_12_04_preview)
  stage?: string;

  @doc("Blueprint name.")
  @added(Versions.v2025_12_04_preview)
  blueprint?: string;

  @doc("The Azure location.")
  azureLocation: azureLocation;

  @doc("Plan version.")
  planVersion?: string;

  @doc("Property bindings.")
  @Azure.ResourceManager.identifiers(#[])
  propertyBindings?: Array<PropertyBinding>;

  @doc("Set to true to skip the not ready resources in the plan silently without failure.")
  skipUnsupportedSilently?: boolean;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: LionrockProvisioningState;

  @doc("The planned quota request identifier; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  requestId?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Fulfilled Plan details after fulfilling the quota of the plan; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  fulfilledPlan?: {};

  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Generic object model is used, because the number of nested properties can be different."
  @doc("Dictionary of the SKUs with alternative assigned. The key is the original SKU and the value is the alternative; a part of provisioning ResultData output.")
  @visibility(Lifecycle.Read) // A part of provisioning ResultData output, gets PATCHed back from FRP.
  alternatives?: {};
}

@doc("Planned Quota Property Binding.")
model PropertyBinding {
  @doc("Property binding placeholder.")
  placeholder: string;

  @doc("Actual resource name of the property.")
  resourceName: string;
}

@doc("plannedQuota Resource")
@subscriptionResource
model PlannedQuotaResource
  is ProxyResource<PlannedQuotaResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]*$")
  @minLength(3)
  @maxLength(80)
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
