import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

namespace KeyVault;
/**
 * A EkmConnection model object.
 */
model EkmConnection {
  /**
   * EKM proxy FQDN (Fully Qualified Domain Name). Only allowed characters are a-z, A-Z, 0-9, hyphen (-), dot (.), and colon (:).
   */
  host: string;

  /**
   * Optional path prefix for the EKM proxy (if any).
   */
  @encodedName("application/json", "path_prefix")
  pathPrefix?: string;

  /**
   * The root CA certificate chain that issued the proxy server's certificate. An array of certificates in the certificate chain, each in DER format and base64 encoded.
   */
  @encodedName("application/json", "server_ca_certificates")
  serverCaCertificates: string[];

  /**
   * The subject common name of the server certificate of EKM Proxy.
   */
  @encodedName("application/json", "server_subject_common_name")
  serverSubjectCommonName?: string;
}

/**
 * EKM proxy client certificate information.
 */
model EkmProxyClientCertificateInfo {
  /**
   * The client root CA certificate chain to authenticate to the EKM proxy. An array of certificates in the certificate chain, each in DER format and base64 encoded.
   */
  @encodedName("application/json", "ca_certificates")
  @visibility(Lifecycle.Read)
  caCertificates: string[];

  /**
   * The subject common name of the client certificate used to authenticate to the EKM proxy.
   */
  @encodedName("application/json", "subject_common_name")
  @visibility(Lifecycle.Read)
  subjectCommonName: string;
}

/**
 * EKM proxy information.
 */
model EkmProxyInfo {
  /**
   * The highest version of proxy interface API supported by the EKM Proxy.
   */
  @encodedName("application/json", "api_version")
  apiVersion: string;

  /**
   * The name of the proxy vendor.
   */
  @encodedName("application/json", "proxy_vendor")
  proxyVendor: string;

  /**
   * The name of the proxy product and its version.
   */
  @encodedName("application/json", "proxy_name")
  proxyName: string;

  /**
   * The name of the EKM vendor.
   */
  @encodedName("application/json", "ekm_vendor")
  ekmVendor: string;

  /**
   * The name of the EKM product and its version.
   */
  @encodedName("application/json", "ekm_product")
  ekmProduct: string;
}
