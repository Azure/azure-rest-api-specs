import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

/** Certificate Issusance request. */
model CertificateIssuanceRequest {
  /**
   * Base64-encoded DER certificate signing request (CSR) without PEM
   * headers and footers. Format of the CSR is in PKCS 10. The CN field
   * of the CSR must be set to the device registrationId.
   */
  csr?: bytes;
}

/**
 * The full chain of the issued certificate, including any intermediate
 * certification authorities (ICAs) and the root certification authority
 * (CA). The first certificate in the list is the issued leaf certificate.
 * Each subsequent certificate is the issuer of the previous.
 */
model IssuedCertificateChain is bytes[];

/** Certificate issuance result. */
model CertificateIssuanceResult {
  /** The full chain of the issued certificate. */
  @visibility(Lifecycle.Read)
  issuedCertificateChain?: IssuedCertificateChain;
}

/** Status monitor for the certificate issuance long-running operation. */
model CertificateIssuanceOperationStatus {
  /** The unique ID of the operation. */
  id: string;

  /** The status of the operation. */
  @Azure.Core.lroStatus
  status: Azure.Core.Foundations.OperationState;

  /** Error object that describes the error when status is "Failed". */
  error?: Azure.Core.Foundations.Error;

  /** The result of the operation. */
  result?: CertificateIssuanceResult;
}

// ──────────────────────────────────────────────
// RuntimeCertIssuance interface
// ──────────────────────────────────────────────

@tag("RuntimeCertIssuance")
interface RuntimeCertIssuance {
  /** Issue operational certificates for IoT devices. */
  @summary("Issue operational certificates for IoT devices.")
  @tag("POST")
  @route("/deviceCertificates/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/namespaces/{namespaceResourceName}/devices/{deviceResourceName}:issueCert")
  @post
  @pollingOperation(RuntimeCertIssuance.getOperationStatus)
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing service contract; preserves wire compatibility for already-deployed clients calling raw REST."
  issueCertificate(
    /** Azure subscription ID. */
    @path subscriptionId: string,

    /** Azure resource group name. */
    @path resourceGroupName: string,

    /** The resource provider name (e.g., microsoft.deviceregistry). */
    @path providerName: string,

    /** Azure Device Registry namespace ARM resource name. */
    @path namespaceResourceName: string,

    /** Azure Device Registry device ARM resource name. */
    @path deviceResourceName: string,

    /** Certificate issuance request. */
    @body certificateIssuance: CertificateIssuanceRequest,

    /** The API version to use for this operation. */
    @query("api-version")
    apiVersion: string,

    /**
     * The name of the Azure Device Registry policy name to use for
     * issuing the certificate. EX, contosoPolicy
     */
    @query("policy-name")
    policyName: string,

    /** The region of the Certificate Management Service. */
    @query
    region: string,
  ): {
    @statusCode statusCode: 202;

    /**
     * The location for monitoring the operation state. It contains the
     * absolute URL of the status monitor resource, including an api-version
     * query parameter. EX "/deviceCertificates/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/namespaces/{namespaceResourceName}/devices/{deviceResourceName}/issueCertOperations/{operationId}?policyName={policyName}&api-version=20250701-preview".
     */
    @header("Operation-Location")
    operationLocation: url;

    /**
     * The Retry-After header can indicate how long the client should wait
     * before polling the operation status.
     */
    @header("Retry-After")
    retryAfter?: int32;

    /** An opaque, globally-unique, client-generated string identifier for the request. */
    @header("x-ms-client-request-id")
    xMsClientRequestId?: Azure.Core.uuid;

    /** The request has been accepted for processing, but processing has not yet completed. */
    ...CertificateIssuanceOperationStatus;
  } | Azure.Core.Foundations.ErrorResponse;

  /** Gets the cert issuance operation status. */
  @summary("Gets the cert issuance operation status.")
  @tag("GET")
  @route("/deviceCertificates/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerName}/namespaces/{namespaceResourceName}/devices/{deviceResourceName}/issueCertOperations/{operationId}")
  @get
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing service contract; preserves wire compatibility for already-deployed clients calling raw REST."
  getOperationStatus(
    /** Azure subscription ID. */
    @path subscriptionId: string,

    /** Azure resource group name. */
    @path resourceGroupName: string,

    /** The resource provider name (e.g., microsoft.deviceregistry). */
    @path providerName: string,

    /** Azure Device Registry namespace ARM resource name. */
    @path namespaceResourceName: string,

    /** Azure Device Registry device ARM resource name. */
    @path deviceResourceName: string,

    /** Operation ID. */
    @path operationId: string,

    /** The API version to use for this operation. */
    @query("api-version")
    apiVersion: string,

    /**
     * The name of the Azure Device Registry policy name to use for
     * issuing the certificate. EX, contosoPolicy
     */
    @query("policy-name")
    policyName: string,

    /** The region of the Certificate Management Service. */
    @query
    region: string,
  ): {
    @statusCode statusCode: 200;

    /**
     * The Retry-After header can indicate how long the client should wait
     * before polling the operation status.
     */
    @header("Retry-After")
    retryAfter?: int32;

    /** An opaque, globally-unique, client-generated string identifier for the request. */
    @header("x-ms-client-request-id")
    xMsClientRequestId?: Azure.Core.uuid;

    /** The request has succeeded. */
    ...CertificateIssuanceOperationStatus;
  } | Azure.Core.Foundations.ErrorResponse;
}
