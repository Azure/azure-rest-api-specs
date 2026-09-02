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

  /**
   * A list of Tag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  tags?: Record<string>;
}

alias CreditSummariesParentGroup = Extension.ExternalResource<
  "Microsoft.Billing",
  "billingAccounts",
  "billingAccountId",
  Description = "BillingAccount ID",
  ParentType = "Tenant"
>;

alias CreditSummariesGroup = Extension.ExternalChildResource<
  CreditSummariesParentGroup,
  "billingProfiles",
  "billingProfileId",
  Description = "Azure Billing Profile ID."
>;

@armResourceOperations
interface CreditSummaries {
  /**
   * The credit summary by billingAccountId and billingProfileId.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://docs.microsoft.com/en-us/rest/api/consumption/")
  get is Extension.Read<
    CreditSummariesGroup,
    CreditSummary,
    Response = ArmResponse<CreditSummary> | ArmNoContentResponse
  >;
}

@@doc(CreditSummary.name, "");
@@doc(CreditSummary.properties, "The properties of the credit summary.");
