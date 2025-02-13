import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedHsm.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * The key resource.
 */
@parentResource(ManagedHsm)
model ManagedHsmKey
  is Azure.ResourceManager.ProxyResource<ManagedHsmKeyProperties, false> {
  ...ResourceNameParameter<
    Resource = ManagedHsmKey,
    KeyName = "keyName",
    SegmentName = "keys",
    NamePattern = "^[a-zA-Z0-9-]{1,127}$"
  >;
}

@armResourceOperations
interface ManagedHsmKeyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ManagedHsm,
          KeyName = "name",
          SegmentName = "managedHSMs",
          NamePattern = "^[A-Za-z]([A-Za-z0-9]|\\-[A-Za-z0-9])+$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ManagedHsmKey,
        KeyName = "keyName",
        SegmentName = "keys",
        NamePattern = "^[a-zA-Z0-9-]{1,127}$"
      >>
    > {}

@armResourceOperations
interface ManagedHsmKeys {
  /**
   * Gets the current version of the specified key from the specified managed HSM.
   */
  get is ManagedHsmKeyOps.Read<ManagedHsmKey>;

  /**
   * Creates the first version of a new key if it does not exist. If it already exists, then the existing key is returned without any write operations being performed. This API does not create subsequent versions, and does not update existing keys.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createIfNotExist is ManagedHsmKeyOps.CreateOrUpdateSync<
    ManagedHsmKey,
    Response = ArmResourceUpdatedResponse<ManagedHsmKey>
  >;
}
@armResourceOperations
interface ManagedHsmKeyOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = ManagedHsm,
          KeyName = "name",
          SegmentName = "managedHSMs",
          NamePattern = "^[A-Za-z]([A-Za-z0-9]|\\-[A-Za-z0-9])+$"
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = Key,
          KeyName = "keyName",
          SegmentName = "keys",
          NamePattern = "^[a-zA-Z0-9-]{1,127}$"
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = ManagedHsmKey,
        KeyName = "keyVersion",
        SegmentName = "versions",
        NamePattern = "^[a-fA-F0-9]{32}$"
      >>
    > {}

@armResourceOperations
interface ManagedHsmKeyOperationGroup {
  /**
   * Gets the specified version of the specified key in the specified managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedHsmKeys_GetVersion")
  getVersion is ManagedHsmKeyOperationGroupOps.Read<ManagedHsmKey>;

  /**
   * Lists the keys in the specified managed HSM.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedHsmKeys_List")
  list is ManagedHsmKeyOperationGroupOps.List<ManagedHsmKey>;
}

@@doc(ManagedHsmKey.name,
  "The name of the key to be created. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information."
);
@@doc(ManagedHsmKey.properties, "The properties of the key.");
@@doc(ManagedHsmKeys.createIfNotExist::parameters.resource,
  "The parameters used to create the specified key."
);
