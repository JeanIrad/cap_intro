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