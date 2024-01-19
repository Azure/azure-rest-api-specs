import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SavingsPlanOrderModel.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
@doc("Savings plan")
@parentResource(SavingsPlanOrderModel)
model SavingsPlanModel is ProxyResource<SavingsPlanModelProperties> {
  @doc("ID of the savings plan")
  @path
  @key("savingsPlanId")
  @segment("savingsPlans")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SavingsPlanModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get savings plan.")
  @operationId("SavingsPlan_Get")
  get is ArmResourceRead<
    SavingsPlanModel,
    {
      ...BaseParameters<SavingsPlanModel>;

      @doc("May be used to expand the detail information of some properties.")
      @query("$expand")
      $expand?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update savings plan.")
  @operationId("SavingsPlan_Update")
  update is ArmCustomPatchSync<SavingsPlanModel, SavingsPlanUpdateRequest>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List savings plans in an order.")
  @operationId("SavingsPlan_List")
  list is ArmResourceListByParent<SavingsPlanModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List savings plans.")
  @operationId("SavingsPlan_ListAll")
  listAll is ArmListBySubscription<SavingsPlanModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Validate savings plan patch.")
  @operationId("SavingsPlan_ValidateUpdate")
  validateUpdate is ArmResourceActionSync<
    SavingsPlanModel,
    SavingsPlanUpdateValidateRequest,
    SavingsPlanValidateResponse
  >;
}

@@projectedName(SavingsPlanModels.update::parameters.properties,
  "json",
  "body"
);
@@extension(SavingsPlanModels.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(SavingsPlanModels.update::parameters.properties,
  "Request body for patching a savings plan order alias"
);
@@doc(SavingsPlanModels.validateUpdate::parameters.body,
  "Request body for validating a savings plan patch request"
);
