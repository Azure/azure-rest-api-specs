import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Azure.ResourceManager.BillingBenefits;

@doc("Validate savings plan purchase.")
@route("/providers/Microsoft.BillingBenefits/validate")
@post
op ValidatePurchase is Azure.Core.Foundations.Operation<
  SavingsPlanPurchaseValidateRequest,
  SavingsPlanValidateResponse
>;
