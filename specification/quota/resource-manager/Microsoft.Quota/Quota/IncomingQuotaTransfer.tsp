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
 * Recipient-side projection of a quota transfer. The URI key `{transferId}` is the
 * server-generated GUID returned to the donor in the PUT response under
 * `properties.transferId`. The resource is read-only from the recipient side; state
 * changes occur through the approve and reject actions.
 */
@added(Versions.v2026_09_01_preview)
model IncomingQuotaTransfer
  is Azure.ResourceManager.ProxyResource<IncomingQuotaTransferProperties> {
  ...ResourceNameParameter<
    Resource = IncomingQuotaTransfer,
    KeyName = "transferId",
    SegmentName = "incomingQuotaTransfers",
    NamePattern = ""
  >;

  #suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Standard ARM etag envelope property."
  ...Azure.ResourceManager.Legacy.EntityTagProperty;
}

/**
 * Operations interface for the recipient-side URI prefix
 * `/subscriptions/{subscriptionId}/providers/{targetProvider}/locations/{region}/providers/Microsoft.Quota/incomingQuotaTransfers/{transferId}`.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface IncomingQuotaTransferOps
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
         * The Azure region the quota transfer applies to.
         */
        @path
        @segment("locations")
        region: Azure.Core.azureLocation,

        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * Server-generated identifier of the transfer (matches `properties.transferId`).
         */
        @path
        @segment("incomingQuotaTransfers")
        transferId: uuid,
      }
    > {}

/**
 * Operations interface for the subscription-wide aggregate URI prefix
 * `/subscriptions/{subscriptionId}/providers/Microsoft.Quota/incomingQuotaTransfers`,
 * used to enumerate inbox entries across every targetProvider and region.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface IncomingQuotaTransferSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /**
         * Server-generated identifier of the transfer.
         */
        @path
        @segment("incomingQuotaTransfers")
        transferId: uuid,
      }
    > {}

/**
 * Recipient-side incoming quota transfer operations.
 */
@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface IncomingQuotaTransfers {
  /**
   * Get an incoming quota transfer.
   */
  get is IncomingQuotaTransferOps.Read<IncomingQuotaTransfer>;

  /**
   * List incoming quota transfers at the (subscription, targetProvider, region) scope.
   */
  list is IncomingQuotaTransferOps.List<IncomingQuotaTransfer>;

  /**
   * List incoming quota transfers across every targetProvider and region for the
   * subscription.
   */
  listBySubscription is IncomingQuotaTransferSubscriptionOps.List<IncomingQuotaTransfer>;

  /**
   * Approve a Pending incoming quota transfer. Long-running. The `If-Match` header value
   * must equal `properties.sourceEtag` returned on a prior GET; a stale value yields
   * 412 SourceResourceModified.
   */
  @action("approve")
  approve is IncomingQuotaTransferOps.ActionAsync<
    IncomingQuotaTransfer,
    IncomingQuotaTransferApproveRequest,
    IncomingQuotaTransfer,
    OptionalRequestBody = true,
    Parameters = {
      /**
       * Optimistic-concurrency precondition. Must equal `properties.sourceEtag` from a
       * prior GET on the incoming transfer.
       */
      @header("If-Match")
      ifMatch: string;

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

  /**
   * Reject a Pending incoming quota transfer. Synchronous. The `If-Match` header value
   * must equal `properties.sourceEtag` returned on a prior GET.
   */
  @action("reject")
  reject is IncomingQuotaTransferOps.ActionSync<
    IncomingQuotaTransfer,
    IncomingQuotaTransferRejectRequest,
    ArmResponse<IncomingQuotaTransfer>,
    OptionalRequestBody = true,
    Parameters = {
      /**
       * Optimistic-concurrency precondition. Must equal `properties.sourceEtag` from a
       * prior GET on the incoming transfer.
       */
      @header("If-Match")
      ifMatch: string;

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

@@doc(IncomingQuotaTransfer.name,
  "Server-generated GUID identifier of the incoming quota transfer."
);
@@doc(IncomingQuotaTransfer.properties,
  "Properties of the incoming quota transfer."
);
