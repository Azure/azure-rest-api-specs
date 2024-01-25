import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
/**
 * Definition of the certificate.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(AutomationAccount)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(CertificateProperties)
model Certificate extends ProxyResourceBase {
  /**
   * The name of certificate.
   */
  @path
  @key("certificateName")
  @segment("certificates")
  @visibility("read")
  name: string;

  /**
   * Gets or sets the properties of the certificate.
   */
  @extension("x-ms-client-flatten", true)
  properties?: CertificateProperties;
}

@armResourceOperations
interface Certificates {
  /**
   * Retrieve the certificate identified by certificate name.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_Get")
  get is ArmResourceRead<Certificate>;

  /**
   * Create a certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;

  /**
   * Update a certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Certificate_Update")
  update is ArmCustomPatchSync<Certificate, CertificateUpdateParameters>;

  /**
   * Delete the certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_Delete")
  delete is ArmResourceDeleteSync<Certificate>;

  /**
   * Retrieve a list of certificates.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Certificate_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Certificate>;
}

@@projectedName(Certificates.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Certificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Certificates.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update certificate operation."
);
@@projectedName(Certificates.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Certificates.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Certificates.update::parameters.properties,
  "The parameters supplied to the update certificate operation."
);
