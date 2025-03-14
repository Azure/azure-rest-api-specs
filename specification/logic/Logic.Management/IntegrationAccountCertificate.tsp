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
@doc("The integration account certificate.")
@parentResource(IntegrationAccount)
model IntegrationAccountCertificate
  is ProxyResource<
    IntegrationAccountCertificateProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IntegrationAccountCertificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = "[a-zA-Z0-9_.()-]{0,79}$"
  >;
}

@armResourceOperations
interface IntegrationAccountCertificates {
  @doc("Gets an integration account certificate.")
  get is ArmResourceRead<IntegrationAccountCertificate>;

  @doc("Creates or updates an integration account certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountCertificate>;

  @doc("Deletes an integration account certificate.")
  delete is ArmResourceDeleteSync<IntegrationAccountCertificate>;

  @doc("Gets a list of integration account certificates.")
  list is ArmResourceListByParent<
    IntegrationAccountCertificate,
    Parameters = {
      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@@doc(IntegrationAccountCertificate.name,
  "The integration account certificate name."
);
@@doc(IntegrationAccountCertificate.properties,
  "The integration account certificate properties."
);
@@doc(IntegrationAccountCertificates.createOrUpdate::parameters.resource,
  "The integration account certificate."
);
