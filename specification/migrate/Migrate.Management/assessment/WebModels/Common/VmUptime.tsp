@doc("Details on the total up-time for the VM.")
model VmUptime {
    @doc("Number of days in a month for VM uptime.")
    daysPerMonth?: int32;

    @doc("Number of hours per day for VM uptime.")
    hoursPerDay?: int32;
}
