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

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

@armResourceOperations
interface ManagedHsmKeyOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the Managed HSM Pool within the specified resource group. */
        @path
        @segment("managedHSMs")
        @key
        @pattern("^[A-Za-z]([A-Za-z0-9]|\\-[A-Za-z0-9])+$")
        @minLength(3)
        @maxLength(24)
        name: string,
      },
      {
        /** The name of the key to be created. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information. */
        @path
        @segment("keys")
        @key
        @pattern("^[a-zA-Z0-9-]{1,127}$")
        keyName: string,
      }
    > {}

@armResourceOperations
interface ManagedHsmKeys {
  /**
   * Gets the current version of the specified key from the specified managed HSM.
   */
  get is ManagedHsmKeyOps.Read<ManagedHsmKey, OverrideErrorType = CloudError>;

  /**
   * Creates the first version of a new key if it does not exist. If it already exists, then the existing key is returned without any write operations being performed. This API does not create subsequent versions, and does not update existing keys.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createIfNotExist is ManagedHsmKeyOps.CreateOrUpdateSync<
    ManagedHsmKey,
    Request = ManagedHsmKeyCreateParameters,
    Response = ArmResourceUpdatedResponse<ManagedHsmKey>,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists the keys in the specified managed HSM.
   */
  list is ManagedHsmKeyOps.List<ManagedHsmKey, OverrideErrorType = CloudError>;
}
@armResourceOperations
interface ManagedHsmKeyOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the Managed HSM Pool within the specified resource group. */
        @path
        @segment("managedHSMs")
        @key
        @minLength(3)
        @maxLength(24)
        @pattern("^[A-Za-z]([A-Za-z0-9]|\\-[A-Za-z0-9])+$")
        name: string,

        /** The name of the key to be created. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information. */
        @path
        @segment("keys")
        @key
        @pattern("^[a-zA-Z0-9-]{1,127}$")
        keyName: string,
      },
      {
        /** The version of the key to be retrieved. */
        @path
        @segment("versions")
        @key
        @pattern("^[a-fA-F0-9]{32}$")
        keyVersion: string,
      }
    > {}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ManagedHsmKeyOperationGroup {
  /**
   * Gets the specified version of the specified key in the specified managed HSM.
   */
  getVersion is ManagedHsmKeyOperationGroupOps.Read<
    ManagedHsmKey,
    OverrideErrorType = CloudError
  >;

  /**
   * Lists the keys in the specified managed HSM.
   */
  listVersions is ManagedHsmKeyOperationGroupOps.List<
    ManagedHsmKey,
    OverrideErrorType = CloudError
  >;
}

@@doc(ManagedHsmKey.name,
  "The name of the key to be created. The value you provide may be copied globally for the purpose of running the service. The value provided should not include personally identifiable or sensitive information."
);
@@doc(ManagedHsmKey.properties, "The properties of the key.");
@@doc(ManagedHsmKeys.createIfNotExist::parameters.resource,
  "The parameters used to create the specified key."
);
