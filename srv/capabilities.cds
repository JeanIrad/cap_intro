using AssetManagementService as service from './asset-service';
using Employee as EmployeeService from './employee';


annotate service.AssetStock with @(
    Aggregation.ApplySupported: {
        Transformations        : [ 'aggregate', 'groupby', 'filter' ],
        GroupableProperties    : [ typeCode, typeName ],
        AggregatableProperties : [
            { Property: total     },
            { Property: available }
        ]
    }
);

annotate service.AssetStock with {
    typeCode  @Analytics.Dimension  @title: 'Type Code';
    typeName  @Analytics.Dimension  @title: 'Hardware Type';
    total     @Analytics.Measure    @title: 'Total Assets';
    available @Analytics.Measure    @title: 'Available';
}






annotate EmployeeService.Requests with @restrict: [
{grant: 'CREATE', to: 'authenticated-user'},
{grant: 'READ', to: 'authenticated-user', where: 'createdBy = $user'},
{ grant: ['UPDATE', 'DELETE', 'action'], to: 'authenticated-user', where: 'createdBy = $user' }
];


annotate EmployeeService.Requests with {

    justification @mandatory @Common.Label: 'Justification' @title: 'Justification';
    assignDate @Common.Label: 'Date Assigned' ;
    approvalStatus @Common.Label : 'Status';
    requestedType @Common.Label : 'Device Type';
    createdAt @Common.Label : 'RequestDate'



};

annotate service.HardwareTypes with {
    name @Common : {Label : 'Asset Type Name'}

}

annotate service.Requests with {
    approvalStatus @Common : { Label : 'Status' }

}