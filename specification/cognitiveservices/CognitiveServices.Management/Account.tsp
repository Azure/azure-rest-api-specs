import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CognitiveServices;
/**
 * Cognitive Services account is an Azure resource representing the provisioned account, it's type, location and SKU.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy usage decorator required for 'Account' to maintain SDK backward compatibility"
model Account is Azure.ResourceManager.ProxyResource<AccountProperties> {
  ...ResourceNameParameter<
    Resource = Account,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'etag' on the resource envelope for backward compatibility"
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * The kind (type) of cognitive service account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'kind' on the resource envelope for backward compatibility"
  kind?: string;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'sku' on the resource envelope for backward compatibility"
  sku?: Sku;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing API defines 'identity' on the resource envelope for backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface AccountOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      {
        /** The name of Cognitive Services account. */
        @path
        @segment("accounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @minLength(2)
        @maxLength(64)
        accountName: string,
      },
      ResourceName = "CognitiveServicesAccount"
    > {}

@armResourceOperations(#{ omitTags: true })
interface Accounts {
  /**
   * Returns a Cognitive Services account specified by the parameters.
   */
  @tag("CognitiveServicesAccounts")
  get is AccountOps.Read<Account>;

  /**
   * Create Cognitive Services Account. Accounts is a resource group wide resource type. It holds the keys for developer to access intelligent APIs. It's also the resource type for billing.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "PUT response codes for 'get' match existing service endpoint behavior"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "'get' returns no response body, matching existing service endpoint behavior"
  @tag("CognitiveServicesAccounts")
  create is AccountOps.CreateOrUpdateAsync<
    Account,
    Response = ArmResourceUpdatedResponse<Account> | ArmResourceCreatedResponse<Account> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Account> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Updates a Cognitive Services account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "'create' returns no response body, matching existing service endpoint behavior"
  @tag("CognitiveServicesAccounts")
  @patch(#{ implicitOptionality: false })
  update is AccountOps.CustomPatchAsync<
    Account,
    PatchModel = Account,
    Response = ArmResponse<Account> | (ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Account> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Deletes a Cognitive Services account from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes for 'update' match existing service endpoint behavior"
  @tag("CognitiveServicesAccounts")
  delete is AccountOps.DeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  @tag("CognitiveServicesAccounts")
  listByResourceGroup is AccountOps.List<Account, Response = AccountListResult>;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  @tag("CognitiveServicesAccounts")
  list is ArmListBySubscription<Account, Response = AccountListResult>;

  /**
   * Lists the account keys for the specified Cognitive Services account.
   */
  @tag("CognitiveServicesAccounts")
  listKeys is AccountOps.ActionSync<Account, void, ArmResponse<ApiKeys>>;

  /**
   * Regenerates the specified account key for the specified Cognitive Services account.
   */
  @tag("CognitiveServicesAccounts")
  regenerateKey is AccountOps.ActionSync<
    Account,
    RegenerateKeyParameters,
    ArmResponse<ApiKeys>
  >;

  /**
   * List available SKUs for the requested Cognitive Services account
   */
  @tag("CognitiveServicesAccounts")
  @get
  @action("skus")
  listSkus is AccountOps.ActionSync<
    Account,
    void,
    ArmResponse<AccountSkuListResult>
  >;

  /**
   * Get usages for the requested Cognitive Services account
   */
  @tag("CognitiveServicesAccounts")
  @get
  @action("usages")
  listUsages is AccountOps.ActionSync<
    Account,
    void,
    ArmResponse<UsageListResult>,
    Parameters = {
      /**
       * An OData filter expression that describes a subset of usages to return. The supported parameter is name.value (name of the metric, can have an or of multiple names).
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * List available Models for the requested Cognitive Services account
   */
  @tag("CognitiveServicesAccounts")
  @get
  @action("models")
  @list
  listModels is AccountOps.ActionSync<
    Account,
    void,
    ArmResponse<AccountModelListResult>
  >;

  /**
   * Gets the private link resources that need to be created for a Cognitive Services account.
   */
  @tag("PrivateLinkResources")
  @get
  @action("privateLinkResources")
  privateLinkResourcesList is AccountOps.ActionSync<
    Account,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;

  /**
   * Test the rai safety provider associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation-response" "Operation response for 'privateLinkResourcesList' matches existing service endpoint behavior"
  @tag("TestRaiExternalSafetyProvider")
  @put
  createOrUpdate is AccountOps.CreateOrUpdateSync<
    Account,
    Request = RaiExternalSafetyProviderSchema,
    Response = ArmResponse<RaiExternalSafetyProviderSchema> | ArmResourceCreatedSyncResponse<RaiExternalSafetyProviderSchema>,
    Parameters = {
      /**
       * The name of the Rai External Safety Provider associated with the Cognitive Services Account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
      @path
      @segment("testRaiExternalSafetyProvider")
      safetyProviderName: string;
    }
  >;
}
@armResourceOperations
interface DeletedAccountOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.CognitiveServices",

        ...LocationParameter,
        ...ResourceGroupParameter,
      },
      {},
      {
        /** The name of Cognitive Services account. */
        @path
        @segment("deletedAccounts")
        @key
        @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
        @maxLength(64)
        @minLength(2)
        accountName: string,
      },
      ResourceName = "CognitiveServicesDeletedAccount"
    > {}

@armResourceOperations(#{ omitTags: true })
interface DeletedAccounts {
  /**
   * Returns a Cognitive Services account specified by the parameters.
   */
  @tag("CognitiveServicesAccounts")
  get is DeletedAccountOps.Read<Account>;

  /**
   * Deletes a Cognitive Services account from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "Delete response codes for 'get' match existing service endpoint behavior"
  @tag("CognitiveServicesAccounts")
  purge is DeletedAccountOps.DeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}

@@maxLength(Account.name, 64);
@@minLength(Account.name, 2);
@@doc(Account.name, "The name of Cognitive Services account.");
@@doc(Account.properties, "Properties of Cognitive Services account.");
@@doc(Accounts.create::parameters.resource,
  "The parameters to provide for the created account."
);
@@doc(Accounts.update::parameters.properties,
  "The parameters to provide for the created account."
);
@@doc(Accounts.regenerateKey::parameters.body, "regenerate key parameters.");
@@doc(Accounts.createOrUpdate::parameters.resource,
  "Properties describing the rai external safety provider."
);
