import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Savings plan order alias
 */
@tenantResource
model SavingsPlanOrderAliasModel
  is Azure.ResourceManager.ProxyResource<SavingsPlanOrderAliasProperties> {
  ...ResourceNameParameter<
    Resource = SavingsPlanOrderAliasModel,
    KeyName = "savingsPlanOrderAliasName",
    SegmentName = "savingsPlanOrderAliases",
    NamePattern = "^[a-zA-Z0-9_\\-\\.]+$"
  >;

  /**
   * Savings plan SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: ResourceSku;

  /**
   * Resource provider kind
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation"
@armResourceOperations
interface SavingsPlanOrderAliasModels {
  /**
   * Get a savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SavingsPlanOrderAlias_Get")
  get is ArmResourceRead<
    SavingsPlanOrderAliasModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create a savings plan. Learn more about permissions needed at https://go.microsoft.com/fwlink/?linkid=2215851
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SavingsPlanOrderAlias_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SavingsPlanOrderAliasModel,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(SavingsPlanOrderAliasModel.name, "Name of the savings plan order alias");
@@doc(SavingsPlanOrderAliasModel.properties,
  "Savings plan order alias properties"
);
@@doc(SavingsPlanOrderAliasModels.create::parameters.resource,
  "Request body for creating a savings plan order alias"
);
