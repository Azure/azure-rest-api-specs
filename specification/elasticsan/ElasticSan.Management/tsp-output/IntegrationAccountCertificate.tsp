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
@doc("The integration account certificate.")
@parentResource(IntegrationAccount)
model IntegrationAccountCertificate
  is TrackedResource<IntegrationAccountCertificateProperties> {
  @doc("The integration account certificate name.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
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
    {
      ...BaseParameters<IntegrationAccountCertificate>;

      @doc("The number of items to be included in the result.")
      @query("$top")
      $top?: int32;
    }
  >;
}

@@projectedName(IntegrationAccountCertificates.createOrUpdate::parameters.resource,
  "json",
  "certificate"
);
@@extension(IntegrationAccountCertificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificate"
);
@@doc(IntegrationAccountCertificates.createOrUpdate::parameters.resource,
  "The integration account certificate."
);
