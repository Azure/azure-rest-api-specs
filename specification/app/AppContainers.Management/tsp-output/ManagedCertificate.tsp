import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.App;
@doc("Managed certificates used for Custom Domain bindings of Container Apps in a Managed Environment")
model ManagedCertificate is TrackedResource<ManagedCertificateProperties> {
  @doc("Name of the Managed Certificate.")
  @path
  @key("managedCertificateName")
  @segment("managedCertificates")
  name: string;
}

@armResourceOperations
interface ManagedCertificates {
  @doc("Get the specified Managed Certificate.")
  get is ArmResourceRead<ManagedCertificate>;

  @doc("Create or Update a Managed Certificate.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ManagedCertificate,
    BaseParameters<ManagedCertificate>,
    ArmAsyncOperationHeader
  >;

  @doc("Patches a managed certificate. Oly patching of tags is supported")
  update is ArmCustomPatchSync<ManagedCertificate, ManagedCertificatePatch>;

  @doc("Deletes the specified Managed Certificate.")
  delete is ArmResourceDeleteSync<ManagedCertificate>;

  @doc("Get the Managed Certificates in a given managed environment.")
  list is ArmResourceListByParent<ManagedCertificate>;
}

@@projectedName(ManagedCertificates.createOrUpdate::parameters.resource,
  "json",
  "managedCertificateEnvelope"
);
@@extension(ManagedCertificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "managedCertificateEnvelope"
);
@@doc(ManagedCertificates.createOrUpdate::parameters.resource,
  "Managed Certificate to be created or updated"
);
@@projectedName(ManagedCertificates.update::parameters.properties,
  "json",
  "managedCertificateEnvelope"
);
@@extension(ManagedCertificates.update::parameters.properties,
  "x-ms-client-name",
  "managedCertificateEnvelope"
);
@@doc(ManagedCertificates.update::parameters.properties,
  "Properties of a managed certificate that need to be updated"
);
