import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Replication protection intent.
 */
model ReplicationProtectionIntent
  is Azure.ResourceManager.ProxyResource<ReplicationProtectionIntentProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationProtectionIntent,
    KeyName = "intentObjectName",
    SegmentName = "replicationProtectionIntents",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ReplicationProtectionIntents {
  /**
   * Gets the details of an ASR replication protection intent.
   */
  get is ArmResourceRead<ReplicationProtectionIntent>;

  /**
   * The operation to create an ASR replication protection intent item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  create is ArmResourceCreateOrReplaceSync<
    ReplicationProtectionIntent,
    Response = ArmResourceUpdatedResponse<ReplicationProtectionIntent>
  >;

  /**
   * Gets the list of ASR replication protection intent objects in the vault.
   */
  list is ArmResourceListByParent<
    ReplicationProtectionIntent,
    Parameters = {
      /**
       * The pagination token.
       */
      @query("skipToken")
      skipToken?: string;

      /**
       * The page size.
       */
      @query("takeToken")
      takeToken?: string;
    },
    Response = ArmResponse<ReplicationProtectionIntentCollection>
  >;
}

@@doc(ReplicationProtectionIntent.name, "Replication protection intent name.");
@@doc(ReplicationProtectionIntent.properties, "The custom data.");
@@doc(ReplicationProtectionIntents.create::parameters.resource,
  "Create Protection Intent Input."
);
