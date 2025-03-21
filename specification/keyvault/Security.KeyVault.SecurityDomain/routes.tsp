import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Security.KeyVault.Common/common.tsp";

using Azure.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace KeyVault;

interface HsmSecurityDomain {
  /**
   * Retrieves the Security Domain download operation status
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "@operationId necessary to preserve original operationId"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @OpenAPI.operationId("HSMSecurityDomain_DownloadPending")
  @route("/securitydomain/download/pending")
  @get
  downloadPending is KeyVaultOperation<{}, SecurityDomainOperationStatus>;

  /**
   * Retrieves the Security Domain from the managed HSM. Calling this endpoint can be used to activate a provisioned managed HSM resource.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "@operationId necessary to preserve original operationId"
  @OpenAPI.operationId("HSMSecurityDomain_Download")
  @pollingOperation(HsmSecurityDomain.downloadPending)
  @useFinalStateVia("azure-async-operation")
  @route("/securitydomain/download")
  @post
  download is KeyVaultOperation<
    {
      /**
       * The Security Domain download operation requires customer to provide N certificates (minimum 3 and maximum 10) containing a public key in JWK format.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
      @body
      CertificateInfoObject: CertificateInfoObject;
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
       * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "@operationId necessary to preserve original operationId"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @OpenAPI.operationId("HSMSecurityDomain_TransferKey")
  @route("/securitydomain/upload")
  @get
  transferKey is KeyVaultOperation<{}, TransferKey>;

  /**
   * Restore the provided Security Domain.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "@operationId necessary to preserve original operationId"
  @OpenAPI.operationId("HSMSecurityDomain_Upload")
  @pollingOperation(HsmSecurityDomain.uploadPending)
  @finalOperation(HsmSecurityDomain.uploadPending)
  @useFinalStateVia("azure-async-operation")
  @route("/securitydomain/upload")
  @post
  upload is KeyVaultOperation<
    {
      /**
       * The Security Domain to be restored.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserving original casing"
      @body
      security_domain: SecurityDomainObject;
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
       * The recommended number of seconds to wait before calling the URI specified in Azure-AsyncOperation.
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "@operationId necessary to preserve original operationId"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Operation name is already established"
  @OpenAPI.operationId("HSMSecurityDomain_UploadPending")
  @route("/securitydomain/upload/pending")
  @get
  uploadPending is KeyVaultOperation<{}, SecurityDomainOperationStatus>;
}
