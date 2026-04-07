import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DataBoxEdgeDevice.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataBoxEdge;
// FIXME: Role has no properties property
/**
 * Compute role.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy DiscriminatedProxyResource for back compatibility"
@discriminator("kind")
@parentResource(DataBoxEdgeDevice)
model Role
  is Azure.ResourceManager.Legacy.DiscriminatedProxyResource<RoleTypes> {
  ...ResourceNameParameter<
    Resource = Role,
    KeyName = "name",
    SegmentName = "roles",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Roles {
  /**
   * Gets a specific role by name.
   */
  get is ArmResourceRead<Role, Error = CloudError>;

  /**
   * Create or update a role.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Role,
    Response = ArmResourceUpdatedResponse<Role> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = Role> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Deletes the role on the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    Role,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Lists all the roles configured in a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Role,
    Response = ArmResponse<RoleList>,
    Error = CloudError
  >;
}

@@doc(Role.name, "The role name.");
@@doc(Roles.createOrUpdate::parameters.resource, "The role properties.");
@@doc(Role.kind, "Role type.");
