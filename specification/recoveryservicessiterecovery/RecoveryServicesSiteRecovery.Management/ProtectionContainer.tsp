import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Protection container details.
 */
@parentResource(Fabric)
model ProtectionContainer
  is Azure.ResourceManager.ProxyResource<ProtectionContainerProperties> {
  ...ResourceNameParameter<
    Resource = ProtectionContainer,
    KeyName = "protectionContainerName",
    SegmentName = "replicationProtectionContainers",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias ReplicationProtectionContainersOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    resourceName: string;

    /** Fabric name. */
    @path
    @segment("replicationFabrics")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    fabricName: string;
  },
  {
    /** Protection container name. */
    @path
    @segment("replicationProtectionContainers")
    @key
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]*[A-Za-z0-9]$")
    protectionContainerName: string;
  }
>;

model ProtectionContainerAcceptedLroResponse<FinalResult extends TypeSpec.Reflection.Model | unknown | void = ProtectionContainer>
  is ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = FinalResult> &
    Azure.Core.Foundations.RetryAfterHeader>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface ProtectionContainers {
  /**
   * Gets the details of a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the protection container details.")
  get is ArmResourceRead<ProtectionContainer, Error = never>;

  /**
   * Operation to create a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create a protection container.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    ProtectionContainer,
    Request = CreateProtectionContainerInput,
    Response = ArmResourceUpdatedResponse<ProtectionContainer> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ProtectionContainer> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = never
  >;

  /**
   * Lists the protection containers in the specified fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of protection container for a fabric.")
  listByReplicationFabrics is ArmResourceListByParent<
    ProtectionContainer,
    Response = ArmResponse<ProtectionContainerCollection>,
    Error = never
  >;

  /**
   * The operation to a add a protectable item to a protection container(Add physical server).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Adds a protectable item to the replication protection container.")
  discoverProtectableItem is ArmResourceActionAsyncBase<
    ProtectionContainer,
    DiscoverProtectableItemRequest,
    ArmResponse<ProtectionContainer> | ProtectionContainerAcceptedLroResponse,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ProtectionContainer>,
    Error = never
  >;

  /**
   * Operation to remove a protection container.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("remove")
  @summary("Removes a protection container.")
  delete is ArmResourceActionAsyncBase<
    ProtectionContainer,
    void,
    NoContentResponse | ProtectionContainerAcceptedLroResponse<void>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ProtectionContainer>,
    Error = never
  >;

  /**
   * Operation to switch protection from one container to another.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Switches protection from one container to another.")
  switchClusterProtection is ReplicationProtectionContainersOps.ActionAsync<
    ProtectionContainer,
    SwitchClusterProtectionInput,
    ArmResponse<ProtectionContainer>,
    LroHeaders = ArmLroLocationHeader<FinalResult = ProtectionContainer> &
      ArmAsyncOperationHeader &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Operation to switch protection from one container to another or one replication provider to another.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("switchprotection")
  @summary("Switches protection from one container to another or one replication provider to another.")
  switchProtection is ArmResourceActionAsyncBase<
    ProtectionContainer,
    SwitchProtectionInput,
    ArmResponse<ProtectionContainer> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = ProtectionContainer> &
      ArmAsyncOperationHeader<FinalResult = ProtectionContainer> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Azure.ResourceManager.Foundations.DefaultBaseParameters<ProtectionContainer>,
    Error = never
  >;
}

@@doc(ProtectionContainer.name, "Protection container name.");
@@doc(ProtectionContainer.properties, "The custom data.");
@@doc(ProtectionContainers.create::parameters.resource, "Creation input.");
@@doc(ProtectionContainers.discoverProtectableItem::parameters.body,
  "The request object to add a protectable item."
);
@@doc(ProtectionContainers.switchClusterProtection::parameters.body,
  "Switch protection input."
);
@@doc(ProtectionContainers.switchProtection::parameters.body,
  "Switch protection input."
);
