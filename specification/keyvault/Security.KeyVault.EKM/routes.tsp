import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Security.KeyVault.Common/common.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace KeyVault;

/**
 * The External Key Manager (EKM) Get operation returns EKM connection. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets the EKM connection.")
@route("/ekm")
@get
op getEkmConnection is KeyVaultOperation<{}, EkmConnection>;

/**
 * The External Key Manager (EKM) Certificate Get operation returns Proxy client certificate. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Gets the EKM proxy client certificate.")
@route("/ekm/certificate")
@get
op getEkmCertificate is KeyVaultOperation<{}, EkmProxyClientCertificateInfo>;

/**
 * The External Key Manager (EKM) Check operation checks the connectivity and authentication with the EKM proxy. This operation requires ekm/read permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Checks the connectivity and authentication with the EKM proxy.")
@route("/ekm/check")
@post
op checkEkmConnection is KeyVaultOperation<{}, EkmProxyInfo>;

/**
 * The External Key Manager (EKM) sets up the EKM connection. If the EKM connection already exists, this operation fails. This operation requires ekm/write permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Creates the EKM connection.")
@route("/ekm/create")
@post
op createEkmConnection is KeyVaultOperation<
  {
    /**
     * The ekmConnection to create.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    ekmConnection: EkmConnection;
  },
  EkmConnection
>;

/**
 * The External Key Manager (EKM) updates the existing EKM connection. If the EKM connection does not exist, this operation fails. This operation requires ekm/write permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Updates the EKM connection.")
@route("/ekm")
@patch(#{ implicitOptionality: true })
op updateEkmConnection is KeyVaultOperation<
  {
    /**
     * The ekmConnection to update.
     */
    #suppress "deprecated" "Property flattening is supported for legacy scenarios like Key Vault's"
    @body
    @flattenProperty
    ekmConnection: EkmConnection;
  },
  EkmConnection
>;

/**
 * The External Key Manager (EKM) deletes the existing EKM connection. If the EKM connection does not already exists, this operation fails. This operation requires ekm/delete permission.
 */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation is necessary for Key Vault"
@summary("Deletes the EKM connection.")
@route("/ekm")
@delete
op deleteEkmConnection is KeyVaultOperation<{}, EkmConnection>;
