import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CodeSigningAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CodeSigning;
@doc("Certificate profile resource.")
@parentResource(CodeSigningAccount)
model CertificateProfile is ProxyResource<CertificateProfileProperties> {
  @doc("Certificate profile name.")
  @pattern("^(?=.{5,100}$)[^0-9][A-Za-z0-9]+(?:-[A-Za-z0-9]+)*$")
  @path
  @key("profileName")
  @segment("certificateProfiles")
  name: string;
}

@armResourceOperations
interface CertificateProfiles {
  @doc("Get details of a certificate profile.")
  get is ArmResourceRead<CertificateProfile>;

  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @doc("Create a certificate profile.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  create is ArmResourceCreateOrReplaceAsync<
    CertificateProfile,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  @doc("Delete a certificate profile.")
  delete is ArmResourceDeleteWithoutOkAsync<CertificateProfile>;

  @doc("List certificate profiles under a trusted signing account.")
  listByCodeSigningAccount is ArmResourceListByParent<CertificateProfile>;

  @doc("Revoke a certificate under a certificate profile.")
  revokeCertificate is ArmResourceActionNoContentSync<
    CertificateProfile,
    RevokeCertificate
  >;
}

@@doc(CertificateProfiles.create::parameters.resource,
  "Parameters to create the certificate profile"
);
@@doc(CertificateProfiles.revokeCertificate::parameters.body,
  "Parameters to revoke the certificate profile"
);
