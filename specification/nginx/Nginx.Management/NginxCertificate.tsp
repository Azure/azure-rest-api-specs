import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NginxDeployment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Nginx.NginxPlus;
/**
 * Nginx Certificate
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(NginxDeployment)
model NginxCertificate
  is Azure.ResourceManager.ProxyResource<NginxCertificateProperties> {
  ...ResourceNameParameter<
    Resource = NginxCertificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = "^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$"
  >;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;
}

@armResourceOperations
interface NginxCertificates {
  /**
   * Get a certificate of given NGINX deployment
   */
  get is ArmResourceRead<NginxCertificate>;

  /**
   * Create or update the NGINX certificates for given NGINX deployment
   */
  createOrUpdate is Azure.ResourceManager.Legacy.Extension.CreateOrUpdateAsync<
    Extension.ResourceGroup,
    NginxCertificate,
    OptionalRequestBody = true
  >;

  /**
   * Deletes a certificate from the NGINX deployment
   */
  delete is ArmResourceDeleteWithoutOkAsync<NginxCertificate>;

  /**
   * List all certificates of given NGINX deployment
   */
  list is ArmResourceListByParent<
    NginxCertificate,
    Response = ArmResponse<NginxCertificateListResponse>
  >;
}

@@doc(NginxCertificate.name, "The name of certificate");
@@doc(NginxCertificate.properties, "Nginx Certificate Properties");
@@doc(NginxCertificates.createOrUpdate::parameters.resource, "The certificate");
