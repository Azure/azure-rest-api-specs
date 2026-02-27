import "./common.tsp";

@doc("compositeWebEndpoints Properties")
model CompositeWebEndpointsProperties {
  @doc("Fqdn of Web Endpoint")
  fqdn: string;

  @doc("Protocol of Web Endpoint")
  protocol?: string;

  @doc("Path of Web Endpoint")
  path?: string;

  @doc("Aliases of Web Endpoint")
  aliases?: string[];

  @doc("PortNumbers of Web Endpoint")
  portNumbers?: int32[];

  @doc("Ownership attribution of the Web Endpoint")
  ownershipAttributes: WebEndpointsOwnershipAttributesObject;

  @doc("Resource attribution which is hosting the Web Endpoint")
  resourceAttributes: WebEndpointsResourceAttributesObject;

  @doc("Status of Web Endpoint")
  status: WebEndpointsStatusObject;

  @doc("BeneficiaryProperties of Web Endpoint")
  beneficiaryProperties: WebEndpointsBeneficiaryPropertiesObject;

  @doc("ComplianceProperties of Web Endpoint")
  complianceProperties: WebEndpointsCompliancePropertiesObject;

  @doc("Cloud location of the IP Address")
  cloud: string;

  @doc("Provisioning state")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@doc("Model that describes the BeneficiaryProperties object for CompositeWebEndpoints")
model WebEndpointsBeneficiaryPropertiesObject {
  @doc("Is HoBo")
  isHobo?: boolean;
}

@doc("Model that describes the ComplianceProperties object for CompositeWebEndpoints")
model WebEndpointsCompliancePropertiesObject {
  @doc("FedRamp compliance flag")
  fedRamp?: string;
}

@doc("Model that describes the OwnershipAttributes object for CompositeWebEndpoints")
model WebEndpointsOwnershipAttributesObject {
  @doc("Owner subscription id of Web Endpoint")
  ownerSubscriptionId?: string;

  @doc("Owner subscription name of Web Endpoint")
  ownerSubscriptionName?: string;

  @doc("Owner service tree id of Web Endpoint")
  ownerServiceTreeId?: string;

  @doc("Owner service tree name of Web Endpoint")
  ownerServiceTreeName?: string;

  @doc("Owner type of Web Endpoint")
  ownerType: string;

  @doc("Owner role of Web Endpoint")
  ownerRole: string;

  @doc("Customer subscription id of Web Endpoint")
  customerSubscriptionId: string;

  @doc("Customer subscription name of Web Endpoint")
  customerSubscriptionName: string;

  @doc("Customer subscription id of Web Endpoint")
  customerServiceTreeId?: string;

  @doc("Customer service tree name of Web Endpoint")
  customerServiceTreeName?: string;

  @doc("Customer type of Web Endpoint")
  customerType: string;
}

@doc("Model that describes the ResourceAttributes (ARM Resource Ids, ARM Resource Types) object for CompositeWebEndpoints")
model WebEndpointsResourceAttributesObject {
  @doc("Provider resource ID")
  providerResourceId: string;

  @doc("Provider resource type")
  providerResourceType: string;
}

@doc("Model that describes the Status object for CompositeWebEndpoints")
model WebEndpointsStatusObject {
  @doc("Timestamp of Web Endpoint resource event")
  eventTimestamp: string;

  @doc("State of Web Endpoint resource")
  endpointState: string;
}
