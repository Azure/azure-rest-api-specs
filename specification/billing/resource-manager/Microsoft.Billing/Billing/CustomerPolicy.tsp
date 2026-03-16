import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Customer.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
    NamePattern = "",
    Type = ServiceDefinedResourceName
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias CustomerPolicyOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;

    /** The ID that uniquely identifies a billing profile. */
    @path
    @segment("billingProfiles")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    billingProfileName: string;

    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    customerName: string;
  },
  {},
  {
    /** Service-defined resource names such as 'default' which are reserved resource names. */
    @path
    @segment("policies")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    policyName: ServiceDefinedResourceName;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface CustomerPolicies {
  /**
   * Lists the policies for a customer. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Policy")
  getByCustomer is CustomerPolicyOps.Read<CustomerPolicy>;
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
    @pattern("^([0-9]+|([Pp][Cc][Nn]\\.[A-Za-z0-9]+)|[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}(:[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}_[0-9]{4}(-[0-9]{2}){2})?)$")
    billingAccountName: string;

    /** The ID that uniquely identifies a customer. */
    @path
    @segment("customers")
    @key
    @pattern("^[a-zA-Z\\d-_]{1,128}$")
    customerName: string;
  },
  {},
  {
    /** undefined */
    @path
    @segment("policies")
    @key
    default: "default";
  }
>;

@armResourceOperations(#{ omitTags: true })
interface Policies {
  /**
   * Lists the policies for a customer at billing account scope. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Policy")
  getByCustomerAtBillingAccount is PolicyOps.Read<CustomerPolicy>;

  /**
   * Updates the policies for a customer at billing account scope. This operation is supported only for billing accounts with agreement type Microsoft Partner Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("Policy")
  createOrUpdateByCustomerAtBillingAccount is PolicyOps.CreateOrUpdateAsync<
    CustomerPolicy,
    LroHeaders = ArmLroLocationHeader<FinalResult = CustomerPolicy> &
      Azure.Core.Foundations.RetryAfterHeader
  >;
}

@@doc(CustomerPolicy.name,
  "Service-defined resource names such as 'default' which are reserved resource names."
);
@@doc(CustomerPolicy.properties, "A policy at customer scope.");
@@doc(Policies.createOrUpdateByCustomerAtBillingAccount::parameters.resource,
  "A policy at customer scope."
);
