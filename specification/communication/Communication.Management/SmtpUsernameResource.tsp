import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CommunicationServiceResource.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Communication;
/**
 * The object describing the smtp username resource.
 */
@parentResource(CommunicationServiceResource)
model SmtpUsernameResource
  is Azure.ResourceManager.ProxyResource<SmtpUsernameProperties> {
  ...ResourceNameParameter<
    Resource = SmtpUsernameResource,
    KeyName = "smtpUsername",
    SegmentName = "smtpUsernames",
    NamePattern = "^[a-zA-Z0-9-]+$"
  >;
}

@armResourceOperations
interface SmtpUsernames {
  /**
   * Get a SmtpUsernameResource.
   */
  @summary("Get")
  get is ArmResourceRead<SmtpUsernameResource>;

  /**
   * Create or update an SmtpUsernameResource.
   */
  @summary("Create Or Update")
  createOrUpdate is ArmResourceCreateOrReplaceSync<SmtpUsernameResource>;

  /**
   * Operation to delete a single SmtpUsername resource.
   */
  @summary("Delete")
  delete is ArmResourceDeleteSync<SmtpUsernameResource>;

  /**
   * Get all SmtpUsernameResources for a Communication resource.
   */
  @summary("Get")
  list is ArmResourceListByParent<
    SmtpUsernameResource,
    Response = ArmResponse<SmtpUsernameResourceCollection>
  >;
}

@@maxLength(SmtpUsernameResource.name, 253);
@@minLength(SmtpUsernameResource.name, 1);
@@doc(SmtpUsernameResource.name, "The name of the SmtpUsernameResource.");
@@doc(SmtpUsernameResource.properties,
  "The properties of a SmtpUsername resource."
);
@@doc(SmtpUsernames.createOrUpdate::parameters.resource,
  "Parameters for the create or update operation"
);
