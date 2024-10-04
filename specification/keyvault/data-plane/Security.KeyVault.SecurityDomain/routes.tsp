import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace KeyVault;

interface HsmSecurityDomain {
  /**
   * Retrieves the Security Domain download operation status
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  @pollingOperation(HsmSecurityDomain.downloadPending)
  @useFinalStateVia("azure-async-operation")
  @route("/securitydomain/download")
  @post
  download is Azure.Core.Foundations.Operation<
    {
      /**
       * The Security Domain download operation requires customer to provide N certificates (minimum 3 and maximum 10)
       * containing a public key in JWK format.
       */
      @body
      certificateInfoObject: CertificateInfoObject;
    },
    {
      @statusCode _: 202;

      /**
       * The URI to poll for completion status.
       */
      @pollingLocation
      @header("Azure-AsyncOperation")
      azureAsyncOperation?: string;

      /**
       * The recommended number of seconds to wait before calling the URI specified in
       * Azure-AsyncOperation.
       */
      @header("Retry-After") retryAfter?: int32;

      /**
       * The response contains the Security Domain that is being confirmed.
       */
      @body response: SecurityDomainObject;
    }
  >;

  /**
   * Retrieve Security Domain transfer key
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  @route("/securitydomain/upload")
  @get
  transferKey is Azure.Core.Foundations.Operation<{}, TransferKey>;

  /**
   * Restore the provided Security Domain.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  @pollingOperation(HsmSecurityDomain.uploadPending)
  @useFinalStateVia("azure-async-operation")
  @route("/securitydomain/upload")
  @post
  upload is Azure.Core.Foundations.Operation<
    {
      /**
       * The Security Domain to be restored.
       */
      @body
      securityDomain: SecurityDomainObject;
    },
    {
      /**
       * Restore of the Security Domain started.
       */
      @statusCode _: 202;

      /**
       * The URI to poll for completion status.
       */
      @pollingLocation
      @header("Azure-AsyncOperation")
      azureAsyncOperation?: string;

      /**
       * The recommended number of seconds to wait before calling the URI specified in
       * Azure-AsyncOperation.
       */
      @header("Retry-After") retryAfter?: int32;

      /**
       * The status of the Security Domain restore operation.
       */
      @body response: SecurityDomainOperationStatus;
    } | {
      /**
       * Final response.
       */
      @statusCode _: 204;
    }
  >;

  /**
   * Get Security Domain upload operation status
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  @route("/securitydomain/upload/pending")
  @get
  uploadPending is Azure.Core.Foundations.Operation<
    {},
    SecurityDomainOperationStatus
  >;
}
