using AssetManagementService as service from './asset-service';



annotate service.Assets with @(


    UI.HeaderInfo:{
        TypeName: 'Asset',
        TypeNamePlural: 'Assets',
        Title: { Value: model},
        Description: {Value: status }
    },
UI.SelectionFields: [
    model,
    hardwareType.name,
    status
],


    UI.Facets: [
{
    $Type: 'UI.ReferenceFacet',
    Label: 'Asset Details',
    Target: '@UI.FieldGroup#Details'
}
    ],
    UI.FieldGroup #Details: {

    Data:[    
        {Value: serialNumber, Label: 'Serial Number'},  
        {Value: model, Label: 'Model'},
        {Value: hardwareType.name, Label: 'Type'},
        {Value: status, Label: 'Status'},
        {Value: vendor, Label: 'Vendor'},
        {Value: currentEmployee.name, Label: 'Assigned To'},
        {Value: price, Label: 'Price'},
        {Value: purchaseDate, Label: 'Purchase Date'},
    ]
    },

    UI.LineItem: [
        { $Type: 'UI.DataField', Value: serialNumber,           Label: 'Serial Number' },
        { $Type: 'UI.DataField', Value: model,                  Label: 'Model'         },
        { $Type: 'UI.DataField', Value: hardwareType.name,      Label: 'Type'          },
        { $Type: 'UI.DataField', Value: status,                 Label: 'Status'        },
        { $Type: 'UI.DataField', Value: vendor,                 Label: 'Vendor'        },
        { $Type: 'UI.DataField', Value: currentEmployee.name,   Label: 'Assigned To'   },
        { $Type: 'UI.DataField', Value: price,                  Label: 'Price'         },
    ],

    UI.PresentationVariant: {
        MaxItems    : 10,
        SortOrder   : [{ Property: modifiedAt, Descending: true }],
        Visualizations: ['@UI.LineItem']
    },

    Capabilities.CountRestrictions: { Countable: true }
);


annotate service.Requests with @(

    UI.HeaderInfo:{
        TypeName: 'Hardware Request',
        TypeNamePlural: 'Hardware Requests',
        Title: {Value: requestedType_code},
        Description: {Value: createdAt}
    },

    UI.SelectionFields: [
    approvalStatus,
    requestedType.name
    ],
    
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: requestedBy.name,       Label: 'Requested By'   },
        { $Type: 'UI.DataField', Value: requestedType.name,     Label: 'Asset Type'     },
        { $Type: 'UI.DataField', Value: approvalStatus,         Label: 'Status'         },
        { $Type: 'UI.DataField', Value: assignDate,             Label: 'Assign Date'    },
        { $Type: 'UI.DataField', Value: allocatedAsset.model,   Label: 'Allocated Asset'},
        { $Type: 'UI.DataField', Value: approvedBy.name,        Label: 'Reviewed By'    },
    ],

    UI.PresentationVariant: {
        MaxItems    : 10,
        SortOrder   : [{ Property: createdAt, Descending: true }],
        Visualizations: ['@UI.LineItem']
    },

    Capabilities.CountRestrictions: { Countable: true }
);

annotate service.HardwareTypes with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: code,   Label: 'Code' },
        { $Type: 'UI.DataField', Value: name,   Label: 'Name' },
        { $Type: 'UI.DataField', Value: descr,  Label: 'Description' },
    ],

    UI.PresentationVariant: {
        MaxItems    : 10,
        SortOrder   : [{ Property: code, Descending: false }],
        Visualizations: ['@UI.LineItem']
    },

    Capabilities.CountRestrictions: { Countable: true }
);

annotate service.Employees with @(
    UI.HeaderInfo: {
        TypeName: 'Employee',
        TypeNamePlural: 'Employees',
        Title: {$Type: 'UI.DataField',Value: name},
        Description: {Value: department}
    },
    UI.Facets: [
        {
          $Type: 'UI.ReferenceFacet',
          Label: 'Employee Details',
          Target: '@UI.FieldGroup#EmployeeDetailsGroup'
        }
    ],
    UI.FieldGroup #EmployeeDetailsGroup: {
       Data: [
        {Value: email, Label: 'Email'},
        {Value: name, Label: 'Name'},
        {Value: department, Label: 'Department'},
       ]
    },
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name,       Label: 'Name'       },
        { $Type: 'UI.DataField', Value: email,      Label: 'Email'      },
        { $Type: 'UI.DataField', Value: department, Label: 'Department' },
    ],

    UI.PresentationVariant: {
        MaxItems    : 20,
        SortOrder   : [{ Property: name, Descending: false }],
        Visualizations: ['@UI.LineItem']
    },

    Capabilities.CountRestrictions: { Countable: true }
);

annotate service.AssetStock with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: typeName,   Label: 'Hardware Type' },
        { $Type: 'UI.DataField', Value: total,      Label: 'Total'         },
        { $Type: 'UI.DataField', Value: available,  Label: 'Available'     },
    ],

    UI.PresentationVariant: {
        MaxItems    : 50,
        SortOrder   : [{ Property: typeName, Descending: false }],
        Visualizations: ['@UI.LineItem']
    },

    Capabilities.CountRestrictions: { Countable: true }
);
