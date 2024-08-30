namespace Microsoft.AVS;

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Rest;
using TypeSpec.Versioning;

alias PrivateCloudList = ResourceList<PrivateCloud>;
@armResourceOperations
interface PrivateClouds {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "Can not change existing operationId."
  @operationId("PrivateClouds_List")
  list is ArmResourceListByParent<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  listInSubscription is ArmListBySubscription<
    PrivateCloud,
    Response = ArmResponse<PrivateCloudList>
  >;

  get is ArmResourceRead<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    PrivateCloud,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  // This could be modeled with ArmCustomPatchAsync if a 202 response with no body is used instead of a 201.
  // update is ArmCustomPatchAsync<PrivateCloud, PrivateCloudUpdate>;
  @doc("Update a PrivateCloud")
  @extension("x-ms-long-running-operation", true)
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "location",
    }
  )
  @armResourceUpdate(PrivateCloud)
  @patch
  update(
    ...ResourceInstanceParameters<PrivateCloud>,

    @bodyRoot
    @doc("The private cloud properties to be updated.")
    privateCloudUpdate: PrivateCloudUpdate,
  ): ArmResponse<PrivateCloud> | {
    // @doc("Resource update request created.")
    ...CreatedResponse;

    ...Azure.Core.Foundations.RetryAfterHeader;
    ...LocationHeader;

    @bodyRoot
    @doc("The updated private cloud.")
    placementPolicy: PrivateCloud;
  } | ErrorResponse;

  #suppress "deprecated"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes"
  delete is ArmResourceDeleteAsync<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  @doc("Rotate the vCenter password")
  rotateVcenterPassword is ArmResourceActionNoContentAsyncNoRequestBody<PrivateCloud>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "Existing API"
  @doc("Rotate the NSX-T Manager password")
  rotateNsxtPassword is ArmResourceActionNoContentAsyncNoRequestBody<PrivateCloud>;

  @doc("List the admin credentials for the private cloud")
  listAdminCredentials is ArmResourceActionSyncNoRequestBody<
    PrivateCloud,
    AdminCredentials
  >;
}

@@encodedName(PrivateClouds.createOrUpdate::parameters.resource,
  "application/json",
  "privateCloud"
);
@@OpenAPI.extension(PrivateClouds.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateCloud"
);
@@clientName(PrivateClouds.createOrUpdate::parameters.resource, "privateCloud");

@doc("private cloud provisioning state")
union PrivateCloudProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("is cancelled")
  Cancelled: "Cancelled",

  @doc("is pending")
  Pending: "Pending",

  @doc("is building")
  Building: "Building",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is updating")
  Updating: "Updating",
}

@doc("NSX public IP quota raised")
union NsxPublicIpQuotaRaisedEnum {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether internet is enabled or disabled")
union InternetEnum {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether SSL is enabled or disabled")
union SslEnum {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether the private clouds is available in a single zone or two zones")
union AvailabilityStrategy {
  string,

  @doc("in single zone")
  SingleZone: "SingleZone",

  @doc("in two zones")
  DualZone: "DualZone",
}

@doc("Whether encryption is enabled or disabled")
union EncryptionState {
  string,

  @doc("is enabled")
  Enabled: "Enabled",

  @doc("is disabled")
  Disabled: "Disabled",
}

@doc("Whether the the encryption key is connected or access denied")
union EncryptionKeyStatus {
  string,

  @doc("is connected")
  Connected: "Connected",

  @doc("is access denied")
  AccessDenied: "AccessDenied",
}

@doc("Whether the encryption version is fixed or auto-detected")
union EncryptionVersionType {
  string,

  @doc("is fixed")
  Fixed: "Fixed",

  @doc("is auto-detected")
  AutoDetected: "AutoDetected",
}
