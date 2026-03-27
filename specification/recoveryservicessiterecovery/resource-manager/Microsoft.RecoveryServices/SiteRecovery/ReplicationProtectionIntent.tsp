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
@parentResource(Vault)
model ReplicationProtectionIntent
  is Azure.ResourceManager.ProxyResource<ReplicationProtectionIntentProperties> {
  ...ResourceNameParameter<
    Resource = ReplicationProtectionIntent,
    KeyName = "intentObjectName",
    SegmentName = "replicationProtectionIntents",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ReplicationProtectionIntents {
  /**
   * Gets the details of an ASR replication protection intent.
   */
  @summary("Gets the details of a Replication protection intent item.")
  get is ArmResourceRead<ReplicationProtectionIntent, Error = never>;

  /**
   * The operation to create an ASR replication protection intent item.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create protection intent Resource.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateSync<
    ReplicationProtectionIntent,
    Request = CreateProtectionIntentInput,
    Response = ArmResourceUpdatedResponse<ReplicationProtectionIntent>,
    Error = never
  >;

  /**
   * Gets the list of ASR replication protection intent objects in the vault.
   */
  @summary("Gets the list of replication protection intent objects.")
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
    Response = ArmResponse<ReplicationProtectionIntentCollection>,
    Error = never
  >;
}

@@doc(ReplicationProtectionIntent.name, "Replication protection intent name.");
@@doc(ReplicationProtectionIntent.properties, "The custom data.");
@@doc(ReplicationProtectionIntents.create::parameters.resource,
  "Create Protection Intent Input."
);
