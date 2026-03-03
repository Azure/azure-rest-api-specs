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

@armResourceOperations
interface InstanceFailoverGroups {
  /**
   * Gets a failover group.
   */
  get is ArmResourceRead<InstanceFailoverGroup>;

  /**
   * Creates or updates a failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    InstanceFailoverGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the failover groups in a location.
   */
  listByLocation is ArmResourceListByParent<InstanceFailoverGroup>;

  /**
   * Fails over from the current primary managed instance to this managed instance.
   */
  failover is ArmResourceActionAsync<
    InstanceFailoverGroup,
    void,
    ArmResponse<InstanceFailoverGroup>
  >;

  /**
   * Fails over from the current primary managed instance to this managed instance. This operation might result in data loss.
   */
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    InstanceFailoverGroup,
    void,
    ArmResponse<InstanceFailoverGroup>
  >;
}

@@doc(InstanceFailoverGroup.name, "The name of the failover group.");
@@doc(InstanceFailoverGroup.properties, "Resource properties.");
@@doc(InstanceFailoverGroups.createOrUpdate::parameters.resource,
  "The failover group parameters."
);
