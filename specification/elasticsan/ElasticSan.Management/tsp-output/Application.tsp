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

namespace Microsoft.Security;
@doc("Security Application over a given scope")
@subscriptionResource
model Application is ProxyResource<ApplicationProperties> {
  @doc("The security Application key - unique key for the standard application")
  @path
  @key("applicationId")
  @segment("applications")
  name: string;
}

@armResourceOperations
interface Applications {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a specific application for the requested scope by applicationId")
  @operationId("Application_Get")
  get is ArmResourceRead<Application>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or update a security application on the given subscription.")
  @operationId("Application_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Application>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete an Application over a given scope")
  @operationId("Application_Delete")
  delete is ArmResourceDeleteSync<Application>;

  @doc("Get a list of all relevant applications over a subscription level scope")
  list is ArmResourceListByParent<Application>;
}

@@projectedName(Applications.createOrUpdate::parameters.resource,
  "json",
  "application"
);
@@extension(Applications.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "application"
);
@@doc(Applications.createOrUpdate::parameters.resource,
  "Application over a subscription scope"
);
