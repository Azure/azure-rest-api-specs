import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.Education;
/**
 * Grant details.
 */
@singleton("default")
model GrantDetails
  is Azure.ResourceManager.ProxyResource<GrantDetailProperties> {
  ...ResourceNameParameter<
    Resource = GrantDetails,
    KeyName = "grant",
    SegmentName = "grants",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing billing-profile and provider-scope grant paths for backward compatibility."
alias BillingProfileGrantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The billing provider namespace. */
    @path
    @segment("providers")
    @key
    billingProviderNamespace: "Microsoft.Billing";

    /** The name of the billing account. */
    @path
    @segment("billingAccounts")
    @key
    billingAccountName: string;

    /** The name of the billing profile. */
    @path
    @segment("billingProfiles")
    @key
    billingProfileName: string;

    ...Legacy.Provider;
  },
  {},
  {
    /** The grant name. */
    @path
    @segment("grants")
    @key("grant")
    grant: "default";
  }
>;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Preserve the existing provider-scope Grants_ListAll path for backward compatibility."
alias EducationGrantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...Legacy.Provider;
  },
  {},
  {
    /** The grant name. */
    @path
    @segment("grants")
    @key("grant")
    grant: "default";
  }
>;

@armResourceOperations
interface Grants {
  /**
   * Get details for a specific grant linked to the provided billing account and billing profile.
   */
  get is BillingProfileGrantOps.Read<
    GrantDetails,
    Parameters = {
      /**
       * May be used to include information about budget that has been allocated.
       */
      @query("includeAllocatedBudget")
      includeAllocatedBudget?: boolean;
    },
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Get details for a specific grant linked to the provided billing account and billing profile.
   */
  list is BillingProfileGrantOps.List<
    GrantDetails,
    Parameters = {
      /**
       * May be used to include information about budget that has been allocated.
       */
      @query("includeAllocatedBudget")
      includeAllocatedBudget?: boolean;
    },
    Response = ArmResponse<GrantListResponse>,
    ErrorType = DefaultErrorResponse
  >;

  /**
   * Get a list of grants that Microsoft has provided.
   */
  listAll is EducationGrantOps.List<
    GrantDetails,
    Parameters = {
      /**
       * May be used to include information about budget that has been allocated.
       */
      @query("includeAllocatedBudget")
      includeAllocatedBudget?: boolean;
    },
    Response = ArmResponse<GrantListResponse>,
    ErrorType = DefaultErrorResponse
  >;
}

@@doc(GrantDetails.name, "");
@@doc(GrantDetails.properties, "Grant detail properties.");
