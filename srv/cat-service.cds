using {sap.capire.bookshop as my} from '../db/schema';

service CatlogService @(odata:'/browse'){
   
 @readonly entity Books as projection on my.Books{
  *,
  author.name as author,
  genre.name as genre,
  reviews,
//   reviews.ratingText as ratingText
  

 } excluding {
  createdBy, modifiedBy
 };

 @Capabilities: {Insertable: true, Updatable: true, Deletable: false}
entity Reviews as projection on my.Reviews {
    *,
    book,
    book.title as bookTitle,
    case when rating <= 3 then 'bad'
    when rating > 3 and rating < 7 then 'average'
    else 'good' end as ratingText
} excluding {
    createdBy, modifiedBy
};

@readonly entity Orders as projection on my.Orders {
    *,
    book,
    book.title as bookTitle
} excluding {
    createdBy, modifiedBy
}
}