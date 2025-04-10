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
model Account is Azure.ResourceManager.TrackedResource<AccountProperties> {
  ...ResourceNameParameter<
    Resource = Account,
    KeyName = "accountName",
    SegmentName = "accounts",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
  >;

  /**
   * The Kind of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind?: string;

  /**
   * The resource model definition representing SKU
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * Identity for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
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
      KeysOf<ResourceNameParameter<
        Resource = Account,
        KeyName = "accountName",
        SegmentName = "accounts",
        NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
      >>
    > {}

@armResourceOperations
interface Accounts {
  /**
   * Returns a Cognitive Services account specified by the parameters.
   */
  get is AccountOps.Read<Account>;

  /**
   * Create Cognitive Services Account. Accounts is a resource group wide resource type. It holds the keys for developer to access intelligent APIs. It's also the resource type for billing.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  create is AccountOps.CreateOrUpdateAsync<
    Account,
    Response = ArmResourceUpdatedResponse<Account> | ArmResourceCreatedResponse<
      Account,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Updates a Cognitive Services account
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is AccountOps.CustomPatchAsync<
    Account,
    PatchModel = Account,
    Response = ArmResponse<Account> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Deletes a Cognitive Services account from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is AccountOps.DeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all the resources of a particular type belonging to a subscription.
   */
  list is AccountOps.ListBySubscription<Account>;

  /**
   * Lists the account keys for the specified Cognitive Services account.
   */
  listKeys is AccountOps.ActionSync<Account, void, ArmResponse<ApiKeys>>;

  /**
   * Regenerates the specified account key for the specified Cognitive Services account.
   */
  regenerateKey is AccountOps.ActionSync<
    Account,
    RegenerateKeyParameters,
    ArmResponse<ApiKeys>
  >;

  /**
   * List available SKUs for the requested Cognitive Services account
   */
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
  @get
  @action("models")
  listModels is AccountOps.ActionSync<
    Account,
    void,
    ArmResponse<AccountModelListResult>
  >;

  /**
   * Gets the private link resources that need to be created for a Cognitive Services account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("PrivateLinkResources_List")
  privateLinkResourcesList is AccountOps.ActionSync<
    Account,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;
}
@armResourceOperations
interface DeletedAccountOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...LocationParameter,
        ...ResourceGroupParameter,
      },
      KeysOf<ResourceNameParameter<
        Resource = Account,
        KeyName = "accountName",
        SegmentName = "deletedAccounts",
        NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
      >>
    > {}

@armResourceOperations
interface DeletedAccounts {
  /**
   * Returns a Cognitive Services account specified by the parameters.
   */
  get is DeletedAccountOps.Read<Account>;

  /**
   * Deletes a Cognitive Services account from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  purge is DeletedAccountOps.DeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;
}
@armResourceOperations
interface ProjectOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Account,
          KeyName = "accountName",
          SegmentName = "accounts",
          NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = Account,
        KeyName = "projectName",
        SegmentName = "projects",
        NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_.-]*$"
      >>
    > {}

@armResourceOperations
interface Projects {
  /**
   * Returns a Cognitive Services project specified by the parameters.
   */
  get is ProjectOps.Read<Account>;

  /**
   * Create Cognitive Services Account's Project. Project is a sub-resource of an account which give AI developer it's individual container to work on.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  create is ProjectOps.CreateOrUpdateAsync<
    Account,
    Response = ArmResourceUpdatedResponse<Account> | ArmResourceCreatedResponse<
      Account,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    > | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Updates a Cognitive Services Project
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ProjectOps.CustomPatchAsync<
    Account,
    PatchModel = Account,
    Response = ArmResponse<Account> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Account;
    })
  >;

  /**
   * Deletes a Cognitive Services project from the resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ProjectOps.DeleteWithoutOkAsync<
    Account,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns all the resources of a particular type belonging to a resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ProjectOps.List<Account>;
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
@@doc(Projects.create::parameters.resource,
  "The parameters to provide for the created project."
);
@@doc(Projects.update::parameters.properties,
  "The parameters to provide for the created project."
);
