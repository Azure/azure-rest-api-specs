import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Azure.ResourceManager;

namespace NGINX.NGINXPLUS;

/** NginxCertificate resource */
@parentResource(NginxDeployment)
model Certificate is ProxyResource<NginxCertificateProperties> {
  ...ResourceNameParameter<Certificate>;
}

/**
 * Properties of an Nginx certificate resource.
 */
model NginxCertificateProperties {
  /**
   * The provisioning state of the certificate.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The virtual path to the key file. This is a path that would be used in an Nginx configuration file, for example, /etc/nginx/ssl/key.key.
   */
  keyVirtualPath?: string;

  /**
   * The virtual path to the certificate file. This is a path that would be used in an Nginx configuration file, for example, /etc/nginx/ssl/cert.pem.
   */
  certificateVirtualPath?: string;

  /**
   * The Key Vault secret ID. Example: `https://myvault.vault.azure.net/secrets/mysecret/1234567890abcdef1234567890abcdef`.
   */
  keyVaultSecretId?: url;

  /**
   * The SHA1 thumbprint of the certificate.
   */
  sha1Thumbprint?: string;

  /**
   * The Key Vault secret version.
   */
  keyVaultSecretVersion?: string;

  /**
   * The creation time of the Key Vault secret in UTC RFC 3339 format.
   * Example: `2025-07-08T10:11:08.856Z`.
   */
  keyVaultSecretCreated?: string;

  /**
   * Error details for the certificate, if any.
   */
  certificateError?: NginxCertificateErrorResponseBody;
}

/**
 * Error details for a certificate resource.
 */
model NginxCertificateErrorResponseBody {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Operations on Nginx certificates under a given deployment.
 */
@armResourceOperations
interface Certificates {
  /**
   * Gets the properties of a specific certificate.
   */
  get is ArmResourceRead<Certificate>;

  /**
   * Creates or updates a certificate.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Certificate>;

  /**
   * Updates a certificate with patch semantics.
   */
  update is ArmCustomPatchSync<
    Certificate,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Certificate,
      NginxCertificateProperties
    >
  >;

  /**
   * Deletes a specific certificate.
   */
  delete is ArmResourceDeleteWithoutOkAsync<Certificate>;

  /**
   * Lists all certificates in a parent deployment.
   */
  listByDeployment is ArmResourceListByParent<Certificate>;
}
