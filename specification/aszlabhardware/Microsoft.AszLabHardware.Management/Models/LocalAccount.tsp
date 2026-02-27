@doc("Base model representing a local BMC account")
model LocalAccount {
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @doc("Username for local account")
  username: string;

  @visibility(Lifecycle.Create, Lifecycle.Update)
  @doc("Password for local account")
  @secret
  password: string;
}
