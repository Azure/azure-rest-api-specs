@doc("Request body for RemoveMaintenanceAccount POST request")
model RemoveAccountRequestBody {
  @doc("The direct access account username to remove from BMC")
  username: string;
}
