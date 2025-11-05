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
@parentResource(DataBoxEdgeDevice)
model Role is Azure.ResourceManager.ProxyResource<{}> {
  ...ResourceNameParameter<
    Resource = Role,
    KeyName = "name",
    SegmentName = "roles",
    NamePattern = ""
  >;

  /**
   * Role type.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  kind: RoleTypes;
}

@armResourceOperations
interface Roles {
  /**
   * Gets a specific role by name.
   */
  get is ArmResourceRead<Role>;

  /**
   * Create or update a role.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Role,
    Response = ArmResourceUpdatedResponse<Role> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader<FinalResult = Role> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes the role on the device.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Role,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Lists all the roles configured in a Data Box Edge/Data Box Gateway device.
   */
  listByDataBoxEdgeDevice is ArmResourceListByParent<
    Role,
    Response = ArmResponse<RoleList>
  >;
}

@@doc(Role.name, "The role name.");
@@doc(Roles.createOrUpdate::parameters.resource, "The role properties.");
