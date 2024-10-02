import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace KeyVault;

interface HSMSecurityDomainOperations {
  /**
   * Retrieves the Security Domain download operation status
   */
  @route("/securitydomain/download/pending")
  @get
  downloadPending is Azure.Core.Foundations.Operation<
    {},
    SecurityDomainOperationStatus
  >;

  /**
   * Retrieves the Security Domain from the managed HSM. Calling this endpoint can
   * be used to activate a provisioned managed HSM resource.
   */
  @route("/securitydomain/download")
  @post
  download is Azure.Core.Foundations.Operation<
    CertificateInfoObject,
    SecurityDomainObject
  >;

  /**
   * Retrieve Security Domain transfer key
   */
  @route("/securitydomain/upload")
  @get
  transferKey is Azure.Core.Foundations.Operation<{}, TransferKey>;

  /**
   * Restore the provided Security Domain.
   */
  @route("/securitydomain/upload")
  @post
  upload is Azure.Core.Foundations.Operation<
    SecurityDomainObject,
    SecurityDomainOperationStatus | void
  >;

  /**
   * Get Security Domain upload operation status
   */
  @route("/securitydomain/upload/pending")
  @get
  uploadPending is Azure.Core.Foundations.Operation<
    {},
    SecurityDomainOperationStatus
  >;
}
