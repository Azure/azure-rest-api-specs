import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-autorest";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Autorest;

namespace Microsoft.App;
/**
 * Certificate used for Custom Domain bindings of Container Apps in a Managed Environment
 */
@parentResource(ManagedEnvironment)
model Certificate
  is Azure.ResourceManager.TrackedResource<CertificateProperties> {
  ...ResourceNameParameter<
    Resource = Certificate,
    KeyName = "certificateName",
    SegmentName = "certificates",
    NamePattern = ""
  >;
}

alias CertificateOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Connected Environment. */
    @path
    @segment("connectedEnvironments")
    @key
    connectedEnvironmentName: string;
  },
  {
    /** Name of the Certificate. */
    @path
    @segment("certificates")
    @key
    certificateName: string;
  },
  ErrorType = CommonTypes.ErrorResponse,
  ResourceName = "ContainerAppConnectedEnvironmentCertificate"
>;

@armResourceOperations
@tag("Certificates")
interface ConnectedEnvironmentCertificates {
  /**
   * Get the specified Certificate.
   */
  @tag("ConnectedEnvironments")
  @summary("Get the specified Certificate.")
  get is CertificateOps.Read<Certificate>;

  /**
   * Create or Update a Certificate.
   */
  @tag("ConnectedEnvironments")
  @summary("Create or Update a Certificate.")
  createOrUpdate is CertificateOps.CreateOrUpdateAsync<
    Certificate,
    OptionalRequestBody = true
  >;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  @tag("ConnectedEnvironments")
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a certificate")
  update is CertificateOps.CustomPatchAsync<
    Certificate,
    PatchModel = CertificatePatch
  >;

  /**
   * Deletes the specified Certificate.
   */
  @tag("ConnectedEnvironments")
  @summary("Deletes the specified Certificate.")
  delete is CertificateOps.DeleteWithoutOkAsync<Certificate>;

  /**
   * Get the Certificates in a given connected environment.
   */
  @tag("ConnectedEnvironments")
  @summary("Get the Certificates in a given connected environment.")
  list is CertificateOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>
  >;
}

@armResourceOperations
@tag("Certificates")
interface ManagedEnvironmentCertificates {
  /**
   * Get the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id during MPG migration."
  @tag("ManagedEnvironments")
  @summary("Get the specified Certificate.")
  @operationId("Certificates_Get")
  @Autorest.example("./examples/Certificate_Get.json", "Get Certificate")
  getCertificates is CertificateOperationGroupOps.Read<Certificate>;

  /**
   * Create or Update a Certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id during MPG migration."
  @tag("ManagedEnvironments")
  @summary("Create or Update a Certificate.")
  @operationId("Certificates_CreateOrUpdate")
  @Autorest.example(
    "./examples/Certificate_CreateOrUpdate.json",
    "Create or Update Certificate"
  )
  @Autorest.example(
    "./examples/Certificate_CreateOrUpdate_FromKeyVault.json",
    "Create or Update Certificate using Managed Identity"
  )
  createOrUpdateCertificates is CertificateOperationGroupOps.CreateOrUpdateSync<
    Certificate,
    Response = ArmResourceUpdatedResponse<Certificate>,
    OptionalRequestBody = true
  >;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id during MPG migration."
  @tag("ManagedEnvironments")
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a certificate")
  @operationId("Certificates_Update")
  @Autorest.example("./examples/Certificates_Patch.json", "Patch Certificate")
  updateCertificates is CertificateOperationGroupOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatch
  >;

  /**
   * Deletes the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id during MPG migration."
  @tag("ManagedEnvironments")
  @summary("Deletes the specified Certificate.")
  @operationId("Certificates_Delete")
  @Autorest.example("./examples/Certificate_Delete.json", "Delete Certificate")
  deleteCertificates is CertificateOperationGroupOps.DeleteSync<Certificate>;

  /**
   * Get the Certificates in a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "Preserve the existing OpenAPI operation id during MPG migration."
  @tag("ManagedEnvironments")
  @summary("Get the Certificates in a given managed environment.")
  @operationId("Certificates_List")
  @Autorest.example(
    "./examples/Certificates_ListByManagedEnvironment.json",
    "List Certificates by Managed Environment"
  )
  listCertificates is CertificateOperationGroupOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>
  >;
}

alias CertificateOperationGroupOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the Managed Environment. */
    @path
    @segment("managedEnvironments")
    @key
    environmentName: string;
  },
  {
    /** Name of the Certificate. */
    @path
    @segment("certificates")
    @key
    certificateName: string;
  },
  ErrorType = CommonTypes.ErrorResponse,
  ResourceName = "ContainerAppManagedEnvironmentCertificate"
>;

@@doc(Certificate.name, "Name of the Certificate.");
@@doc(Certificate.properties, "Certificate resource specific properties");
@@doc(
  ConnectedEnvironmentCertificates.createOrUpdate::parameters.resource,
  "Certificate to be created or updated"
);
@@doc(
  ConnectedEnvironmentCertificates.update::parameters.properties,
  "Properties of a certificate that need to be updated"
);
@@doc(
  ManagedEnvironmentCertificates.createOrUpdateCertificates::parameters.resource,
  "Certificate to be created or updated"
);
@@doc(
  ManagedEnvironmentCertificates.updateCertificates::parameters.properties,
  "Properties of a certificate that need to be updated"
);
