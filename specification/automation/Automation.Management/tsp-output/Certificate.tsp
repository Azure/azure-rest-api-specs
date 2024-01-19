import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AutomationAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automation;
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
interface Certificates {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve the certificate identified by certificate name.")
  @operationId("Certificate_Get")
  get is ArmResourceRead<Certificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create a certificate.")
  @operationId("Certificate_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<Certificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Update a certificate.")
  @operationId("Certificate_Update")
  update is ArmCustomPatchSync<Certificate, CertificateUpdateParameters>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the certificate.")
  @operationId("Certificate_Delete")
  delete is ArmResourceDeleteSync<Certificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Retrieve a list of certificates.")
  @operationId("Certificate_ListByAutomationAccount")
  listByAutomationAccount is ArmResourceListByParent<Certificate>;
}

@@projectedName(Certificates.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Certificates.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Certificates.createOrUpdate::parameters.resource,
  "The parameters supplied to the create or update certificate operation."
);
@@projectedName(Certificates.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(Certificates.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Certificates.update::parameters.properties,
  "The parameters supplied to the update certificate operation."
);
