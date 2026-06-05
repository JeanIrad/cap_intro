using {CatlogService} from './cat-service';


annotate CatlogService.Books with @(
    UI.HeaderInfo: {
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Title         : { Value: title },       
        Description   : { Value: author }   
    },

    UI.SelectionFields: [
        genre_ID,
        author_ID
    ]
);
