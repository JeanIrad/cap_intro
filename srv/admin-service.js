const cds = require('@sap/cds');
const { Books, Orders, StockAlerts } = cds.entities('sap.capire.bookshop');
const CustomError = require('../utils/customError');
class AdminService extends cds.ApplicationService {
  init() {
    this.on('submitOrder', async function (request) {
      try {
        const { book_ID, quantity } = request.data;
        const tx = cds.tx(request);
        const book = await tx.run(
          SELECT.one.from(Books).where({ ID: book_ID }),
        );
        if (book.stock < quantity) request.reject(400, 'Out of stock!');
        const newStock = book.stock - quantity;
        await tx.run(
          UPDATE(Books).set({ stock: newStock }).where({ ID: book_ID }),
        );
        await tx.run(INSERT.into(Orders).entries({ book_ID, quantity }));
        // await new Promise((_, reject) => {
        //   setTimeout(
        //     () =>
        //       reject(
        //         new CustomError(
        //           409,
        //           'Simulated failure after order submission',
        //         ),
        //       ),
        //     100,
        //   );
        // });
        if (newStock < 5) {
          console.log(
            `[EMITTER] Stock for book ${book_ID} dropped to ${newStock}. Emitting LowStock event...`,
          );
          request.on('succeeded', () => {
            // This will only run AFTER the 'submitOrder' function returns
            // and SQLite safely unlocks the database.
            this.emit('LowStock', { book_ID: book_ID, currentStock: newStock });
          });
        }
        this.emit('orderedBook', { book_ID, quantity });
        console.log(
          'Emitting orderedBook event to be caught in catalog service for checking and proving in-service communication!',
        );
        return { message: 'Order placed successfully!' };
      } catch (error) {
        console.error('Error STACK processing order:', error.stack);
        request.reject(
          error.statusCode || 500,
          error.message || 'Internal Server Error',
        );
      }
    });

    this.on('LowStock', async (message) => {
      console.log('Message of low stock alert received', message);
      const { book_ID, currentStock } = message.data;
      await cds.tx(async () => {
        await INSERT.into(StockAlerts).entries({
          book_ID: book_ID,
          message: `CRITICAL: Stock for Book ${book_ID} has fallen to ${currentStock}.`,
        });
      });
    });
    this.before('CREATE', 'Orders', async (req) => {
      // if(req.)
      const { quantity, book_ID } = req.data;
      const book = await SELECT.one
        .from('sap.capire.bookshop.Books')
        .where({ ID: book_ID });
      if (!book) {
        req.reject(400, "Book with such ID doesn't exist!");
      }
      if (book.stock < quantity) {
        req.reject(400, 'Insufficient stock!');
      }
    });

    return super.init();
  }
}

module.exports = {
  AdminService,
};
