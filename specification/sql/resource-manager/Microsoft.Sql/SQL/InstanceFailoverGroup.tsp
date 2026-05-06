import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * An instance failover group.
 */
@parentResource(ResourceGroupLocationResource)
model InstanceFailoverGroup
  is Azure.ResourceManager.ProxyResource<InstanceFailoverGroupProperties> {
  ...ResourceNameParameter<
    Resource = InstanceFailoverGroup,
    KeyName = "failoverGroupName",
    SegmentName = "instanceFailoverGroups",
    NamePattern = ""
  >;
}

alias InstanceFailoverGroupsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the region where the resource is located. */
    @path
    @segment("locations")
    @key
    locationName: string;
  },
  {
    /** The name of the failover group. */
    @path
    @segment("instanceFailoverGroups")
    @key
    failoverGroupName: string;
  }
>;

@armResourceOperations
interface InstanceFailoverGroups {
  /**
   * Gets a failover group.
   */
  get is InstanceFailoverGroupsOps.Read<InstanceFailoverGroup>;

  /**
   * Creates or updates a failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is InstanceFailoverGroupsOps.CreateOrUpdateAsync<
    InstanceFailoverGroup,
    Response = ArmResourceUpdatedResponse<InstanceFailoverGroup> | ArmResourceCreatedResponse<
      InstanceFailoverGroup,
      ArmLroLocationHeader<FinalResult = InstanceFailoverGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is InstanceFailoverGroupsOps.DeleteWithoutOkAsync<
    InstanceFailoverGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the failover groups in a location.
   */
  listByLocation is InstanceFailoverGroupsOps.List<InstanceFailoverGroup>;

  /**
   * Fails over from the current primary managed instance to this managed instance.
   */
  failover is InstanceFailoverGroupsOps.ActionAsync<
    InstanceFailoverGroup,
    void,
    void,
    Response = ArmResponse<InstanceFailoverGroup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = InstanceFailoverGroup> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Fails over from the current primary managed instance to this managed instance. This operation might result in data loss.
   */
  forceFailoverAllowDataLoss is InstanceFailoverGroupsOps.ActionAsync<
    InstanceFailoverGroup,
    void,
    void,
    Response = ArmResponse<InstanceFailoverGroup> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = InstanceFailoverGroup> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;
}

@@doc(InstanceFailoverGroup.name, "The name of the failover group.");
@@doc(InstanceFailoverGroup.properties, "Resource properties.");
@@doc(InstanceFailoverGroups.createOrUpdate::parameters.resource,
  "The failover group parameters."
);
