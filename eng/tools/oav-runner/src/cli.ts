
import { main } from './main.js';

const [ , , targetDir ] = process.argv;

if (!targetDir) {
  console.error('Usage: oav-runner <targetDirectory>');
  process.exit(1);
}
else {
    await main(targetDir);
    console.log(`Running oav-runner on ${targetDir}`);
}