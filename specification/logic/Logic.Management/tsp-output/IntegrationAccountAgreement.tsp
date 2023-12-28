import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Logic;
@doc("The integration account agreement.")
@parentResource(IntegrationAccount)
model IntegrationAccountAgreement
  is TrackedResource<IntegrationAccountAgreementProperties> {
  @doc("The integration account agreement name.")
  @key("agreementName")
  @segment("agreements")
  name: string;
}

@armResourceOperations
interface IntegrationAccountAgreements {
  @doc("Gets an integration account agreement.")
  get is ArmResourceRead<IntegrationAccountAgreement>;
  @doc("Creates or updates an integration account agreement.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountAgreement>;
  @doc("Deletes an integration account agreement.")
  delete is ArmResourceDeleteSync<IntegrationAccountAgreement>;
  @doc("Gets a list of integration account agreements.")
  list is ArmResourceListByParent<
    IntegrationAccountAgreement,
    {
      ...BaseParameters<IntegrationAccountAgreement>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: AgreementType.")
      @query("$filter")
      $filter?: string;
    }
  >;
  @doc("Get the content callback url.")
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountAgreement,
    GetCallbackUrlParameters,
    WorkflowTriggerCallbackUrl
  >;
}
