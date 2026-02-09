import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
/**
 * Certificate used for Custom Domain bindings of Container Apps in a Managed Environment
 */
@parentResource(ConnectedEnvironment)
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
  }
>;

@armResourceOperations
@tag("Certificates")
interface Certificates {
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
  createOrUpdate is CertificateOps.CreateOrUpdateAsync<Certificate>;

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

  /**
   * Get the specified Certificate.
   */
  @tag("ManagedEnvironments")
  @summary("Get the specified Certificate.")
  getCertificates is CertificateOperationGroupOps.Read<Certificate>;

  /**
   * Create or Update a Certificate.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("ManagedEnvironments")
  @summary("Create or Update a Certificate.")
  createOrUpdateCertificates is CertificateOperationGroupOps.CreateOrUpdateSync<
    Certificate,
    Response = ArmResourceUpdatedResponse<Certificate>
  >;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  @tag("ManagedEnvironments")
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a certificate")
  updateCertificates is CertificateOperationGroupOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatch
  >;

  /**
   * Deletes the specified Certificate.
   */
  @tag("ManagedEnvironments")
  @summary("Deletes the specified Certificate.")
  deleteCertificates is CertificateOperationGroupOps.DeleteSync<Certificate>;

  /**
   * Get the Certificates in a given managed environment.
   */
  @tag("ManagedEnvironments")
  @summary("Get the Certificates in a given managed environment.")
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
  }
>;

@@doc(Certificate.name, "Name of the Certificate.");
@@doc(Certificate.properties, "Certificate resource specific properties");
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Certificate to be created or updated"
);
@@doc(Certificates.update::parameters.properties,
  "Properties of a certificate that need to be updated"
);
@@doc(Certificates.createOrUpdateCertificates::parameters.resource,
  "Certificate to be created or updated"
);
@@doc(Certificates.updateCertificates::parameters.properties,
  "Properties of a certificate that need to be updated"
);
