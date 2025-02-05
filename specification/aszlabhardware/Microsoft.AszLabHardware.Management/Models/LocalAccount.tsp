@doc("Base model representing a local BMC account")
model LocalAccount {
  @visibility("create", "read", "update")
  @doc("Username for local account")
  username: string;

  @visibility("create", "update")
  @doc("Password for local account")
  @secret
  password: string;
}
