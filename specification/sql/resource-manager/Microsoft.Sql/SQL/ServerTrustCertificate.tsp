import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Server trust certificate imported from box to enable connection between box and Sql Managed Instance.
 */
@parentResource(ManagedInstance)
model ServerTrustCertificate
  is Azure.ResourceManager.ProxyResource<ServerTrustCertificateProperties> {
  ...ResourceNameParameter<
    Resource = ServerTrustCertificate,
    KeyName = "certificateName",
    SegmentName = "serverTrustCertificates",
    NamePattern = ""
  >;
}

@armResourceOperations
interface ServerTrustCertificates {
  /**
   * Gets a server trust certificate that was uploaded from SQL Server to SQL Managed Instance.
   */
  get is ArmResourceRead<ServerTrustCertificate>;

  /**
   * Uploads a server trust certificate from SQL Server to SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ServerTrustCertificate,
    Response = ArmResourceUpdatedResponse<ServerTrustCertificate> | ArmResourceCreatedResponse<
      ServerTrustCertificate,
      ArmLroLocationHeader<FinalResult = ServerTrustCertificate> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes a server trust certificate that was uploaded from SQL Server to SQL Managed Instance.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ServerTrustCertificate,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of the server trust certificates used to secure communication between SQL Server and the specified SQL Managed Instance
   */
  listByInstance is ArmResourceListByParent<ServerTrustCertificate>;
}

@@doc(ServerTrustCertificate.name, "Name of of the certificate to get.");
@@doc(ServerTrustCertificate.properties, "Resource properties.");
@@doc(ServerTrustCertificates.createOrUpdate::parameters.resource,
  "The server trust certificate info."
);
