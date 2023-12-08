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
model AutomationCertificate is ProxyResource<CertificateProperties> {
  @doc("The name of certificate.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface AutomationCertificates {
  @doc("Retrieve the certificate identified by certificate name.")
  get is ArmResourceRead<AutomationCertificate>;
  @doc("Create a certificate.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AutomationCertificate>;
  @doc("Update a certificate.")
  update is ArmResourcePatchSync<AutomationCertificate, CertificateProperties>;
  @doc("Delete the certificate.")
  delete is ArmResourceDeleteSync<AutomationCertificate>;
  @doc("Retrieve a list of certificates.")
  listByAutomationAccount is ArmResourceListByParent<AutomationCertificate>;
}
