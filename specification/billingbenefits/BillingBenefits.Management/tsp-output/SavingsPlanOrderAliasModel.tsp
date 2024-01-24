import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BillingBenefits;
/**
 * Savings plan order alias
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(
  SavingsPlanOrderAliasProperties
)
@includeInapplicableMetadataInPayload(false)
model SavingsPlanOrderAliasModel extends ProxyResourceBase {
  /**
   * Name of the savings plan order alias
   */
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("savingsPlanOrderAliasName")
  @segment("savingsPlanOrderAliases")
  name: string;

  /**
   * Resource provider kind
   */
  kind?: string;

  /**
   * Savings plan order alias properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: SavingsPlanOrderAliasProperties;

  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SavingsPlanOrderAliasModels {
  /**
   * Get a savings plan.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlanOrderAlias_Get")
  get is ArmResourceRead<SavingsPlanOrderAliasModel>;

  /**
   * Create a savings plan. Learn more about permissions needed at https://go.microsoft.com/fwlink/?linkid=2215851
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SavingsPlanOrderAlias_Create")
  create is ArmResourceCreateOrReplaceAsync<
    SavingsPlanOrderAliasModel,
    BaseParameters<SavingsPlanOrderAliasModel>,
    ArmAsyncOperationHeader
  >;
}

@@projectedName(SavingsPlanOrderAliasModels.create::parameters.resource,
  "json",
  "body"
);
@@extension(SavingsPlanOrderAliasModels.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(SavingsPlanOrderAliasModels.create::parameters.resource,
  "Request body for creating a savings plan order alias"
);
