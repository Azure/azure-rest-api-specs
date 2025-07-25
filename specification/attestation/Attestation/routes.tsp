import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace AttestationClient;

interface PolicyOperationGroup {
  /**
   * Retrieves the current policy for an attestation type.
   */
  @summary("Retrieves the current policy for an attestation type.")
  @operationId("Policy_Get")
  @route("/policies/{attestationType}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies the trusted execution environment to be used to validate the evidence
       */
      @path
      attestationType: AttestationType;
    },
    PolicyResponse
  >;

  /**
   * Sets the policy for a given attestation type.
   */
  @summary("Sets the policy for a given attestation type.")
  @operationId("Policy_Set")
  @route("/policies/{attestationType}")
  @put
  set is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies the trusted execution environment to be used to validate the evidence
       */
      @path
      attestationType: AttestationType;

      /**
       * JWT Expressing the new policy whose body is a StoredAttestationPolicy object.
       */
      @bodyRoot
      newAttestationPolicy: string;
    },
    PolicyResponse
  >;

  /**
   * Resets the attestation policy for the specified tenant and reverts to the
   * default policy.
   */
  @summary("""
    Resets the attestation policy for the specified tenant and reverts to the
    default policy.
    """)
  @operationId("Policy_Reset")
  @route("/policies/{attestationType}:reset")
  @post
  reset is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies the trusted execution environment to be used to validate the evidence
       */
      @path
      attestationType: AttestationType;

      /**
       * JSON Web Signature with an empty policy document
       */
      @bodyRoot
      PolicyJws: string;
    },
    PolicyResponse
  >;
}

interface PolicyCertificatesOperationGroup {
  /**
   * Retrieves the set of certificates used to express policy for the current tenant.
   */
  @summary("Retrieves the set of certificates used to express policy for the current tenant.")
  @operationId("PolicyCertificates_Get")
  @route("/certificates")
  @get
  get is Azure.Core.Foundations.Operation<{}, PolicyCertificatesResponse>;

  /**
   * Adds a new attestation policy certificate to the set of policy management
   * certificates.
   */
  @summary("""
    Adds a new attestation policy certificate to the set of policy management
    certificates.
    """)
  @operationId("PolicyCertificates_Add")
  @route("/certificates:add")
  @post
  add is Azure.Core.Foundations.Operation<
    string,
    PolicyCertificatesModifyResponse
  >;

  /**
   * Removes the specified policy management certificate. Note that the final policy
   * management certificate cannot be removed.
   */
  @summary("""
    Removes the specified policy management certificate. Note that the final policy
    management certificate cannot be removed.
    """)
  @operationId("PolicyCertificates_Remove")
  @route("/certificates:remove")
  @post
  remove is Azure.Core.Foundations.Operation<
    string,
    PolicyCertificatesModifyResponse
  >;
}

interface AttestationOperationGroup {
  /**
   * Processes an OpenEnclave report , producing an artifact. The type of artifact
   * produced is dependent upon attestation policy.
   */
  @summary("Attest to an SGX enclave.")
  @operationId("Attestation_AttestOpenEnclave")
  @route("/attest/OpenEnclave")
  @post
  attestOpenEnclave is Azure.Core.Foundations.Operation<
    AttestOpenEnclaveRequest,
    AttestationResponse
  >;

  /**
   * Processes an SGX enclave quote, producing an artifact. The type of artifact
   * produced is dependent upon attestation policy.
   */
  @summary("Attest to an SGX enclave.")
  @operationId("Attestation_AttestSgxEnclave")
  @route("/attest/SgxEnclave")
  @post
  attestSgxEnclave is Azure.Core.Foundations.Operation<
    AttestSgxEnclaveRequest,
    AttestationResponse
  >;

  /**
   * Processes an Azure Guest TCG Log, producing an artifact. The type of artifact
   * produced is dependent upon attestation policy.
   */
  @summary("Attest to an Azure Guest VM.")
  @operationId("Attestation_AttestAzureGuest")
  @route("/attest/AzureGuest")
  @post
  attestAzureGuest is Azure.Core.Foundations.Operation<
    AttestAzureGuestRequest,
    SealedAttestationResponse
  >;

  /**
   * Processes attestation evidence from a VBS enclave, producing an attestation
   * result. The attestation result produced is dependent upon the attestation
   * policy.
   */
  @summary("Attest a Virtualization-based Security (VBS) enclave.")
  @operationId("Attestation_AttestTpm")
  @route("/attest/Tpm")
  @post
  attestTpm is Azure.Core.Foundations.Operation<
    TpmAttestationRequest,
    TpmAttestationResponse
  >;

  /**
   * Processes a SEV SNP Boot chain. The type of artifact produced is dependent upon
   * attestation policy.
   */
  @summary("Attest to an SEV SNP Virtual Machine.")
  @operationId("Attestation_AttestSevSnpVm")
  @route("/attest/SevSnpVm")
  @post
  attestSevSnpVm is Azure.Core.Foundations.Operation<
    AttestSevSnpVmRequest,
    AttestationResponse
  >;

  /**
   * Processes an TDX quote, producing an artifact. The type of artifact produced is
   * dependent upon attestation policy.
   */
  @summary("Attest to a TDX Virtual Machine.")
  @operationId("Attestation_AttestTdxVm")
  @route("/attest/TdxVm")
  @post
  attestTdxVm is Azure.Core.Foundations.Operation<
    AttestTdxVmRequest,
    AttestationResponse
  >;
}

interface TcbBaselinesOperationGroup {
  /**
   * Retrieves a list of all Azure supported baseline details for the a TEE type
   * along with an indication of which one is in enforced for the attestation
   * provider.
   */
  @summary("""
    Retrieves a list of all Azure supported baseline details for the a TEE type
    along with an indication of which one is in enforced for the attestation
    provider.
    """)
  @operationId("TcbBaselines_Get")
  @route("/tcbbaselines/{attestationType}")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Specifies the trusted execution environment to be used to validate the evidence
       */
      @path
      attestationType: AttestationType;
    },
    TcbBaselineResult
  >;
}

interface SigningCertificatesOperationGroup {
  /**
   * Retrieves metadata signing certificates in use by the attestation service
   */
  @summary("Retrieves the attestation signing keys in use by the attestation service")
  @operationId("SigningCertificates_Get")
  @route("/certs")
  @get
  get is Azure.Core.Foundations.Operation<
    {},
    JsonWebKeySet & {
      @header
      contentType: "application/jwk+json" | "application/json";
    }
  >;
}

interface MetadataConfigurationOperationGroup {
  /**
   * Retrieves metadata about the attestation signing keys in use by the attestation
   * service
   */
  @summary("Retrieves the OpenID Configuration data for the Azure Attestation Service")
  @operationId("MetadataConfiguration_Get")
  @route("/.well-known/openid-configuration")
  @get
  get is Azure.Core.Foundations.Operation<{}, OpenIDConfigurationResponse>;
}
