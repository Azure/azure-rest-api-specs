import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Certificate used for Custom Domain bindings of Container Apps in a Managed Environment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(ConnectedEnvironment)
@Azure.ResourceManager.Private.armResourceInternal(CertificateProperties)
@includeInapplicableMetadataInPayload(false)
model Certificate extends TrackedResourceBase {
  /**
   * Name of the Certificate.
   */
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;

  /**
   * Certificate resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: CertificateProperties;
}

@armResourceOperations
interface Certificates {
  /**
   * Get the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsCertificates_Get")
  get is ArmResourceRead<Certificate>;

  /**
   * Create or Update a Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsCertificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("ConnectedEnvironmentsCertificates_Update")
  update is ArmCustomPatchSync<Certificate, CertificatePatch>;

  /**
   * Deletes the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsCertificates_Delete")
  delete is ArmResourceDeleteSync<Certificate>;

  /**
   * Get the Certificates in a given connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConnectedEnvironmentsCertificates_List")
  list is ArmResourceListByParent<Certificate>;
}

@@projectedName(Certificates.createOrUpdate::parameters.resource,
  "json",
  "certificateEnvelope"
);
@@extension(Certificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateEnvelope"
);
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Certificate to be created or updated"
);
@@projectedName(Certificates.update::parameters.properties,
  "json",
  "certificateEnvelope"
);
@@extension(Certificates.update::parameters.properties,
  "x-ms-client-name",
  "certificateEnvelope"
);
@@doc(Certificates.update::parameters.properties,
  "Properties of a certificate that need to be updated"
);
