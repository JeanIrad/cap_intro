const cds = require("@sap/cds");
class CatlogService extends cds.ApplicationService {
  init() {
    // After READ handler on Books to add discount info
    this.after("READ", "Books", (results) => {
      console.log("results=======>", results);
      //   results = results.map(result)

      results = results.push({ total: results.length });
      // this.on("READ", "Books", (req) => {
      //   return [{ ID: 1, title: "Hello world" }];
      // });
    });
    this.on("orderedBook", async function (req) {
      console.log("THE BOOK WAS ORDERD BY XXXX");
    });
    return super.init();
  }
}
module.exports = { CatlogService };
