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
/**
 * The integration account certificate.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(IntegrationAccount)
@Azure.ResourceManager.Private.armResourceInternal(
  IntegrationAccountCertificateProperties
)
@includeInapplicableMetadataInPayload(false)
model IntegrationAccountCertificate extends Resource {
  /**
   * The integration account certificate name.
   */
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;

  /**
   * The integration account certificate properties.
   */
  @extension("x-ms-client-flatten", true)
  properties: IntegrationAccountCertificateProperties;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("IntegrationAccountCertificates_List")
  list is ArmResourceListByParent<
    IntegrationAccountCertificate,
    {
      ...BaseParameters<IntegrationAccountCertificate>;

      /**
       * The number of items to be included in the result.
       */
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
