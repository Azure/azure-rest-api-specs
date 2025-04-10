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
/**
 * The integration account certificate.
 */
@parentResource(IntegrationAccount)
model IntegrationAccountCertificate
  is Azure.ResourceManager.TrackedResource<
    IntegrationAccountCertificateProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = IntegrationAccountCertificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface IntegrationAccountCertificates {
  /**
   * Gets an integration account certificate.
   */
  get is ArmResourceRead<IntegrationAccountCertificate>;

  /**
   * Creates or updates an integration account certificate.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<IntegrationAccountCertificate>;

  /**
   * Deletes an integration account certificate.
   */
  delete is ArmResourceDeleteSync<IntegrationAccountCertificate>;

  /**
   * Gets a list of integration account certificates.
   */
  list is ArmResourceListByParent<
    IntegrationAccountCertificate,
    Parameters = {
      /**
       * The number of items to be included in the result.
       */
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
