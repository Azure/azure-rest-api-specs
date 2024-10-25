import { devOps, cli } from "@azure/avocado";

export async function runSwaggerAPIView() {
  const pr = await devOps.createPullRequestProperties(cli.defaultConfig());
  console.log(pr);
  console.log(process.env.AGENT_BUILDDIRECTORY);
}

runSwaggerAPIView();