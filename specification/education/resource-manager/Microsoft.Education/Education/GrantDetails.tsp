import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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

alias billingAccountExternalResource = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingAccounts",
  "{billingAccountName}"
>;

@armResourceOperations
interface Grants {
  /**
   * Get details for a specific grant linked to the provided billing account and billing profile.
   */
  get is ArmResourceRead<
    GrantDetails,
    Parameters = {
      /**
       * May be used to include information about budget that has been allocated.
       */
      @query("includeAllocatedBudget")
      includeAllocatedBudget?: boolean;
    }
  >;

  /**
   * Get details for a specific grant linked to the provided billing account and billing profile.
   */
  list is ArmResourceListByParent<
    GrantDetails,
    Parameters = {
      /**
       * May be used to include information about budget that has been allocated.
       */
      @query("includeAllocatedBudget")
      includeAllocatedBudget?: boolean;
    },
    Response = ArmResponse<GrantListResponse>
  >;
}

@@doc(GrantDetails.name, "");
@@doc(GrantDetails.properties, "Grant detail properties.");
