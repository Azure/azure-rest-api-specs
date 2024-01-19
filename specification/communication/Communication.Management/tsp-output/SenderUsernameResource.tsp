import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
@doc("A class representing a SenderUsername resource.")
@parentResource(DomainResource)
model SenderUsernameResource is ProxyResource<SenderUsernameProperties> {
  @doc("The valid sender Username.")
  @maxLength(253)
  @minLength(1)
  @path
  @key("senderUsername")
  @segment("senderUsernames")
  name: string;
}

@armResourceOperations
interface SenderUsernameResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get a valid sender username for a domains resource.")
  @operationId("SenderUsernames_Get")
  get is ArmResourceRead<SenderUsernameResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Add a new SenderUsername resource under the parent Domains resource or update an existing SenderUsername resource.")
  @operationId("SenderUsernames_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SenderUsernameResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Operation to delete a SenderUsernames resource.")
  @operationId("SenderUsernames_Delete")
  delete is ArmResourceDeleteSync<SenderUsernameResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all valid sender usernames for a domains resource.")
  @operationId("SenderUsernames_ListByDomains")
  listByDomains is ArmResourceListByParent<SenderUsernameResource>;
}

@@projectedName(SenderUsernameResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SenderUsernameResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SenderUsernameResources.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
