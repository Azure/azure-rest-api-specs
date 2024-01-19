import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.DataShare;

interface EmailRegistrationsOperations {
  @summary("Activates the tenant and email combination using email code received.")
  @doc("Activate the email registration for the current tenant")
  @route("/providers/Microsoft.DataShare/locations/{location}/activateEmail")
  @post
  activateEmail is Azure.Core.Foundations.Operation<
    {
      @doc("Location of the activation.")
      @path
      location: string;

      @doc("The payload for tenant domain activation.")
      @body
      emailRegistration: EmailRegistration;
    },
    EmailRegistration
  >;

  @summary("Registers the tenant and email combination for verification.")
  @doc("Register an email for the current tenant")
  @route("/providers/Microsoft.DataShare/locations/{location}/registerEmail")
  @post
  registerEmail is Azure.Core.Foundations.Operation<
    {
      @doc("Location of the registration")
      @path
      location: string;
    },
    EmailRegistration
  >;
}
