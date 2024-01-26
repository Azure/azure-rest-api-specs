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
/**
 * A class representing a SenderUsername resource.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(DomainResource)
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SenderUsernameProperties)
model SenderUsernameResource extends ProxyResourceBase {
  /**
   * The valid sender Username.
   */
  @maxLength(253)
  @minLength(1)
  @path
  @key("senderUsername")
  @segment("senderUsernames")
  @visibility("read")
  name: string;

  /**
   * The properties of a SenderUsername resource.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SenderUsernameProperties;
}

@armResourceOperations
interface SenderUsernameResources {
  /**
   * Get a valid sender username for a domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SenderUsernames_Get")
  get is ArmResourceRead<SenderUsernameResource>;

  /**
   * Add a new SenderUsername resource under the parent Domains resource or update an existing SenderUsername resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SenderUsernames_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SenderUsernameResource>;

  /**
   * Operation to delete a SenderUsernames resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SenderUsernames_Delete")
  delete is ArmResourceDeleteSync<SenderUsernameResource>;

  /**
   * List all valid sender usernames for a domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
