import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Automation;
@doc("Definition of the credential.")
@parentResource(AutomationAccount)
model AutomationCredential is ProxyResource<CredentialProperties> {
  @doc("The name of credential.")
  @path
  @key("credentialName")
  @segment("credentials")
  name: string;
}

@armResourceOperations
interface AutomationCredentials {
  @doc("Retrieve the credential identified by credential name.")
  get is ArmResourceRead<AutomationCredential>;
  @doc("Create a credential.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationCredential>;
  @doc("Update a credential.")
  update is ArmResourcePatchSync<AutomationCredential, CredentialProperties>;
  @doc("Delete the credential.")
  delete is ArmResourceDeleteSync<AutomationCredential>;
  @doc("Retrieve a list of credentials.")
  listByAutomationAccount is ArmResourceListByParent<AutomationCredential>;
}
