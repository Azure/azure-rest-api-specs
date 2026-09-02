import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Billing;

/**
 * The details of the partner change request.
 */
@added(Versions.v2024_08_01_preview)
@tenantResource
@parentResource(BillingAccount)
model PartnerChangeRequestGetDetails
  is Azure.ResourceManager.ProxyResource<PartnerChangeRequestGetDetailsProperties> {
  ...ResourceNameParameter<
    Resource = PartnerChangeRequestGetDetailsProperties,
    KeyName = "partnerChangeRequestGuid",
    SegmentName = "partnerChangeRequests"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

/**
 * The result of the cancellation of partner change request.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeRequestCancellation
  is Azure.ResourceManager.ProxyResource<PartnerChangeRequestCancellationProperties> {
  ...ResourceNameParameter<
    Resource = PartnerChangeRequestCancellationProperties,
    KeyName = "partnerChangeRequestGuid",
    SegmentName = "partnerChangeRequests"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

/**
 * A partner change request document resource.
 */
@added(Versions.v2024_08_01_preview)
model PartnerChangeDocumentDownloadResult
  is Azure.ResourceManager.ProxyResource<PartnerChangeDocumentDownloadResultProperties> {
  ...ResourceNameParameter<
    Resource = PartnerChangeDocumentDownloadResultProperties,
    KeyName = "partnerChangeRequestGuid",
    SegmentName = "partnerChangeRequests"
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

/** Details of a partner change request initiation response. */
@added(Versions.v2024_08_01_preview)
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing API model contract. Back compat."
model PartnerChangeRequestInitiatedResponse {
  ...AcceptedResponse;

  /**
   * The details of the partner change request for initiate operations.
   */
  @bodyRoot
  body: PartnerChangeRequestInitiateResponse;
}

/** Details of a partner change request cancellation response. */
@added(Versions.v2024_08_01_preview)
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing API model contract. Back compat."
model PartnerChangeRequestCancelledResponse {
  ...AcceptedResponse;

  /**
   * The result of the cancellation of partner change request.
   */
  @bodyRoot
  body: PartnerChangeRequestCancellation;
}

alias PartnerChangeRequestOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Billing";

    /** The ID that uniquely identifies a billing account. */
    @path
    @segment("billingAccounts")
    @key
    @pattern(BillingAccountNamePattern)
    billingAccountName: string;
  },
  {},
  {
    /** The unique identifier of the partner change request. */
    @path
    @segment("partnerChangeRequests")
    @key
    @pattern(GuidPattern)
    partnerChangeRequestGuid: string;
  },
  "PartnerChangeRequest"
>;

@armResourceOperations(#{ omitTags: true })
interface PartnerChangeRequest {
  /**
   * Gets the partner change request by ID. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PartnerChangeRequest")
  get is PartnerChangeRequestOps.Read<
    PartnerChangeRequestGetDetails,
    Response = ArmResponse<PartnerChangeRequestGetDetails>
  >;

  /**
   * Sends a request to new billing partner to take over the ownership of their enrollment. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "ARM approved before TypeSpec conversion."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "ARM approved before TypeSpec conversion."
  @added(Versions.v2024_08_01_preview)
  @tag("PartnerChangeRequest")
  initiate is PartnerChangeRequestOps.CreateOrUpdateSync<
    PartnerChangeRequestGetDetails,
    Parameters = {
      /**
       * If true, only evaluates the request without executing the partner change request.
       */
      @header("x-ms-evaluateOnly")
      evaluateOnly?: boolean;
    },
    Response = PartnerChangeRequestInitiatedResponse,
    Request = PartnerChangeInitiateRequest
  >;

  /**
   * Cancels a partner change request. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "ARM approved before TypeSpec conversion."
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "ARM approved before TypeSpec conversion."
  @added(Versions.v2024_08_01_preview)
  @tag("PartnerChangeRequest")
  @action("cancel")
  cancel is PartnerChangeRequestOps.ActionSync<
    PartnerChangeRequestGetDetails,
    PartnerChangeCancelRequest,
    PartnerChangeRequestCancelledResponse
  >;
}

@armResourceOperations(#{ omitTags: true })
interface PartnerChangeRequestDocument {
  /**
   * Gets a URL to download the partner change request document. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PartnerChangeRequest")
  @get
  @action("download")
  download is PartnerChangeRequestOps.ActionSync<
    PartnerChangeDocumentDownloadResult,
    void,
    ArmResponse<PartnerChangeDocumentDownloadResult>
  >;
}

@armResourceOperations(#{ omitTags: true })
interface PartnerChangeRequestsByBillingAccount {
  /**
   * Lists the partner change requests for a given billing account. The operation is supported only for billing accounts with agreement type Enterprise Agreement.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("PartnerChangeRequest")
  list is PartnerChangeRequestOps.List<
    PartnerChangeRequestGetDetails,
    Parameters = {
      /**
       * The number of results to return.
       */
      @query
      top?: int32;

      /**
       * The number of results to skip.
       */
      @query
      skip?: int32;

      /**
       * The ordering expression for the results.
       */
      @query
      orderBy?: string;
    },
    Response = ArmResponse<PartnerChangeRequestListResult>
  >;
}

@@doc(
  PartnerChangeRequest.initiate::parameters.resource,
  "The request parameters for initiating a partner change request."
);
@@doc(
  PartnerChangeRequest.cancel::parameters.body,
  "The request parameters for cancellation of partner change request."
);
