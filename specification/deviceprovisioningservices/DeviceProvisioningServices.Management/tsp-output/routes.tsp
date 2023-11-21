import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace iotDpsClient;

interface OperationsOperations {
  @doc("Lists all of the available Microsoft.Devices REST API operations.")
  @route("/providers/Microsoft.Devices/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface DpsCertificateOperations {
  @doc("Get the certificate from the provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/certificates/{certificateName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the certificate to retrieve.")
      @path
      certificateName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("Name of the provisioning service the certificate is associated with.")
      @path
      provisioningServiceName: string;

      @doc("ETag of the certificate.")
      @header
      `If-Match`: string;
    },
    CertificateResponse
  >;

  @summary("Upload the certificate to the provisioning service.")
  @doc("Add new certificate or update an existing certificate.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/certificates/{certificateName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      provisioningServiceName: string;

      @doc("The name of the certificate create or update.")
      @path
      certificateName: string;

      @doc("""
ETag of the certificate. This is required to update an existing certificate,
and ignored while creating a brand new certificate.
""")
      @header
      `If-Match`: string;

      @doc("The certificate body.")
      @body
      certificateDescription: CertificateResponse;
    },
    CertificateResponse
  >;

  @summary("Delete the Provisioning Service Certificate.")
  @doc("Deletes the specified certificate associated with the Provisioning Service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/certificates/{certificateName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("ETag of the certificate")
      @header
      `If-Match`: string;

      @doc("The name of the provisioning service.")
      @path
      provisioningServiceName: string;

      @doc("""
This is a mandatory field, and is the logical name of the certificate that the
provisioning service will access by.
""")
      @path
      certificateName: string;

      @doc("This is optional, and it is the Common Name of the certificate.")
      @query
      `certificate.name`: string;

      @doc("Raw data within the certificate.")
      @query
      `certificate.rawBytes`: bytes;

      @doc("Indicates if certificate has been verified by owner of the private key.")
      @query
      `certificate.isVerified`: boolean;

      @doc("A description that mentions the purpose of the certificate.")
      @query
      `certificate.purpose`: CertificatePurpose;

      @doc("Time the certificate is created.")
      @query
      `certificate.created`: utcDateTime;

      @doc("Time the certificate is last updated.")
      @query
      `certificate.lastUpdated`: utcDateTime;

      @doc("Indicates if the certificate contains a private key.")
      @query
      `certificate.hasPrivateKey`: boolean;

      @doc("Random number generated to indicate Proof of Possession.")
      @query
      `certificate.nonce`: string;
    },
    void
  >;

  @doc("Get all the certificates tied to the provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/certificates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Name of resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of provisioning service to retrieve certificates for.")
      @path
      provisioningServiceName: string;
    },
    CertificateListDescription
  >;

  @doc("Generate verification code for Proof of Possession.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/certificates/{certificateName}/generateVerificationCode")
  @post
  GenerateVerificationCode is Azure.Core.Foundations.Operation<
    {
      @doc("""
The mandatory logical name of the certificate, that the provisioning service
uses to access.
""")
      @path
      certificateName: string;

      @doc("""
ETag of the certificate. This is required to update an existing certificate,
and ignored while creating a brand new certificate.
""")
      @header
      `If-Match`: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("name of resource group.")
      @path
      resourceGroupName: string;

      @doc("Name of provisioning service.")
      @path
      provisioningServiceName: string;

      @doc("Common Name for the certificate.")
      @query
      `certificate.name`: string;

      @doc("Raw data of certificate.")
      @query
      `certificate.rawBytes`: bytes;

      @doc("Indicates if the certificate has been verified by owner of the private key.")
      @query
      `certificate.isVerified`: boolean;

      @doc("Description mentioning the purpose of the certificate.")
      @query
      `certificate.purpose`: CertificatePurpose;

      @doc("Certificate creation time.")
      @query
      `certificate.created`: utcDateTime;

      @doc("Certificate last updated time.")
      @query
      `certificate.lastUpdated`: utcDateTime;

      @doc("Indicates if the certificate contains private key.")
      @query
      `certificate.hasPrivateKey`: boolean;

      @doc("Random number generated to indicate Proof of Possession.")
      @query
      `certificate.nonce`: string;
    },
    VerificationCodeResponse
  >;

  @summary("Verify certificate's private key possession.")
  @doc("""
Verifies the certificate's private key possession by providing the leaf cert
issued by the verifying pre uploaded certificate.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/certificates/{certificateName}/verify")
  @post
  VerifyCertificate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The mandatory logical name of the certificate, that the provisioning service
uses to access.
""")
      @path
      certificateName: string;

      @doc("ETag of the certificate.")
      @header
      `If-Match`: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;

      @doc("Provisioning service name.")
      @path
      provisioningServiceName: string;

      @doc("Common Name for the certificate.")
      @query
      `certificate.name`: string;

      @doc("Raw data of certificate.")
      @query
      `certificate.rawBytes`: bytes;

      @doc("Indicates if the certificate has been verified by owner of the private key.")
      @query
      `certificate.isVerified`: boolean;

      @doc("Describe the purpose of the certificate.")
      @query
      `certificate.purpose`: CertificatePurpose;

      @doc("Certificate creation time.")
      @query
      `certificate.created`: utcDateTime;

      @doc("Certificate last updated time.")
      @query
      `certificate.lastUpdated`: utcDateTime;

      @doc("Indicates if the certificate contains private key.")
      @query
      `certificate.hasPrivateKey`: boolean;

      @doc("Random number generated to indicate Proof of Possession.")
      @query
      `certificate.nonce`: string;

      @doc("The name of the certificate")
      @body
      request: VerificationCodeRequest;
    },
    CertificateResponse
  >;
}

interface IotDpsResourceOperations {
  @summary("Get the non-security related metadata of the provisioning service.")
  @doc("Get the metadata of the provisioning service without SAS keys.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the provisioning service to retrieve.")
      @path
      provisioningServiceName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group name.")
      @path
      resourceGroupName: string;
    },
    ProvisioningServiceDescription
  >;

  @summary("Create or update the metadata of the provisioning service.")
  @doc("""
Create or update the metadata of the provisioning service. The usual pattern to
modify a property is to retrieve the provisioning service metadata and security
metadata, and then combine them with the modified values in a new body to
update the provisioning service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("Name of provisioning service to create or update.")
      @path
      provisioningServiceName: string;

      @doc("Description of the provisioning service to create or update.")
      @body
      iotDpsDescription: ProvisioningServiceDescription;
    },
    ProvisioningServiceDescription
  >;

  @summary("Update an existing provisioning service's tags.")
  @doc("""
Update an existing provisioning service's tags. to update other fields use the
CreateOrUpdate method
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("Name of provisioning service to create or update.")
      @path
      provisioningServiceName: string;

      @doc("Updated tag information to set into the provisioning service instance.")
      @body
      ProvisioningServiceTags: TagsResource;
    },
    ProvisioningServiceDescription
  >;

  @summary("Delete the Provisioning Service")
  @doc("Deletes the Provisioning Service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("Name of provisioning service to delete.")
      @path
      provisioningServiceName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;
    },
    void
  >;

  @summary("Get all the provisioning services in a subscription.")
  @doc("List all the provisioning services for a given subscription id.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Devices/provisioningServices")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;
    },
    ProvisioningServiceDescriptionListResult
  >;

  @doc("Get a list of all provisioning services in the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;
    },
    ProvisioningServiceDescriptionListResult
  >;

  @doc("""
Gets the status of a long running operation, such as create, update or delete a
provisioning service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/operationresults/{operationId}")
  @get
  GetOperationResult is Azure.Core.Foundations.Operation<
    {
      @doc("""
Operation id corresponding to long running operation. Use this to poll for the
status.
""")
      @path
      operationId: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Resource group identifier.")
      @path
      resourceGroupName: string;

      @doc("Name of provisioning service that the operation is running on.")
      @path
      provisioningServiceName: string;

      @doc("""
Async header used to poll on the status of the operation, obtained while
creating the long running operation.
""")
      @query
      asyncinfo: string;
    },
    AsyncOperationResult
  >;

  @summary("Get the list of valid SKUs for a provisioning service.")
  @doc("Gets the list of valid SKUs and tiers for a provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/skus")
  @get
  listValidSkus is Azure.Core.Foundations.Operation<
    {
      @doc("Name of provisioning service.")
      @path
      provisioningServiceName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("Name of resource group.")
      @path
      resourceGroupName: string;
    },
    IotDpsSkuDefinitionListResult
  >;

  @summary("Check if a provisioning service name is available.")
  @doc("""
Check if a provisioning service name is available. This will validate if the
name is syntactically valid and if the name is usable
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Devices/checkProvisioningServiceNameAvailability")
  @post
  CheckProvisioningServiceNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("""
Set the name parameter in the OperationInputs structure to the name of the
provisioning service to check.
""")
      @body
      arguments: OperationInputs;
    },
    NameAvailabilityInfo
  >;

  @summary("Get the security metadata for a provisioning service.")
  @doc("List the primary and secondary keys for a provisioning service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/listkeys")
  @post
  ListKeys is Azure.Core.Foundations.Operation<
    {
      @doc("The provisioning service name to get the shared access keys for.")
      @path
      provisioningServiceName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("resource group name")
      @path
      resourceGroupName: string;
    },
    SharedAccessSignatureAuthorizationRuleListResult
  >;

  @summary("Get a shared access policy by name from a provisioning service.")
  @doc("List primary and secondary keys for a specific key name")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{provisioningServiceName}/keys/{keyName}/listkeys")
  @post
  ListKeysForKeyName is Azure.Core.Foundations.Operation<
    {
      @doc("Name of the provisioning service.")
      @path
      provisioningServiceName: string;

      @doc("Logical key name to get key-values for.")
      @path
      keyName: string;

      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;
    },
    SharedAccessSignatureAuthorizationRuleAccessRightsDescription
  >;

  @summary("List private link resources")
  @doc("List private link resources for the given provisioning service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{resourceName}/privateLinkResources")
  @get
  ListPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      resourceName: string;
    },
    PrivateLinkResources
  >;

  @summary("Get the specified private link resource")
  @doc("Get the specified private link resource for the given provisioning service")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{resourceName}/privateLinkResources/{groupId}")
  @get
  GetPrivateLinkResources is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      resourceName: string;

      @doc("The name of the private link resource")
      @path
      groupId: string;
    },
    GroupIdInformation
  >;

  @summary("List private endpoint connections")
  @doc("List private endpoint connection properties")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{resourceName}/privateEndpointConnections")
  @get
  ListPrivateEndpointConnections is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      resourceName: string;
    },
    void
  >;

  @summary("Get private endpoint connection")
  @doc("Get private endpoint connection properties")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  GetPrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection
  >;

  @summary("Create or update private endpoint connection")
  @doc("""
Create or update the status of a private endpoint connection with the specified
name
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  CreateOrUpdatePrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;

      @doc("The private endpoint connection with updated properties")
      @body
      privateEndpointConnection: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @summary("Delete private endpoint connection")
  @doc("Delete private endpoint connection with the specified name")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Devices/provisioningServices/{resourceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  DeletePrivateEndpointConnection is Azure.Core.Foundations.Operation<
    {
      @doc("The subscription identifier.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group that contains the provisioning service.")
      @path
      resourceGroupName: string;

      @doc("The name of the provisioning service.")
      @path
      resourceName: string;

      @doc("The name of the private endpoint connection")
      @path
      privateEndpointConnectionName: string;
    },
    PrivateEndpointConnection | void
  >;
}
