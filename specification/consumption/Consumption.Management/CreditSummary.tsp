import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Consumption;
/**
 * A credit summary resource.
 */
@singleton("balanceSummary")
model CreditSummary
  is Azure.ResourceManager.ProxyResource<CreditSummaryProperties> {
  ...ResourceNameParameter<
    Resource = CreditSummary,
    KeyName = "credit",
    SegmentName = "credits",
    NamePattern = ""
  >;
}

alias billingAccountExternalResource = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingAccounts",
  "{billingAccountId}"
>;

@armResourceOperations
interface CreditSummaries {
  /**
   * The credit summary by billingAccountId and billingProfileId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @operationId("Credits_Get")
  get is ArmResourceRead<
    CreditSummary,
    Parameters = {
      /**
       * BillingAccount ID
       */
      @path
      @segment("billingAccounts")
      billingAccountId: string;

      /**
       * Billing Profile ID.
       */
      @path
      @segment("billingProfiles")
      billingProfileId: string;
    },
    Error = ErrorResponse,
    Response = ArmResponse<CreditSummary> | ArmNoContentResponse
  >;
}

@@doc(CreditSummary.name, "");
@@doc(CreditSummary.properties, "The properties of the credit summary.");
