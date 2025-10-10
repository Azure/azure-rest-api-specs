import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./DomainResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * A class representing a SenderUsername resource.
 */
@parentResource(DomainResource)
model SenderUsernameResource
  is Azure.ResourceManager.ProxyResource<SenderUsernameProperties> {
  ...ResourceNameParameter<
    Resource = SenderUsernameResource,
    KeyName = "senderUsername",
    SegmentName = "senderUsernames",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SenderUsernames {
  /**
   * Get a valid sender username for a domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  get is ArmResourceRead<SenderUsernameResource>;

  /**
   * Add a new SenderUsername resource under the parent Domains resource or update an existing SenderUsername resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<SenderUsernameResource>;

  /**
   * Operation to delete a SenderUsernames resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteSync<SenderUsernameResource>;

  /**
   * List all valid sender usernames for a domains resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  listByDomains is ArmResourceListByParent<
    SenderUsernameResource,
    Response = ArmResponse<SenderUsernameResourceCollection>
  >;
}

@@maxLength(SenderUsernameResource.name, 253);
@@minLength(SenderUsernameResource.name, 1);
@@doc(SenderUsernameResource.name, "The valid sender Username.");
@@doc(SenderUsernameResource.properties,
  "The properties of a SenderUsername resource."
);
@@doc(SenderUsernames.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
