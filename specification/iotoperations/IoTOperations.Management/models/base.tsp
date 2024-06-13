import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

@doc("Extended location is an extension of Azure locations. They provide a way to use their Azure ARC enabled Kubernetes clusters as target locations for deploying Azure services instances.")
model ExtendedLocation {
  @doc("The name of the extended location.")
  name: string;

  @doc("Type of ExtendedLocation.")
  type: ExtendedLocationType;
}

@doc("The enum defining type of ExtendedLocation accepted.")
union ExtendedLocationType {
  string,

  @doc("CustomLocation type")
  "CustomLocation",
}
@doc("The enum defining status of resource.")
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is getting provisioned.")
  Provisioning: "Provisioning",

  @doc("Resource is Updating.")
  Updating: "Updating",

  @doc("Resource is Deleting.")
  Deleting: "Deleting",

  @doc("Resource has been Accepted.")
  Accepted: "Accepted",
}

@doc("Defines the Node Tolerations details")
model NodeTolerations {
  @doc("Toleration effect.")
  effect: string;

  @doc("Toleration key.")
  key: string;

  @doc("Toleration operator like 'Exists', 'Equal' etc.")
  operator: TolerationOperator;

  @doc("Toleration Value.")
  value: string;
}

@doc("The enum defining type of TolerationOperator accepted.")
union TolerationOperator {
  string,

  @doc("Equal operator.")
  Equal: "Equal",

  @doc("Exists operator.")
  Exists: "Exists",
}

@doc("X509 Certificate Authentication properties.")
model X509ManualCertificate {
  @doc("Kubernetes secret containing an X.509 client certificate. This is a reference to the secret through an identifying name, not the secret itself.")
  secretName: string;

  @doc("Certificate K8S namespace. Omit to use current namespace.")
  secretNamespace?: string;
}
