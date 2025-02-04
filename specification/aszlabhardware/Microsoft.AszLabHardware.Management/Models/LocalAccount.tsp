@doc("Base model representing a local BMC account")
model LocalAccount {
  @visibility("create", "read", "update")
  @doc("Username")
  username: string;

  @visibility("create", "update")
  @doc("Password")
  @secret
  password: string;
}
