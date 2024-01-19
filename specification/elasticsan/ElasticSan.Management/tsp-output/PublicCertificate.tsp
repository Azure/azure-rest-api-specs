import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
@doc("Public certificate object")
@parentResource(Site)
model PublicCertificate is ProxyResource<PublicCertificateProperties> {
  @doc("Public certificate name.")
  @path
  @key("publicCertificateName")
  @segment("publicCertificates")
  name: string;
}

@armResourceOperations
interface PublicCertificates {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get the named public certificate for an app (or deployment slot, if specified).")
  @operationId("WebApps_GetPublicCertificate")
  getPublicCertificate is ArmResourceRead<PublicCertificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Creates a hostname binding for an app.")
  @operationId("WebApps_CreateOrUpdatePublicCertificate")
  createOrUpdatePublicCertificate is ArmResourceCreateOrReplaceSync<PublicCertificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Deletes a hostname binding for an app.")
  @operationId("WebApps_DeletePublicCertificate")
  deletePublicCertificate is ArmResourceDeleteSync<PublicCertificate>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Get public certificates for an app or a deployment slot.")
  @operationId("WebApps_ListPublicCertificates")
  listPublicCertificates is ArmResourceListByParent<PublicCertificate>;
}

@@projectedName(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "json",
  "publicCertificate"
);
@@extension(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "x-ms-client-name",
  "publicCertificate"
);
@@doc(PublicCertificates.createOrUpdatePublicCertificate::parameters.resource,
  "Public certificate details. This is the JSON representation of a PublicCertificate object."
);
