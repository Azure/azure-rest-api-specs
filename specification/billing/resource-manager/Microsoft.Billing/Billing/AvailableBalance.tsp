import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Billing;
/**
 * The Available Credit or Payment on Account Balance. The credit balance can be used to settle due or past due invoices.
 */
@singleton("default")
@tenantResource
@parentResource(BillingAccount)
model AvailableBalance
  is Azure.ResourceManager.ProxyResource<AvailableBalanceProperties> {
  ...ResourceNameParameter<
    Resource = AvailableBalance,
    KeyName = "availableBalance",
    SegmentName = "availableBalance",
    NamePattern = ""
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

alias AvailableBalanceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  },
  {},
  {
    /** undefined */
    @path
    @segment("availableBalance")
    @key
    default: "default";
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AvailableBalances {
  /**
   * The Available Credit or Payment on Account Balance for a billing account. The credit balance can be used to settle due or past due invoices and is supported for billing accounts with agreement type Microsoft Customer Agreement. The payment on account balance is supported for billing accounts with agreement type Microsoft Customer Agreement or Microsoft Online Services Program.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("AvailableBalance")
  getByBillingAccount is AvailableBalanceOps.Read<AvailableBalance>;
}
alias AvailableBalanceOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
  },
  {},
  {
    /** undefined */
    @path
    @segment("availableBalance")
    @key
    default: "default";
  }
>;

@armResourceOperations(#{ omitTags: true })
interface AvailableBalanceOperationGroup {
  /**
   * The Available Credit or Payment on Account Balance for a billing profile. The credit balance can be used to settle due or past due invoices and is supported for billing accounts with agreement type Microsoft Customer Agreement. The payment on account balance is supported for billing accounts with agreement type Microsoft Customer Agreement.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/billing/")
  @tag("AvailableBalance")
  getByBillingProfile is AvailableBalanceOperationGroupOps.Read<AvailableBalance>;
}

@@doc(AvailableBalance.name, "");
@@doc(AvailableBalance.properties,
  "The Available Credit or Payment on Account Balance. The credit balance can be used to settle due or past due invoices."
);
