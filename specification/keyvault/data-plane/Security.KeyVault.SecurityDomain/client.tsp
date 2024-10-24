import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using KeyVault;

@TypeSpec.Versioning.useDependency(Azure.Core.Versions.v1_0_Preview_2)
@TypeSpec.Versioning.useDependency(KeyVault.Versions.`v7.5`)
namespace ClientCustomizations;

@client({
  name: "SecurityDomainClient",
  service: KeyVault,
})
interface SecurityDomainClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  getDownloadStatus is HsmSecurityDomain.downloadPending;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  download is HsmSecurityDomain.download;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  getUploadStatus is HsmSecurityDomain.uploadPending;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  upload is HsmSecurityDomain.upload;
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundations.Operation necessary for Key Vault"
  getTransferKey is HsmSecurityDomain.transferKey;
}
