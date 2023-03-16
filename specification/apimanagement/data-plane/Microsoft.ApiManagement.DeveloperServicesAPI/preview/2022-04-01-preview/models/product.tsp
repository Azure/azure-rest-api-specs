namespace DeveloperServicesAPI.Models;

model Product {
  id: string;
  name: string;
  description: string;
  terms: string;
  subscriptionRequired?: boolean;
  approvalRequired?: boolean;
  subscriptionsLimit?: int32;
}
