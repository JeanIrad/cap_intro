using {Currency, managed, sap, cuid} from '@sap/cds/common';
namespace sap.capire.bookshop;

entity Books: managed {
    key ID: Integer;
    name: String;
    author: Association to Authors;
    title  : localized String;
    descr  : localized String;
    genre  : Association to Genres;
    stock  : Integer;
    price  : Decimal;
    currency : Currency;
    shelf: Association to Shelvies;
    reviews: composition of many Reviews on reviews.book = $self;
}

entity Authors: managed {
    key ID: Integer;
    name: String;
    books: Association to many Books on books.author = $self;
}

entity Genres : sap.common.CodeList{
Key ID: Integer;
parent: Association to Genres
}

entity Orders: cuid, managed {
    
    quantity : Integer not null;
    book: Association to Books not null;
    orderDate: Timestamp default current_timestamp; 
    status: OrderStatus default 'New';
    currency: Currency;
    TotalAmount: Decimal(10, 2)
}

entity StockAlerts: managed, cuid{
    book_ID: Integer;
    message: String;
    resolved: Boolean default false;
}

entity Shelvies: cuid, managed {
    books: Association to many Books on books.shelf = $self
}
// entity Users:cuid, managed {
//     firstName: String;
//     lastName: String;
//     @assert.format: '/^\S+@\S+\.\S+$/'
//     @assert.format.message: 'Provide a valid email Address'
//     email: String;
// }
// type DayOfWeek : Number @assert.range: [1,7];?
type Genre : String enum { Mystery; Fiction}
type OrderStatus : String enum { New; Processed; Shipped; Delivered; Cancelled }
entity Reviews: cuid, managed {
    rating: Integer;
    ratingText: String;
    comment: String;
    book: Association to Books not null;
}