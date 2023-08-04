enum MachineBootType {
    "Unknown",
    "EFI",
    Bios: "BIOS",
    "NotSpecified",
}

@doc("The status of the current operation.")
enum ProvisioningState {
  Succeeded,
  Failed,
  Canceled,
  Provisioning,
  Updating,
  Deleting,
  Accepted,
}
