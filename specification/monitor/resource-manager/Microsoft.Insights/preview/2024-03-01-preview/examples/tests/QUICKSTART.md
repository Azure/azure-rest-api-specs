# Quick Start - Query-Based Metric Alerts Testing

## 🎯 Purpose
This guide helps you quickly set up and run tests for Query-Based Metric Alerts in the .NET SDK.

## 📦 Prerequisites

```bash
# Required Azure resources
- Azure subscription
- Resource group
- Azure Monitor workspace/account
- Managed identity
- Action group
```

## 🚀 Quick Test Setup

### 1. Minimal Test Example (Most Common)

```csharp
using Azure.ResourceManager.Monitor;
using NUnit.Framework;

[Test]
public async Task CreateSimpleQueryAlert()
{
    // Create alert with PromQL query for CPU > 90%
    var alert = new MetricAlertData(AzureLocation.EastUS)
    {
        Severity = 3,
        IsEnabled = true,
        EvaluationFrequency = TimeSpan.FromMinutes(1),
        Criteria = new PromQLCriteria
        {
            AllOf = { new PromQLCriterion("CPU") 
            { 
                Query = "avg({\\\"system.cpu.utilization\\\"}) > 90" 
            }}
        }
    };
    
    alert.Scopes.Add("/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Monitor/accounts/{account}");
    
    var result = await _resourceGroup
        .GetMetricAlerts()
        .CreateOrUpdateAsync(WaitUntil.Completed, "my-alert", alert);
    
    Assert.IsNotNull(result.Value);
}
```

## 📋 Common PromQL Query Examples

```csharp
// CPU Utilization > 90%
"avg({\\\"system.cpu.utilization\\\"}) > 90"

// Memory Usage > 80%
"avg({\\\"system.memory.utilization\\\"}) > 80"

// Request Rate > 1000/sec
"rate({\\\"http.requests.count\\\"}[5m]) > 1000"

// Error Rate > 5%
"(sum(rate({\\\"http.requests.errors\\\"}[5m])) / sum(rate({\\\"http.requests.count\\\"}[5m]))) > 0.05"
```

## 🔧 Test Configuration

### appsettings.test.json
```json
{
  "AzureTest": {
    "SubscriptionId": "YOUR_SUBSCRIPTION_ID",
    "ResourceGroup": "test-rg-queryalerts",
    "Location": "eastus",
    "MonitorAccountId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Monitor/accounts/{name}",
    "ActionGroupId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.Insights/actionGroups/{name}",
    "ManagedIdentityId": "/subscriptions/{sub}/resourceGroups/{rg}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{name}"
  }
}
```

## 🧪 Running Tests

```bash
# Run all query alert tests
dotnet test --filter "FullyQualifiedName~QueryBasedMetricAlert"

# Run specific test
dotnet test --filter "CreateQueryBasedMetricAlert_WithPromQL_Success"

# Run with verbose logging
dotnet test --logger "console;verbosity=detailed"
```

## ✅ Test Checklist

Before running tests, ensure:
- [ ] Azure subscription is accessible
- [ ] Resource group exists
- [ ] Azure Monitor account is created
- [ ] Managed identity has permissions
- [ ] Action group is configured
- [ ] Test credentials are set up

## 🎨 Test Patterns

### Pattern 1: Create and Validate
```csharp
var alert = await CreateAlert();
Assert.IsNotNull(alert);
Assert.IsInstanceOf<PromQLCriteria>(alert.Data.Criteria);
```

### Pattern 2: Update and Verify
```csharp
var patch = new MetricAlertPatch { IsEnabled = false };
var updated = await alert.UpdateAsync(patch);
Assert.IsFalse(updated.Value.Data.IsEnabled);
```

### Pattern 3: List and Filter
```csharp
var alerts = await _resourceGroup.GetMetricAlerts().GetAllAsync().ToListAsync();
var queryAlerts = alerts.Where(a => a.Data.Criteria is PromQLCriteria);
Assert.IsNotEmpty(queryAlerts);
```

## 🐛 Troubleshooting

### Issue: "Unauthorized" error
**Solution**: Ensure managed identity has "Monitoring Metrics Publisher" role

### Issue: "Invalid PromQL query"
**Solution**: Escape quotes properly in C# strings: `\\\"metric.name\\\"`

### Issue: "Scope not found"
**Solution**: Verify Monitor account exists and ID format is correct

## 📚 Full Test Reference

See `QueryBasedMetricAlertTest.md` for:
- Complete test suite with 7 test cases
- All CRUD operations
- Multi-resource scenarios
- Advanced configurations
- Best practices

## 🔗 Resources

- [PromQL Documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/)
- [Azure Monitor Workspace](https://learn.microsoft.com/azure/azure-monitor/essentials/prometheus-metrics-overview)
- [Metric Alerts API Reference](https://learn.microsoft.com/rest/api/monitor/metric-alerts)

---

**Ready to test?** Start with the minimal example above, then explore the full test suite in `QueryBasedMetricAlertTest.md`!
