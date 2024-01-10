import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Automation;
@doc("Definition of the credential.")
@parentResource(AutomationAccount)
model Credential is ProxyResource<CredentialProperties> {
  @doc("The name of credential.")
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
@projectedName("client", "Credential")
interface Credentials_Credential {
  @doc("Retrieve the credential identified by credential name.")
  get is ArmResourceRead<Credential>;

  @doc("Create a credential.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Credential>;

  @doc("Update a credential.")
  update is ArmCustomPatchSync<Credential, CredentialUpdateParameters>;

  @doc("Delete the credential.")
  delete is ArmResourceDeleteSync<Credential>;

  @doc("Retrieve a list of credentials.")
  listByAutomationAccount is ArmResourceListByParent<Credential>;
}
