import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";
import "./models.tsp";
import "./BillingAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Microsoft.Billing;

/**
 * The license reservation.
 */
@added(Versions.v2024_08_01_preview)
@tenantResource
@parentResource(BillingAccount)
model LicenseReservation
  is Azure.ResourceManager.ProxyResource<LicenseReservationProperties> {
  ...ResourceNameParameter<
    Resource = LicenseReservation,
    KeyName = "licenseReservationName",
    SegmentName = "licenseReservations",
    NamePattern = LicenseReservationPattern
  >;

  /**
   * Dictionary of metadata associated with the resource. It may not be populated for all resource types. Maximum key/value length supported of 256 characters. Keys/value should not empty value nor null. Keys can not contain < > % & \ ? /
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing documentation to provide tags like this. Same type as types.tsp/TrackedResource."
  tags?: Record<string>;
}

alias LicenseReservationOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    /** The ID that uniquely identifies a license reservation. */
    @path
    @segment("licenseReservations")
    @key
    @pattern(LicenseReservationPattern)
    licenseReservationName: string;
  },
  "LicenseReservation"
>;

/**
 * The license reservation was/is being updated. If the provisioningState in the response does not indicate a terminal state, an 'Azure-AsyncOperation' header will be included, allowing the client to poll for details about the operation's progress.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing API model contract. Back compat."
@added(Versions.v2024_08_01_preview)
model LicenseReservationUpdatedLroResponse {
  ...ArmResponse<LicenseReservation>;
  ...ArmAsyncOperationHeader<FinalResult = LicenseReservation>;
  ...Azure.Core.Foundations.RetryAfterHeader;
}

/**
 * The license reservation was/is being created. If the provisioningState in the response does not indicate a terminal state, an 'Azure-AsyncOperation' header will be included, allowing the client to poll for details about the operation's progress.
 */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Existing API model contract. Back compat."
@added(Versions.v2024_08_01_preview)
model LicenseReservationCreatedLroResponse {
  ...CreatedResponse;
  ...ArmAsyncOperationHeader<FinalResult = LicenseReservation>;
  ...Azure.Core.Foundations.RetryAfterHeader;

  /** The resource body. */
  @Azure.Core.pollingLocation(
    Azure.Core.StatusMonitorPollingOptions<LicenseReservation>
  )
  @bodyRoot
  body: LicenseReservation;
}

@armResourceOperations(#{ omitTags: true })
interface LicenseReservations {
  /**
   * Gets a license reservation for VL Online Services by its ID. This operation is supported for billing accounts of type Enterprise Agreement to get a license reservation under Volume Licensing (VL).
   */
  @added(Versions.v2024_08_01_preview)
  @tag("LicenseReservation")
  get is LicenseReservationOps.Read<LicenseReservation>;

  /**
   * Lists the license reservations for VL Online Services. This operation is supported for billing accounts of type Enterprise Agreement to list license reservations under Volume Licensing (VL).
   */
  @added(Versions.v2024_08_01_preview)
  @tag("LicenseReservation")
  list is LicenseReservationOps.List<
    LicenseReservation,
    Response = ArmResponse<LicenseReservationListResult>
  >;

  /**
   * Creates the license reservation for VL Online Services. This operation is supported for billing accounts of type Enterprise Agreement to create license reservations under Volume Licensing (VL).
   */
  @added(Versions.v2024_08_01_preview)
  @tag("LicenseReservation")
  create is LicenseReservationOps.CreateOrUpdateAsync<
    LicenseReservation,
    Response =
      | LicenseReservationUpdatedLroResponse
      | LicenseReservationCreatedLroResponse
  >;

  /**
   * Cancels a license reservation for VL Online services. Accepts an optional cancellation reason. This operation is supported for billing accounts of type Enterprise Agreement to cancel a license reservation under Volume Licensing (VL).
   */
  @added(Versions.v2024_08_01_preview)
  @tag("LicenseReservation")
  @action("cancel")
  cancel is LicenseReservationOps.ActionAsync<
    LicenseReservation,
    CancelLicenseReservationRequest,
    void,
    Response = ArmAcceptedLroResponse
  >;

  /**
   * DELETE operation is currently not supported for license reservation resource type. For cancelling license reservation, please use the cancel action.
   */
  @added(Versions.v2024_08_01_preview)
  @tag("LicenseReservation")
  delete is LicenseReservationOps.DeleteWithoutOkAsync<LicenseReservation>;
}

@@doc(
  LicenseReservation.name,
  "The ID that uniquely identifies a license reservation."
);
@@doc(LicenseReservation.properties, "The license reservation.");
@@doc(
  LicenseReservations.create::parameters.resource,
  "The license reservation."
);
@@doc(
  LicenseReservations.cancel::parameters.body,
  "Request parameters for cancel license reservation."
);
