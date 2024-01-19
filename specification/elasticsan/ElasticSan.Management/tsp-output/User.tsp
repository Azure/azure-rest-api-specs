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
@doc("User credentials used for publishing activity.")
@singleton("web")
@tenantResource
model User is ProxyResource<UserProperties> {
  @key("publishingUser")
  @segment("publishingUsers")
  name: string;
}

@armResourceOperations
interface Users {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets publishing user")
  @operationId("GetPublishingUser")
  getPublishingUser is ArmResourceRead<User>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates publishing user")
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
