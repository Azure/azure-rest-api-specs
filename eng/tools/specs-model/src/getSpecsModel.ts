export async function getSpecsModel(path: string): Promise<string> {
  // eslint-disable-next-line @typescript-eslint/require-await
  await (async () => {
    console.log(path);
  })();
  return `stub getSpecsModel. path: ${path}`;
}
