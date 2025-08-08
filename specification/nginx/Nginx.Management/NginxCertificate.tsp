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
@parentResource(NginxDeployment)
model NginxCertificate
  is Azure.ResourceManager.ProxyResource<NginxCertificateProperties> {
  ...ResourceNameParameter<
    Resource = NginxCertificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = "^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$"
  >;
}

@armResourceOperations
interface NginxCertificates {
  /**
   * Get a certificate of given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Get")
  get is ArmResourceRead<NginxCertificate>;

  /**
   * Create or update the NGINX certificates for given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<NginxCertificate>;

  /**
   * Deletes a certificate from the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<NginxCertificate>;

  /**
   * List all certificates of given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_List")
  list is ArmResourceListByParent<
    NginxCertificate,
    Response = ArmResponse<NginxCertificateListResponse>
  >;
}

@@doc(NginxCertificate.name, "The name of certificate");
@@doc(NginxCertificate.properties, "Nginx Certificate Properties");
@@doc(NginxCertificates.createOrUpdate::parameters.resource, "The certificate");
