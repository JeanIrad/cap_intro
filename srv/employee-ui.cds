using {Admin} from './it-admin';
using {Employee} from './employee';





annotate  Employee.Requests with @(

    UI.HeaderInfo: {
TypeName: 'Hardware Request',
TypeNamePlural: 'Hardware Requests',
Title: {Value: requestedType_code},
Description: {Value: createdAt}
},

UI.Facets: [
{
    $Type: 'UI.ReferenceFacet',
    Label: 'Request Details',
    Target: '@UI.FieldGroup#RequestDetailsGroup'
}
],

UI.FieldGroup #RequestDetailsGroup:{
  Data: [ 
{Value: requestedType_code},
// {Value: approvalStatus},
{Value: justification}
    ]
}
,
);
annotate Employee.Requests with @(



UI.SelectionFields:[
    createdAt,
    approvalStatus,
],


UI.LineItem: [
    {Value: ID, Label: 'Request ID'},
{Value: justification, Label: 'Reason'},
{Value: requestedType_code, Label: 'Device Category'},
{Value: approvalStatus, Label: 'Status'},
{
    $Type: 'UI.DataFieldForAction',
    Action: 'Employee.cancelRequest',
    Label: 'Cancel Request'
}
]
);

annotate Employee.Requests with{

    requestedType @Common.ValueList:{
        CollectionPath: 'HardwareTypes',
        Label: 'Select Hardware Category',
        Parameters: [{
            $Type: 'Common.ValueListParameterInOut',
            LocalDataProperty: requestedType_code,
            ValueListProperty: 'code'
        }, {
            $Type: 'Common.ValueListParameterDisplayOnly',
            ValueListProperty: 'name'
        }]
    }
}