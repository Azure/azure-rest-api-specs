import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the certificate.
 */
@parentResource(AutomationAccount)
model Certificate
  is Azure.ResourceManager.ProxyResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = Certificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Certificates {
  /**
   * Retrieve the certificate identified by certificate name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificate_Get")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/certificateoperations")
  get is ArmResourceRead<Certificate>;

  /**
   * Create a certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificate_CreateOrUpdate")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/certificateoperations")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    Certificate,
    Request = CertificateCreateOrUpdateParameters
  >;

  /**
   * Update a certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificate_Update")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/certificateoperations")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Certificate,
    PatchModel = CertificateUpdateParameters
  >;

  /**
   * Delete the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificate_Delete")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/certificateoperations")
  delete is ArmResourceDeleteSync<Certificate, Response = ArmDeletedResponse>;

  /**
   * Retrieve a list of certificates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("Certificate_ListByAutomationAccount")
  @OpenAPI.externalDocs("http://aka.ms/azureautomationsdk/certificateoperations")
  listByAutomationAccount is ArmResourceListByParent<Certificate>;
}

@@doc(Certificate.name, "The name of certificate.");
@@doc(Certificate.properties,
  "Gets or sets the properties of the certificate."
);
@@doc(Certificates.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update certificate operation."
);
@@doc(Certificates.update::parameters.properties,
  "The parameters supplied to the update certificate operation."
);
