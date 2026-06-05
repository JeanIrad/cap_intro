using { AdminService } from './admin-service';

annotate AdminService.Books with @(
// Zone 1: The List Report Header and Search/Filter Bar
    UI.HeaderInfo: {
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Title         : { Value: title },       
        Description   : { Value: author.name }   
    },

    // Generates the search/filter inputs at the top of the List Report
    UI.SelectionFields: [
        genre_ID,
        author_ID
    ]
);

// ========================================================================
// 2. THE TABLE COLUMNS (List Report Line Items)
// ========================================================================
annotate AdminService.Books with @(
    UI.LineItem: [
        { Value: ID,          Label: 'Book ID' },
        { Value: title,       Label: 'Book Title' },
        { Value: author.name, Label: 'Author' },
        { Value: genre.name,  Label: 'Genre' },
        { Value: price,       Label: 'Retail Price' },
        { Value: stock,       Label: 'Available Stock' }
    ]
);

// ========================================================================
// 3. THE DETAILS FORM (Object Page Layout)
// ========================================================================
annotate AdminService.Books with @(
    // Facets partition the Object Page into logical tabs or layout forms
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneralData'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Inventory Metrics',
            Target: '@UI.FieldGroup#StockData'
        }
    ],

    // Grouping specific fields together inside the respective Facet forms
    UI.FieldGroup #GeneralData: {
        Data: [
            { Value: title,  Label: 'Title' },
            { Value: author_ID, Label: 'Author ID' },
            { Value: descr,  Label: 'Synopsis' }
        ]
    },

    UI.FieldGroup #StockData: {
        Data: [
            { Value: stock, Label: 'Current Warehouse Stock' },
            { Value: price, Label: 'Price Per Unit' }
        ]
    }
);

annotate AdminService.Orders with @(
UI.HeaderInfo: {
    TypeName: 'Order',
    TypeNamePlural: 'Orders',
    Title: {
        $Type: 'UI.DataField',
        Value: ID
    },
    Description: {
        $Type: 'UI.DataField',
        Value: book.title
    }
}
);

annotate AdminService.Orders with @(


UI.FieldGroup #GeneralInfo:{
    $Type: 'UI.FieldGroupType',
    Label: 'General Information',
    Data: [
        {
             Value: quantity, Label: 'Quantity'
        },
        {
            Value: book.title, Label: 'Book Title'
        }
    ]
},

UI.Facets: [
{
    $Type: 'UI.ReferenceFacet',
    Label: 'General Information',
    Target: '@UI.FieldGroup#GeneralInfo'
}
]
);

annotate AdminService.Orders with @(
UI.SelectionFields: [
// {Value: book.author.name, Label: 'By Author Name'},
// book.ID,
// quantity
book.title,
book.author.name

]

);

annotate AdminService.Orders with @(
UI.LineItem: [
    {Value: ID, Label: 'Order ID', $Type: 'UI.DataField'},
    {Value: quantity, Label: 'Quantity', $type: 'UI.DataField'},
    {Value: book.title, Label: 'Book Title', $Type: 'UI.DataField'},
    {Value: book.author.name, Label: 'Author'},
]


)