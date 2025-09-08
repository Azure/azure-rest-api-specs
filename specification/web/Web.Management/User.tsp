import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * User credentials used for publishing activity.
 */
@singleton("web")
@tenantResource
model User is Azure.ResourceManager.ProxyResource<UserProperties> {
  ...ResourceNameParameter<
    Resource = User,
    KeyName = "publishingUser",
    SegmentName = "publishingUsers",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface Users {
  /**
   * Description for Gets publishing user
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("GetPublishingUser")
  getPublishingUser is ArmResourceRead<
    User,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Updates publishing user
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("UpdatePublishingUser")
  updatePublishingUser is ArmResourceCreateOrReplaceSync<
    User,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = ArmResourceUpdatedResponse<User>,
    Error = DefaultErrorResponse
  >;
}

@@doc(User.name, "");
@@doc(User.properties, "User resource specific properties");
@@doc(Users.updatePublishingUser::parameters.resource,
  "Details of publishing user"
);
