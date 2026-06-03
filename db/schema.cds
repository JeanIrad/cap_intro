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

entity Orders: cuid {
    quantity : Integer;
    book: Association to Books not null;
}

entity Shelvies: cuid, managed {
    books: Association to many Books on books.shelf = $self
}
entity Users:cuid, managed {
    firstName: String;
    lastName: String;
    @assert.format: '/^\S+@\S+\.\S+$/'
    @assert.format.message: 'Provide a valid email Address'
    email: String;
}
// type DayOfWeek : Number @assert.range: [1,7];?
type Genre : String enum { Mystery; Fiction}