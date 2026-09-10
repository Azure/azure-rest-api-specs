import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./models.tsp";
import "./Customer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Billing;
/**
 * A policy at customer scope.
 */
@tenantResource
@parentResource(Customer)
model CustomerPolicy
  is Azure.ResourceManager.ProxyResource<CustomerPolicyProperties> {
  ...ResourceNameParameter<
    Resource = CustomerPolicy,
    KeyName = "policyName",
    SegmentName = "policies",
    NamePattern = BillingProfileCustomerInvoiceSectionNamePattern,
    Type = ServiceDefinedResourceName
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias CustomerOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    billingProfileName: string;
  },
  {},
  {
    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    customerName: string;
  },
  "BillingProfileCustomer"
>;

@armResourceOperations(#{ omitTags: true })
interface CustomerPolicies {
  /**
   * Lists the policies for a customer. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Policy")
  getByCustomer is ArmResourceRead<
    CustomerPolicy,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Updates the policies for a customer. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "CustomerPolicy is the same response."
  @tag("Policy")
  @put
  @action("policies/default")
  createOrUpdateByCustomer is CustomerOps.ActionAsync<
    Customer,
    CustomerPolicy,
    CustomerPolicy,
    Response =
      | ArmResourceCreatedResponse<
          CustomerPolicy,
          ArmLroLocationHeader<FinalResult = CustomerPolicy> &
            Azure.Core.Foundations.RetryAfterHeader
        >
      | ArmResponse<CustomerPolicy>
  >;
}

alias PolicyOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;

    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern(BillingProfileCustomerInvoiceSectionNamePattern)
    customerName: string;
  },
  {},
  {
    /** undefined */
    @path
    @segment("policies")
    @key
    default: "default";
  },
  "BillingCustomerPolicy"
>;

@armResourceOperations(#{ omitTags: true })
interface Policies {
  /**
   * Lists the policies for a customer at billing account scope. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Policy")
  getByCustomerAtBillingAccount is PolicyOps.Read<CustomerPolicy>;

  /**
   * Updates the policies for a customer at billing account scope. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  @tag("Policy")
  createOrUpdateByCustomerAtBillingAccount is PolicyOps.CreateOrUpdateAsync<
    CustomerPolicy,
    LroHeaders = ArmLroLocationHeader<FinalResult = CustomerPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(
  CustomerPolicy.name,
  "Service-defined resource names such as 'default' which are reserved resource names."
);
@@doc(CustomerPolicy.properties, "A policy at customer scope.");
@@doc(
  Policies.createOrUpdateByCustomerAtBillingAccount::parameters.resource,
  "A policy at customer scope."
);
@@doc(
  CustomerPolicies.createOrUpdateByCustomer::parameters.body,
  "A policy at customer scope."
);
