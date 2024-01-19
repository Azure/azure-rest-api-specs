import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./IntegrationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Logic;
@doc("The integration account agreement.")
@parentResource(IntegrationAccount)
model IntegrationAccountAgreement
  is TrackedResource<IntegrationAccountAgreementProperties> {
  @doc("The integration account agreement name.")
  @path
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

@@projectedName(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "json",
  "agreement"
);
@@extension(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "agreement"
);
@@doc(IntegrationAccountAgreements.createOrUpdate::parameters.resource,
  "The integration account agreement."
);
@@projectedName(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body,
  "json",
  "listContentCallbackUrl"
);
@@extension(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body,
  "x-ms-client-name",
  "listContentCallbackUrl"
);
@@doc(IntegrationAccountAgreements.listContentCallbackUrl::parameters.body, "");
