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
@tag("ConnectedEnvironments")
@tag("Certificates")
interface Certificates {
  /**
   * Get the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsCertificates_Get")
  @summary("Get the specified Certificate.")
  get is CertificateOps.Read<Certificate>;

  /**
   * Create or Update a Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsCertificates_CreateOrUpdate")
  @summary("Create or Update a Certificate.")
  createOrUpdate is CertificateOps.CreateOrUpdateAsync<Certificate>;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConnectedEnvironmentsCertificates_Update")
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a certificate")
  update is CertificateOps.CustomPatchAsync<
    Certificate,
    PatchModel = CertificatePatch
  >;

  /**
   * Deletes the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Deletes the specified Certificate.")
  @operationId("ConnectedEnvironmentsCertificates_Delete")
  delete is CertificateOps.DeleteWithoutOkAsync<Certificate>;

  /**
   * Get the Certificates in a given connected environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("Get the Certificates in a given connected environment.")
  @operationId("ConnectedEnvironmentsCertificates_List")
  list is CertificateOps.List<
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

@armResourceOperations
@tag("ManagedEnvironments")
@tag("Certificates")
interface CertificateOperationGroup {
  /**
   * Get the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Get")
  @summary("Get the specified Certificate.")
  get is CertificateOperationGroupOps.Read<Certificate>;

  /**
   * Create or Update a Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("Certificates_CreateOrUpdate")
  @summary("Create or Update a Certificate.")
  createOrUpdate is CertificateOperationGroupOps.CreateOrUpdateSync<
    Certificate,
    Response = ArmResourceUpdatedResponse<Certificate>
  >;

  /**
   * Patches a certificate. Currently only patching of tags is supported
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Update")
  @patch(#{ implicitOptionality: false })
  @summary("Update properties of a certificate")
  update is CertificateOperationGroupOps.CustomPatchSync<
    Certificate,
    PatchModel = CertificatePatch
  >;

  /**
   * Deletes the specified Certificate.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_Delete")
  @summary("Deletes the specified Certificate.")
  delete is CertificateOperationGroupOps.DeleteSync<Certificate>;

  /**
   * Get the Certificates in a given managed environment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Certificates_List")
  @summary("Get the Certificates in a given managed environment.")
  list is CertificateOperationGroupOps.List<
    Certificate,
    Response = ArmResponse<CertificateCollection>
  >;
}

@@doc(Certificate.name, "Name of the Certificate.");
@@doc(Certificate.properties, "Certificate resource specific properties");
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Certificate to be created or updated"
);
@@doc(Certificates.update::parameters.properties,
  "Properties of a certificate that need to be updated"
);
@@doc(CertificateOperationGroup.createOrUpdate::parameters.resource,
  "Certificate to be created or updated"
);
@@doc(CertificateOperationGroup.update::parameters.properties,
  "Properties of a certificate that need to be updated"
);
