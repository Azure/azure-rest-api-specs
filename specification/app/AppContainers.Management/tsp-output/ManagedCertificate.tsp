import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Managed certificates used for Custom Domain bindings of Container Apps in a Managed Environment
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(ManagedCertificateProperties)
model ManagedCertificate extends TrackedResourceBase {
  /**
   * Name of the Managed Certificate.
   */
  @path
  @key("managedCertificateName")
  @segment("managedCertificates")
  @visibility("read")
  name: string;

  /**
   * Certificate resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: ManagedCertificateProperties;
}

@armResourceOperations
interface ManagedCertificates {
  /**
   * Get the specified Managed Certificate.
   */
  get is ArmResourceRead<ManagedCertificate>;

  /**
   * Create or Update a Managed Certificate.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ManagedCertificate,
    BaseParameters<ManagedCertificate>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patches a managed certificate. Oly patching of tags is supported
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<ManagedCertificate, ManagedCertificatePatch>;

  /**
   * Deletes the specified Managed Certificate.
   */
  delete is ArmResourceDeleteSync<ManagedCertificate>;

  /**
   * Get the Managed Certificates in a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedCertificates_List")
  list is ArmResourceListByParent<ManagedCertificate>;
}

@@projectedName(ManagedCertificates.createOrUpdate::parameters.resource,
  "json",
  "managedCertificateEnvelope"
);
@@extension(ManagedCertificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedCertificateEnvelope"
);
@@doc(ManagedCertificates.createOrUpdate::parameters.resource,
  "Managed Certificate to be created or updated"
);
@@projectedName(ManagedCertificates.update::parameters.properties,
  "json",
  "managedCertificateEnvelope"
);
@@extension(ManagedCertificates.update::parameters.properties,
  "x-ms-client-name",
  "managedCertificateEnvelope"
);
@@doc(ManagedCertificates.update::parameters.properties,
  "Properties of a managed certificate that need to be updated"
);
