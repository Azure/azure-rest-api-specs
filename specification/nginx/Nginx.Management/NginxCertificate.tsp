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

@parentResource(NginxDeployment)
model NginxCertificate
  is Azure.ResourceManager.ProxyResource<NginxCertificateProperties> {
  ...ResourceNameParameter<
    Resource = NginxCertificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = ""
  >;
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface NginxCertificatesOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /**
         * The name of targeted NGINX deployment
         */
        @path
        @segment("nginxDeployments")
        @pattern("^([a-z0-9A-Z][a-z0-9A-Z-]{0,28}[a-z0-9A-Z]|[a-z0-9A-Z])$")
        deploymentName: string,
      },
      {
        /**
         * The name of certificate
         */
        @path
        @segment("certificates")
        certificateName: string,
      },
      ErrorResponse
    > {}

@armResourceOperations
interface NginxCertificates {
  /**
   * Get a certificate of given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificates_Get")
  get is ArmResourceRead<NginxCertificate>;

  /**
   * Create or update the NGINX certificates for given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificates_CreateOrUpdate")
  createOrUpdate is NginxCertificatesOps.CreateOrUpdateAsync<
    NginxCertificate,
    OptionalRequestBody = true
  >;

  /**
   * Deletes a certificate from the NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificates_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NginxCertificate,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all certificates of given NGINX deployment
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificates_List")
  list is ArmResourceListByParent<
    NginxCertificate,
    Response = ArmResponse<NginxCertificateListResponse>
  >;
}

@@doc(NginxCertificate.name, "The name of certificate");
@@doc(NginxCertificate.properties, "");
@@doc(NginxCertificates.createOrUpdate::parameters.resource, "The certificate");
