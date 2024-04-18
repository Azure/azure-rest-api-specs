import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using Autorest;

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

  @doc("Plan version")
  planVersion?: string;

  @doc("Stage name")
  stage?: string;

  @doc("Property bindings")
  @extension("x-ms-identifiers", [])
  propertyBindings?: Array<PropertyBinding>;

  @doc("Skip unsupported silently")
  skipUnsupportedSilently?: boolean;

  @doc("Provisioning state")
  @visibility("read")
  provisioningState?: PlannedQuotaProvisioningState;
}

@doc("plannedQuota Property Binding")
model PropertyBinding {
  @doc("Placeholder")
  placeholder: string;

  @doc("Resource Name")
  resourceName: string;
}

@doc("plannedQuota Resource")
model PlannedQuotaResource
  is ProxyResource<PlannedQuotaResourceProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("plannedQuotas") // Start with lower case. Should be plural
  @visibility("read")
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface PlannedQuota {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PlannedQuotaResource>;
  listBySubscription is ArmListBySubscription<PlannedQuotaResource>;
  listByResourceGroup is ArmResourceListByParent<PlannedQuotaResource>;
  get is ArmResourceRead<PlannedQuotaResource>;
}
