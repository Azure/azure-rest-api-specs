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
@doc("The integration account partner.")
@parentResource(IntegrationAccount)
model IntegrationAccountPartner
  is Azure.ResourceManager.TrackedResource<
    IntegrationAccountPartnerProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IntegrationAccountPartner,
    KeyName = "partnerName",
    SegmentName = "partners",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IntegrationAccountPartners {
  @doc("Gets an integration account partner.")
  get is ArmResourceRead<IntegrationAccountPartner>;

  @doc("Creates or updates an integration account partner.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountPartner>;

  @doc("Deletes an integration account partner.")
  delete is ArmResourceDeleteSync<IntegrationAccountPartner>;

  @doc("Gets a list of integration account partners.")
  list is ArmResourceListByParent<
    IntegrationAccountPartner,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;

      @doc("The filter to apply on the operation. Options for filters include: PartnerType.")
      @query("$filter")
      $filter?: string;
    }
  >;

  @doc("Get the content callback url.")
  listContentCallbackUrl is ArmResourceActionSync<
    IntegrationAccountPartner,
    GetCallbackUrlParameters,
    ArmResponse<WorkflowTriggerCallbackUrl>
  >;
}

@@doc(IntegrationAccountPartner.name, "The integration account partner name.");
@@doc(IntegrationAccountPartner.properties,
  "The integration account partner properties."
);
@@doc(IntegrationAccountPartners.createOrUpdate::parameters.resource,
  "The integration account partner."
);
@@doc(IntegrationAccountPartners.listContentCallbackUrl::parameters.body, "");
