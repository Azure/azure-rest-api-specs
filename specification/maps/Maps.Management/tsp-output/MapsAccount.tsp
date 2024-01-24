import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Maps;
/**
 * An Azure resource which represents access to a suite of Maps REST APIs.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(MapsAccountProperties)
@includeInapplicableMetadataInPayload(false)
model MapsAccount extends TrackedResourceBase {
  /**
   * The name of the Maps Account.
   */
  @path
  @key("accountName")
  @segment("accounts")
  name: string;

  /**
   * Get or Set Kind property.
   */
  kind?: Kind = Kind.Gen1;

  /**
   * The map account properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MapsAccountProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface MapsAccounts {
  /**
   * Get a Maps Account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Get")
  get is ArmResourceRead<MapsAccount>;

  /**
   * Create or update a Maps Account. A Maps Account holds the keys which allow access to the Maps REST APIs.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<MapsAccount>;

  /**
   * Updates a Maps Account. Only a subset of the parameters may be updated after creation, such as Sku, Tags, Properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Accounts_Update")
  update is ArmCustomPatchSync<MapsAccount, MapsAccountUpdateParameters>;

  /**
   * Delete a Maps Account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteSync<MapsAccount>;

  /**
   * Get all Maps Accounts in a Resource Group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<MapsAccount>;

  /**
   * Get all Maps Accounts in a Subscription
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListBySubscription")
  listBySubscription is ArmListBySubscription<MapsAccount>;

  /**
   * Create and list an account shared access signature token. Use this SAS token for authentication to Azure Maps REST APIs through various Azure Maps SDKs. As prerequisite to create a SAS Token.
   *
   * Prerequisites:
   * 1. Create or have an existing User Assigned Managed Identity in the same Azure region as the account.
   * 2. Create or update an Azure Map account with the same Azure region as the User Assigned Managed Identity is placed.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListSas")
  listSas is ArmResourceActionSync<
    MapsAccount,
    AccountSasParameters,
    MapsAccountSasToken
  >;

  /**
   * Get the keys to use with the Maps APIs. A key is used to authenticate and authorize access to the Maps REST APIs. Only one key is needed at a time; two are given to provide seamless key regeneration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListKeys")
  listKeys is ArmResourceActionSync<MapsAccount, void, MapsAccountKeys>;

  /**
   * Regenerate either the primary or secondary key for use with the Maps APIs. The old key will stop working immediately.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_RegenerateKeys")
  regenerateKeys is ArmResourceActionSync<
    MapsAccount,
    MapsKeySpecification,
    MapsAccountKeys
  >;
}

@@projectedName(MapsAccounts.createOrUpdate::parameters.resource,
  "json",
  "MapsAccount"
);
@@extension(MapsAccounts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "MapsAccount"
);
@@doc(MapsAccounts.createOrUpdate::parameters.resource,
  "The new or updated parameters for the Maps Account."
);
@@projectedName(MapsAccounts.update::parameters.properties,
  "json",
  "MapsAccountUpdateParameters"
);
@@extension(MapsAccounts.update::parameters.properties,
  "x-ms-client-name",
  "MapsAccountUpdateParameters"
);
@@doc(MapsAccounts.update::parameters.properties,
  "The updated parameters for the Maps Account."
);
@@projectedName(MapsAccounts.listSas::parameters.body,
  "json",
  "MapsAccountSasParameters"
);
@@extension(MapsAccounts.listSas::parameters.body,
  "x-ms-client-name",
  "MapsAccountSasParameters"
);
@@doc(MapsAccounts.listSas::parameters.body,
  "The updated parameters for the Maps Account."
);
@@projectedName(MapsAccounts.regenerateKeys::parameters.body,
  "json",
  "keySpecification"
);
@@extension(MapsAccounts.regenerateKeys::parameters.body,
  "x-ms-client-name",
  "keySpecification"
);
@@doc(MapsAccounts.regenerateKeys::parameters.body,
  "Which key to regenerate:  primary or secondary."
);
