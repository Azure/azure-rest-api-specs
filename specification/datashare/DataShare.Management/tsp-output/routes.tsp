import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataShare;

interface EmailRegistrationsOperations {
  /**
   * Activate the email registration for the current tenant
   */
  @summary("Activates the tenant and email combination using email code received.")
  @route("/providers/Microsoft.DataShare/locations/{location}/activateEmail")
  @post
  activateEmail is Azure.Core.Foundations.Operation<
    {
      /**
       * Location of the activation.
       */
      @path
      location: string;

      /**
       * The payload for tenant domain activation.
       */
      @body
      emailRegistration: EmailRegistration;
    },
    EmailRegistration
  >;

  /**
   * Register an email for the current tenant
   */
  @summary("Registers the tenant and email combination for verification.")
  @route("/providers/Microsoft.DataShare/locations/{location}/registerEmail")
  @post
  registerEmail is Azure.Core.Foundations.Operation<
    {
      /**
       * Location of the registration
       */
      @path
      location: string;
    },
    EmailRegistration
  >;
}
