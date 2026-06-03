using {sap.capire.bookshop as my} from '../db/schema';

service CatlogService @(odata:'/browse'){
   
 @readonly entity Books as projection on my.Books{
  *,
  author.name as author,
  genre.name as genre,
 } excluding {
  createdBy, modifiedBy
 };
@readonly entity Users as select from my.Users
event orderedBook: {book: UUID; quantiity: Integer; buyer: Users:ID}
}