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
@doc("Savings plan order alias")
@tenantResource
model SavingsPlanOrderAliasModel
  is ProxyResource<SavingsPlanOrderAliasProperties> {
  @doc("Name of the savings plan order alias")
  @pattern("^[a-zA-Z0-9_\\-\\.]+$")
  @path
  @key("savingsPlanOrderAliasName")
  @segment("savingsPlanOrderAliases")
  name: string;

  ...Azure.ResourceManager.ResourceSku;
  ...Azure.ResourceManager.ResourceKind;
}

@armResourceOperations
interface SavingsPlanOrderAliasModels {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a savings plan.")
  @operationId("SavingsPlanOrderAlias_Get")
  get is ArmResourceRead<SavingsPlanOrderAliasModel>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a savings plan. Learn more about permissions needed at https://go.microsoft.com/fwlink/?linkid=2215851")
  @operationId("SavingsPlanOrderAlias_Create")
  create is ArmResourceCreateOrUpdateAsync<
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
