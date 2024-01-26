import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.BillingBenefits;

/**
 * Validate savings plan purchase.
 */
@route("/providers/Microsoft.BillingBenefits/validate")
@post
op validatePurchase is Azure.Core.Foundations.Operation<
  SavingsPlanPurchaseValidateRequest,
  SavingsPlanValidateResponse
>;
