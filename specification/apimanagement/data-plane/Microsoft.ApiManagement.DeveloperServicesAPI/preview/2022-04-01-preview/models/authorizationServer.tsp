namespace DeveloperServicesAPI.Models;

model AuthorizationServer {
  name: string;
  description: string;
  clientId: string;
  authorizationEndpoint: string;
  tokenEndpoint: string;
  defaultScope: string;
  grantTypes: GrantType[];
  useInTestConsole: boolean;
  useInApiDocumentation: boolean;
}
