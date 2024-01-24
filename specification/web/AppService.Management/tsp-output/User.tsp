import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * User credentials used for publishing activity.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@singleton("web")
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(UserProperties)
@includeInapplicableMetadataInPayload(false)
model User extends ProxyOnlyResource {
  @key("publishingUser")
  @segment("publishingUsers")
  name: string;

  /**
   * User resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: UserProperties;
}

@armResourceOperations
interface Users {
  /**
   * Description for Gets publishing user
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GetPublishingUser")
  getPublishingUser is ArmResourceRead<User>;

  /**
   * Description for Updates publishing user
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("UpdatePublishingUser")
  updatePublishingUser is ArmResourceCreateOrReplaceSync<User>;
}

@@projectedName(Users.updatePublishingUser::parameters.resource,
  "json",
  "userDetails"
);
@@extension(Users.updatePublishingUser::parameters.resource,
  "x-ms-client-name",
  "userDetails"
);
@@doc(Users.updatePublishingUser::parameters.resource,
  "Details of publishing user"
);
