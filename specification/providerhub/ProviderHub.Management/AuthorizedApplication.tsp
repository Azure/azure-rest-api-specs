import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ProviderRegistration.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.ProviderHub;

@parentResource(ProviderRegistration)
model AuthorizedApplication
  is Azure.ResourceManager.ProxyResource<AuthorizedApplicationProperties> {
  ...ResourceNameParameter<
    Resource = AuthorizedApplication,
    KeyName = "applicationId",
    SegmentName = "authorizedApplications",
    NamePattern = ""
  >;
}

@armResourceOperations
interface AuthorizedApplications {
  /**
   * Gets the authorized application details.
   */
  get is ArmResourceRead<AuthorizedApplication>;

  /**
   * Creates or updates the authorized application.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AuthorizedApplication>;

  /**
   * Deletes an authorized application.
   */
  delete is ArmResourceDeleteSync<AuthorizedApplication>;

  /**
   * Gets the list of the authorized applications in the provider namespace.
   */
  list is ArmResourceListByParent<
    AuthorizedApplication,
    Response = ArmResponse<AuthorizedApplicationArrayResponseWithContinuation>
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@format(AuthorizedApplication.name, "uuid");
@@doc(AuthorizedApplication.name, "The application ID.");
@@doc(AuthorizedApplication.properties, "");
@@doc(AuthorizedApplications.createOrUpdate::parameters.resource,
  "The authorized application properties supplied to the CreateOrUpdate operation."
);
