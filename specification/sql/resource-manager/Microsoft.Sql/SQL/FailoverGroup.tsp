import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Server.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A failover group.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(Server)
model FailoverGroup
  is Azure.ResourceManager.ProxyResource<FailoverGroupProperties> {
  ...ResourceNameParameter<
    Resource = FailoverGroup,
    KeyName = "failoverGroupName",
    SegmentName = "failoverGroups",
    NamePattern = ""
  >;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * Resource location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface FailoverGroups {
  /**
   * Gets a failover group.
   */
  get is ArmResourceRead<FailoverGroup>;

  /**
   * Creates or updates a failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    FailoverGroup,
    Response = ArmResourceUpdatedResponse<FailoverGroup> | ArmResourceCreatedResponse<
      FailoverGroup,
      ArmLroLocationHeader<FinalResult = FailoverGroup> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Updates a failover group.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    FailoverGroup,
    PatchModel = FailoverGroupUpdate
  >;

  /**
   * Deletes a failover group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    FailoverGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the failover groups in a server.
   */
  listByServer is ArmResourceListByParent<FailoverGroup>;

  /**
   * Fails over from the current primary server to this server.
   */
  failover is ArmResourceActionAsync<
    FailoverGroup,
    void,
    Response = FailoverGroup
  >;

  /**
   * Fails over from the current primary server to this server. This operation might result in data loss.
   */
  forceFailoverAllowDataLoss is ArmResourceActionAsync<
    FailoverGroup,
    void,
    Response = FailoverGroup
  >;

  /**
   * Fails over from the current primary server to this server. This operation tries planned before forced failover but might still result in data loss.
   */
  tryPlannedBeforeForcedFailover is ArmResourceActionAsync<
    FailoverGroup,
    void,
    Response = FailoverGroup
  >;
}

@@doc(FailoverGroup.name, "The name of the failover group.");
@@doc(FailoverGroup.properties, "Resource properties.");
@@doc(FailoverGroups.createOrUpdate::parameters.resource,
  "The failover group parameters."
);
@@doc(FailoverGroups.update::parameters.properties,
  "The failover group parameters."
);
