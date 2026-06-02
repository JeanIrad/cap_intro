const cds = require("@sap/cds");

class AdminService extends cds.ApplicationService {
  init() {
    this.on("submitOrder", async function (request) {
      console.log("REQUEST HITS SERVER==========>", request.data);
      const { book_ID, quantity } = request.data;
      if (!book_ID || !quantity)
        request.reject(400, "Provide something to deal with!");
      const book = await SELECT.one
        .from("sap.capire.bookshop.Books")
        .where({ ID: book_ID });

      console.log("BOOK==========>", book);
      if (!book) request.reject(404, "Book not found!");
      if (book.stock < quantity) request.reject("Insufficient stock!");
      await INSERT.into("sap.capire.bookshop.Orders").entries({
        book_ID,
        quantity,
      });

      return { message: "Order submitted successfully!" };
    });
    this.before("CREATE", "Orders", async (req) => {
      // if(req.)
      const { quantity, book_ID } = req.data;
      const book = await SELECT.one
        .from("sap.capire.bookshop.Books")
        .where({ ID: book_ID });
      if (!book) {
        req.reject(400, "Book with such ID doesn't exist!");
      }
      if (book.stock < quantity) {
        req.reject(400, "Insufficient stock!");
      }
    });

    return super.init();
  }
}

module.exports = {
  AdminService,
};
