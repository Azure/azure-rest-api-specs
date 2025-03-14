import "./LocalAccount.tsp";

@doc("Request body for SetMaintenanceAccount POST request")
model SetAccountRequestBody {
  @doc("The direct access account to provision on the BMC")
  localAccount: LocalAccount;
}
