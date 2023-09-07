import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using Azure.Core.Traits;

@armProviderNamespace("Microsoft.EnterpriseSupport")
@service({
  title: "Microsoft ESRP",
  version: "2023-05-01-preview",
  summary: "Microsoft Enterprise Support Resource Provider"
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Microsoft.EnterpriseSupport;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A ESRPProviderHub resource")
model EnterpriseSupports is TrackedResource<EnterpriseSupportsResponseProperties> {
	@doc("The name of the  Enterprise Support")
	@pattern("^[a-zA-Z0-9-]{3,24}$")
	@key("EnterpriseSupportName")
	@segment("EnterpriseSupports")
	@path
	name: string;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
enum ProvisioningState {
	...ResourceProvisioningState,
	Provisioning,
	Updating,
	Deleting,
	Accepted,
	Deleted
}

@doc("Details of the ESRP EnterpriseSupport.")
model EnterpriseSupportsResponseProperties {
	@doc("Provisioning status")
	provisioningState?: ProvisioningState;

	@doc("Billing Account ID")
	billingAccountId: string;

	@doc("Billing Group ID")
	billingGroupId: string;

	@doc("Invoice section for the billing account")
	projectId: string;

	@doc("BicCat product ID")
	productId: string;

	@doc("BigCat SKU ID")
	skuId: string;

	@doc("BigCat availability ID")
	availabilityId: string;

	@doc("BigCat Term ID")
	termId: string;

	@doc("Quantity for the purchase")
	quantity: integer;

	@doc("Service start date for  Enterprise Support")
	serviceStartDate: utcDateTime;

	@doc("CSAM for the  Enterprise Support")
	csam: string;
}

@doc("The request for an eligibility check.")
model ValidateEnterpriseSupportRequestItem {
	@doc("The array of items to be validated")
	items: Array<ItemToValidate>;
}

@doc("The item to be validated.")
model ItemToValidate {
	@doc("The billing account ID")
	billingAccountId: string;

	@doc("The billing group ID")
	billingGroupId: string;

	@doc("The product ID.")
	productId: string;

	@doc("The product SKU ID.")
	skuId: string;

	@doc("The quantity for this purchase")
	quantity: integer;
}

@doc("The response for an eligibility check.")
model ValidateEnterpriseSupportResponseItem {
	@doc("The billing account ID")
	billingAccountId: string;

	@doc("The billing group ID")
	billingGroupId: string;

	@doc("The product ID.")
	productId: string;

	@doc("The product SKU ID.")
	skuId: string;

	@doc("The quantity for this purchase")
	quantity: integer;	

	@doc("Boolean value to determine if purchase is eligible")
	isEligible: boolean;	

	@doc("String reason for isEligible")
	reason: string;

	@doc("Code reason for isEligible")
	reasonCode: integer;
}

@doc("Parameters for a custom operation.")
model CustomParams {
	@doc("Subscription ID")
	@path
	@segment("subscriptions")
	subscriptionId: string;

	@doc("Resource Group Name")
	@path
	@segment("resourceGroups")
	resourceGroupName: string;
}

@armResourceOperations
interface EnterpriseSupportsResource extends TrackedResourceOperations<EnterpriseSupports, EnterpriseSupportsResponseProperties> {
}

@autoRoute
@armResourceOperations
interface ProviderLevelOperations {
    @post
	@doc("ProviderLevel operation to check eligibility to create EnterpriseSupport instance")
    @segment("providers/Microsoft.EnterpriseSupport/ValidateEnterpriseSupport")
    validateEnterpriseSupport(...CustomParams, @body items: ValidateEnterpriseSupportRequestItem): ArmResponse<Array<ValidateEnterpriseSupportResponseItem>>;
}

