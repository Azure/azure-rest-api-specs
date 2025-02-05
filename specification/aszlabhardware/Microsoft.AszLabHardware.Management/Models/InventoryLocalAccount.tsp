@doc("Inventory local account")
model InventoryLocalAccount {
  @doc("Username of local account")
  @visibility("read")
  username: string;

  @doc("The account type")
  @visibility("read")
  accountType: InventoryLocalAccountType;

  @doc("The status of the account")
  @visibility("read")
  accountStatus: AccountStatus;
}

@doc("The account type of the local account")
union InventoryLocalAccountType {
  @doc("Service account. Cannot be modified or removed")
  Service: "Service",

  @doc("Direct access account. Used by customers for temporary access to the BMC and provisioned by the service")
  DirectAccess: "DirectAccess",

  @doc("Unknown account")
  Unknown: "Unknown",

  @doc("Special account, such as monitoring accounts left on the lab team")
  Special: "Special",

  string,
}

@doc("The status of the account")
union AccountStatus {
  @doc("Account is enabled")
  Enabled: "Enabled",

  @doc("Account is disabled")
  Disabled: "Disabled",

  string,
}
