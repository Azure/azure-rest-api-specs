import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration account agreement.")
@parentResource(IntegrationAccount)
model IntegrationAccountAgreement
  is ProxyResource<
    IntegrationAccountAgreementProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IntegrationAccountAgreement,
    KeyName = "agreementName",
    SegmentName = "agreements",
    NamePattern = "[a-zA-Z0-9_.()-]{0,79}$"
  >;
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
    Parameters = {
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
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;
}

@@doc(IntegrationAccountAgreement.name,
  "The integration account agreement name."
);
@@doc(IntegrationAccountAgreement.properties,
  "The integration account agreement properties."
);
@@doc(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "The integration account agreement."
);
@@doc(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body, "");
