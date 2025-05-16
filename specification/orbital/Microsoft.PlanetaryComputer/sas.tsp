import "@typespec/rest";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.Http;
using Azure.Core.Foundations;

namespace Microsoft.PlanetaryComputer;

/**
 * Represents a Shared Access Signature (SAS) token response for accessing Azure Blob Storage.
 */
@summary("SasToken")
model SasToken {
  /**
   * The expiration date and time of the SAS token in UTC.
   */
  @summary("Msft:Expiry")
  @encodedName("application/json", "msft:expiry")
  msftExpiry: utcDateTime;

  /**
   * The SAS token string used for authentication.
   */
  @summary("Token") token: string;
}

/**
 * Represents a link that has not been signed with a SAS token.
 * The expiry field will be null for unsigned links.
 */
@summary("UnsignedLink")
model UnsignedLink {
  /**
   * The expiry date of the signed link. This indicates when the link will no longer be valid.
   */
  @summary("Msft:Expiry")
  @encodedName("application/json", "msft:expiry")
  msftExpiry?: utcDateTime;

  /**
   * The URL of the unsigned link.
   */
  @summary("Href") href: string;
}

/**
 * Successful Response
 */
model TokenResponse {
  /**
   * Status code
   */
  @statusCode statusCode: 200;

  /**
   * Response body
   */
  @body
  body: SasToken;
}

/**
 * Successful Response
 */
model SignedHrefResponse {
  /**
   * Status code
   */
  @statusCode
  statusCode: 200;

  /**
   * Response body
   */
  @summary("Response Signed Href Api Sign Get")
  @body
  body?: UnsignedLink;
}

interface Sas {
  /**
   * Generate a [SAS Token](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview#how-a-shared-access-signature-works)
   * for the given storage account and container. The storage account and container
   * must be associated with a Planetary Computer dataset indexed by the STAC API.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @tag("Shared Access Signature (SAS) Tokens to use with Azure SDKs")
  @route("/sas/token/{collectionId}")
  @get
  @summary("generate a SAS Token for the given Azure Blob storage account and container.")
  getToken(
    /**
     * The API version to use.
     */
    ...Azure.Core.Foundations.ApiVersionParameter,

    /**
     * The name of the Collection that the SAS token will be issued for.
     */
    @summary("Collection Id")
    @path
    collectionId: string,

    /**
     * The duration, in minutes, that the SAS token will be valid. Only valid for approved users.
     */
    @summary("Duration")
    @query
    duration?: int64,
  ): TokenResponse | ErrorResponse;

  /**
   * Revoke a [SAS Token](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview#how-a-shared-access-signature-works)
   * for managed storage account of this GeoCatalog.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @tag("Shared Access Signature (SAS) Tokens to use with Azure SDKs")
  @route("/sas/token/revoke")
  @post
  @summary("revoke a SAS Token for the given Azure Blob storage account")
  revokeToken(
    /**
     * The API version to use.
     */
    ...Azure.Core.Foundations.ApiVersionParameter,

    /**
     * The duration, in minutes, that the SAS token will be valid. Only valid for approved users.
     */
    @summary("Duration")
    @query
    duration?: int64,
  ): OkResponse | ErrorResponse;

  /**
   * Signs a HREF (a link URL) by appending a [SAS Token](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview#how-a-shared-access-signature-works).
   * If the HREF is not a Azure Blob Storage HREF, then pass back the HREF unsigned.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
  @tag("Sign an HREF for read access")
  @route("/sas/sign")
  @get
  @summary("sign an HREF in the format of a URL and returns a SingedLink")
  getSign(
    /**
     * The API version to use.
     */
    ...Azure.Core.Foundations.ApiVersionParameter,

    /**
     * HREF (URL) to sign
     */
    @summary("Href")
    @query
    href: string,

    /**
     * The duration, in minutes, that the SAS token will be valid. Only valid for approved users.
     */
    @summary("Duration")
    @query
    duration?: int64,
  ): SignedHrefResponse | ErrorResponse;
}
