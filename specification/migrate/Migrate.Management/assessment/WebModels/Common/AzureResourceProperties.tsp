import "./CommonEnums.tsp";

@doc("Common properties for all azure tracked and proxy resources.")
model AzureResourceProperties {
    @doc("The status of the last operation.")
    provisioningState?: ProvisioningState;
}
