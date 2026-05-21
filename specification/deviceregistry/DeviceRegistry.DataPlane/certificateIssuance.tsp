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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing service contract; preserves wire compatibility for already-deployed clients calling raw REST."
  @summary("Issue operational certificates for IoT devices.")
  @tag("POST")
  @route("/namespaces/{namespaceUuid}/devices/{deviceName}/authenticationProfiles/{authenticationProfileName}:issueCert")
  @post
  @pollingOperation(RuntimeCertIssuance.OperationStatusLookup)
  issueCertificate(
    /** The unique identifier of the namespace. */
    @path namespaceUuid: string,

    /** The name of the device. */
    @path deviceName: string,

    /** The name of the device authentication profile. */
    @path authenticationProfileName: string,

    /** Certificate issuance request. */
    @body certificateIssuance: CertificateIssuanceRequest,

    /** The API version to use for this operation. */
    @query("api-version")
    apiVersion: string,
  ): {
    @statusCode statusCode: 202;

    /**
     * The location for monitoring the operation state. It contains the
     * absolute URL of the status monitor resource, including an api-version
     * query parameter. EX "/namespaces/{namespaceUuid}/devices/{deviceName}/authenticationProfiles/{authenticationProfileName}/issueCertResults/{operationId}?api-version=2026-11-01-preview".
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing service contract; preserves wire compatibility for already-deployed clients calling raw REST."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Preserves existing operationId for wire/SDK parity with shipped CMS spec."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserves existing operationId for wire/SDK parity with shipped CMS spec."
  @summary("Gets the cert issuance operation status.")
  @tag("GET")
  @route("/namespaces/{namespaceUuid}/devices/{deviceName}/authenticationProfiles/{authenticationProfileName}/issueCertResults/{operationId}")
  @get
  OperationStatusLookup(
    /** The unique identifier of the namespace. */
    @path namespaceUuid: string,

    /** The name of the device. */
    @path deviceName: string,

    /** The name of the device authentication profile. */
    @path authenticationProfileName: string,

    /** Operation ID. */
    @path operationId: string,

    /** The API version to use for this operation. */
    @query("api-version")
    apiVersion: string,
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
