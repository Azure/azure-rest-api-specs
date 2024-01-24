import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Public certificate object
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@Azure.ResourceManager.Private.armResourceInternal(PublicCertificateProperties)
@includeInapplicableMetadataInPayload(false)
model PublicCertificate extends ProxyOnlyResource {
  /**
   * Public certificate name.
   */
  @path
  @key("publicCertificateName")
  @segment("publicCertificates")
  name: string;

  /**
   * PublicCertificate resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: PublicCertificateProperties;
}

@armResourceOperations
interface PublicCertificates {
  /**
   * Description for Get the named public certificate for an app (or deployment slot, if specified).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetPublicCertificate")
  getPublicCertificate is ArmResourceRead<PublicCertificate>;

  /**
   * Description for Creates a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_CreateOrUpdatePublicCertificate")
  createOrUpdatePublicCertificate is ArmResourceCreateOrReplaceSync<PublicCertificate>;

  /**
   * Description for Deletes a hostname binding for an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeletePublicCertificate")
  deletePublicCertificate is ArmResourceDeleteSync<PublicCertificate>;

  /**
   * Description for Get public certificates for an app or a deployment slot.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListPublicCertificates")
  listPublicCertificates is ArmResourceListByParent<PublicCertificate>;
}

@@projectedName(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "json",
  "publicCertificate"
);
@@extension(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "x-ms-client-name",
  "publicCertificate"
);
@@doc(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "Public certificate details. This is the JSON representation of a PublicCertificate object."
);
