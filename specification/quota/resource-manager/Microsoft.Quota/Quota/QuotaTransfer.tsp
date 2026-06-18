import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./transfer-models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.Quota;

/**
 * A quota transfer authored on the donor side. The donor selects the URI segment
 * `{transferName}`; the recipient addresses the same logical transfer via the
 * server-generated `properties.transferId` GUID on the `incomingQuotaTransfers` URI.
 */
@added(Versions.v2026_09_01_preview)
model QuotaTransfer
  is Azure.ResourceManager.ProxyResource<QuotaTransferProperties> {
  ...ResourceNameParameter<
    Resource = QuotaTransfer,
    KeyName = "transferName",
    SegmentName = "quotaTransfers",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9._-]{2,62}$"
  >;
  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Standard ARM etag envelope property."
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

/**
 * Operations interface that establishes the donor-side URI prefix
 * `/subscriptions/{subscriptionId}/providers/{targetProvider}/locations/{region}/providers/Microsoft.Quota/quotaTransfers/{transferName}`.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface QuotaTransferOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /**
         * The ARM provider namespace whose quota is being transferred (for example,
         * `Microsoft.Compute`).
         */
        @path
        @segment("providers")
        @pattern("^Microsoft\\.[A-Za-z0-9]+$")
        targetProvider: string,

        /**
         * The Azure region the quota transfer applies to. A transfer URI is region-singular.
         */
        @path
        @segment("locations")
        region: Azure.Core.azureLocation,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * The donor-chosen name segment of the quota transfer. Used as the idempotency key
         * for retries on the donor side.
         */
        @path
        @segment("quotaTransfers")
        @minLength(3)
        @maxLength(63)
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9._-]{2,62}$")
        transferName: string,
      }
    > {}

/**
 * Donor-side quota transfer operations.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface QuotaTransfers {
  /**
   * Get a quota transfer.
   */
  get is QuotaTransferOps.Read<QuotaTransfer>;

  /**
   * Submit a quota transfer. Idempotent on the URI: a retry with the same body returns the
   * cached outcome and the same `transferId`; a retry with a different financial body
   * returns 409 BodyMismatch.
   */
  createOrUpdate is QuotaTransferOps.CreateOrUpdateAsync<QuotaTransfer>;

  /**
   * Delete a quota transfer record. Quota is not moved by delete; only the resource entry
   * is removed.
   */
  delete is QuotaTransferOps.DeleteSync<QuotaTransfer>;

  /**
   * List quota transfers at the (subscription, targetProvider, region) scope.
   */
  list is QuotaTransferOps.List<QuotaTransfer>;

  /**
   * Cancel a Pending quota transfer. Synchronous. Transitions the transfer to Cancelled
   * and returns the refreshed resource envelope.
   */
  @action("cancel")
  cancel is QuotaTransferOps.ActionSync<
    QuotaTransfer,
    QuotaTransferCancelRequest,
    ArmResponse<QuotaTransfer>,
    OptionalRequestBody = true,
    Parameters = {
      /**
       * An opaque, globally-unique, client-generated string identifier for the request.
       */
      @header("Repeatability-Request-ID")
      repeatabilityRequestId?: string;

      /**
       * Specifies the date and time at which the request was first created.
       */
      @header("Repeatability-First-Sent")
      repeatabilityFirstSent?: utcDateTime;
    }
  >;
}

@@doc(
  QuotaTransfer.name,
  "The donor-chosen name segment of the quota transfer."
);
@@doc(QuotaTransfer.properties, "Properties of the quota transfer.");
