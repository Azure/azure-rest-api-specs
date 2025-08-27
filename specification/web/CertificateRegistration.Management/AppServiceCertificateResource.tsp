import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AppServiceCertificateOrder.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Key Vault container ARM resource for a certificate that is purchased through Azure.
 */
@parentResource(AppServiceCertificateOrder)
model AppServiceCertificateResource
  is Azure.ResourceManager.TrackedResource<AppServiceCertificate> {
  ...ResourceNameParameter<
    Resource = AppServiceCertificateResource,
    KeyName = "name",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AppServiceCertificateResources {}

@@doc(AppServiceCertificateResource.name, "Name of the certificate.");
@@doc(AppServiceCertificateResource.properties, "Core resource properties");
