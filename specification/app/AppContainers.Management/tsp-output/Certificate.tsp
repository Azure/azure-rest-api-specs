import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConnectedEnvironment.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
@doc("Certificate used for Custom Domain bindings of Container Apps in a Managed Environment")
@parentResource(ConnectedEnvironment)
model Certificate is TrackedResource<CertificateProperties> {
  @doc("Name of the Certificate.")
  @path
  @key("certificateName")
  @segment("certificates")
  name: string;
}

@armResourceOperations
interface Certificates {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the specified Certificate.")
  @operationId("ConnectedEnvironmentsCertificates_Get")
  get is ArmResourceRead<Certificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or Update a Certificate.")
  @operationId("ConnectedEnvironmentsCertificates_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patches a certificate. Currently only patching of tags is supported")
  @operationId("ConnectedEnvironmentsCertificates_Update")
  update is ArmCustomPatchSync<Certificate, CertificatePatch>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the specified Certificate.")
  @operationId("ConnectedEnvironmentsCertificates_Delete")
  delete is ArmResourceDeleteSync<Certificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the Certificates in a given connected environment.")
  @operationId("ConnectedEnvironmentsCertificates_List")
  list is ArmResourceListByParent<Certificate>;
}

@@projectedName(Certificates.createOrUpdate::parameters.resource,
  "json",
  "certificateEnvelope"
);
@@extension(Certificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "certificateEnvelope"
);
@@doc(Certificates.createOrUpdate::parameters.resource,
  "Certificate to be created or updated"
);
@@projectedName(Certificates.update::parameters.properties,
  "json",
  "certificateEnvelope"
);
@@extension(Certificates.update::parameters.properties,
  "x-ms-client-name",
  "certificateEnvelope"
);
@@doc(Certificates.update::parameters.properties,
  "Properties of a certificate that need to be updated"
);
