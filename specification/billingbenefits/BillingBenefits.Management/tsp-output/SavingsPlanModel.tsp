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
/**
 * Savings plan
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SavingsPlanOrderModel)
@Azure.ResourceManager.Private.armResourceInternal(SavingsPlanModelProperties)
@includeInapplicableMetadataInPayload(false)
model SavingsPlanModel extends ProxyResourceBase {
  /**
   * ID of the savings plan
   */
  @path
  @key("savingsPlanId")
  @segment("savingsPlans")
  name: string;

  /**
   * Savings plan properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SavingsPlanModelProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SavingsPlanModels {
  /**
   * Get savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlan_Get")
  get is ArmResourceRead<
    SavingsPlanModel,
    {
      ...BaseParameters<SavingsPlanModel>;

      /**
       * May be used to expand the detail information of some properties.
       */
      @query("$expand")
      $expand?: string;
    }
  >;

  /**
   * Update savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("SavingsPlan_Update")
  update is ArmCustomPatchSync<SavingsPlanModel, SavingsPlanUpdateRequest>;

  /**
   * List savings plans in an order.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlan_List")
  list is ArmResourceListByParent<SavingsPlanModel>;

  /**
   * List savings plans.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlan_ListAll")
  listAll is ArmListBySubscription<SavingsPlanModel>;

  /**
   * Validate savings plan patch.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
