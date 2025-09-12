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

  /**
   * eTag of the resource. To handle concurrent update scenario, this field will be used to determine whether the user is updating the latest version or not.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

alias CreditSummariesOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    providerNamespace: "Microsoft.Billing";

    /**
     * BillingAccount ID
     */
    @segment("billingAccounts")
    @path
    billingAccountId: string;

    /**
     * Azure Billing Profile ID.
     */
    @segment("billingProfiles")
    @path
    billingProfileId: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<CreditSummary>;
  },
  {
    ...Extension.ExtensionProviderNamespace<CreditSummary>;
  }
>;

@armResourceOperations
interface CreditSummaries {
  /**
   * The credit summary by billingAccountId and billingProfileId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  @action("credits/balanceSummary")
  get is CreditSummariesOps.Read<
    CreditSummary,
    ErrorType = ErrorResponse,
    Response = ArmResponse<CreditSummary> | ArmNoContentResponse
  >;
}

@@doc(CreditSummary.name, "");
@@doc(CreditSummary.properties, "The properties of the credit summary.");
