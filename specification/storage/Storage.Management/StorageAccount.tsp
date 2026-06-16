import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Storage;
/**
 * The storage account.
 */
model StorageAccount
  is Azure.ResourceManager.TrackedResource<StorageAccountProperties> {
  ...ResourceNameParameter<
    Resource = StorageAccount,
    KeyName = "accountName",
    SegmentName = "storageAccounts",
    NamePattern = "^[a-z0-9]+$"
  >;

  /**
   * Gets the SKU.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  sku?: Sku;

  /**
   * Gets the Kind.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: Kind;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;

  /**
   * The extendedLocation of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  extendedLocation?: ExtendedLocation;

  ...Azure.ResourceManager.AvailabilityZonesProperty;

  /**
   * Optional. Gets or sets the zonal placement details for the storage account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  placement?: Placement;
}

alias StorageAccountListKeysParameters = {
  /**
   * Specifies type of the key to be listed. Possible value is kerb.
   */
  @query("$expand")
  $expand?: "kerb";
};

alias StorageAccountFailoverParameters = {
  /**
   * The parameter is set to 'Planned' to indicate whether a Planned failover is requested.
   */
  @query("failoverType")
  failoverType?: "Planned";
};

@armResourceOperations
interface StorageAccounts {
  /**
   * Checks that the storage account name is valid and is not already in use.
   */
  @autoRoute
  checkNameAvailability is ArmProviderActionSync<
    Request = StorageAccountCheckNameAvailabilityParameters,
    Response = CheckNameAvailabilityResult,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ErrorResponse
  >;
  /**
   * Returns the properties for the specified storage account including but not limited to name, SKU name, location, and account status. The ListKeys operation should be used to retrieve storage keys.
   */
  getProperties is ArmResourceRead<
    StorageAccount,
    Parameters = {
      /**
       * May be used to expand the properties within account's properties. By default, data is not included when fetching properties. Currently we only support geoReplicationStats and blobRestoreStatus.
       */
      @query("$expand")
      $expand?: StorageAccountExpand;
    },
    Error = ErrorResponse
  >;

  /**
   * Asynchronously creates a new storage account with the specified parameters. If an account is already created and a subsequent create request is issued with different properties, the account properties will be updated. If an account is already created and a subsequent create or update request is issued with the exact same set of properties, the request will succeed.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @armResourceCreateOrUpdate(StorageAccount)
  @autoRoute
  create is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      StorageAccount,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<StorageAccount>
    >,
    StorageAccountCreateParameters,
    Response = ArmResourceUpdatedResponse<StorageAccount> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = StorageAccount> &
      Azure.Core.Foundations.RetryAfterHeader>,
    ErrorResponse = ErrorResponse
  >;

  /**
   * The update operation can be used to update the SKU, encryption, access tier, or tags for a storage account. It can also be used to map the account to a custom domain. Only one custom domain is supported per storage account; the replacement/change of custom domain is not supported. In order to replace an old custom domain, the old value must be cleared/unregistered before a new value can be set. The update of multiple properties is supported. This call does not change the storage keys for the account. If you want to change the storage account keys, use the regenerate keys operation. The location and name of the storage account cannot be changed after creation.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    StorageAccount,
    PatchModel = StorageAccountUpdateParameters,
    Error = ErrorResponse
  >;

  /**
   * Deletes a storage account in Microsoft Azure.
   */
  delete is ArmResourceDeleteSync<StorageAccount, Error = ErrorResponse>;

  /**
   * Lists all the storage accounts available under the given resource group. Note that storage keys are not returned; use the ListKeys operation for this.
   */
  listByResourceGroup is ArmResourceListByParent<
    StorageAccount,
    Error = ErrorResponse
  >;

  /**
   * Lists all the storage accounts available under the subscription. Note that storage keys are not returned; use the ListKeys operation for this.
   */
  list is ArmListBySubscription<StorageAccount, Error = ErrorResponse>;

  /**
   * Lists the access keys or Kerberos keys (if active directory enabled) for the specified storage account.
   */
  listKeys is ArmResourceActionSync<
    StorageAccount,
    void,
    ArmResponse<StorageAccountListKeysResult>,
    Parameters = StorageAccountListKeysParameters,
    Error = ErrorResponse
  >;

  /**
   * Regenerates one of the access keys or Kerberos keys for the specified storage account.
   */
  regenerateKey is ArmResourceActionSync<
    StorageAccount,
    StorageAccountRegenerateKeyParameters,
    ArmResponse<StorageAccountListKeysResult>,
    Error = ErrorResponse
  >;

  /**
   * List SAS credentials of a storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("ListAccountSas")
  listAccountSAS is ArmResourceActionSync<
    StorageAccount,
    AccountSasParameters,
    ArmResponse<ListAccountSasResponse>,
    Error = ErrorResponse
  >;

  /**
   * List service SAS credentials of a specific resource.
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("ListServiceSas")
  listServiceSAS is ArmResourceActionSync<
    StorageAccount,
    ServiceSasParameters,
    ArmResponse<ListServiceSasResponse>,
    Error = ErrorResponse
  >;

  /**
   * A failover request can be triggered for a storage account in the event a primary endpoint becomes unavailable for any reason. The failover occurs from the storage account's primary cluster to the secondary cluster for RA-GRS accounts. The secondary cluster will become primary after failover and the account is converted to LRS. In the case of a Planned Failover, the primary and secondary clusters are swapped after failover and the account remains geo-replicated. Failover should continue to be used in the event of availability issues as Planned failover is only available while the primary and secondary endpoints are available. The primary use case of a Planned Failover is disaster recovery testing drills. This type of failover is invoked by setting FailoverType parameter to 'Planned'. Learn more about the failover options here- https://learn.microsoft.com/azure/storage/common/storage-disaster-recovery-guidance
   */
  failover is ArmResourceActionAsync<
    StorageAccount,
    void,
    {
      @body body: void;
    },
    Parameters = StorageAccountFailoverParameters,
    Error = ErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Live Migration of storage account to enable Hns
   */
  @action("hnsonmigration")
  hierarchicalNamespaceMigration is ArmResourceActionAsync<
    StorageAccount,
    void,
    {
      @body body: void;
    },
    Parameters = {
      /**
       * Required. Hierarchical namespace migration type can either be a hierarchical namespace validation request 'HnsOnValidationRequest' or a hydration request 'HnsOnHydrationRequest'. The validation request will validate the migration whereas the hydration request will migrate the account.
       */
      @query("requestType")
      requestType: string;
    },
    Error = ErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Abort live Migration of storage account to enable Hns
   */
  @action("aborthnsonmigration")
  abortHierarchicalNamespaceMigration is ArmResourceActionAsync<
    StorageAccount,
    void,
    {
      @body body: void;
    },
    Error = ErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Account Migration request can be triggered for a storage account to change its redundancy level. The migration updates the non-zonal redundant storage account to a zonal redundant account or vice-versa in order to have better reliability and availability. Zone-redundant storage (ZRS) replicates your storage account synchronously across three Azure availability zones in the primary region.
   */
  @action("startAccountMigration")
  customerInitiatedMigration is ArmResourceActionAsync<
    StorageAccount,
    StorageAccountMigration,
    {
      @body body: void;
    },
    Error = ErrorResponse,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader &
      ArmLroLocationHeader<FinalResult = void>
  >;

  /**
   * Restore blobs in the specified blob ranges
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  restoreBlobRanges is ArmResourceActionAsyncBase<
    StorageAccount,
    BlobRestoreParameters,
    BaseParameters = Azure.ResourceManager.Foundations.DefaultBaseParameters<StorageAccount>,
    Response = ArmResponse<BlobRestoreStatus> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BlobRestoreStatus> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: BlobRestoreStatus;
    }),
    Error = ErrorResponse
  >;

  /**
   * Revoke user delegation keys.
   */
  revokeUserDelegationKeys is ArmResourceActionSync<
    StorageAccount,
    void,
    OkResponse,
    Error = ErrorResponse
  >;

  /**
   * Gets the private link resources that need to be created for a storage account.
   */
  @get
  @action("privateLinkResources")
  listByStorageAccount is ArmResourceActionSync<
    StorageAccount,
    void,
    ArmResponse<PrivateLinkResourceListResult>,
    Error = ErrorResponse
  >;

  /**
   * Fetch the report summary of all the storage task assignments and instances in an account
   */
  @get
  @list
  @action("reports")
  storageTaskAssignmentsInstancesReportList is ArmResourceActionSync<
    StorageAccount,
    void,
    ArmResponse<StorageTaskReportSummary>,
    Parameters = {
      /**
       * Optional, specifies the maximum number of storage task assignment instances to be included in the list response.
       */
      @query("$maxpagesize")
      $maxpagesize?: int32;

      /**
       * Optional. When specified, it can be used to query using reporting properties. See [Constructing Filter Strings](https://learn.microsoft.com/rest/api/storageservices/querying-tables-and-entities#constructing-filter-strings) for details.
       */
      @query("$filter")
      $filter?: string;
    },
    Error = ErrorResponse
  >;
}

@@maxLength(StorageAccount.name, 24);
@@minLength(StorageAccount.name, 3);
@@doc(StorageAccount.name,
  "The name of the storage account within the specified resource group. Storage account names must be between 3 and 24 characters in length and use numbers and lower-case letters only."
);
@@doc(StorageAccount.properties, "Properties of the storage account.");
@@doc(StorageAccounts.create::parameters.resource,
  "The parameters to provide for the created account."
);
@@doc(StorageAccounts.update::parameters.properties,
  "The parameters to provide for the updated account."
);
@@doc(StorageAccounts.regenerateKey::parameters.body,
  "Specifies name of the key which should be regenerated -- key1, key2, kerb1, kerb2."
);
@@doc(StorageAccounts.listAccountSAS::parameters.body,
  "The parameters to provide to list SAS credentials for the storage account."
);
@@doc(StorageAccounts.listServiceSAS::parameters.body,
  "The parameters to provide to list service SAS credentials."
);
@@doc(StorageAccounts.customerInitiatedMigration::parameters.body,
  "The request parameters required to perform storage account migration."
);
@@doc(StorageAccounts.restoreBlobRanges::parameters.body,
  "The parameters to provide for restore blob ranges."
);
