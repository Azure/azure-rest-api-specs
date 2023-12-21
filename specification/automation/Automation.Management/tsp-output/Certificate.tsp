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
@doc("Definition of the certificate.")
@parentResource(AutomationAccount)
model Certificate is ProxyResource<CertificateProperties> {
  @doc("The name of certificate.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface Certificate {
  @doc("Retrieve the certificate identified by certificate name.")
  get is ArmResourceRead<Certificate>;
  @doc("Create a certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;
  @doc("Update a certificate.")
  update is ArmResourcePatchSync<Certificate, CertificateProperties>;
  @doc("Delete the certificate.")
  delete is ArmResourceDeleteSync<Certificate>;
  @doc("Retrieve a list of certificates.")
  listByAutomationAccount is ArmResourceListByParent<Certificate>;
}
