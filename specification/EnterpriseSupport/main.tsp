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
})
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Microsoft.EnterpriseSupport;

interface Operations extends Azure.ResourceManager.Operations {}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("A ESRPProviderHub resource")
model UnifiedEnterpriseSupport is TrackedResource<UnifiedEnterpriseSupportResponseProperties> {
	@doc("The name of the Unified Enterprise Support")
	@pattern("^[a-zA-Z0-9-]{3,24}$")
	@key("unifiedEnterpriseSupportName")
	@segment("unifiedEnterpriseSupport")
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
}

@doc("Details of the ESRP UnifiedEnterpriseSupport.")
model UnifiedEnterpriseSupportResponseProperties {
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

	@doc("Service start date for Unified Enterprise Support")
	serviceStartDate: utcDateTime;

	@doc("CSAM for the Unified Enterprise Support")
	csam: string;
}


@armResourceOperations
interface UnifiedEnterpriseSupports extends TrackedResourceOperations<UnifiedEnterpriseSupport, UnifiedEnterpriseSupportResponseProperties> { 
	get is ArmResourceRead<UnifiedEnterpriseSupport>;
	createOrUpdate is ArmResourceCreateOrUpdateAsync<UnifiedEnterpriseSupport>;
	delete is ArmResourceDeleteAsync<UnifiedEnterpriseSupport>;
	listByParent is ArmResourceListByParent<UnifiedEnterpriseSupport>;
}